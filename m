Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D69CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5699521911
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZYBmpd+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfGVSSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:18:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36969 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGVSSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:18:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so19529823plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f+EvBU2cPVBzM8PQ0FPDkzwG1E5GGkfBBtHwRsmRpjI=;
        b=ZYBmpd+QBrrVXlTK80i48wnPMVkuOFnOheaJJPa7CGBslM3kfiEjlsUUileul+y/aT
         sIyTmJA3zTEgA4futpEx4QeCiF58mu2sy2Plk5rYoLOT56z9exBHdAGcoW7XCL2HrC6I
         eghfkV6cAjTGylFDeXx6QQkUYPxrumHx0+ts4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+EvBU2cPVBzM8PQ0FPDkzwG1E5GGkfBBtHwRsmRpjI=;
        b=hn3xBFWXKYkuY5gLOz3N0Xn9P5yQwiZFFqy1hbgfUBrNfHP7fpz+c6nLbJfjWqlQSw
         gE3OqyvZWsc7HCjnfVRdPOKfQQCA5l6zr/x6td7hTKQKfK7gLVDsTLeRu7E7MFU9xVzN
         kvq8akD1Y+tMa1yPxSbXx5qsTIiLd5E3H6Hdrj01aM+pa59LS+LwDtAIIqhf20zfYYSe
         I3buoKfCHPPpdXVy28FgfMXX+Z100i7GPpcDwjE+4+OsG2lMK5oCf6bPjmW18lvJ1SeK
         xRFMoay2m9HTuPIz+kvzdk85tjelvcrDKJL/pbNaoOJICVpRWfLHhwB3LsQt4rJJ5EuK
         ExkQ==
X-Gm-Message-State: APjAAAXvH1c7wbGUTfIxLGqdVyE4Rq18gl8Ja8OOO8gZSAY7BL+TGwdo
        CsVQOfgqeRDhJvmm4PWshiAdHg==
X-Google-Smtp-Source: APXvYqzKgLF223uw/JHxlrlAFM0A7p9yaZS2vEzbwf0/Z3V+zNZe1QVoP/BadRa/bU48/bFGR0+qBQ==
X-Received: by 2002:a17:902:744c:: with SMTP id e12mr76102154plt.287.1563819493921;
        Mon, 22 Jul 2019 11:18:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r18sm30269979pfg.77.2019.07.22.11.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 11:18:13 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:18:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] libata: zpodd: Fix small read overflow in
 zpodd_get_mech_type()
Message-ID: <201907221117.254D219F9E@keescook>
References: <201907192038.AEF9B52@keescook>
 <CAKwvOdkkqhwHz_yLN5VjAdENj3qtwdJ080QKpQ9vr--F1xQPhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkkqhwHz_yLN5VjAdENj3qtwdJ080QKpQ9vr--F1xQPhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:40:40AM -0700, Nick Desaulniers wrote:
> On Fri, Jul 19, 2019 at 8:41 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
> > eject_tray()"), this fixes a cdb[] buffer length, this time in
> > zpodd_get_mech_type():
> >
> > We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
> > ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.
> >
> > The KASAN report was:
> >
> > BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
> > Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
> > ...
> > The buggy address belongs to the variable:
> >  cdb.48319+0x0/0x40
> >
> > Reported-by: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
> > Fixes: afe759511808c ("libata: identify and init ZPODD devices")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Interesting, both initializer lists are less than ATAPI_CDB_LEN (16)
> elements, yet ata_exec_internal_sg() in drivers/ata/libata-core.c very
> clearly has a ATAPI_CDB_LEN byte memcpy on that element.  Probably
> both initializer lists should just lead off the trailing zero's or
> provide the entire 16 elements.  For now, thank you for the patch.

Yup, with the specific size added it'll be zero-padded.

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

-Kees

> 
> > ---
> >  drivers/ata/libata-zpodd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
> > index 173e6f2dd9af..eefda51f97d3 100644
> > --- a/drivers/ata/libata-zpodd.c
> > +++ b/drivers/ata/libata-zpodd.c
> > @@ -56,7 +56,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
> >         unsigned int ret;
> >         struct rm_feature_desc *desc;
> >         struct ata_taskfile tf;
> > -       static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
> > +       static const char cdb[ATAPI_CDB_LEN] = {  GPCMD_GET_CONFIGURATION,
> >                         2,      /* only 1 feature descriptor requested */
> >                         0, 3,   /* 3, removable medium feature */
> >                         0, 0, 0,/* reserved */
> > --
> > 2.17.1
> >
> >
> > --
> > Kees Cook
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 
Kees Cook
