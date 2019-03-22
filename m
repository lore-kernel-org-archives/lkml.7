Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78366C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFC621900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfCVVcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:32:48 -0400
Received: from anholt.net ([50.246.234.109]:52848 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfCVVcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:32:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E33E710A2F13;
        Fri, 22 Mar 2019 14:32:46 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id rHgAq3A3uj_F; Fri, 22 Mar 2019 14:32:45 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A985010A2C47;
        Fri, 22 Mar 2019 14:32:45 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 419872FE4653; Fri, 22 Mar 2019 14:32:45 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Dave Emett <david.emett@broadcom.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Subject: Re: [PATCH 1/4] drm/v3d: Add a note about OOM vs FRDONE, which may be racing on v3.3.
In-Reply-To: <CAApk1dWqPtCem_BHYVKY47TR8GtvDivY_kg0fv+w+gBZZPnNqA@mail.gmail.com>
References: <20190313235211.28995-1-eric@anholt.net> <CAApk1dWqPtCem_BHYVKY47TR8GtvDivY_kg0fv+w+gBZZPnNqA@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 22 Mar 2019 14:32:44 -0700
Message-ID: <87d0mi388z.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Dave Emett <david.emett@broadcom.com> writes:

> On Wed, 13 Mar 2019 at 23:52, Eric Anholt <eric@anholt.net> wrote:
>>
>> We deref v3d->bin_job in the work handler, but v3d->bin_job doesn't
>> actually hold a ref on the job.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Dave Emett <david.emett@broadcom.com>
>
>> ---
>>  drivers/gpu/drm/v3d/v3d_irq.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
>> index b4d6ae81186d..a09442ec7297 100644
>> --- a/drivers/gpu/drm/v3d/v3d_irq.c
>> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
>> @@ -87,7 +87,8 @@ v3d_irq(int irq, void *arg)
>>         if (intsts & V3D_INT_OUTOMEM) {
>>                 /* Note that the OOM status is edge signaled, so the
>>                  * interrupt won't happen again until the we actually
>> -                * add more memory.
>> +                * add more memory.  Also, as of V3D 4.1, FRDONE won't
>> +                * be reported until any OOM state has been cleared.
> Strictly speaking it's FLDONE for bins.

Fixed, thanks.

I'm applying the first 2 of the series for now.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyVVH0ACgkQtdYpNtH8
nuiD/hAAnqi/pyh5g+qPMyvsPFptn5iGmBRB0XTvEFlsIw9yb/NGc+PGjGlISymi
W5VLmYxN+beMCG5LKZriIWre3x5nyuAWvxfUbh8WdlmV1ieB7apqLoDwfI0Y78MP
yzAw013nPLEV5ghuC6s4fUcJn+OttXFPnyrzXwTu4ro4UKApfV5/rSvQRSKmpkJ+
l372h38SgW86FWi51mvlAh62U03O1UuFZMeBIvhAzgJUCngfgEH2Q9v2F75YQrhG
fSWnkuIEMqMb+2dM1tEkVpqt4gBJ5OHNlYfJNycNU+qIYbT6CaVdGhzRhwNsG6rH
FbKY1fYVvBaAhc5A2SRokig+Zu548+iFZjK5V7FHR168VUfEC1NrCt0ujEE3BD62
gvJrc6/tNHqGecGP0Y2DaW11TqPEnPoAc4YWTJ66asQ80gwO/R+opfVuzLp1bM98
zYPixTI99mp2PSaLmgSQkCxCKJTUiS0yklgGf/Cq1aOn+KnaBtf6d9l0MRjPxXIu
QbuLlIHPxdoj6bkNeV50mqoAdQLIdF6hTexLrsu/ZyXaWnB7a+0IvV6taUSJe4RS
pa3oeVO8wAeDS8FywTLGV5one4y7lpuhsu20zvFRF2BGBCrUhnSgCUZmnI4siLVo
RMswNVqzCaw8Ew3U17dCXqs25IKEskDeuG5jI7IwiwN0jP9BrUo=
=fGyR
-----END PGP SIGNATURE-----
--=-=-=--
