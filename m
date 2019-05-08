Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D188C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA99521530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO7AzAIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEHPk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:40:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46851 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfEHPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:40:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so203890pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UacGnCWSnnX/ubt9WP8ILRmg8JHZOIflTzuul+wE29g=;
        b=pO7AzAIshGQWIb7xrPc8YYgQb+Vt5N9C4mFtDnZOpFvN0YMxmPEpIwd+gHGYjrINXL
         uALm4Pj1ez13Swz3eRdqCfEZtpb3jkDLRifI9SHF2vWZ2HDJ1AlhA/bjtAvOeEv/eecY
         P/Couz7yq52evabS7CIhMMmHR+ydwFilOCWXxzYHur6gK+PkPaMFN75LHXiXAv0+6UIh
         BJ4s2PUCFVhRPzlUePVhClTOnXKh6H6rtC05KIqWjAHNCdJZnj5qt5FTLS3hbItI2Ume
         oYGXOfg0FuHMdu8sH4JFVBeSM5hNF3zirnQ3z+MY/GqMuMS4eLH7y5MLYDYOaOTOn+Ig
         ryGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UacGnCWSnnX/ubt9WP8ILRmg8JHZOIflTzuul+wE29g=;
        b=R4U0mE8klr8UULDOa1xD/DuYGobzNoRPcEymVXY1TvvVgHOfP4EhbceXCV1kUXamjH
         OP25f8E3xgfzuZoQ9oqh3gQIhAeS6/XRUIiwS5XWThSSkaK8terE02vditedxClqLAI8
         OS1InbomJBQ4LjSbb17cFJDXc6X8WMigveWpoOxrUM7ti4xi6aJjqRztcp6ibizLfJxV
         eGbnD6KCibow93bYs6SWzsx2izvnfXVmxBOE+queieiHK4wxWctRWvwbbvzUhKvQku9D
         eCNj0LVua7v9A04GdFexoAIVG4BabsGEOU8UNfyww6aLiTGHrUxRvW0canI5qJxH20O/
         uVXA==
X-Gm-Message-State: APjAAAVMe8Idb74MPTzKItiipORwjAU+8ftFXmOiHR8M042Ge80mdxeX
        JppGWJZzAyMf5gSnF1b5R6Idc98VcYMN4TVRBTk=
X-Google-Smtp-Source: APXvYqywTP1cYBFMFV/ThSpGRRP6TzQDBKhQTDunwcu/png1t7dYBTbmqTQi0QRyAetOsFnIST5lW00y7j8qYZl/L9Q=
X-Received: by 2002:a63:fc08:: with SMTP id j8mr26566098pgi.432.1557330025512;
 Wed, 08 May 2019 08:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-4-git-send-email-akinobu.mita@gmail.com> <aced1953-4ea2-c8b1-9ee9-068e92ae1f8a@intel.com>
In-Reply-To: <aced1953-4ea2-c8b1-9ee9-068e92ae1f8a@intel.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 9 May 2019 00:40:14 +0900
Message-ID: <CAC5umyiLgyGambM+umb3GoYV-0Eo-CFiyy5RLhKGTq+fBTcZtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] devcoredump: allow to create several coredump
 files in one device
To:     "Heitke, Kenneth" <kenneth.heitke@intel.com>
Cc:     linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=888=E6=97=A5(=E6=B0=B4) 2:35 Heitke, Kenneth <kenneth.=
heitke@intel.com>:
>
>
>
> On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> > @@ -292,6 +309,12 @@ void dev_coredumpm(struct device *dev, struct modu=
le *owner,
> >       if (device_add(&devcd->devcd_dev))
> >               goto put_device;
> >
> > +     for (i =3D 0; i < devcd->num_files; i++) {
> > +             if (device_create_bin_file(&devcd->devcd_dev,
> > +                                        &devcd->files[i].bin_attr))
> > +                     /* nothing - some files will be missing */;
>
> Is the conditional necessary if you aren't going to do anything?

The device_create_bin_file() is declared with __must_check, so ignoring
the return value emits warning.
