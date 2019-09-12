Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA53C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32B920856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNjTicGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfILNaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:30:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40847 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbfILNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:30:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id y10so11786338pll.7;
        Thu, 12 Sep 2019 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T7yOTc6AM6CK4gI48nKg1cFnDjTACpLQV/CXZUsKR78=;
        b=tNjTicGxO56p1XVGcD8R3SxrHsRfwvYzbGKguNRV7sO40XGVOHV5rVXh16qYZhZgVt
         DPoBqyuME4XSrI+umr8GzhBo+NKyF3MaYou3a0ojeUZYfLWPrIZ/EqIv6BNGMTLgxMDc
         yk7ufN+8EYPqZFipnLczteXiDYrUABYvaZd7zitEDEG8aGbp+l9Tvop/dpQB2d8cqOfN
         IbNtx6IYNzayMY+sSSQJJ6G4JPtsUccWz3mD3CAPEPrdiwnR4sHKg3aeh/YflHlEfLh/
         Xrc1I2Wfqk5HA9/1CBmCiFlMGP4sFjnt1EuaFcNnhlBX6PUiYfwBnAjmvgzDABJ1+l5X
         rjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T7yOTc6AM6CK4gI48nKg1cFnDjTACpLQV/CXZUsKR78=;
        b=ickVE1QgvkY8qLu2QT4dhxb8/MpMGVNdAG/KzPDTMvr209Kjm5l9SX84gA7mYa4lnD
         vWSjQkbTnY8X1ICgqkTcbTkzpiilu5TM+VVDMDHqbo+K9e55t00aADwhq/wxaJ5NA1VX
         6d67V8uWExy5QdJx/2fI+h56uTAWxzPOcs9OODGUZ15KBO7tMAMSgf18iJJIL2rRwYiu
         uY+r3FbFat6UK3cfalNX20QZr8xA3TvUoLB5VSZhzGaTcu+RU3c3eJiu9IfUpHzGA/l9
         dZCmcOiU13AxL5VpYPniQ4GSK7RMyP08teaaOsYeoSgGI7oV+z5WRJ+dOO591mEFBtZe
         Smww==
X-Gm-Message-State: APjAAAVOpSWBpB8JMsquC193GILEo0VI209L63WBGTpfU83bhWa5+WK1
        HQdeWBxSDtjAt3SMwMMTZyUfPqJK3Du0vmDQFjw7f0HLREU=
X-Google-Smtp-Source: APXvYqwojJdrFarStObqD+Wc9p1tMfp1r8LGvX3LBSNGJLOSHqNL50xJuCMKrck9hk4lYk9fbHFGsobbwWb1JIZXN20=
X-Received: by 2002:a17:902:b208:: with SMTP id t8mr6801182plr.262.1568295017642;
 Thu, 12 Sep 2019 06:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <156824368856.28378.14511879419677114177@WARFSTATION> <20190912073358.n5bxqosowhky5uhb@pali>
In-Reply-To: <20190912073358.n5bxqosowhky5uhb@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 Sep 2019 16:30:06 +0300
Message-ID: <CAHp75VcRBqBBQ6S6KAGv2=KMLk1Jbq3aYOYkM6qLHvDoGP0XdQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlight on
 Inspiron 10xx
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Mario

On Thu, Sep 12, 2019 at 10:34 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Thursday 12 September 2019 01:14:48 Pacien TRAN-GIRARD wrote:
> > This patch registers a quirk disabling keyboard backlight support
> > for the Dell Inspiron 1012 and 1018.
> >
> > Those models wrongly report supporting the KBD_LED_OFF_TOKEN and
> > KBD_LED_ON_TOKEN SMBIOS tokens, exposing keyboard brightness controls
> > through sysfs which freeze the system when used.
> >
> > The associated SMBIOS calls never return and cause the system to
> > hang, notably at boot when systemd-backlight tries to restore
> > previous brightness settings.
>
> Hi! This sounds like a firmware bug. Have you already reported it to Dell=
?
>
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D107651
> > Signed-off-by: Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
With Best Regards,
Andy Shevchenko
