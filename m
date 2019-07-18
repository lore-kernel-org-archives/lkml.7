Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA8AC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469D420873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="NoIcq9Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfGRBXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:23:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39298 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfGRBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:23:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so12953408pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lbzCvZDGyPKPq8F4BmEKa3ahl7R/ac02jNKU8Fy5zIM=;
        b=NoIcq9Pgg0Mfv0npWnMHoeU/qnF5lhl58eJALtFrY84Tu8TfmO9RHdQwTjDDQon+3O
         IZwynXowSYhjoIWJ7IRb+A3ryQ+8+M91j+jgC/OsuhfefUuU9X4dmBbOeMX8czCgeemB
         pmIGtVa5MMqEbHHhK87yCZgXSS+j6c9FMHVEMvzlS2heMTLsbGVqwe9ungZesfcOKALG
         8fwuZrM+XKAjSzFcalCpC9IlaHU2bQNfe5u+wt4curcf3jzCR8jTsYHKWn+2QDB8ucdr
         w+AGJufr+djipqAfO2CwGyimGSgtPoD+piJy5F06vXeR0H1a3Kp1geJqYXimsspyCIXI
         Lv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt:cc
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lbzCvZDGyPKPq8F4BmEKa3ahl7R/ac02jNKU8Fy5zIM=;
        b=Wc7dmJKe5BGMrpLMH7R+s2gAF1tOe3fsBCxyod6/ZMIx9TPsCgdeMSAtbPrFCwZsWH
         wsPd2ESiqEfQvJk8feHaudmnaszAyxNijktKNbCWJTkTdG040h2scqaa1Nvs/sqEcHtl
         LydYFiEIvN3uB1K0ziiQnv2hqP/3s6JD7VisVz0bdvHhq2wMTGI5Q0ggTpK1L8gJAFBu
         PEv5UCAx8dgxnojmhTa5GKtY3s7gwTDbtFALrEIG/28BRDIvUimVvPFC0Y+ZjZ3YeYGp
         KNwicJnhwELiwteplTsjT0tns001otMgR/UR0jQrImybDc0Z7K8uxwUyRU0HZ7URuYWc
         gBgQ==
X-Gm-Message-State: APjAAAXK6/kXSBUKYBzhFQZ2pxR14/XmabJdKGzuM+zESOPQcG2zY3JJ
        i4dmlhEW6jqxbEBBfKlVmtU=
X-Google-Smtp-Source: APXvYqzo9Mjrx3jocSYveWg/mRnuvBro4ngyRW7hHhE5Yq2BZRUaHGtNZCoeYv81ZflKvWgw8mIQRQ==
X-Received: by 2002:a17:902:f301:: with SMTP id gb1mr46176551plb.292.1563413003548;
        Wed, 17 Jul 2019 18:23:23 -0700 (PDT)
Received: from etsukata.local (fs76eecbcd.tkyc008.ap.nuro.jp. [118.238.203.205])
        by smtp.gmail.com with ESMTPSA id r6sm17765963pgl.74.2019.07.17.18.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 18:23:22 -0700 (PDT)
Subject: Re: [PATCH] tracing: Fix user stack trace "??" output
To:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
References: <20190630085438.25545-1-devel@etsukata.com>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com
Message-ID: <1789efd4-1108-64e8-a6aa-39ca5d5595dc@etsukata.com>
Date:   Thu, 18 Jul 2019 10:23:19 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190630085438.25545-1-devel@etsukata.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven

Would you review the patch?

On 2019/06/30 17:54, Eiichi Tsukata wrote:
> Commit c5c27a0a5838 ("x86/stacktrace: Remove the pointless ULONG_MAX
> marker") removes ULONG_MAX marker from user stack trace entries but
> trace_user_stack_print() still uses the marker and it outputs unnecessary
> "??".
> 
> For example:
> 
>             less-1911  [001] d..2    34.758944: <user stack trace>
>    =>  <00007f16f2295910>
>    => ??
>    => ??
>    => ??
>    => ??
>    => ??
>    => ??
>    => ??
> 
> The user stack trace code zeroes the storage before saving the stack, so if
> the trace is shorter than the maximum number of entries it can terminate
> the print loop if a zero entry is detected.
> 
> Fixes: 4285f2fcef80 ("tracing: Remove the ULONG_MAX stack trace hackery")
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
> ---
>  kernel/trace/trace_output.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index ba751f993c3b..cab4a5398f1d 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1109,17 +1109,10 @@ static enum print_line_t trace_user_stack_print(struct trace_iterator *iter,
>  	for (i = 0; i < FTRACE_STACK_ENTRIES; i++) {
>  		unsigned long ip = field->caller[i];
>  
> -		if (ip == ULONG_MAX || trace_seq_has_overflowed(s))
> +		if (!ip || trace_seq_has_overflowed(s))
>  			break;
>  
>  		trace_seq_puts(s, " => ");
> -
> -		if (!ip) {
> -			trace_seq_puts(s, "??");
> -			trace_seq_putc(s, '\n');
> -			continue;
> -		}
> -
>  		seq_print_user_ip(s, mm, ip, flags);
>  		trace_seq_putc(s, '\n');
>  	}
> 
