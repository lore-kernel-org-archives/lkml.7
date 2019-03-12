Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5917C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6292206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMFT+Qvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfCLRYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:24:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53467 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbfCLRYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:24:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so3546508wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wOgQTqUvo1iyRPDgFCgf03Z4Is6gI3Btaz9S11jZwk8=;
        b=uMFT+QvilVASz0m5wFuuNN4DtvrTdrRXacC1NVhzkegcPy6bRVBmUBnVmiHvX+GKWr
         QJREo0f0R6N+5JlvyJiNLB7gzR6erwi9C8PVtLKdT+XXPmfCmrUO74+SYFKIDsTLZnoz
         GyLmOwEtnmUAyufH4/mAbgzDbBHRXaJqJ3pk2JRLnPVObZxGFbRSQOmsQs7yEAIiE2Ki
         IlatRqTAr0mVu/HxJO2Fe5dWqfXlUzwUH1jk6vxzfRf0Dpqz+e+Te1hW8rbSLrarD/Q+
         pxR7Lf2fzSOctfHde14zILp+u82HPjzt9N2ckqIfL9coJon7c6PRbrM5fMGNl738ShG+
         wT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wOgQTqUvo1iyRPDgFCgf03Z4Is6gI3Btaz9S11jZwk8=;
        b=ZnjnNIMqfoQpyITayPjtG7yL10ZTCIHDDBYTmXuvR5oEUMvQg5tbyELL3bCLTQaz3I
         PmgrzIAr+lZ/+FG/43o3+TwyG9tzmK9a/JtQT+DfxpIkkvv9EZ9RsKITdkfRs8No2YSk
         xSgLKIr9K6h33670KiAyPSYkDGBtbyfvttF2uNXFzzvfcjeOeWPsevFlO3k5I+xy5tex
         cVOlLO4PQmywKquvvQuJPlgdzZXWFd+U3l0WAnZU7izWuFvezJOzQrkoJPKYB/MBuIOJ
         CGD9W1yz/hdsjQEOMTNcCOx8J68Z79R+MdPvdKYA0ln1RYIvIlyV1MbNgbZht4CdlBMD
         gHsQ==
X-Gm-Message-State: APjAAAXV4JZDWOA8E4rbnQNYrpyAzSFquUHIUOwCbV9X/hk8ATvbzBm6
        C61QYVGm7hzp6UXoUdEzHPXIgME=
X-Google-Smtp-Source: APXvYqzm0YuHgIffCWl959fI6P5ljt7NDrxvh65geOpJONceWPTJmANJTOOowGZ5yWotMNhsjlyh4Q==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr3285148wmi.3.1552411489985;
        Tue, 12 Mar 2019 10:24:49 -0700 (PDT)
Received: from avx2 ([46.53.244.87])
        by smtp.gmail.com with ESMTPSA id p12sm7993742wrt.4.2019.03.12.10.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 10:24:49 -0700 (PDT)
Date:   Tue, 12 Mar 2019 20:24:47 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop -Wdeclaration-after-statement
Message-ID: <20190312172447.GA10166@avx2>
References: <20190310133535.GA20473@avx2>
 <20190311173845.53c2e4e4d2257a3701fa2033@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311173845.53c2e4e4d2257a3701fa2033@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:38:45PM -0700, Andrew Morton wrote:
> On Sun, 10 Mar 2019 16:35:35 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Newly added static_assert() is formally a declaration, which will give
> > a warning if used in the middle of the function.
> > 
> > ...
> >
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -792,9 +792,6 @@ endif
> >  # arch Makefile may override CC so keep this after arch Makefile is included
> >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> >  
> > -# warn about C99 declaration after statement
> > -KBUILD_CFLAGS += -Wdeclaration-after-statement
> > -
> >  # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
> >  KBUILD_CFLAGS += $(call cc-option,-Wvla)
> 
> I do wish your changelogs were more elaborate :(

> So the proposal is to disable -Wdeclaration-after-statement in all
> cases for all time because static_assert() doesn't work correctly?

Yes. I converted 2 cases in /proc to static_assert() and you can't write

	{
		[code]
		static_assert()
	}

without a warning because static_assert() is declaration.
So people would move BUILD_BUG_ON() to where it doesn't belong.

> Surely there's something we can do to squish the static_assert() issue
> while retaining -Wdeclaration-after-statement?

It is not good in my opinion to stick to -Wdeclaration-after-statement.

> Perhaps by making
> static_assert() a nop if -Wdeclaration-after-statement is in use. 
> Perhaps simply by putting { } around the static_assert()?

Making a statement out of it would disable current cases where it is
placed in headers.
