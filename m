Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5262C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8103206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDIIrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:47:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIIrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:47:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E50793002727;
        Tue,  9 Apr 2019 08:47:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97E0F600D4;
        Tue,  9 Apr 2019 08:47:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C583616E03; Tue,  9 Apr 2019 10:47:19 +0200 (CEST)
Date:   Tue, 9 Apr 2019 10:47:19 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/qxl: drop prime import/export callbacks
Message-ID: <20190409084719.qaiq5pyigfezroni@sirius.home.kraxel.org>
References: <20190110081750.11358-1-kraxel@redhat.com>
 <CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
 <CAPM=9tyEmn2LXhNmPSOi7JAgBc3QZwNtM+8FT8CWebz4GztaJA@mail.gmail.com>
 <20190409060323.xrw3fwj3yvcxsx3t@sirius.home.kraxel.org>
 <CAMwc25q-7rfR=31R=FEVC47z2HvDK5xN+aOKqq00yoXSpudusQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwc25q-7rfR=31R=FEVC47z2HvDK5xN+aOKqq00yoXSpudusQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Apr 2019 08:47:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Should we add something like DRM_PRIME_CAP_SAME_DEVICE?
> 
> Yeah I expect we need some sort of same device only capability, so
> that dri3 userspace can work.
> 
> If we just fail importing in these cases what happens? userspace just
> gets confused, I know we used to print a backtrace if we hit the mmap
> path, but if we didn't do that what happens?

Well, we printed a backtrace and returned -EINVAL.  So it looked a bit
scary due to the backtrace which is usually printed for more serious
problems.  But we also returned a proper error code.

Userspace was not happy.  It was wayland (gnome-shell) which ran into it
it, and it didn't came up with a working display.

cheers,
  Gerd

