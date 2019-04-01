Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02631C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D0F206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfDANs7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:48:59 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:50132 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726991AbfDANs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:48:59 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16092181-1500050 
        for multiple; Mon, 01 Apr 2019 14:48:21 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
Cc:     Sean Paul <sean@poorly.run>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-3-robh@kernel.org>
 <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
Message-ID: <155412649586.24691.809508732198367112@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
Date:   Mon, 01 Apr 2019 14:48:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2019-04-01 14:06:48)
> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
> > +{
> > +       int i, ret = 0;
> > +       struct drm_gem_object *obj;
> > +
> > +       spin_lock(&filp->table_lock);
> > +
> > +       for (i = 0; i < count; i++) {
> > +               /* Check if we currently have a reference on the object */
> > +               obj = idr_find(&filp->object_idr, handle[i]);
> > +               if (!obj) {
> > +                       ret = -ENOENT;

Unwind previous drm_gem_object_get(), the caller has no idea how many
were processed before the error.
-Chris
