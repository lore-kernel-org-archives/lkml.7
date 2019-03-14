Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3313DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBD42186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCNTLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:11:22 -0400
Received: from anholt.net ([50.246.234.109]:59176 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfCNTLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 15:11:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D1A7B10A2E6D;
        Thu, 14 Mar 2019 12:11:21 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id WCLnjkj1SGZM; Thu, 14 Mar 2019 12:11:20 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A4E2A10A2A54;
        Thu, 14 Mar 2019 12:11:20 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 3DBA32FE4653; Thu, 14 Mar 2019 12:11:20 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Subject: Re: [PATCH] drm/v3d: Use the new shmem helpers to reduce driver boilerplate.
In-Reply-To: <CAL_JsqLeyDahEpWkj=3ogEcbz84qFQTj=wBZDTDoyNjbRz3Ccg@mail.gmail.com>
References: <20190313004344.24169-1-robh@kernel.org> <20190314163451.13431-1-eric@anholt.net> <CAL_JsqLeyDahEpWkj=3ogEcbz84qFQTj=wBZDTDoyNjbRz3Ccg@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Mar 2019 12:11:19 -0700
Message-ID: <87sgvptgo8.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Rob Herring <robh@kernel.org> writes:

> On Thu, Mar 14, 2019 at 11:34 AM Eric Anholt <eric@anholt.net> wrote:
>>
>> The new shmem helpers from Noralf and Rob abstract out a bunch of our
>> BO creation and mapping code.
>>
>> v2: Use the new sgt getter, and flag pages as dirty before freeing.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/gpu/drm/v3d/Kconfig   |   1 +
>>  drivers/gpu/drm/v3d/v3d_bo.c  | 317 ++++++++++------------------------
>>  drivers/gpu/drm/v3d/v3d_drv.c |  27 +--
>>  drivers/gpu/drm/v3d/v3d_drv.h |  14 +-
>>  drivers/gpu/drm/v3d/v3d_gem.c |  12 +-
>>  drivers/gpu/drm/v3d/v3d_irq.c |   8 +-
>>  drivers/gpu/drm/v3d/v3d_mmu.c |  11 +-
>>  7 files changed, 120 insertions(+), 270 deletions(-)
>
>> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
>> index 945eaaaad016..b84d89c7b3fb 100644
>> --- a/drivers/gpu/drm/v3d/v3d_gem.c
>> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
>> @@ -201,7 +201,8 @@ v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
>>
>>         for (i = 0; i < bo_count; i++) {
>>                 /* XXX: Use shared fences for read-only objects. */
>> -               reservation_object_add_excl_fence(bos[i]->base.resv, fence);
>> +               reservation_object_add_excl_fence(bos[i]->base.base.resv,
>> +                                                 fence);
>
> All these 'bos[i]->base.base' occurrences are not the prettiest.
> Changing your bos array to a struct drm_gem_object ** instead would
> help. That's what I did for panfrost. Though I've not looked at were
> you actually need the v3d_bo.

Agreed that would probably be a goodcleanup, but I'm hoping I can land
the compute shaders first.  I've been doing a lot of rebasing of that
series and I want to just get it done.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyKp1gACgkQtdYpNtH8
nuhPtg/+KxdwmhWLAo13UFLEFNiFCwl80bYblKerlMJcFTpODtJNd4X2ke+KsWbf
25n9HlQyQbvCBXWHFxSShSlrCnRDiaE1AXYQPSgYSrouT5gIkbCRoJKbQ7AeazT5
EfGYVFii1swody+gIopKP1lWn6g3aCxEHx4UW+nQ9OQxhf0BfeORAgZGpsdCrOCu
TqaTWzYXRYyEgZNuqN6NiKGnFV6oAsdDVd5hVy1Wy4NkXmsqyADrT29oldfa4lFJ
05AH/0qm77wBeJVDdzn5OZkPGOzumYiXPQVqrN7WFA2LdbRXO0eECtnmkylAd/bF
+FKuWCXK1eqrHJArDwExK+UF1Sr4NEpWFZP6SYH4iH0t/v9Mo6PCR571bEIdWBxB
zGjgnA2EWOrFkTFWoArh/wYUuEDJQmnmIXuzn+/21xXIDEXfIU5gX+oIh/v4C9Vn
2cAzs6QPaYvL275EXJWhAkwdolrC5QUGFJAJHPbjXbF7srPnS+mfn47UoNKwAdBF
qZdQladN5xlQ6WbTe+FqL2b+08obf2IcEQstvFHTUh4NcrHoQ8Ves+Bca8UPNjwZ
Ugbf7nGTakibTKCsWK+Zg4vAAKM+k3gE2/9wy4Xn7XJMIBzyd5m9wsQEfJVAu85P
F5WQ47jVNQVRBAevrF/bkI8JEU5bysjqz+v6/Zsb4s3YrF7Dr+g=
=9YWP
-----END PGP SIGNATURE-----
--=-=-=--
