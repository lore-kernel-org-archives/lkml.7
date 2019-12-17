Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4147C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F1D2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfLQKFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:05:33 -0500
Received: from foss.arm.com ([217.140.110.172]:60072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfLQKFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:05:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DE8330E;
        Tue, 17 Dec 2019 02:05:32 -0800 (PST)
Received: from [10.37.12.145] (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A870D3F6CF;
        Tue, 17 Dec 2019 02:05:30 -0800 (PST)
Subject: Re: [PATCH 1/2] include: trace: Add SCMI header with trace events
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rostedt@goodmis.org, sudeep.holla@arm.com
References: <20191216161650.21844-1-lukasz.luba@arm.com>
 <20191216161650.21844-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <99cea477-d776-1723-162b-f12ca64fce6e@arm.com>
Date:   Tue, 17 Dec 2019 10:05:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191216161650.21844-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jim,

On 12/16/19 10:15 PM, Jim Quinlan wrote:
> From: Lukasz Luba <lukasz.luba@arm.com>
> 
> +
> +TRACE_EVENT(scmi_xfer_begin,
> +	TP_PROTO(u8 id, u8 protocol_id, u16 seq, bool poll),
> +	TP_ARGS(id, protocol_id, seq, poll),
> +
> +	TP_STRUCT__entry(
> +		__field(u8, id)
> +		__field(u8, protocol_id)
> +		__field(u16, seq)
> +		__field(bool, poll)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = id;
> +		__entry->protocol_id = protocol_id;
> +		__entry->seq = seq;
> +		__entry->poll = poll;
> +	),
> +
> +	TP_printk("id=%u protocol_id=%u seq=%u poll=%u", __entry->id,
> +		__entry->protocol_id, __entry->seq, __entry->poll)
> +);
> +
> +TRACE_EVENT(scmi_xfer_end,
> +	TP_PROTO(u8 id, u8 protocol_id, u16 seq, u32 status),
> +	TP_ARGS(id, protocol_id, seq, status),
> +
> +	TP_STRUCT__entry(
> +		__field(u8, id)
> +		__field(u8, protocol_id)
> +		__field(u16, seq)
> +		__field(u32, status)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = id;
> +		__entry->protocol_id = protocol_id;
> +		__entry->seq = seq;
> +		__entry->status = status;
> +	),
> +
> +	TP_printk("id=%u protocol_id=%u seq=%u status=%u", __entry->id,
> +		__entry->protocol_id, __entry->seq, __entry->status)
> +);
> 
> Hello,
> 
> When there are multiple messages in the mbox queue, I've found it
> a chore matching up the 'begin' event with the 'end' event for each
> SCMI msg.  The id (command) may not be unique, the proto_id may not be
> unique, and the seq may not be unique.  The combination of the three
> may not be unique.  Would it make sense to assign a monotonically
> increasing ID to each msg so that one can easily match the two events
> for each msg?  This id could be the result of an atomic increment and
> could be stored in the xfer structure.  Of course, it would be one of
> the values printed out in the events.

Hmmm, an atomic variable in this code might be too heavy, especially in
case of fast_switch from cpufreq. Let me think about it and experiment.

> 
> Also, would you consider a third event, right after the
> scmi_fetch_response() invocation in scmi_rx_callback()?  I've found
> this to be insightful in situations where we were debugging a timeout.

Yes, of course. It would be really useful. Thank you for the
suggestion.

> 
> I'm fine if you elect not to do the above; I just wanted to post
> this for your consideration.

Thant's a valuable feedback. I will definitely consider it.

Regards,
Lukasz

> 
> Thanks,
> Jim Quinlan
> Broadcom
> 
