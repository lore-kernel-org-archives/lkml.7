Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCFCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46582146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qt9gyLSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfC0NRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:17:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37200 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfC0NRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:17:00 -0400
Received: by mail-io1-f67.google.com with SMTP id x7so14009600ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w4a/CCm93Q3/JA0g6q8gFPwDhCZnbG/rR/qxMzhxgbo=;
        b=qt9gyLSyYpgLzbIfvmiy1RtjW0Bl8EeeXhZLI18Sk+sNvHA1g70UHeKKy0wDLI0DCd
         ZGaomln2dqCBou0+qoVYXYkeAnTxi6dBi7LqKpOZQmMmwhFFMEcadmVKBfn7cgUecwda
         aYzd2isJCqBionZB2+HSwNUEZ3lUAaH5snIB55cDWHVa6t101XgdYf+ILWxjgD8Nd3HZ
         D5RJZGdXhQfp38AmjoScjxAk5RAUJGOz4t4ZY5busB+6kc5PpT/hqetJOg6zqXVbDk8y
         hro62rQYYU4/y5ety5Ld4bsOmkm00Zsp52xpnjqQ9hCw10k0KmND6P6I+3953fz9HUXR
         dRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w4a/CCm93Q3/JA0g6q8gFPwDhCZnbG/rR/qxMzhxgbo=;
        b=Co+mPkseu/h+FM2L3+d7Pi+SQAv1dOLyzPX7f6CVG2FqX+UVyWI/tyFFh61NoQfllp
         kcnvd1CETRjquC1qgH8K7KAYIvPiea3df5uvQDoj4WYHeb84JlwdoJp4QfBEmVNs2llo
         31K/rRDP3T62JPLnVEywPyihNeGjN/V3pX3PstnYVvnit/mA3Mk4ll0tqsw3kMTb7L8/
         uaUL9A+r5dfKzScS2TyItm0TZTDwKYHoeTA6wwsFQlRH+6TbFn6B79EoO+f9uqNas+lU
         vDew25wmiB8H7qOK02nhQyKyx781Nh2RTdwc/SbUltmVUBBIGG9r9vHdu89J2Ban8TLB
         9YBQ==
X-Gm-Message-State: APjAAAXOFT0RxmpFWTKMs01I+6Hg2w4AxWVMDdNCHia6ZdVSA/tWqsHu
        Fsep/GJq4SHehfOmTBzamv8BbX66UJ8Ek7zzAht3xg==
X-Google-Smtp-Source: APXvYqzChgYl0cdQDU4O3rPHYs+LOQCcreh5gd5ajX7+F+F82yWafyIrl398qpyyxlWax87zm1Dj5WKr74EPTB4Ffrs=
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr12792112iog.187.1553692619260;
 Wed, 27 Mar 2019 06:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155728.5432-1-brgl@bgdev.pl> <712540aa-6927-9141-4f0c-740193d26f33@ti.com>
In-Reply-To: <712540aa-6927-9141-4f0c-740193d26f33@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Mar 2019 14:16:48 +0100
Message-ID: <CAMRc=McPzhOy9Ebp+hDC1eiSKJBf-q9gCeD_WMF5Wa4SSBR=dg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: davinci: ohci-da8xx: model the vbus GPIO as a
 fixed regulator
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 mar 2019 o 12:37 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> Hi Bart,
>
> On 26/03/19 9:27 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Adding the vbus GPIO support to the ohci-da8xx driver isn't really the
> > optimal solution. Rather: it should be modeled as a fixed regulator
> > in which case the driver already has support.
>
> Can you clarify "driver already has support"? You are introducing
> support to use the VBUS gpio as regulator as part of 3/3.
>

The support is there as in: if the driver can obtain the regulator, it
will enable it. The overcurrent protection does not work however and
this is what patch 3 adds. Maybe I should rework the ordering in that
I'd first add the irq thread disabling the regulator if it exists,
then the regulator fixups to board files and then remove the vbus
GPIO.

> I do see other instances of VBUS regulator being used in USB tree. But
> we just converted the driver to use VBUS and over-current GPIOs in v5.1.
> So this is a bit of "churn".
>

Yes and it's my fault - I simply converted the legacy code without
giving it enough consideration. I should have used a fixed regulator
right away, but now it's upstream and we need a follow-up series.

> Can you document why the current solution is not optimal? Is it to make
> future device-tree conversion for these boards easier? Or?
>

It's sub-optimal from the HW modeling in SW PoV - it is in fact a
regulator enabled/disabled by a GPIO. Also: it's code duplication as
currently we check if the vbus GPIO exists and then use it or check if
the regulator exists and use this as the second choice. The third
patch actually shrinks the driver.

Bart

> >
> > This series adds necessary fixups to the board files and removes the
> > vbus GPIO from the ohci driver.
>
> Thanks,
> Sekhar
