Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4FFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A941020663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 05:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eISp/3im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfLPFeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 00:34:23 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:54192 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbfLPFeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 00:34:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576474462; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Iq+3wsIwxnkJUdYkRcKnn98ba+bfrla4alb2pRAb9yQ=; b=eISp/3imXsYE/5Y7/zB+A5HSPh2jvYD0+f08USFmJs4gJ6JvEbQTAEXVypdeJNO0NGYEslLI
 j4AX/tlcblJnUV3Y+2T0paPrW1OyUvGvfcZzvd/sec4iY6ex2ZNRcyFwFG9+dFvtRcsDRTUE
 QIrkI5vC374QHhhNmd2C0jclut0=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df7175b.7f17c67d63b0-smtp-out-n01;
 Mon, 16 Dec 2019 05:34:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A21AC4479C; Mon, 16 Dec 2019 05:34:18 +0000 (UTC)
Received: from [10.204.79.81] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C542C43383;
        Mon, 16 Dec 2019 05:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C542C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH v3] tracing: Fix lock inversion in
 trace_event_enable_tgid_record()
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, kaushalk@codeaurora.org
References: <20191209142314.4f3e04d6@gandalf.local.home>
 <1575969300-1066-1-git-send-email-prsood@codeaurora.org>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <6754382c-30dd-4ec2-8657-1710d57c750c@codeaurora.org>
Date:   Mon, 16 Dec 2019 11:04:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1575969300-1066-1-git-send-email-prsood@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Please help in reviewing below patch


Thanks

Prateek

On 12/10/2019 2:45 PM, Prateek Sood wrote:
> Hi Steve,
>
> Are you suggesting something like below?
>
>> 8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8
>
>         Task T2                             Task T3
> trace_options_core_write()            subsystem_open()
>
>   mutex_lock(trace_types_lock)           mutex_lock(event_mutex)
>
>   set_tracer_flag()
>
>     trace_event_enable_tgid_record()       mutex_lock(trace_types_lock)
>
>      mutex_lock(event_mutex)
>
> This gives a circular dependency deadlock between trace_types_lock and
> event_mutex. To fix this invert the usage of trace_types_lock and
> event_mutex in trace_options_core_write(). This keeps the sequence of
> lock usage consistent.
>
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> ---
>   kernel/trace/trace.c        | 8 ++++++++
>   kernel/trace/trace_events.c | 8 ++++----
>   2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6a0ee91..4dc93e3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4590,6 +4590,10 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
>   
>   int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
>   {
> +	if ((mask == TRACE_ITER_RECORD_TGID) ||
> +	    (mask == TRACE_ITER_RECORD_CMD))
> +		lockdep_assert_held(&event_mutex);
> +
>   	/* do nothing if flag is already set */
>   	if (!!(tr->trace_flags & mask) == !!enabled)
>   		return 0;
> @@ -4657,6 +4661,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
>   
>   	cmp += len;
>   
> +	mutex_lock(&event_mutex);
>   	mutex_lock(&trace_types_lock);
>   
>   	ret = match_string(trace_options, -1, cmp);
> @@ -4667,6 +4672,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
>   		ret = set_tracer_flag(tr, 1 << ret, !neg);
>   
>   	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>   
>   	/*
>   	 * If the first trailing whitespace is replaced with '\0' by strstrip,
> @@ -7972,9 +7978,11 @@ static void get_tr_index(void *data, struct trace_array **ptr,
>   	if (val != 0 && val != 1)
>   		return -EINVAL;
>   
> +	mutex_lock(&event_mutex);
>   	mutex_lock(&trace_types_lock);
>   	ret = set_tracer_flag(tr, 1 << index, val);
>   	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>   
>   	if (ret < 0)
>   		return ret;
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index fba87d1..995061b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -320,7 +320,8 @@ void trace_event_enable_cmd_record(bool enable)
>   	struct trace_event_file *file;
>   	struct trace_array *tr;
>   
> -	mutex_lock(&event_mutex);
> +	lockdep_assert_held(&event_mutex);
> +
>   	do_for_each_event_file(tr, file) {
>   
>   		if (!(file->flags & EVENT_FILE_FL_ENABLED))
> @@ -334,7 +335,6 @@ void trace_event_enable_cmd_record(bool enable)
>   			clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
>   		}
>   	} while_for_each_event_file();
> -	mutex_unlock(&event_mutex);
>   }
>   
>   void trace_event_enable_tgid_record(bool enable)
> @@ -342,7 +342,8 @@ void trace_event_enable_tgid_record(bool enable)
>   	struct trace_event_file *file;
>   	struct trace_array *tr;
>   
> -	mutex_lock(&event_mutex);
> +	lockdep_assert_held(&event_mutex);
> +
>   	do_for_each_event_file(tr, file) {
>   		if (!(file->flags & EVENT_FILE_FL_ENABLED))
>   			continue;
> @@ -356,7 +357,6 @@ void trace_event_enable_tgid_record(bool enable)
>   				  &file->flags);
>   		}
>   	} while_for_each_event_file();
> -	mutex_unlock(&event_mutex);
>   }
>   
>   static int __ftrace_event_enable_disable(struct trace_event_file *file,

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
