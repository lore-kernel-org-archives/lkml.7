Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9AEC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1742173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbfHHNkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:40:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732882AbfHHNkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:40:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5BB5315C005;
        Thu,  8 Aug 2019 13:40:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0B55C219;
        Thu,  8 Aug 2019 13:40:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A029816E08; Thu,  8 Aug 2019 15:40:00 +0200 (CEST)
Date:   Thu, 8 Aug 2019 15:40:00 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] ttm: turn ttm_bo_device.vma_manager into a pointer
Message-ID: <20190808134000.oz5ztbjyyux5ufvo@sirius.home.kraxel.org>
References: <20190808093702.29512-1-kraxel@redhat.com>
 <20190808093702.29512-3-kraxel@redhat.com>
 <2a90c899-19eb-5be2-3eda-f20efd31aa29@amd.com>
 <20190808103521.u6ggltj4ftns77je@sirius.home.kraxel.org>
 <20190808120252.GO7444@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808120252.GO7444@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 08 Aug 2019 13:40:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > > That would also make the verify_access callback completely superfluous 
> > > and looks like a good step into the right direction of de-midlayering.
> > 
> > Hmm, right, noticed that too while working on another patch series.
> > Guess I'll try to merge those two and see where I end up ...
> 
> ... but if it gets too invasive I'd vote for incremental changes.

Yep, this is what I'm up to.  Sketching things up with vram helpers and
qxl, in a way that we can switch over drivers one by one.

Once all drivers are switched removing ttm_bo_device.vma_manager
altogether should be easy.

> Even if
> we completely rip out the vma/mmap lookup stuff from ttm, we still need to
> keep a copy somewhere for vmwgfx.

If vmwgfx is the only user we can probably just move things from ttm to
vmwgfx.

> Or would the evil plan be the vmwgfx
> would use the gem mmap helpers too?

That would work as well ;)

cheers,
  Gerd

