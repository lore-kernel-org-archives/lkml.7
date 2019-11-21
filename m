Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3318AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1228E2068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKUOIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:08:12 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37360 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:08:12 -0500
Received: by mail-oi1-f196.google.com with SMTP id y194so3278188oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzRJ35Zp4BTqx9Mq1SQKqk4ePtQGbumxi9+L4hDtyxo=;
        b=cK/H4L8LPYW4+QehxZBpRUXTfOSq3fe+WLuYnSek7pIUA/Ae4Iy7M9Go4NgLKwblQS
         yjS/LSdJeS+OY/naiXHbyeZOy9JaV9iPEEKNExCrmVo7WDkfjU8oKiuwwZaJn8btYhct
         kfzt2py1TqUXzO0kPNxbzI16wwmpRZoSHkJeKgAcBi70R5wpefj2qCK0Br7cs7PtI+dO
         TCLQSdUvrNEg07bEGkmiRlm9oUcCDQnnZ/rRsNQ7Izk4ausFJNjiGMa8cuq6p2hiHnn8
         6IORomaSxnj5KanCbeot8irOP7brxixB5cY1IzEmoT+vJbTQSCXPN/OOPo6yiZq8NMs8
         25iQ==
X-Gm-Message-State: APjAAAWRP19c+AexTcAR0bkxHWxJ4fYAVScLLMaFENT735+xhNsJrtN1
        CwsyoQcTKP4OHSH6sqoOFlOr51rs19bOgSjLGAQ=
X-Google-Smtp-Source: APXvYqzBtKjZOtNmCsLmqQu4i5bJfdamTNwuqvv1NbfvaDavvqjMk4leMbOYunrIvMUpb6A5NO2xmmXE3Y+0mQCDavg=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr7470039oia.131.1574345291569;
 Thu, 21 Nov 2019 06:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20191120143619.1027-1-geert+renesas@glider.be>
 <20191120143619.1027-3-geert+renesas@glider.be> <20191121135743.GA552517@kroah.com>
In-Reply-To: <20191121135743.GA552517@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Nov 2019 15:08:00 +0100
Message-ID: <CAMuHMdVSBFfmYQkYhu-R0i4y0wen0zMnVRZvkFL2SNOgVxhouA@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: Print device in really_probe() warning backtrace
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Nov 21, 2019 at 2:57 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 20, 2019 at 03:36:19PM +0100, Geert Uytterhoeven wrote:
> > If a device already has devres items attached before probing, a warning
> > backtrace is printed.  However, this backtrace does not reveal the
> > offending device, leaving the user uninformed.
> >
> > Use dev_WARN_ON() instead of WARN_ON() to fix this.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -516,7 +516,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >       atomic_inc(&probe_count);
> >       pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
> >                drv->bus->name, __func__, drv->name, dev_name(dev));
> > -     WARN_ON(!list_empty(&dev->devres_head));
> > +     dev_WARN_ON(dev, !list_empty(&dev->devres_head));
>
> We really do not want WARN_ON() anywhere, as that causes systems with
> panic-on-warn to reboot.
>
> If this can happen, we should switch it to a real error message, with
> dev_err() and the like, and recover properly.

If this happens, there's something serious wrong with resource management,
beyond recovery.

> I don't want to make it easier to add WARN_ON() lines, like
> dev_WARN_ON() would allow, instead we should be removing them, as they
> encourage slopping programming habits.

OK, will respin, using dev_warn().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
