Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89DBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953E12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLRMJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:09:08 -0500
Received: from foss.arm.com ([217.140.110.172]:44064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfLRMJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:09:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C5F930E;
        Wed, 18 Dec 2019 04:09:07 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 290633F6CF;
        Wed, 18 Dec 2019 04:09:06 -0800 (PST)
Date:   Wed, 18 Dec 2019 12:09:00 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] include: trace: Add SCMI header with trace events
Message-ID: <20191218120900.GA28599@bogus>
References: <20191216161650.21844-1-lukasz.luba@arm.com>
 <20191216161650.21844-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216161650.21844-1-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 05:15:54PM -0500, Jim Quinlan wrote:
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
> unique, and the seq may not be unique.

I agree on id and proto_id part easily and the seq may not be unique
if and only if the previous command has completed.

> The combination of the three may not be unique.

Not 100% sure on that. I remember one of the issue you reported where OS
times out and platform may still be processing it. That's one of the
case where seq id may get re-assigned, but now that's fixed and the
scenario may not happen. I am trying to understand why you think it
is not unique ?

> Would it make sense to assign a monotonically increasing ID to each
> msg so that one can easily match the two events for each msg?

I am not sure if we need to maintain a tracker/counter just for trace
purposes.

> This id could be the result of an atomic increment and
> could be stored in the xfer structure.  Of course, it would be one of
> the values printed out in the events.
>
> Also, would you consider a third event, right after the
> scmi_fetch_response() invocation in scmi_rx_callback()?  I've found
> this to be insightful in situations where we were debugging a timeout.
>
> I'm fine if you elect not to do the above; I just wanted to post
> this for your consideration.
>

I am interested in the scenario we can make use of this and also help
in testing it if we add this. I am not against it but I don't see the
need for it.

--
Regards,
Sudeep

