Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B9D20833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuhsGbvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfDBC3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:29:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34081 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:29:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so5749939pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 19:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JncuGoN6JseQTJjArJxA4ZDxHpYBXn9E6IFuajhHbAc=;
        b=BuhsGbvfeEBuVnLpTkKNB3DOknNTK8mXBOd3pKqi7OEamHoibxo//4L/zfVX0GNuIo
         6s7umJ9NjsRfIYss2gX6UTr+HUf0ZPt7Q8fAG61lLhzaP7s274ThDbMbLoApqq9eVuPE
         X4MZ1Tb3VRXk+BZ/aJzaMptcU0iLAsURXMs8U8DBBELLbZn5980LizAReYBIwNeeomhq
         KwHUJThI4FZxMNCzjQKKxxIxXFHRJaeB/9RL8BcDAlR2Ze/jsxbNFHqIiUo9LCM4UPzc
         xjRFNc+RZTdXZYjfOUSr1HSgQMCbuyh/D8lSOQjRRjsfMGTSuWlgt1stLY9+NsWjxuwp
         AvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JncuGoN6JseQTJjArJxA4ZDxHpYBXn9E6IFuajhHbAc=;
        b=aZHV+YpWBSvPwjSUQCVEv7kZFtgl8kli5XeDh5itRZIL5jW8Bo4u7NyLIHXxE9ahdX
         iA2vsoOxBJehz0lrjdk/r14EAUPG2LXDpAsk7ZjDX+AsEbZJZkivZidKklibxp1QWOpE
         p4br/V0gbxXEUvMiwRNF3WPpf1ZdBDvRaLKfBqZ4sqd+pJCWVD3oUpI3Wa/6l9uB2+U+
         3kKBz97qWRcqzm88XJM95eFBtT+qjWnJZT3ASaME80HiIjuwlb2esTHXHipHshilArBk
         mb2CU9kU6DgF+11uroXQjMwMlt1dI6DrDgslTC/IboNSZNvPYYImYuzU0UMNgPYFoya4
         I1+Q==
X-Gm-Message-State: APjAAAUgePJdsS37usYw4avw5Paz95Lbu7WY6KGF8DVmVbi0AJxxL9xm
        JWUdLH0jn100Qql6uMxs6Cs=
X-Google-Smtp-Source: APXvYqwXmEeAMtrnQfc8VhrB7ILDgbv/gpnuJScUovvrLv5OpPEpm/1++NdWggdnmrQaulchY0MGJw==
X-Received: by 2002:a63:4a5a:: with SMTP id j26mr54465712pgl.361.1554172144182;
        Mon, 01 Apr 2019 19:29:04 -0700 (PDT)
Received: from localhost ([175.223.14.1])
        by smtp.gmail.com with ESMTPSA id e184sm17742763pfc.143.2019.04.01.19.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:29:03 -0700 (PDT)
Date:   Tue, 2 Apr 2019 11:29:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] printk: Add an option to flush all messages on panic
Message-ID: <20190402022900.GA2219@jagdpanzerIV>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <20190402021419.GA617@jagdpanzerIV>
 <20190402022840.et7sbiamxeutbw2q@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402022840.et7sbiamxeutbw2q@shbuild888>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/02/19 10:28), Feng Tang wrote:
> > So my first thought was - let's not add a `bool flag', but instead add
> > an `enum' with clear flag names, e.g. DUMP_ALL/DUMP_PENDING, etc. Something
> > similar to what ftrace_dump(DUMP_ALL) does. And we already have panic_print
> > bit-mask and panic_print_sys_info(), which controls what we print when in
> > panic. So we can move console_flush_on_panic() to panic_print_sys_info()
> > and handle different types of console_flush_on_panic() there:
> > 
> > ---
> > 
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 0ae0d7332f12..e142faaebbcd 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -134,6 +134,11 @@ EXPORT_SYMBOL(nmi_panic);
> >  
> >  static void panic_print_sys_info(void)
> >  {
> > +	if (panic_print & PANIC_PRINT_REPLAY_LOGBUF)
> > +		console_flush_on_panic(DUMP_ALL);
> > +	else
> > +		console_flush_on_panic(DUMP_PENDING);
> > +
> >  	if (panic_print & PANIC_PRINT_TASK_INFO)
> >  		show_state();
> >  
> > @@ -277,7 +282,6 @@ void panic(const char *fmt, ...)
> >  	 * panic() is not being callled from OOPS.
> >  	 */
> >  	debug_locks_off();
> > -	console_flush_on_panic();
> >  
> >  	panic_print_sys_info();
> >  
> 
> I guess this is what my 2/2 patch exactly does :)

Oh, indeed... I didn't check 2/2.

	-ss
