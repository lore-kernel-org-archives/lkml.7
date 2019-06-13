Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54013C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B7620673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HRNcwqMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfFMQqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:46:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbfFMFcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 01:32:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45PXS00jprz9s9y;
        Thu, 13 Jun 2019 15:32:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560403937;
        bh=v8IFBTO5V5TY7KGBZV751LEQxf/CeoT/DotZWwmhsSY=;
        h=Date:From:To:Cc:Subject:From;
        b=HRNcwqMfb95iDhut86ckDdIsIgvxHm6kZqCQq+zR8QyC/B+5cxPTVsj47Ru2+oq7v
         Dyd/j0L2tL8Rou0Gyb2vzTKmFnh5lTabxJXu0vHneoGazhoeZW2eqi+3ZVhSsm6gBE
         kgXHHHPZN9TSVeJVm/eEH6pnwkSP/QseBtl4OgxNA5SMGbFpmwU8RazxyZTvkQhALd
         RhoRX/Ca4SPe0UNPT88n9UwYwfTyCMbDUv8cKZ7kiPJPVYMr3fW/JuljO6mva0g4+y
         zuQHwOcbTj5HTcgkH+Xa8V8FW7/djYj454RZSqvIndJ99ibzVV9qqdOKxon4uwqpRF
         MoOUwGj9zg0PA==
Date:   Thu, 13 Jun 2019 15:32:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bich Hemon <bich.hemon@st.com>,
        Erwan Le Ray <erwan.leray@st.com>
Subject: linux-next: build failure after merge of the tty tree
Message-ID: <20190613153215.0c99f252@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S+Fa5fHjAM9HT=SW.URaEjA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S+Fa5fHjAM9HT=SW.URaEjA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the tty tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/tty/serial/stm32-usart.c: In function 'stm32_serial_suspend':
drivers/tty/serial/stm32-usart.c:1298:2: error: implicit declaration of fun=
ction 'pinctrl_pm_select_sleep_state' [-Werror=3Dimplicit-function-declarat=
ion]
  pinctrl_pm_select_sleep_state(dev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/stm32-usart.c: In function 'stm32_serial_resume':
drivers/tty/serial/stm32-usart.c:1307:2: error: implicit declaration of fun=
ction 'pinctrl_pm_select_default_state' [-Werror=3Dimplicit-function-declar=
ation]
  pinctrl_pm_select_default_state(dev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  c70669ecef4e ("serial: stm32: select pinctrl state in each suspend/resume=
 function")

I have used the tty tree from next-20190612 for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/S+Fa5fHjAM9HT=SW.URaEjA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0B398ACgkQAVBC80lX
0Gx8tAf+PbjxRIDVuW7/k9dlVEjJhGcbkXxePLiv5QzLBDt/O/AvO3ukdCKLK+jE
RptwbGs+Vz+tZ13cvpvZurPAZ5PFbgTP2T+1ufhjFdVZP0irHHeQE0svHTyweltb
DqpsYfeJKrV++rMHbGNQbPxsO+qhBxPGt/ZPKUObbi9MPUHa3Yh7P0kLAAxDIwLS
zAr8B7QpC2iWP/APByW288RVSfVJZPWS6aktVPPkM5qVcl8oXuBzAtFWztinlV3q
Z1GjPy1uF4psVSH+tzJOg/sdRupTW5gKI3oXG4HwAgXSNVoybxObzOvGie/YNNeE
YgYxLIcFmJ2tX7E/NN6vhMhYzk3Zow==
=AftU
-----END PGP SIGNATURE-----

--Sig_/S+Fa5fHjAM9HT=SW.URaEjA--
