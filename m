Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D94FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA6920679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfHEKuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfHEKuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:50:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68AA5C051676;
        Mon,  5 Aug 2019 10:50:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15EC45D712;
        Mon,  5 Aug 2019 10:50:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4A79816E08; Mon,  5 Aug 2019 12:50:39 +0200 (CEST)
Date:   Mon, 5 Aug 2019 12:50:39 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Frediano Ziglio <fziglio@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: get vga ioports
Message-ID: <20190805105039.cxf2ogbzdf7hropp@sirius.home.kraxel.org>
References: <20190805085355.12527-1-kraxel@redhat.com>
 <1869747233.4556840.1564996693878.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1869747233.4556840.1564996693878.JavaMail.zimbra@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 05 Aug 2019 10:50:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > +	ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
> > +	if (ret) {
> > +		DRM_ERROR("can't get legacy vga ports\n");
> > +		goto put_vga;
> 
> I suppose that if this fails it's secondary so should continue.

Ah, right, there are secondary qxl cards (without the vga compat bits).
We should skip the call in that case (likewise for the cleanups).

> What happen configuring 2 QXL devices?
> Only a card should provide VGA registers in the system so
> if any other card provide them QXL won't work.

Well, with intel vgpu everything works fine with this patch.  Probably
i915 skips direct vga register access in case vga_get fails (because qxl
grabed them first).

In any case I'd prefer to fail qxl initialization over continuing
despite vga_get() having failed.  The failure mode is rather awkward:
qemu thinks the qxl card is in vga mode while the guest kernel thinks
qxl is in native mode.  Guest keeps queuing commands until the ring is
full while qemu never takes them out, so at some point the guest kernel
blocks forever in qxl_ring_push().

cheers,
  Gerd

