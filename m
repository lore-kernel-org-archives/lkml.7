Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7391CC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E7F20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfILMiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:38:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4BD710C092C;
        Thu, 12 Sep 2019 12:38:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EE9360872;
        Thu, 12 Sep 2019 12:38:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B502E16E05; Thu, 12 Sep 2019 14:38:21 +0200 (CEST)
Date:   Thu, 12 Sep 2019 14:38:21 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stevensd@chromium.org,
        marcheu@chromium.org, zachr@chromium.org, keiichiw@chromium.org,
        posciak@chromium.org
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
Message-ID: <20190912123821.rraib5entkcxt5p5@sirius.home.kraxel.org>
References: <20190912094121.228435-1-tfiga@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912094121.228435-1-tfiga@chromium.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 12 Sep 2019 12:38:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> To seamlessly enable buffer sharing with drivers using such frameworks,
> make the virtio-gpu driver expose the resource handle as the DMA address
> of the buffer returned from the DMA-buf mapping operation.  Arguably, the
> resource handle is a kind of DMA address already, as it is the buffer
> identifier that the device needs to access the backing memory, which is
> exactly the same role a DMA address provides for native devices.

No.  A scatter list has guest dma addresses, period.  Stuffing something
else into a scatterlist is asking for trouble, things will go seriously
wrong when someone tries to use such a fake scatterlist as real scatterlist.

Also note that "the DMA address of the buffer" is bonkers in virtio-gpu
context.  virtio-gpu resources are not required to be physically
contigous in memory, so typically you actually need a scatter list to
describe them.

cheers,
  Gerd

