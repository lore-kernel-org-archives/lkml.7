Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB748C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E7C218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfGEOHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:07:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbfGEOHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:07:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FCC459451;
        Fri,  5 Jul 2019 14:07:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-90.ams2.redhat.com [10.36.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1D277DE33;
        Fri,  5 Jul 2019 14:07:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C692B16E2D; Fri,  5 Jul 2019 16:07:46 +0200 (CEST)
Date:   Fri, 5 Jul 2019 16:07:46 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 15/18] drm/virtio: rework
 virtio_gpu_transfer_to_host_ioctl fencing
Message-ID: <20190705140746.czs2e5ffryx2slxf@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
 <20190702141903.1131-16-kraxel@redhat.com>
 <CAPaKu7S0n=E7g0o2e6fEk1YjP+u=tsoV8upw7J=noSx88PgP+A@mail.gmail.com>
 <20190704115138.ou77sb3rlrex67tj@sirius.home.kraxel.org>
 <CAPaKu7SDwR1TgFQK2XGEbRqSkCO0XZYxGhcjzsAwOH42aOHEEw@mail.gmail.com>
 <20190705090553.jx5zcdoxeimojq2i@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705090553.jx5zcdoxeimojq2i@sirius.home.kraxel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 05 Jul 2019 14:07:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > ... 3d case passes the objs list to virtio_gpu_cmd_transfer_to_host_3d,
> > > so it gets added to the vbuf and released when the command is finished.
> > Why doesn't this apply to virtio_gpu_cmd_transfer_to_host_2d?
> 
> Hmm, yes, makes sense to handle both the same way.
> 
> With virgl=off qemu processes the commands from the guest
> synchronously, so it'll work fine as-is.  So you can't hit
> the theoretical race window in practice.  But depending
> on that host-side implementation detail isn't a good idea
> indeed.

Branch with incremental fixes:
https://git.kraxel.org/cgit/linux/log/?h=drm-virtio-kill-ttm

I'll be offline three weeks now, will resume this when I'm back.

cheers,
  Gerd

