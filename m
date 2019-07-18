Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0889C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8434021849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eKO2yoYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbfGRVfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:35:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37907 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRVfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:35:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so13202161pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KkttYUYXAWuWBOKGYfn41xR+6vj7CFYrcZ8YCFpnCUQ=;
        b=eKO2yoYFYu3Tnhrp1Rx1k9pfRxTZSm6XeyDXK0qTzarYNq4CcveUMKhrhOO+L5z1eb
         Xt/N0Fp8730Doh929vOfA27ApjGm1UoMAjfMzvuMUSKbuSekYJHMP0l80bRqM1BUWaK9
         Xx3cNZlgKViPwsCWwRg9KpWHaAJnOx4HYCR4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KkttYUYXAWuWBOKGYfn41xR+6vj7CFYrcZ8YCFpnCUQ=;
        b=tXCopVkipdiNGny/B7pUbNGef29389jwd1vuVPL5uTB7Kkpx/IKy4maMFeCGYzZSJt
         Ic8IAPgO/5FZnFJ4CxD7ZDeCimfHB1IXuw8PfzszcsfVhhPB9mixyrSzP942HiIC9ipX
         me1jRtr5P6fEOXGyjRJWqVSivJyK6c5Y/mJBQlcetlcj8HNAA4fpzzkTC41w0CYSrBx1
         cWyEutydLYJLzOz8w9lMedjJcvZ6E6BhD8yKyG2YbrcqEkgjhjyltP0prtgdHVgITdx/
         /igYX4V1ZC4zgVDlCZqPcY6NFjb76saHpyhqUieOhpipQeqPZIDpQRtjSngvyQvX8iiI
         tg6Q==
X-Gm-Message-State: APjAAAWqibsgOgBXSmye79gKJLiVdRbFBoBr6kMJXMbrQj+b+aRBgBRn
        bJkujBbur4qCsDr5p/fg1FonorC3VD4=
X-Google-Smtp-Source: APXvYqzT0fTv1kapezScaDAMcftkI5shhKzLtvdMSdOzSbWnd4qnblZzQQlOIUWe2GaTzsbtqlc/dA==
X-Received: by 2002:a63:3fc9:: with SMTP id m192mr50998872pga.429.1563485747382;
        Thu, 18 Jul 2019 14:35:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm23169608pjj.2.2019.07.18.14.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 14:35:46 -0700 (PDT)
Date:   Thu, 18 Jul 2019 14:35:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: BUG: KASAN: global-out-of-bounds in
 ata_exec_internal_sg+0x50f/0xc70
Message-ID: <201907181423.E808958@keescook>
References: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
 <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:28:29AM -0700, Nick Desaulniers wrote:
> On Wed, Jul 10, 2019 at 10:44 AM Jeffrin Thalakkottoor
> <jeffrin@rajagiritech.edu.in> wrote:
> >
> > hello all ,
> >
> > i encountered a KASAN bug related .    here are some related information...
> >
> >
> > -------------------x-----------------------------x------------------
> > [   30.037312] BUG: KASAN: global-out-of-bounds in
> > ata_exec_internal_sg+0x50f/0xc70
> > [   30.037447] Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
> >
> >
> > [   30.039935] The buggy address belongs to the variable:
> > [   30.040059]  cdb.48319+0x0/0x40
> > (gdb) l *ata_exec_internal_sg+0x50f
> > 0xffffffff81c7b59f is in ata_exec_internal_sg (./include/linux/string.h:359).
> 
> So looks like ata_exec_internal_sg() is panic'ing when...
> 
> > 354 if (q_size < size)
> > 355 __read_overflow2();
> > 356 }
> > 357 if (p_size < size || q_size < size)
> > 358 fortify_panic(__func__);
> > 359 return __builtin_memcpy(p, q, size);

^^^ here, so within memcpy(), but after the "easy" sanity checks.

The only place where I see ata_exec_internal_sg() calling memcpy() is
here:

        /* prepare & issue qc */
        qc->tf = *tf;
        if (cdb)
                memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);

the "16" is consistent with the report:

include/linux/ata.h:    ATAPI_CDB_LEN           = 16,

which matches the claim about the cdb variable from KASAN. And it's a
read, so "cdb" is wrong. Do you have a longer back trace? What called
ata_exec_internal_sg()?

ata_exec_internal() is the only caller of ata_exec_internal_sg(). Nearly
all callers of ata_exec_internal() pass a NULL cdb. Those that don't
are:

atapi_eh_tur()
	u8 cdb[ATAPI_CDB_LEN] = ...
atapi_eh_request_sense()
	u8 cdb[ATAPI_CDB_LEN] = ...

These two are on the static and correctly sized.

eject_tray()
        static const char cdb[ATAPI_CDB_LEN] = ...
zpodd_get_mech_type()
	static const char cdb[] = ...

These are both in rodata, and only the first is correctly sized. I
assume the following will fix it:


diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 173e6f2dd9af..eefda51f97d3 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -56,7 +56,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 	unsigned int ret;
 	struct rm_feature_desc *desc;
 	struct ata_taskfile tf;
-	static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
+	static const char cdb[ATAPI_CDB_LEN] = {  GPCMD_GET_CONFIGURATION,
 			2,      /* only 1 feature descriptor requested */
 			0, 3,   /* 3, removable medium feature */
 			0, 0, 0,/* reserved */



-- 
Kees Cook
