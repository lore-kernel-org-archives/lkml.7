Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E0AC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728132184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjo+wyDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfDRAAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:00:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33955 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDRAAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:00:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so262736plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PH0BWaeZBYyHBkNVuDHXcFcEioCoZhwO44ywYgKNc6M=;
        b=Qjo+wyDnfa5/ECxZfLqPwN2/GqOBsQef4vpOX7a8RUb1AN726Sfy5vXE2XiihrXYiN
         Mt9g/rwumNRBiNu/gvfyA4sIP/jQWEDp3tAIgVfuOTdVZ3bf3MSamUlcibM2X2KnIvBb
         FPSMGOe2chS+DPm7l072kl5PrXHsmgcoSmnXbEL4pD9iC3U+CyIuQgAIgt0PH27Hxzbu
         lafmytVXphICKq0phihiMu0XdZ++iYyJglARs+38TJyuSZXvzSldpW+uHUqn2ypEPvBE
         3qXOqcPQXrh/Ca7V5Wz1DkwXUSUeMNjVOcMp8V8aXM1o8NOUJGlmC3UYxHvitU15ad+/
         hA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PH0BWaeZBYyHBkNVuDHXcFcEioCoZhwO44ywYgKNc6M=;
        b=l1aCI425hE+KnagjRH6vllQU5iGllFwvFPargEJ/dLNmnJzb6+7RzNn87dzCwscrQG
         Fo4WPT+Ykbs1d2d8qnIz2M4BZxsGJ8lVH1iPqnsxusouiCsFfRUZubT7N237NeA6BkZr
         GYKkX45M+6cnvaiWg8Gkacfjg9kGtLXfq/PckLa3H0S6IDR5Rpy7IHGsKyY+Z0FrZ2y3
         y8lCLUS3G0aeCkTxxyfm7sAPbmVtph4WbVpxxJTqP9hNqMab+gx3+h9b4Z+9Cg2AS8JF
         v+CxL3CK2wSw+QGmDRf+K/OKhN1U3f11U2bn/CSaTkdhHxB3v8sY2xZc4i+7aX8SUVPW
         HlTg==
X-Gm-Message-State: APjAAAX3cuveLTAZzCgr+kGHdSIZHZrHviyXTJmI/fvPoiC/h4xCW2ju
        xBVQ5VHTK7RM+I8U7ST9in8=
X-Google-Smtp-Source: APXvYqy1NQhvNScPl5csQZKPmD4/RIayT88vYfoEvPEvJ/8vD+0D+W2j0nvdigXpomalFVn1PEwwuw==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr38710117plp.294.1555545619240;
        Wed, 17 Apr 2019 17:00:19 -0700 (PDT)
Received: from localhost ([110.70.26.132])
        by smtp.gmail.com with ESMTPSA id x5sm391895pfi.91.2019.04.17.17.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:00:18 -0700 (PDT)
Date:   Thu, 18 Apr 2019 09:00:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, ying.huang@intel.com
Subject: Re: [PATCH v2] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190418000014.GA2059@jagdpanzerIV>
References: <20190410153718.22905-1-feng.tang@intel.com>
 <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
 <20190417064844.ppyqxcx2mgek5455@shbuild888>
 <20190417091832.z252cvcf4ktxeamv@pathway.suse.cz>
 <20190417094614.GB4260@jagdpanzerIV>
 <20190417105010.GA8492@jagdpanzerIV>
 <20190417122458.mhl3orevzha7sp6h@pathway.suse.cz>
 <20190417151817.xsun2k7cxff5rknn@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417151817.xsun2k7cxff5rknn@shbuild888>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/17/19 23:18), Feng Tang wrote:
> > > +++ b/kernel/printk/printk.c
> > > @@ -2549,6 +2549,14 @@ void console_flush_on_panic(void)
> > >  	 */
> > >  	console_trylock();
> > >  	console_may_schedule = 0;
> > > +	if (flush_mode == CONSOLE_FLUSH_ALL) {
> > > +		/*
> > > +		 * Can be done under logbuf lock, but it's unlikely that
> > > +		 * we will have any race conditions here.
> > > +		 */
> > > +		console_seq = log_first_seq;
> > > +		console_idx = log_first_idx;
> 
> This is very similar to my V1 patch :), excepted I used a bool
> as the parameter.

Yes it is :)

I will reply to Petr's and Feng's email.

> > I agree that it is easier. The cost is that the same messages are
> > printed again without any explanation.
> > 
> > I still think that it would be convenient to write a header line.
> > It would help to understand the log for any, even 3rd-party, reader.
> > Also it would help to find the beginning in a very long log.
>
> My thought is, the replay is only a debug option and disabled by default,
> so when user specifically enable the bit of PANIC_PRINT_ALL_PRINTK_MSG,
> the whole replay of printk msg should be expected.

I think that PANIC_PRINT_ALL_PRINTK_MSG is a debugging option; a quite
specific one. So people who ask the kernel to PANIC_PRINT_ALL_PRINTK_MSG
they know what they are doing, and we probably will not cofuse anyone.
After all, we don't print any headers when we ftrace_dump() or imitate
sysrq via sysrq_timer_list_show(), or for any other panic_print_sys_info()
printouts. So it's OK to just do the simple thing for
PANIC_PRINT_ALL_PRINTK_MSG.

	-ss
