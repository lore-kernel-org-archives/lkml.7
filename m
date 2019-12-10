Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B477EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D022077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575977944;
	bh=p4ZI08kCrTStm4YBIWYZvtY50nnsN/Ta3QzcAmX9ra4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=v+bavn6JvgYkM7u0qS/Ukd6i4397ymaYqePKgfJnpULeT2XruOPOKjxhTA+7fW/bB
	 NANycQzQ3XB4xDydW+r8dupXy3XMVZmc21/gdxYh0nH48PyH4XXJMY077w9U3OZySq
	 udh6Ce1WvtJoUA/q7sjaRH9DrWky8PLJTpWSimK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfLJLjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:39:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45180 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLJLjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:39:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so13388149lfa.12;
        Tue, 10 Dec 2019 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=paNqhFZXRyT6E8o7LJGyUT8QuWl+b8l39w8bSosKx14=;
        b=SxP3aG/tYco+shyDZW0JDd7hC0NmrwFqKdXDdflrJT0VgS9+2aa9PPcSfkbv6SM1ly
         S1K9BGc0enhfrnyyXCN7xxa+EH8MWl1Y1yITChe8YrldAgCSfG99FnOQa1u1xP4Vlpw1
         Uyg9OElyCQh8tJRVdWbcc+OYPMigbyHjsbX0IYduKgqQdUWSxUX1GCA9XgafG0sWHSDo
         12Z+AU4TMbaGLRaUJ/fvH9XB4zSv+bVAloQNJBFxuEnPiHal/pqRsm0nvJ2+lyEMtf5J
         JgQnJ807b/jVr/8Dz7Nr10tb08FR9W+e20de2TDFLnB0ZSwkxE4TaGkyxjuqQokP8ULR
         Uwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=paNqhFZXRyT6E8o7LJGyUT8QuWl+b8l39w8bSosKx14=;
        b=OMI1vaXtHDO8hhBBjPc4nApEc+1Y0WKw3Wg43vcTMhZ7r+KqUTS9yN7kLmtMMBiFSh
         JU+eNvX345uNznxviw2e7s3lHRQR4USOZZgpACcglqzT0R/KQrzAdtx0xZMNOkoSP9M7
         TfVnvPTWqcNzA+xL5tRof0Xl7xm6Phxe4zQjaQaIkkRfbFojlJp2lKR4jBFLN9ZI2uX+
         WUAajodwAx30RBLITKdaD2l7/w+ZhUWwHYV7Ag4QHnRfDwZR9NLOXmnvCeDAS8Y5jzLP
         DH07MjOiKpxfYPIbqBDvjd521YugHdAZDqvWl568gnztTXMv8IEEFd1Q2ikHmpk7y+Y4
         xb+g==
X-Gm-Message-State: APjAAAWRiK0cjI86CsBu90EQFGhuB41pyp0i8Vo/3aJwHpBveUwHJ5fR
        se8qWWF1YPyI79GGoBVViLEtIEu7X4g=
X-Google-Smtp-Source: APXvYqxthsAEkGc+kltqcDBPVN+6AY4Dy5v9qfgB8teyAZxHCmQS9eSDcJsDXKz8bReOAMmkbgsN2w==
X-Received: by 2002:a05:6512:21d:: with SMTP id a29mr11710124lfo.186.1575977940594;
        Tue, 10 Dec 2019 03:39:00 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id a19sm1929493ljd.90.2019.12.10.03.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 03:38:59 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     kernel@puri.sm, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: suspend problem with dwc3 gadget / g_multi when usb disconnected
