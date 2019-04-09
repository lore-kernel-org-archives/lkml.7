Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C93C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C90E2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDIQzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:55:31 -0400
Received: from anholt.net ([50.246.234.109]:38128 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:55:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2E1BE10A32EB;
        Tue,  9 Apr 2019 09:55:30 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AP9KTSRNASch; Tue,  9 Apr 2019 09:55:28 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A1FB210A32EA;
        Tue,  9 Apr 2019 09:55:28 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 3DC602FE36FA; Tue,  9 Apr 2019 09:55:28 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," 
        <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
In-Reply-To: <CAL_Jsq+So-kadir8o8T-YNYkfOYD8vopAS3UWGbSdRVLjH_JGQ@mail.gmail.com>
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-3-robh@kernel.org> <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com> <155412649586.24691.809508732198367112@skylake-alporthouse-com> <8736n120jw.fsf@anholt.net> <CAL_Jsq+So-kadir8o8T-YNYkfOYD8vopAS3UWGbSdRVLjH_JGQ@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Apr 2019 09:55:27 -0700
Message-ID: <878swjnmo0.fsf@anholt.net>
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

> On Mon, Apr 1, 2019 at 10:43 AM Eric Anholt <eric@anholt.net> wrote:
>>
>> Chris Wilson <chris@chris-wilson.co.uk> writes:
>>
>> > Quoting Daniel Vetter (2019-04-01 14:06:48)
>> >> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
>> >> > +{
>> >> > +       int i, ret = 0;
>> >> > +       struct drm_gem_object *obj;
>> >> > +
>> >> > +       spin_lock(&filp->table_lock);
>> >> > +
>> >> > +       for (i = 0; i < count; i++) {
>> >> > +               /* Check if we currently have a reference on the object */
>> >> > +               obj = idr_find(&filp->object_idr, handle[i]);
>> >> > +               if (!obj) {
>> >> > +                       ret = -ENOENT;
>> >
>> > Unwind previous drm_gem_object_get(), the caller has no idea how many
>> > were processed before the error.
>>
>> I had the same thought, but the pattern we have is that you're loading
>> into a refcounted struct that will free the BOs when you're done,
>> anyway.
>
> The real bug here is if allocation of the array fails. The BO array
> may be NULL when the count is not. So this V3D cleanup hunk:
>
> for (i = 0; i < exec->bo_count; i++)
>   drm_gem_object_put_unlocked(&exec->bo[i]->base.base);
>   kvfree(exec->bo);
>
> Needs to be wrapped with 'if (exec->bo)'. We have a similar problem
> with fence arrays too.

Yeah, seems legit.  Not really going to write new patches when I've got
month-old critical patches I can't get acked, though. :/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyszn8ACgkQtdYpNtH8
nugquA/8DPK4mN09dn/AZq67osFqFl6wN3K0sqmG6JaW+Opu7DkzH10fmUthRfbD
+q2HSJATWQbIP04FLmCmOp6AeqfWV7aX8jB39ltn3EHxuFb0qdLyFm/Rp6Tyr+sb
yn+GknjYKzO56+SZFoaIJuBcpZKEUjaxhfr85fgJxfR0nR7B2wH3n+IIRf+dFWeO
6hmRFNzENYeaPgQCHkNnYLxXnQDIDZ+eScp1Z3CwpU4LCJFEM6LylXx7xordg9qa
ljfYYT/asSruPYpvTjiQ2fhvlsgFizn6uA4R//Ls45LMtQaT/4gnCFuAI8w8559O
ppg7QkBHqbUYji7bSZVQzQwp/QNAGwg/aVbaKrLCj1hFRxj73e9VllofndapQV45
Vv/5CYaG84CntgdN8AK34R1s90NHDRkGJV9A3FaY/9sTk1y7uV+OArcdsChhNNRT
m4eq1cBGwA4n8ZuxbApcM0m0e6oA6qMxathbeIaTab5UEYnlWl3UTsXaOT0EEuDx
A0XRCq1X2natvm9Zf40AX9p4WUDH1eNE7DJyIHO7LY2jC++7v2YwWK2T/ccS09tK
QUAhTvQc4wlCBTIz40s7cWcxPmEWQuhcaAnY6e499HZPiE0RoLarMh42t/fiz+Rp
Ie3qcv6nRTNQHWJrGCKiKbQEiNK2MSzJxptXA0KGwFcvlp41CcY=
=vGS6
-----END PGP SIGNATURE-----
--=-=-=--
