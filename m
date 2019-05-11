Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40884C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B21B20578
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzavZLD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfEKI2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 04:28:34 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33926 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfEKI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 04:28:33 -0400
Received: by mail-ua1-f66.google.com with SMTP id f9so3008666ual.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 01:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=25ik70f2E2mAqLYpaZBMoD10MWbGvVn+7ZN/sGqsAX8=;
        b=ZzavZLD6qcIcx27oWgwnwDdGt2K42iJVD7gdU7YMgaLWkjgNw7hkznt1WyQra2t/Ca
         PSdNc66gm1Q2wt/o9lffYPRP4eWEGjwcnqNpaI5ROqXZQ35SGuXzj3PBFBhYrZg8Hm3C
         XfLlyw1TEt6D50MxwAybtGukEZ7qxN8cG6bUht7PupXuvjBQYhw5EjCPApW3BFdXjhXH
         y/f43k1v+n/tvuDmOh/uFs5r2gXPx9uGeMg11z0fGncfnCQphFRZ1OnK4WPt5PgoI1YK
         aKZiJbgPD1rIpVucYCt6qiZX1azeRdtiXbiMRWB4BxCrhUgnHJpSdEuSSfMpGHy9+ozb
         lR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=25ik70f2E2mAqLYpaZBMoD10MWbGvVn+7ZN/sGqsAX8=;
        b=a2JQX3FfHedN0ADt/u0vkgkb/XSj/CM+B8C5BoeqxMg9j8jy2srbk5Rf37KBmP8yfb
         bDE6pB/SgfG2Q1vyu+LjyCuecwNSFLS+9VAHFbZ8TAgynKTrJ0qruNpEaqp+svGTtzd+
         JIyUPCpnXTLA2EJ26s/5jOk/6zCDFuBpc1vNP0A1uhgQHBMr8KrRDnwBjFrS6nSmqwXc
         AXUOq4tB4hPPCto6eEDzsiO1tL/Di2XwPx8+ujqW3TnsZa7uZZZgmBXxlOIE8IijprKG
         pB4HvTR7KnrZMC5m2/t2yQB1V+bc9nEg/IImdyveil69Tl+59OFvxWjwW7H2KS6u9ktq
         mzHA==
X-Gm-Message-State: APjAAAWfFo/3xAYfz18oSS6NJs+RogyRkqMIuBwaQ1tGKS3KDiddKOxi
        KBUbZ10jRt4SaSCHlCnCAg+GzFwbnypVyq+3a/k=
X-Google-Smtp-Source: APXvYqxNg7H2RZMKn5M0pmOgmfKoVyv6mjSjMMBK58Qm0Wm0QvncqQjkgtL96swgZ8adzof1JOCjAYLTsoHnBa7KAHk=
X-Received: by 2002:ab0:70d4:: with SMTP id r20mr4110137ual.67.1557563312464;
 Sat, 11 May 2019 01:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <1555960190-8645-1-git-send-email-dagmcr@gmail.com> <20190508102701.GI3995@dell>
In-Reply-To: <20190508102701.GI3995@dell>
From:   Daniel G <dagmcr@gmail.com>
Date:   Sat, 11 May 2019 10:28:21 +0200
Message-ID: <CAPsT6hmVQWNtt2cLWkVQ8kHa_Q_7KVp4D-mMnjBsajdYdn8EeA@mail.gmail.com>
Subject: Re: [PATCH] spi: TI power management: add missing of table registration
To:     Lee Jones <lee.jones@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 12:27 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> The subject line is not correct.  This is an MFD driver.
>
> When submitting you should follow the convention for the subsystem you
> are patching against.  The following command is helpful:
>
>   `git log --oneline -- <SUBSYSTEM>`
>
> I will fix it for you this time (and for the other patch I see).
>
Sorry for that and thanks for rewriting the subject.

> On Mon, 22 Apr 2019, Daniel Gomez wrote:
>
> > MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete D=
T
> > OF mathing mechanism and register it.
> >
> > Before this patch:
> > modinfo drivers/mfd/tps65912-spi.ko | grep alias
> > alias:          spi:tps65912
> >
> > After this patch:
> > modinfo drivers/mfd/tps65912-spi.ko | grep alias
> > alias:          of:N*T*Cti,tps65912C*
> > alias:          of:N*T*Cti,tps65912
> > alias:          spi:tps65912
> >
> > Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> > Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> > ---
> >  drivers/mfd/tps65912-spi.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Applied, thanks.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
