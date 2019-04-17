Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F934C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450DA2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbfDQLck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:32:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731508AbfDQLcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:32:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FEB7AF8D;
        Wed, 17 Apr 2019 11:32:37 +0000 (UTC)
Message-ID: <1eba0edb8cc1b7136aac218cdb6696f92d8dbf20.camel@suse.de>
Subject: Re: [PATCH 3/3] firmware: stratix10-svc: fix leaked of_node
 references
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Tull <atull@kernel.org>,
        Richard Gong <richard.gong@intel.com>
Date:   Wed, 17 Apr 2019 13:32:35 +0200
In-Reply-To: <1555469093-35179-4-git-send-email-wen.yang99@zte.com.cn>
References: <1555469093-35179-1-git-send-email-wen.yang99@zte.com.cn>
         <1555469093-35179-4-git-send-email-wen.yang99@zte.com.cn>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OU47z1bWZJtjh8cPzFkD"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OU47z1bWZJtjh8cPzFkD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-04-17 at 10:44 +0800, Wen Yang wrote:
> In stratix10_svc_init function, fw_np is obtained by calling
> of_find_node_by_name(), np is obtained by calling
> of_find_matching_node(), and the reference counts of those
> two device_nodes, fw_np and np, are increased.
> But when the function exits, only of_node_put is called on np,
> and fw_np's reference count is leaked.
>=20
> Detected by coccinelle with the following warnings:
> ./drivers/firmware/stratix10-svc.c:1020:2-8: ERROR: missing of_node_put;
> acquired a node pointer with refcount incremented on line 1014, but witho=
ut a
> corresponding object release within this function.
> ./drivers/firmware/stratix10-svc.c:1025:2-8: ERROR: missing of_node_put;
> acquired a node pointer with refcount incremented on line 1014, but witho=
ut a
> corresponding object release within this function.
> ./drivers/firmware/stratix10-svc.c:1027:1-7: ERROR: missing of_node_put;
> acquired a node pointer with refcount incremented on line 1014, but witho=
ut a
> corresponding object release within this function.
>=20
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Richard Gong <richard.gong@intel.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/firmware/stratix10-svc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix1=
0-
> svc.c
> index 6e65148..482a6bd 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1016,15 +1016,21 @@ static int __init stratix10_svc_init(void)
>  		return -ENODEV;
> =20
>  	np =3D of_find_matching_node(fw_np, stratix10_svc_drv_match);

Sorry but this patch isn't right, of_find_matching_node() will free the
reference to fw_np internally.

> -	if (!np)
> -		return -ENODEV;
> +	if (!np) {
> +		ret =3D -ENODEV;
> +		goto out_put_fw_np;
> +	}
> =20
>  	of_node_put(np);
>  	ret =3D of_platform_populate(fw_np, stratix10_svc_drv_match, NULL, NULL=
);
>  	if (ret)
> -		return ret;
> +		goto out_put_fw_np;

Consequently and assuming I'm not missing something, I think fw_np shouldn'=
t be
used here as is.

Regards,
Nicolas


--=-OU47z1bWZJtjh8cPzFkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAly3DtMACgkQlfZmHno8
x/6HeAgAh+LrkNghtEw2qyVOh8S/c9YBI/kby2TjwgfKHGaKjnCeJfrf4xQM+Nkl
hoqOcb0Cow343nx8MtD2Fm2jImXzVvfteR/wFdR7aLbmI07T7SiJg8kbdTFKRxOi
8Min92XYmXii65O0wGbDX/IyassX2er+fPbz6WWstsj3x+jmPanmEqncUuqla66j
LkwMzZr0Mm+a0xfWlW+Jshhwgt1EyAvziDjbAy1VJZUZTHUwAWdCeqKWdRzLdDlj
kZs/r1SL88PNH6iJDCMRNtum546sWbDAWglslQ+JkrdW2lluDhpt10XTKcQFjcEE
7Gukb4Ebq/54tpRePOCIAyknFYsV0A==
=xnTE
-----END PGP SIGNATURE-----

--=-OU47z1bWZJtjh8cPzFkD--

