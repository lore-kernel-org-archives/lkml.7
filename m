Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFC82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXy6TgE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfLKIPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:15:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726983AbfLKIPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576052150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9+eXVJvGhvjgCko5lAbFcvBiKAk1D5Fec1eKLqFyyY=;
        b=ZXy6TgE6/MJyjO7nN6qbTrAlargJ83+qMWK3YcWM1mN46Idt6Cah8TK+TIDJj73P9qCxx9
        cXozvhshv9OB/Mk9u8hX95htVOYVcR0ZABMI71oXWgbfNHu9SNvZ1KfuniLmbH/IRzb0+i
        9BJy7a8RaFLzjCKiN74l7qX8pHCo7e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-wgVuXbNjO-abuQ7falBagA-1; Wed, 11 Dec 2019 03:15:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0942E911EA;
        Wed, 11 Dec 2019 08:15:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DEB160BE1;
        Wed, 11 Dec 2019 08:15:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AB48E16E05; Wed, 11 Dec 2019 09:15:41 +0100 (CET)
Date:   Wed, 11 Dec 2019 09:15:41 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        gurchetansingh@chromium.org
Subject: Re: [PATCH] drm/virtio: fix mmap page attributes
Message-ID: <20191211081541.ejofg4uxo6poss6v@sirius.home.kraxel.org>
References: <20191210085759.14763-1-kraxel@redhat.com>
 <e8915378-df67-e6f4-f40c-599797e16e9c@suse.de>
MIME-Version: 1.0
In-Reply-To: <e8915378-df67-e6f4-f40c-599797e16e9c@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wgVuXbNjO-abuQ7falBagA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> There's similar code in udl, [1] which still uses writecombine for
> imported buffers. Virtio does not need this?

virtio doesn't support dma-buf imports (yet).
So no worries for now.

Why pick writecombine for the imported buffer btw?
It'll probably be correct for the majority of imports, but it still
looks like a educated guess to me.  What if you import from vgem?

I guess we should either ...
  (1) Ask the exporting driver to handle things, simliar to how it is
      done for vmaps already, probably by calling dma_buf_mmap(), or
  (2) Refuse to mmap imported objects via drm api.

> Aside from this, do you think we could handle all special cases within
> shmem?

Probably makes sense to teach shmem helpers about caching.

cheers,
  Gerd

