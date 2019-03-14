Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B116C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB41F2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q659j779"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfCNVFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:05:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39061 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfCNVFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:05:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id i20so4682589pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BP0btLgzdlLEmSaLrJGxpO88AlAWxf1QFIm0r4SJRoE=;
        b=q659j779fcivHH03sd8DVq4CpdHYIrtwHk28PcW0pWTvd5b07Wt3NWPxuTJqUtJiei
         SrMIYc9Jd1ATp7SD4Ojq2G/IXbx6sxV8kL+4W8acIdlfSl85SCPzq7vvgv9BcH+B9TBD
         m8m9n3gLq56nTQBBbsiq4Ci56YkG4dKnntgW5+sy922jwT/YNOpmKRe236JOtibQj9RM
         EjNg6jmrctnI3nrbm2oml5feUPMoGEJNDyS5PwTWP3xxDuxQ+bfmQcGneUFn58+Ujtgz
         64QwJreeoFkTxGMmnZxkxH7k/tJ1OSdNG5csGXq88SmDxqdEajwEKtIuJ99/ODtV5lcN
         bQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BP0btLgzdlLEmSaLrJGxpO88AlAWxf1QFIm0r4SJRoE=;
        b=KmPdH7n9derlImo0PL9qPFD97//+IW16DyCq1IQmOdRKipQp7xMVfPAZ2WSPJT00eJ
         l45KPKcMeIlWVw5/RBTlbm2lljHNcymexF5xiCvZr0UUIucuRG5Lzx3swmNZz2U8YazD
         Xjji/z4gtXry4X//1Q9PWwMEZMt7oKRrbUi927h/2MW+c8bWaea8VcHs0X/tx0M2OLJw
         WmjU3qyrcztZIRNeXFvHnJ3ztvxsu5izQXz2pTzID8D1poioDZFXtYX2DckJuE4QK2LN
         qIGEe8juURM9ysIT3hSishK7h84QxCSd6IIhd8WwTsZVfhLEHYfxY0KlalTmz+jNMirH
         EqXg==
X-Gm-Message-State: APjAAAW9xj1wiabT5KZ0HlfBCIGltXw7FykTCbWvCntiAjk+wB41BwNl
        X+F1aWx3j5bzgLcmQrUu+nwyY3nF
X-Google-Smtp-Source: APXvYqxQ9GFeHtQisMGhqHAC1fzw92Z+lLkVS9b7J49dq1a7GHAvMv/w6pqewxeBYE7DN/VrNQZzkg==
X-Received: by 2002:a63:145b:: with SMTP id 27mr46115164pgu.74.1552597505236;
        Thu, 14 Mar 2019 14:05:05 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h127sm12854pfg.65.2019.03.14.14.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:05:04 -0700 (PDT)
Subject: Re: [PATCH] tracing: initialize variable in create_dyn_event()
From:   Frank Rowand <frowand.list@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <1548382670-30266-1-git-send-email-frowand.list@gmail.com>
Message-ID: <2872713a-8b99-5117-27df-eeda824e55a0@gmail.com>
Date:   Thu, 14 Mar 2019 14:05:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548382670-30266-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Ping.

-Frank


On 1/24/19 6:17 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Fix compile warning in create_dyn_event(): 'ret' may be used uninitialized
> in this function [-Wuninitialized].
> 
> Fixes: 5448d44c3855 ("tracing: Add unified dynamic event framework")
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Compile and boot tested only.  Please verify the initialization value
> of zero is correct.
> 
> There is also a sparse warning you might want to check into (when
> ARCH=arm, so 32 bit):
> 
>    include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
> 
> 
>  kernel/trace/trace_dynevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index dd1f43588d70..4f633476c307 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -74,7 +74,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
>  static int create_dyn_event(int argc, char **argv)
>  {
>  	struct dyn_event_operations *ops;
> -	int ret;
> +	int ret = 0;
>  
>  	if (argv[0][0] == '-' || argv[0][0] == '!')
>  		return dyn_event_release(argc, argv, NULL);
> 

