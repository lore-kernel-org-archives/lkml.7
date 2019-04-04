Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85C0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04F72147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfDDK11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:27:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfDDK1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7945B20264;
        Thu,  4 Apr 2019 10:27:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F19B62669;
        Thu,  4 Apr 2019 10:27:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4EA2B16E31; Thu,  4 Apr 2019 12:27:22 +0200 (CEST)
Date:   Thu, 4 Apr 2019 12:27:22 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Message-ID: <20190404102722.w6c7aoxzcrhn5xhi@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
 <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
 <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
 <CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
 <20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
 <CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
 <2866e37e-8563-1f1e-8f16-1119f70d52e1@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2866e37e-8563-1f1e-8f16-1119f70d52e1@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 04 Apr 2019 10:27:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > tinydrm_xrgb8888_to_*
> > 
> > imo these could be put into some drm_format_helpers.c to be shared.
> 
> I agree, my long term goal is to get rid of tinydrm.ko. Just haven't got
> there yet.
> 
> Gerd, if you end up using some of those functions, feel free to move
> just those you need and I can do the rest later. But if you have time to
> spare I wouldn't mind getting all of them moved ;-)

For now I just promoted cirrus to be a tinydrm driver ;)

Noticed that those helpers (including tinydrm_memcpy for the
non-converting case) apply clipping on the source but not on
the destination.  So, for fullscreen updates that works ok,
but for updating sub-rectangles it doesn't ...

So I guess I have to add a dest_clip bool parameter when moving them.
/me looks for a good place.  drm_fb_helpers.c I think.

cheers,
  Gerd

