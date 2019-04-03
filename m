Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA06C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A2F20643
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDCUyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:54:06 -0400
Received: from sauhun.de ([88.99.104.3]:51634 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCUyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:54:05 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id 0D4362C282F;
        Wed,  3 Apr 2019 22:54:03 +0200 (CEST)
Date:   Wed, 3 Apr 2019 22:54:02 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] axxia-i2c: use auto cmd for last message
Message-ID: <20190403205402.dr2uolmpew45xoxd@ninjato>
References: <20190328111858.GA17086@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6l3yfohu3gsj3jo7"
Content-Disposition: inline
In-Reply-To: <20190328111858.GA17086@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6l3yfohu3gsj3jo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 28, 2019 at 11:19:45AM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> Some recent commits to this driver were trying to make sure the TSS
> interrupt is not generated on busy system due to 25ms timer expiring
> between commands. It can still happen, however if STOP command is not
> issued on time at the end of the transmission. If wait_for_completion in
> axxia_i2c_xfer_msg() would not return after 25ms of getting an
> interrupt, TSS will be generated and idev->err_msg will be set to
> -ETIMEDOUT which will be returned from the axxia_i2c_xfer_msg(), even
> though the transfer did actually succeed (STOP is automatically issued
> when TSS triggers).
>=20
> Fortunately, apart from already used manual and sequence commands, the
> controller also has so called auto command. It works just like manual
> mode but it but an automatic STOP is issued when either transfer length
> is met or NAK is received from slave device.
>=20
> This patch changes the axxia_i2c_xfer_msg() function so that auto
> command is used for last message in transaction letting hardware manage
> issuing STOP. TSS is disabled just after command transferring last
> message finishes. Auto command, just like sequence, ends with SS
> interrupt instead of SNS so handling of both had to be unified.
>=20
> The axxia_i2c_stop() is no longer needed as the transfer can only end
> with following conditions:
> - fully successful - then last message was send by AUTO command and STOP
>   was issued automatically
> - NAK received - STOP is issued automatically by controller
> - arbitration lost - STOP should not be issued as we don't control the
>   bus
> - IP interrupt received - this is sent when transfer length is set to 0
>   for auto/sequence command. The check for that is done before START is
>   send so no STOP is required
> - TSS received between commands - STOP is issued by the controller

I am not sure. Is this a bugfix (=3D for-current) or more a new feature (=3D
for-next)?

> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

I trust you that Alexander gave the review, but it would be a tad more
'open development' if he could give it as a reply to your patch on the
mailing list.

Thanks,

   Wolfram


--6l3yfohu3gsj3jo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlylHWoACgkQFA3kzBSg
KbbsKQ/+P9zFtuRRIvAsHKTSBI0uhB4PfJGhVOi6dZdCkw/LKN5j77iixqkIMRZE
dPXic+LoF7BycMHN+0WJF9qAhnBf9xAvoPCjBwTg15AnpsZlM/q79vqPVYuTmIe2
SsMWyWbtz+Et9jwRVKaIAkP+CWtZMrA1p0dB3w//blQ32/uE8qj54sugQgdjmRcg
IHNUlv2s1RjrJM5UcU1HAYP0lU5UR6oTlDKa/MdOKcuPM8Aem4vE+ZPLG8CUPJvf
Sa+DoUL3yjcmwfz2ghovfi6IhrID5+LY/laFacc3t+vkF3KoLFn2PrBUDqphM3Wj
8A/li8vEuGYL6uucveKzD1+96Y7tkVdWOSgBDlHX6LBkTWCj+r24QULm3WGmpltd
XM/QUz7xHPdiQdY2dYbgF+yVpijUNLWS9KeBJFeA3wdXUbzIhBxk4AubVCbLrAKa
b/j8DKZ4V4cHQEYQGyMvvnDSQ87+WGArvUWCnfcijaTd593emQ5dQ+/xUBHGZyy6
ojIw9V8aZcjLRaysBJxodmWZ8sRJk5IdCuCTET4DEpykxzRVpgybAVMg8xOg8O1c
Ho0DrwRJuV3d8Lwv1s0QYPN+fS6SMXmP0SLm7gATuSxnq23KQsdE7GaeqrNdMPUs
nA+qbM850iKZPfxuKntrQsqW7E9CoVdOOM6DdnsxwmW2plgN24Y=
=J56r
-----END PGP SIGNATURE-----

--6l3yfohu3gsj3jo7--
