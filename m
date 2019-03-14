Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5638CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620321871
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfCNQrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:47:40 -0400
Received: from anholt.net ([50.246.234.109]:58452 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:47:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0EFD510A2E6A;
        Thu, 14 Mar 2019 09:47:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id aCqMXrpPWURL; Thu, 14 Mar 2019 09:47:39 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id ED52910A27AB;
        Thu, 14 Mar 2019 09:47:38 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 87DA12FE4653; Thu, 14 Mar 2019 09:47:38 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] drm/v3d: Use the new shmem helpers to reduce driver boilerplate.
In-Reply-To: <20190314163451.13431-1-eric@anholt.net>
References: <20190313004344.24169-1-robh@kernel.org> <20190314163451.13431-1-eric@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Mar 2019 09:47:36 -0700
Message-ID: <87k1h1csif.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Eric Anholt <eric@anholt.net> writes:

> The new shmem helpers from Noralf and Rob abstract out a bunch of our
> BO creation and mapping code.
>
> v2: Use the new sgt getter, and flag pages as dirty before freeing.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

> @@ -185,83 +33,120 @@ void v3d_free_object(struct drm_gem_object *obj)
>  	struct v3d_dev *v3d =3D to_v3d_dev(obj->dev);
>  	struct v3d_bo *bo =3D to_v3d_bo(obj);
>=20=20
> +	v3d_mmu_remove_ptes(bo);
> +
>  	mutex_lock(&v3d->bo_lock);
>  	v3d->bo_stats.num_allocated--;
>  	v3d->bo_stats.pages_allocated -=3D obj->size >> PAGE_SHIFT;
>  	mutex_unlock(&v3d->bo_lock);
>=20=20
> -	v3d_bo_put_pages(bo);
> -
> -	if (obj->import_attach)
> -		drm_prime_gem_destroy(obj, bo->sgt);
> -
> -	v3d_mmu_remove_ptes(bo);
>  	spin_lock(&v3d->mm_lock);
>  	drm_mm_remove_node(&bo->node);
>  	spin_unlock(&v3d->mm_lock);
>=20=20
> -	mutex_destroy(&bo->lock);
> +	drm_gem_shmem_put_pages(&bo->base);

This put_pages() should be dropped -- it generated a WARN because the
shared helpers already do a put_pages after freeing the sgt.  The CTS
had passed, so I missed it until after I'd sent the patch.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyKhagACgkQtdYpNtH8
nuhHqQ/9ERIvaKy9nKL5lDsLB3xtqrNU3yZUnc4tLmwGdAWbtDDmvndikKi4eurx
hY27f4ZIY3Kl3BvttN0XX3UM0jme/1IxgtM69Y5ZE8F9B2d17+afhBtcy9YOsqDk
CgWWT3tzjnvuHp9Kv7kCDK3LqDzn3Jdc+5gzcHs+bM/+vkd5StXyTagW8wCURso7
dFcT07OMGcqeGnMBiWB/QKCH+5gNtauAI+SJqbdf6iO/2bdobVZXxos+80MM+f+K
f1GERY2KYIWbhqIrziKZn45UTeM216RqEphlMBLiPrECA/dkjhbf6nHcxzCTo47V
9yAo+osC8PVBSQ+rEBaGRi00dAqFCrT8CWL5i4FAfnJ6d2PD7ovbK4/NXluHoTSt
L4WQhOCW5iyZR2gIe7OmqicWRKZs7f2zsDSp3SP0DXle2XubcPMUgBH2aW0WLCzZ
F+Niv4zqx2IFsLor9zqnxN2rKoP+191izSzPacMuKNCjIzZ0GKhRAUD0ZwYMjkGg
AVBreIaeyq/3ggfxiWa3KfWYBqa+bnCdtcTlKRivhYjA7lnZtLW0hMG4diFg7H+4
GWurA0P1DShK1Qs0pxBNdXc7Ei3L0gI3G3A5t2V9mmcodRFUOqoZf7acCJEic8Bp
I7JocwzaxcubiUnP71nKDU09v0AVmhFa88n3/utXI1U00OZcD0s=
=F7J4
-----END PGP SIGNATURE-----
--=-=-=--
