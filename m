Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FCBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A8820656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfF1KtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfF1KtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:49:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1069A30BBEA6;
        Fri, 28 Jun 2019 10:49:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B44EE1001B1B;
        Fri, 28 Jun 2019 10:49:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EB20D11AA3; Fri, 28 Jun 2019 12:49:07 +0200 (CEST)
Date:   Fri, 28 Jun 2019 12:49:07 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/12] drm/virtio: switch from ttm to gem shmem helpers
Message-ID: <20190628104907.vign7lmgftrwfisv@sirius.home.kraxel.org>
References: <20190620060726.926-1-kraxel@redhat.com>
 <20190620060726.926-12-kraxel@redhat.com>
 <CAPaKu7QXCMMKR50Oiv=CefUA4S+S3KgpJ2FKTd1WA1H2_ORqXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7QXCMMKR50Oiv=CefUA4S+S3KgpJ2FKTd1WA1H2_ORqXg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 28 Jun 2019 10:49:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  static inline struct virtio_gpu_object*
> >  virtio_gpu_object_ref(struct virtio_gpu_object *bo)

> The last users of these two helpers are removed with this patch.  We
> can remove them.

patch 12/12 does that.

> > +       bo = gem_to_virtio_gpu_obj(&shmem_obj->base);
> > +       bo->base.base.funcs = &virtio_gpu_gem_funcs;
> Move this to virtio_gpu_create_object.

Fixed.

> > +       ret = drm_gem_shmem_pin(&obj->base.base);
> The bo is attached for its entire lifetime, at least currently.  Maybe
> we can use drm_gem_shmem_get_pages_sgt (and get rid of obj->pages).

Already checked this.
We can't due to the iommu quirks.

cheers,
  Gerd

