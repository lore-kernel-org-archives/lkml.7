Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83463C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5345C218B0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="lTJbB8WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfCAHE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:04:57 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:38700 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tU1kq8rAzBtqhmjfXYLMsOFlCp0Wns1ijfZSq4jeNTg=; b=lTJbB8WPoyIf1z7rOcYcXhZW/
        g+ACoLC6K0Ut4KtUegEbKb6lHf7AkozeUMBoZhkIq0+ipWZCslcL3hORtzQEjaGqPOUNAD/g3a2Lw
        WEzojPPgCyn8UHJRj3nWwc66Mk1md/MImqf+srdafYgX/dkQt70eG+GmGu0MwpELyhe8M=;
Received: from [2a02:790:ff:919:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gzcDz-0001rA-Mh; Fri, 01 Mar 2019 08:04:52 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gzcDw-0002Ds-UG; Fri, 01 Mar 2019 08:04:49 +0100
Date:   Fri, 1 Mar 2019 07:45:11 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] mfd: twl-core: disable irq while suspended
Message-ID: <20190301074511.2d15aacc@kemnade.info>
In-Reply-To: <20190223182323.GA39872@atomide.com>
References: <20190223114754.16286-1-andreas@kemnade.info>
        <20190223182323.GA39872@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N40uUVtxTp0XE0kd_lnYTyP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N40uUVtxTp0XE0kd_lnYTyP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 23 Feb 2019 10:23:23 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190223 11:48]:
> > Since commit
> > 6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device f=
or suspend")
> > on gta04 we have handle_twl4030_pih() called in situations where pm_run=
time_get()
> > in i2c-omap.c returns -EACCES.
> > [   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 se=
conds) done.
> > [   86.485473] printk: Suspending console(s) (use no_console_suspend to=
 debug)
> > [   86.555572] Disabling non-boot CPUs ...
> > [   86.555664] Successfully put all powerdomains to target state
> > [   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
> > [   86.563751] twl4030: I2C error -13 reading PIH ISR
> > [   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
> > [   86.563812] twl4030: I2C error -13 reading PIH ISR
> > [   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
> > [   86.563903] twl4030: I2C error -13 reading PIH ISR
> >=20
> > This happens when we wakeup via something behing twl4030
> > (powerbutton or rtc alarm).
> > This goes on for minutes until the system is finally resumed.
> > Disable the irq on suspend and enable it on resume to avoid
> > having i2c access problems when the irq registers are checked. =20
>=20
> Thanks for fixing this, still works fine for me for rtcwake:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>
>=20
hmm, in which version we will see this regression fixed?

I consider this whole thing as a reminder to finally
improve my automated test facilities and finally add the suspend/power
consumption test scripts I have to it so I can catch such things earlier.

Regards,
Andreas

--Sig_/N40uUVtxTp0XE0kd_lnYTyP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlx41PcACgkQl4jFM1s/
ye95PBAAjch8QEbm1Xjq6d2frVDCzM1NZTy4094hu42wz0Ku+VkXIZ5TlTBi+r//
FqDoodgDMPKus/QxKNsRzv5bVXZmRTt07QLWTmMih5HykoGvZAHdiVbH2wWMtMME
a4snuBjsCVnKilEceTn8Mghe5xMDbtSUPPM9pIQYegPR6iePzqCJX8l1KcAc6uQH
4SHCqtXOpP/cp07Y9MmqLWShvc3IWRdSo9qofqcDhZBhezCuHbJ33p2XKsY+21rM
6i0guXjNVYLgPWHGFQ6JUUE5PDMAgts2u1wcgOHL+Siae5KRxbaE0F4h8gzAi++1
gnRKfg+p4uZ7RjgbPrb18U2CDNDr9GbCvFH0clXyuW5NTLfxL6i6YYqF13bciztC
5QvN4E/vVmXfE+i8TrOjVxyOGCxlZWrFgj8pTS0kbjzURakbhyYywPz4YNMCQhP7
U7fYvYveNqCmof0KZ5JA+aSqo9uRVHbcY9OZ6SoBzQGg4MoMx1JDFdEshSsM2i0a
+mYxEo9zpngH7VeMWT3v00xCRMQi6MD2moKLWkHNP2vxAOkAAXf8O4tcuGl2ceFF
sI+V5gqTAzoZiS2TfeX1+sA2LNz13y7xrLTN0gFctWiiMGh4H5fc1XMvDF2j2qyw
dp9F6wGNgqM3aGPyiTv0L894cv7w6XkIg4b5OzTKtiAWsPzu1TY=
=iIvs
-----END PGP SIGNATURE-----

--Sig_/N40uUVtxTp0XE0kd_lnYTyP--