In-Reply-To: <38edc05e-680b-d881-49fc-e8230a93b2c8@puri.sm>
References: <38edc05e-680b-d881-49fc-e8230a93b2c8@puri.sm>
Date:   Tue, 10 Dec 2019 13:39:47 +0200
Message-ID: <87blsgl88s.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Martin Kepplinger <martin.kepplinger@puri.sm> writes:
> I'm running today's linux-next with this defconfig on a librem 5 devkit:
>
> https://source.puri.sm/martin.kepplinger/linux-next/blob/next-20191205/li=
brem5/arch/arm64/configs/librem5_defconfig
>
> So I want to have host and gadget mode (G_MULTI, most importantly a
> serial ACM console), and I'm having trouble with S3 suspend:
>
> * The most interesting case here: When I boot with USB disconnected
> (from the battery) I can't suspend or unload dwc3. After "echo mem >
> /sys/power/state" I get nothing in the my logs except
>
> [   18.107380] PM: suspend entry (deep)
>
> and the system hangs. similarly, I can't work around this by rmmod -f
> dwc3. What can go wrong here? I don't know enough about usb hci and why
> this shouldn't work. What can I do to help you here?
>
> * When I boot with USB connected, then unplug USB, I get:
>
> [   19.289602] dwc3 38100000.usb: request 000000006a19695c was not
> queued to ep3in

please capture ftrace logs from dwc3. We have documentation for this:

https://www.kernel.org/doc/html/latest/driver-api/usb/dwc3.html

(note to self: update email address :-)

> and then try to suspend:
>
> root@pureos:/home/purism# echo mem > /sys/power/state
> [   37.863066] xhci-hcd xhci-hcd.0.auto: xHCI host controller not
> responding, assume dead
> [   37.871345] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
> [   37.877260] PM: dpm_run_callback(): platform_pm_suspend+0x0/0x78
> returns -22
> [   37.884626] PM: Device xhci-hcd.0.auto failed to suspend async: error =
-22
> [   37.891728] PM: Some devices failed to suspend, or early wake event
> detected
> bash: echo: write error: Invalid argument
>
>
> * When I keep USB connected, the behaviour is similar actually, but
> rmmod works (but that use-case is not that interesting to me).
>
>
> Since my experience with USB drivers is limited, I'm glad to hear about
> any of your experience with dwc3- or more general gadget-problems with
> suspend and that or a similar configuration.
>
> Without G_MULTI and dwc3 host-only, suspend works btw. And all the above
> is basically identical on previous stable kernels too.

Have you tried any other gadget drivers or just g-multi? Care to try
with something simple like g-zero?

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl3vhAMACgkQzL64meEa
mQYPVQ/+KolGBV6DSxWa+ZuofyRKG3rnfK7xflYuCxqLBrMW7gTOyWmm5DnzKVtv
f9KusJuNOQbNEDwT0qFhIDYbiBAO3yPHeOqhXwWN9Hmj3SdtEeD0MVXY/PgQLX0Y
OBDyNrOUsC4MWf60kaghPJXnUJBTaUTJFVkTWPKJ3b/m+ZrSn7R+L1BJKApTSpZg
ByHB+IM04svwQXQst59g3p03rHg01YI9V7lJMPbmHVhykXjY0Hal9u8b7q+EjoCc
lH886XMe25FvS6JuZYnns4Cu58LjtVCYEU5XVbE+K8liJLm5JYCtyJTPXeIv7Fzd
jROhaDW1LYDjsUpb+9XZS4AW09RaqOK6NkPbxwfq1i0B/8j15ofzTF2mb1buNCw2
tV8guoiXgCsiA6Lwk2PNh69joqMotLLqzjPnmOt/iDtCAR2JNr3ppLHxb1OlUQFo
oCMDePQYbZ2gJlHnJADLD3vZjmIeol0fM9d4WQIUURfanrOwan6kuo8c18gZGQYW
rdJIWPE/E4PZ1oq4147Hv/Ar8xK0UAeSCmSLG1cm6E+XZfZXqJ0Tuti7ybs8LzDk
5Db9PCKjp15mN+D+EukKCTQXfV2OwQ4EVJN1NkS+BlEz5cYy2JlF+awRYMDDwcOU
jvTy3fgS+mOWIglfIuH8YhScSTm+2GpOl8PB0+6ECNpQMEbpmXg=
=69+K
-----END PGP SIGNATURE-----
--=-=-=--
