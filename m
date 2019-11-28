Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D715DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5FF21781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4pwOX2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfK1Ljp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:39:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbfK1Ljm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574941181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/jeELqhj5P3A7DPG/PC1XpTw6obMUxkE54tKkidDrQ=;
        b=g4pwOX2rQhNfvIEUgpoCchPqBRTXF9WlB5YAMdLdK1DapGKS0RWhYXqhWd3U4Dd1YNHcLh
        l6jYp036zIve75CJA663lxajKgV5eyVa7mFTN4U9SZahTclEpsHJ/af7BKwbBq9FurOZRY
        JWPuQuHxRIz0kSEboLyVXdAJwcSIJG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-JkfH9-oZNDChP8mZlQBhKw-1; Thu, 28 Nov 2019 06:39:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E29E107ACC7;
        Thu, 28 Nov 2019 11:39:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 526BE5D9E1;
        Thu, 28 Nov 2019 11:39:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 56292A1E0; Thu, 28 Nov 2019 12:39:30 +0100 (CET)
Date:   Thu, 28 Nov 2019 12:39:30 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     robh@kernel.org, intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drm: call drm_gem_object_funcs.mmap with fake
 offset
Message-ID: <20191128113930.yhckvneecpvfhlls@sirius.home.kraxel.org>
References: <20191127092523.5620-1-kraxel@redhat.com>
 <20191127092523.5620-2-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191127092523.5620-2-kraxel@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: JkfH9-oZNDChP8mZlQBhKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:25:22AM +0100, Gerd Hoffmann wrote:
> The fake offset is going to stay, so change the calling convention for
> drm_gem_object_funcs.mmap to include the fake offset.  Update all users
> accordingly.
>=20
> Note that this reverts 83b8a6f242ea ("drm/gem: Fix mmap fake offset
> handling for drm_gem_object_funcs.mmap") and on top then adds the fake
> offset to  drm_gem_prime_mmap to make sure all paths leading to
> obj->funcs->mmap are consistent.
>=20
> v3: move fake-offset tweak in drm_gem_prime_mmap() so we have this code
>     only once in the function (Rob Herring).

Now this series fails in Intel CI.  Can't see why though.  The
difference between v2 and v3 is just the place where vma->vm_pgoff gets
updated, and no code between the v2 and v3 location touches vma ...

confused,
  Gerd

