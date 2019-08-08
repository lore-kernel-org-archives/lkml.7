Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D86C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B6A2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403769AbfHHKf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:35:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389981AbfHHKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:35:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81CBBEE563;
        Thu,  8 Aug 2019 10:35:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 143C2600C8;
        Thu,  8 Aug 2019 10:35:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4F40F16E08; Thu,  8 Aug 2019 12:35:21 +0200 (CEST)
Date:   Thu, 8 Aug 2019 12:35:21 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] ttm: turn ttm_bo_device.vma_manager into a pointer
Message-ID: <20190808103521.u6ggltj4ftns77je@sirius.home.kraxel.org>
References: <20190808093702.29512-1-kraxel@redhat.com>
 <20190808093702.29512-3-kraxel@redhat.com>
 <2a90c899-19eb-5be2-3eda-f20efd31aa29@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a90c899-19eb-5be2-3eda-f20efd31aa29@amd.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 08 Aug 2019 10:35:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:48:49AM +0000, Koenig, Christian wrote:
> Am 08.08.19 um 11:36 schrieb Gerd Hoffmann:
> > Rename the embedded struct vma_offset_manager, it is named _vma_manager
> > now.  ttm_bo_device.vma_manager is a pointer now, pointing to the
> > embedded ttm_bo_device._vma_manager by default.
> >
> > Add ttm_bo_device_init_with_vma_manager() function which allows to
> > initialize ttm with a different vma manager.
> 
> Can't we go down the route of completely removing the vma_manager from 
> TTM? ttm_bo_mmap() would get the BO as parameter instead.

It surely makes sense to target that.  This patch can be a first step
into that direction.  It allows gem and ttm to use the same
vma_offset_manager (see patch #3), which in turn makes various gem
functions work on ttm objects (see patch #4 for vram helpers).

> That would also make the verify_access callback completely superfluous 
> and looks like a good step into the right direction of de-midlayering.

Hmm, right, noticed that too while working on another patch series.
Guess I'll try to merge those two and see where I end up ...

cheers,
  Gerd

