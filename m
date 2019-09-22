Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B20C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55B420830
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 13:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdYb/YQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfIVNn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 09:43:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43872 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfIVNn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 09:43:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so11124620wrx.10;
        Sun, 22 Sep 2019 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6UhvR1aaBGYr0TReoDAG8Re2m9hxnBDY81KOwF03hpA=;
        b=ZdYb/YQbfo/SxK9xKIITVGsVydZf6Ctcp6UX2zZX+jAVdS6VdDUcB+dYpGYQrI+q0y
         EbNopeedEqXDCpgxUL/mqPJVvSt4JH1b9WPB2WSfox4DMDbmpWoNpmBhd8IGSVV/zmoX
         Ko205y71nuBZQwXZ9+9PSGSCkHmGFni0D9vgGWtxeoLuFx1GUoaWK1Vf/HBOWxKkEKdy
         KcSklD9Et64JvXLrvO53nvVDD0QnsF/2h7eoE40DqFBdHp2Kqotoc50za0IldI/7aKDr
         8EmOWu9zPfEAFjp28eaNwT3LphxU0H4cgYx8PGkbv3Pi/2kMcgMSzR7SDvA7TRVCmFr3
         fVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UhvR1aaBGYr0TReoDAG8Re2m9hxnBDY81KOwF03hpA=;
        b=lp1/8ZtYvYiTL3OZ8MCYhwQES6yKxYNk5bcPd+LCvATk1di3Axk/KY+dOy4SoCvDwJ
         OQ+u6gn6Eu2qGOhc1zHgMUylcSC9tFGVGAN8LhKkiD0+znz5Wuly+QQZkc+/fb/9WMUB
         OM8fr6CjI4iDNeK72dxpOXYdfuuqIp3ozMRUntb4eq1EXDP4rE4JtCTIQkE+tLJWJkZu
         3l87yReCFQLo0H31jC6/b9Cj/WZ+AG76U3C3hdMqr2mv8YYd+Bv5cMtVcDM/Usx6ONv5
         0mo0wdjEhPicz4xEo5ak5qPP7WqUdXOQMecmRx+3FrafxTHamXpY1jNeMpIYoMsyiejd
         hKFg==
X-Gm-Message-State: APjAAAVoARATG5fmHUtSCZFMflJVq70QCI6e58fjZ50DqkFbwB5xZeC8
        dvarvY9tsIwm6EOQTbeKJA8=
X-Google-Smtp-Source: APXvYqzmJH6PRbDYZzY4u7rcYVp2RK6T8a0b6pGf7x6BtVtw6CEMGPd+r7x8DPJPJ3sZ8/Yl3F+K9Q==
X-Received: by 2002:adf:ec91:: with SMTP id z17mr19572644wrn.346.1569159805541;
        Sun, 22 Sep 2019 06:43:25 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f18sm5945519wrv.38.2019.09.22.06.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Sep 2019 06:43:24 -0700 (PDT)
Date:   Sun, 22 Sep 2019 15:43:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@dell.com
Subject: Re: [PATCH] platform/x86: dell-laptop: fix phantom kbd backlight on
 Inspiron 10xx
Message-ID: <20190922134323.mowwoyeuqoalpwsg@pali>
References: <156824368856.28378.14511879419677114177@WARFSTATION>
 <20190912073358.n5bxqosowhky5uhb@pali>
 <156882055514.9370.16951540573597044820@WARFSTATION>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hve2rdbpgwpt5hzd"
Content-Disposition: inline
In-Reply-To: <156882055514.9370.16951540573597044820@WARFSTATION>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hve2rdbpgwpt5hzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 September 2019 17:29:15 Pacien TRAN-GIRARD wrote:
> Quoting Pali Roh=C3=A1r (2019-09-12 09:33:58)
> > On Thursday 12 September 2019 01:14:48 Pacien TRAN-GIRARD wrote:
> > > This patch registers a quirk disabling keyboard backlight support
> > > for the Dell Inspiron 1012 and 1018.
> > >=20
> > > Those models wrongly report supporting the KBD_LED_OFF_TOKEN and
> > > KBD_LED_ON_TOKEN SMBIOS tokens, exposing keyboard brightness controls
> > > through sysfs which freeze the system when used.
> > >=20
> > > The associated SMBIOS calls never return and cause the system to
> > > hang, notably at boot when systemd-backlight tries to restore
> > > previous brightness settings.
> >=20
> > Hi! This sounds like a firmware bug. Have you already reported it to De=
ll?
>=20
> Yes, the issue has been reported to Dell's technical support, which didn't
> provide a satisfying answer.

There were already some firmware problems with keyboard backlight and
Mario posted this comment about Linux support:
https://github.com/dell/libsmbios/issues/48#issuecomment-391328501

Can you try to use libsmbios tools and if they do not work too, report
problem also there?

> I'm not familiar with Dell's policy, but I doubt that they would issue a
> BIOS update for discontinued models from 2010.

We need to wait what Mario wrote about this particular problem.

> >=20
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D107651
> > > Signed-off-by: Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
> >=20
> > --=20
> > Pali Rohr
> > pali.rohar@gmail.com
>=20
> --
> Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--hve2rdbpgwpt5hzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXYd6eQAKCRCL8Mk9A+RD
UvCfAJ9OGlR6Lvdo/g0uHuS1xjs+xY+qYACdHJqEhlTHrOq7NT4TwVs7GLVSol4=
=6851
-----END PGP SIGNATURE-----

--hve2rdbpgwpt5hzd--
