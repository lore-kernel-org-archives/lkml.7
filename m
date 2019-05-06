Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CAAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6D720B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY/3izGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEFMXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:23:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45197 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFMXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:23:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so6373471pgi.12;
        Mon, 06 May 2019 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7G2qcndlUs9UKH2SYP/ADID5gQNBuli4FP7HtNrbCsw=;
        b=AY/3izGGQclzoxGpWfiTX6DsKUPMjNtIiCPh3BAnnK6NoU6Zh2O/mDOVPPrywW5mBi
         N/govuaxkHgagpgBzTwp3QLT2CWckqU0CxIEN1r3mxSgYcGcCJZkHv/V7hfm4zrc1jQV
         +zK7oZtIlx+TtZE7uV7cIE8QQbtEoAuFnjphHBO1cwiEZsYTeyoDF4rJJ1yAxdJsSjLz
         qBpyIdjn5/0hwqQbo3BDTCf6/e/DVez1RD9Xj35L56p77XzD2x1zI+I6y5qvDG7vDZ6w
         XRB2+xpd1p2LNdSkg8q7CXA/fesD9saBbbtwF+JsvN9N9n1+ojMC8WuF+aXR8gBVbACe
         vfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7G2qcndlUs9UKH2SYP/ADID5gQNBuli4FP7HtNrbCsw=;
        b=pXPizUtBjJpxBDvBCX+R7aU8G/4w7+Kc3Glo+pQ9c2ZBfMMKwyr8Fp1Y3A2Upv5Gnp
         gFjZVYsYN+gBcjoVVhhmuLcEXIm2ohk7b5pEOl1iba2QlVjTK9/jZDqWpM5Gg2AW5f+m
         S+47j3rnPO8Ul0/hcu6mVL69H/zPcnLxgTbiEU7p2Ryz5LsXghOEG3nA77ynvopSADIx
         Wc7QjWJx15JMD3Os5dYGIVLZIxctZ8U5oUHq0AilBYb5PkyEWx8A7u73xHhEi5xBxiSY
         DF/qnCdoGNdyesY2wGyYPYw1r69UsXFrkAIZYXF2dqmxCoI2Fh3UQQJVqBDr2SXvxflh
         Xb1Q==
X-Gm-Message-State: APjAAAWNu/YoLbtnMxeEY5SA8b6Ygt2yHbm7MzR91EGOt1tz9Tj0E6pU
        QmhFNIesZkY5/BY+uMhd0lS9kpNaJG/McbmzD8bOTj+JboF4TCOF
X-Google-Smtp-Source: APXvYqxDLvljWju1rYqBU3gaeT2QVer56cMcH63Z4NclfT09M/NYdFQY0OqrXSFPy5o+hP5IFfHswAl2X//EV6BvxiE=
X-Received: by 2002:a62:30c2:: with SMTP id w185mr32997244pfw.175.1557145396104;
 Mon, 06 May 2019 05:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190424180934.GA29307@embeddedor> <cd02e064-1172-a8a2-14af-1f20e09a0738@embeddedor.com>
In-Reply-To: <cd02e064-1172-a8a2-14af-1f20e09a0738@embeddedor.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 15:23:05 +0300
Message-ID: <CAHp75VddRrLjahX0O4-q9=VLeUAAj6rOmnJ=W2Sg65OyUkVDqQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: sony-laptop: Fix unintentional fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mattia Dongili <malattia@linux.it>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 11:42 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Friendly ping:
>
> Who can take this?

Pushed to my review and testing queue, thanks!


>
> Thanks
> --
> Gustavo
>
> On 4/24/19 1:09 PM, Gustavo A. R. Silva wrote:
> > It seems that the default case should return AE_CTRL_TERMINATE, instead
> > of falling through to case ACPI_RESOURCE_TYPE_END_TAG and returning AE_OK;
> > otherwise the line of code at the end of the function is unreachable and
> > makes no sense:
> >
> > return AE_CTRL_TERMINATE;
> >
> > This fix is based on the following thread of discussion:
> >
> > https://lore.kernel.org/patchwork/patch/959782/
> >
> > Fixes: 33a04454527e ("sony-laptop: Add SNY6001 device handling (sonypi reimplementation)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/platform/x86/sony-laptop.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> > index 4bfbfa3f78e6..2058445fc456 100644
> > --- a/drivers/platform/x86/sony-laptop.c
> > +++ b/drivers/platform/x86/sony-laptop.c
> > @@ -4424,14 +4424,16 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
> >                       }
> >                       return AE_OK;
> >               }
> > +
> > +     case ACPI_RESOURCE_TYPE_END_TAG:
> > +             return AE_OK;
> > +
> >       default:
> >               dprintk("Resource %d isn't an IRQ nor an IO port\n",
> >                       resource->type);
> > +             return AE_CTRL_TERMINATE;
> >
> > -     case ACPI_RESOURCE_TYPE_END_TAG:
> > -             return AE_OK;
> >       }
> > -     return AE_CTRL_TERMINATE;
> >  }
> >
> >  static int sony_pic_possible_resources(struct acpi_device *device)
> >



-- 
With Best Regards,
Andy Shevchenko
