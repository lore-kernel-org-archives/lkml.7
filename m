Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7019EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486F620857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfDAPny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:43:54 -0400
Received: from anholt.net ([50.246.234.109]:44994 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfDAPnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:43:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3F85B10A280A;
        Mon,  1 Apr 2019 08:43:50 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id o7B0OpqILtge; Mon,  1 Apr 2019 08:43:49 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F361310A0220;
        Mon,  1 Apr 2019 08:43:48 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 76A912FE2F72; Mon,  1 Apr 2019 08:43:48 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\, 
        Joerg Roedel \<joro\@8bytes.org\>\, " 
        <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
In-Reply-To: <155412649586.24691.809508732198367112@skylake-alporthouse-com>
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-3-robh@kernel.org> <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com> <155412649586.24691.809508732198367112@skylake-alporthouse-com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 01 Apr 2019 08:43:47 -0700
Message-ID: <8736n120jw.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Chris Wilson <chris@chris-wilson.co.uk> writes:

> Quoting Daniel Vetter (2019-04-01 14:06:48)
>> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
>> > +{
>> > +       int i, ret = 0;
>> > +       struct drm_gem_object *obj;
>> > +
>> > +       spin_lock(&filp->table_lock);
>> > +
>> > +       for (i = 0; i < count; i++) {
>> > +               /* Check if we currently have a reference on the object */
>> > +               obj = idr_find(&filp->object_idr, handle[i]);
>> > +               if (!obj) {
>> > +                       ret = -ENOENT;
>
> Unwind previous drm_gem_object_get(), the caller has no idea how many
> were processed before the error.

I had the same thought, but the pattern we have is that you're loading
into a refcounted struct that will free the BOs when you're done,
anyway.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyiMbMACgkQtdYpNtH8
nujFuRAAtd7ggD7Y+nzWpAGHGpCEBgf6La2B4uHi5SYwMJ1ayMSjxnkx31DyQ4el
ehc1zitZ8lNeJs3RkeIQTlBcLvVmCvkiKRftEIHihA+hbPl9Y8+sadcEbSln2kHT
vjGZyEQ9anQjQIOSaiSmUMVO2MzbbjS9VNsRP87jHDiqu40WSA9R8lP0yFnbjTkJ
4Fc4wnoduR+Z+o5DxhknFRhBfivIswXI25LnB+gG/cCJ4i8N6QjoY/qbQnnQHcwK
hbDTWkqeN2lyzZkTW/fvvksDRY+ODAj1J5kyQohhe9O3qtTRxawtHcRWqjPRDXfY
LC4bKRjRk9184JJQxnwW8KqsuYsqciHDPjWY8U6ezoTrHQ2QnRguC4IiUSICLrhT
Ova551wK9xbKIfhVd1M1NWx5QgOn7KWoy7Oiv+DMHGGN7+ohHzo5kABb3OLQA36o
DRMTk0Ot3KsTFCskbHR0mkGTCEFjyC96R9VmkSToi1QCW8enDwe4jdskXcX5An8h
59dZvFgCn641x08E6mG1j2PkyuzezV7puE5CbJWlJWlaVRXP+QGngydTS29AaJip
GOT2fIabzQ8fQ3eCmaD9Wtpx7xY8p6HAIwmk95fk/XjtTLs4iS9ZGc8+vM+ISdWv
Qaw7BpiSXNPLGi3/C1rGpLTCaDVcEWafWJkEDf9puOnci7aSwjM=
=jMdG
-----END PGP SIGNATURE-----
--=-=-=--
