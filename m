Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC910C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F872224CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfKTN2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:28:49 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:36772 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfKTN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:28:48 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A87451C1A58; Wed, 20 Nov 2019 14:28:46 +0100 (CET)
Date:   Wed, 20 Nov 2019 14:28:46 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 383/422] firmware: dell_rbu: Make payload memory
 uncachable
Message-ID: <20191120132845.GA32699@duo.ucw.cz>
References: <20191119051400.261610025@linuxfoundation.org>
 <20191119051423.887664218@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20191119051423.887664218@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Stuart Hayes <stuart.w.hayes@gmail.com>
>=20
> [ Upstream commit 6aecee6ad41cf97c0270f72da032c10eef025bf0 ]
>=20
> The dell_rbu driver takes firmware update payloads and puts them in memor=
y so
> the system BIOS can find them after a reboot.  This sometimes fails (thou=
gh
> rarely), because the memory containing the payload is in the CPU cache but
> never gets written back to main memory before the system is rebooted (CPU
> cache contents are lost on reboot).
>=20
> With this patch, the payload memory will be changed to uncachable to ensu=
re
> that the payload is actually in main memory before the system is
> rebooted.

Flushing the cache sounds like easier way to accomplish same
goal... and perhaps with better performance too.

Best regards,
								Pavel
							=09
> +++ b/drivers/firmware/dell_rbu.c
> @@ -45,6 +45,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/firmware.h>
>  #include <linux/dma-mapping.h>
> +#include <asm/set_memory.h>
> =20
>  MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
>  MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
> @@ -181,6 +182,11 @@ static int create_packet(void *data, size_t length)
>  			packet_data_temp_buf =3D NULL;
>  		}
>  	}
> +	/*
> +	 * set to uncachable or it may never get written back before reboot
> +	 */
> +	set_memory_uc((unsigned long)packet_data_temp_buf, 1 << ordernum);
> +
>  	spin_lock(&rbu_data.lock);
> =20
>  	newpacket->data =3D packet_data_temp_buf;
> @@ -349,6 +355,8 @@ static void packet_empty_list(void)
>  		 * to make sure there are no stale RBU packets left in memory
>  		 */
>  		memset(newpacket->data, 0, rbu_data.packetsize);
> +		set_memory_wb((unsigned long)newpacket->data,
> +			1 << newpacket->ordernum);
>  		free_pages((unsigned long) newpacket->data,
>  			newpacket->ordernum);
>  		kfree(newpacket);
> --=20
> 2.20.1
>=20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXdU/jQAKCRAw5/Bqldv6
8i5yAJsE3Yw0kWsaNyR/q/RfczB//zqRSACeMehYMBKXVT8mZk8PSi66SfydNhg=
=kZtH
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
