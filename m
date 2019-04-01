Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFCBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D8920883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfDASWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:22:19 -0400
Received: from anholt.net ([50.246.234.109]:47258 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbfDASWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:22:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E893610A0220;
        Mon,  1 Apr 2019 11:22:17 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wRZ8IiiYAfYF; Mon,  1 Apr 2019 11:22:15 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 90DCD10A278C;
        Mon,  1 Apr 2019 11:22:15 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 2DDF02FE33BA; Mon,  1 Apr 2019 11:22:15 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," 
        <iommu@lists.linux-foundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
In-Reply-To: <CAL_JsqJ4uppXc_Sti67z0ZBJ4sw1RPgNHCg6usqpUmbQcGQmpQ@mail.gmail.com>
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-3-robh@kernel.org> <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com> <CAL_JsqJ4uppXc_Sti67z0ZBJ4sw1RPgNHCg6usqpUmbQcGQmpQ@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 01 Apr 2019 11:22:14 -0700
Message-ID: <87sgv14mcp.fsf@anholt.net>
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

> On Mon, Apr 1, 2019 at 8:07 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
>> >
>> > Similar to the single handle drm_gem_object_lookup(),
>> > drm_gem_objects_lookup() takes an array of handles and returns an array
>> > of GEM objects.
>> >
>> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>> > Cc: Sean Paul <sean@poorly.run>
>> > Cc: David Airlie <airlied@linux.ie>
>> > Cc: Daniel Vetter <daniel@ffwll.ch>
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > ---
>> >  drivers/gpu/drm/drm_gem.c | 46 +++++++++++++++++++++++++++++++--------
>> >  include/drm/drm_gem.h     |  2 ++
>> >  2 files changed, 39 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> > index 388b3742e562..5c9bff45e5e1 100644
>> > --- a/drivers/gpu/drm/drm_gem.c
>> > +++ b/drivers/gpu/drm/drm_gem.c
>> > @@ -663,6 +663,42 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>> >  }
>> >  EXPORT_SYMBOL(drm_gem_put_pages);
>> >
>> > +/**
>> > + * drm_gem_objects_lookup - look up GEM objects from an array of handles
>> > + * @filp: DRM file private date
>> > + * @handle: pointer to array of userspace handle
>> > + * @count: size of handle array
>> > + * @objs: pointer to array of drm_gem_object pointers
>> > + *
>> > + * Returns:
>> > + *
>> > + * @objs filled in with GEM object pointers. -ENOENT is returned on a lookup
>> > + * failure. 0 is returned on success.
>>
>> Bonus points for adding references between the array and normal lookup
>> functions to guide people around. Also a comment that the buffers need
>> to be released with drm_gem_object_put().
>>
>> > + */
>> > +int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
>> > +                          struct drm_gem_object **objs)
>>
>> With a pointer to a pointer I'd expect this function to do the
>> allocation, but it doesn't. Normal pointer is enough to pass an array.
>> Also maybe make the handle pointer
>> const, so it's clear that it's an input parameter.
>
> I thought about doing the allocation here, but then I couldn't
> implement the single drm_gem_object_lookup() using this function.
> Maybe I can refactor in 3 functions making this one a static function.

FWIW, I was thinking for v3d that I'd probably add a helper that took in
the user's pointer to handles :)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyiVtYACgkQtdYpNtH8
nuiMBg//VvQsbg5XwF+KRXj9otwDpkUrrGoK72c+wmoCBIWMPgV9fHi17iVul/8Y
uoIq7rGWoNnPjMMoj50AecbF/Z3848xgsXtwzCSiCSqyEzt9GWHZotNCjUKk+Usu
fvSCW2kMlow9LPPG9XcVqxT7+79fWse7d5bL6nh44rkFYynMtbyV4zYFdPgh2UyP
8IXYtK8W265MCJiLWvMlTxzdoryX7xygVqDnbcqX/bS53zpAVseNar7cxV4I4CK8
xoOv09Np3SmAVN0OGcJe0JjHV4iRUHHldtHqvddYl1WMAGBPH21fir4Qfdid9DAb
atb6QzY/OcS3AZ8hRYm4Lm//WPHfbza6AclnCK9QmsierhFxVRECZED5rUieK0kA
KUYCfNhgB8dxks3lKuYpMOtRXGEbnpiKQsJE1WGiKkWhZvuilb1JCQISZXf7BV93
32zupQg60EXYs+qNFCa2m9w7tCTqia2F0A52/zDB2nXjDMV0umnMzsoPfaqYCywX
nKjqknOC7apeMgEl/WvEXDulLTF8Uo2ZN5Nr6cjoZf3aR2YFsMlhDUJ/z/KYIYeK
JpTowKxpwO3Je7WIQhhDuf7PyiIhUZEy3rxegXKaiDUySuE4mK2p7Nu3F3uAeu2K
8Ou5n5U5sv5PQMdzpVRE2KjxLdti7fd8osmkupb4J/1MYdsmyms=
=q8QO
-----END PGP SIGNATURE-----
--=-=-=--
