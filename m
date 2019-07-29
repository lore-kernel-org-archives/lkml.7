Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A78C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0F6217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="mC+Tkr3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbfG2TfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:35:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44101 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387510AbfG2Te7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:34:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so28751173pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byWzZ+ebvntD/pIF8IWQsVrt4IxJU9AaeSArf/PQmE0=;
        b=mC+Tkr3ExXxYMOrEnO8QAI/6QlDfVo3EnBsIjar9B7b2AV1wZNgMJrpXVf6a10+XC0
         NxpRho35xFarKvktehtjUImE2nh6kUVJkP/Tof27ACvq3IrGat1mmauAqM68d6QZx9S7
         9AkGXwAp+0ozTatv3CSna0bUpVkkEgQnAgaX40/pODjNnYwZn9RIEhDD99IBBYbzUeVb
         HSORXq3HztcTOacZ7x9QsJTmu2OtKbcg00mi3nNFcRP6wO9JHCrS6Uny/T7YWHJbfYWY
         PlE4WCr63+g4QIxBv47YCYzOt+WuRjHrdawV70moxjheGhGHqwhTcunw3jPhj75++7zm
         A73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byWzZ+ebvntD/pIF8IWQsVrt4IxJU9AaeSArf/PQmE0=;
        b=NpQJnbe4Iqr9M/wd8SDjgP06jyEitVKogCe9sNAWl9/+RJM/KvXqQn4TQXt+sNnUSm
         pBqRQc0KRdB9fJ6LsrAL4a0QZfeWWNWw3Gj/R+J4bt/upt/4v27cvRzKnoNm4ANwBhof
         LlMvLzbHUUtfn8NI1tqibp0vM7O02hGNK2xAB03h5JNkGybYtxUmZ8MuYJgAOpQefDBB
         wqdvznlNuEV5IKnnhQFCgdBrDaLdUKF6/i1QHffFAk8GAa0JubSuWlXgvzP7o8uE9SdG
         2WXbkiL3uZpgijpt7qak/ReFVqVahKQ6qBF9y8BCUS0pH5V6X2UpBG4oiF/SLDV0eK1k
         Y/pw==
X-Gm-Message-State: APjAAAX7jPlRC8TpSvL5BJcQfYxSPdXLh+sMpZA3I4NVx89NVzDNo2wn
        U5Ebm+IbywNGSVyFSUBNxfsbh0/o8pxCRe3A82yuMg==
X-Google-Smtp-Source: APXvYqwUtusKdriEytqu3Mo88BMqu1nwBnQlRuKdgqlJiIOMjckKv9aqtzaRWLkkP5qg+5jFSBu8VQGexGKhuv1D7vg=
X-Received: by 2002:a62:3895:: with SMTP id f143mr37735364pfa.116.1564428897838;
 Mon, 29 Jul 2019 12:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
 <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com> <201907181423.E808958@keescook>
In-Reply-To: <201907181423.E808958@keescook>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Tue, 30 Jul 2019 01:04:17 +0530
Message-ID: <CAG=yYwmTdW0THoVGJc-Le+TyGMaHKZD-NHTRfXczNes65T8qWA@mail.gmail.com>
Subject: Re: BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello Kees Cook,

i tested your fix and i think it worked like a charm !
kasan message related disappeared during boot time and it does not
show in the output of "sudo dmesg -l err"
anyway thanks a lot !

On Fri, Jul 19, 2019 at 3:05 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jul 16, 2019 at 11:28:29AM -0700, Nick Desaulniers wrote:
> > On Wed, Jul 10, 2019 at 10:44 AM Jeffrin Thalakkottoor
> > <jeffrin@rajagiritech.edu.in> wrote:
> > >
> > > hello all ,
> > >
> > > i encountered a KASAN bug related .    here are some related information...
> > >
> > >
> > > -------------------x-----------------------------x------------------
> > > [   30.037312] BUG: KASAN: global-out-of-bounds in
> > > ata_exec_internal_sg+0x50f/0xc70
> > > [   30.037447] Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
> > >
> > >
> > > [   30.039935] The buggy address belongs to the variable:
> > > [   30.040059]  cdb.48319+0x0/0x40
> > > (gdb) l *ata_exec_internal_sg+0x50f
> > > 0xffffffff81c7b59f is in ata_exec_internal_sg (./include/linux/string.h:359).
> >
> > So looks like ata_exec_internal_sg() is panic'ing when...
> >
> > > 354 if (q_size < size)
> > > 355 __read_overflow2();
> > > 356 }
> > > 357 if (p_size < size || q_size < size)
> > > 358 fortify_panic(__func__);
> > > 359 return __builtin_memcpy(p, q, size);
>
> ^^^ here, so within memcpy(), but after the "easy" sanity checks.
>
> The only place where I see ata_exec_internal_sg() calling memcpy() is
> here:
>
>         /* prepare & issue qc */
>         qc->tf = *tf;
>         if (cdb)
>                 memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
>
> the "16" is consistent with the report:
>
> include/linux/ata.h:    ATAPI_CDB_LEN           = 16,
>
> which matches the claim about the cdb variable from KASAN. And it's a
> read, so "cdb" is wrong. Do you have a longer back trace? What called
> ata_exec_internal_sg()?
>
> ata_exec_internal() is the only caller of ata_exec_internal_sg(). Nearly
> all callers of ata_exec_internal() pass a NULL cdb. Those that don't
> are:
>
> atapi_eh_tur()
>         u8 cdb[ATAPI_CDB_LEN] = ...
> atapi_eh_request_sense()
>         u8 cdb[ATAPI_CDB_LEN] = ...
>
> These two are on the static and correctly sized.
>
> eject_tray()
>         static const char cdb[ATAPI_CDB_LEN] = ...
> zpodd_get_mech_type()
>         static const char cdb[] = ...
>
> These are both in rodata, and only the first is correctly sized. I
> assume the following will fix it:
>
>
> diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
> index 173e6f2dd9af..eefda51f97d3 100644
> --- a/drivers/ata/libata-zpodd.c
> +++ b/drivers/ata/libata-zpodd.c
> @@ -56,7 +56,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
>         unsigned int ret;
>         struct rm_feature_desc *desc;
>         struct ata_taskfile tf;
> -       static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
> +       static const char cdb[ATAPI_CDB_LEN] = {  GPCMD_GET_CONFIGURATION,
>                         2,      /* only 1 feature descriptor requested */
>                         0, 3,   /* 3, removable medium feature */
>                         0, 0, 0,/* reserved */
>
>
>
> --
> Kees Cook



-- 
software engineer
rajagiri school of engineering and technology
