Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C0DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683D420692
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGsWQv/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKOVHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:07:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26073 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726599AbfKOVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573852068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fZHCbRTyudvOPs1jp78LmqzUhByFAzYjWlaniYrl0dY=;
        b=JGsWQv/Mm+DHjKjtTB1x2R51wFiDSA8U6Nq0t2Yv/VIoMjVwpPWIFJ6Of604ofi/fi82JX
        JodG5rz86sBD6fpKS0a+Nx9pX9vbWmSkISoEu8irFdt3L1sd/eX/YaN+4EhhAzg3rVprhO
        hpWWRkSxwFUzEU+M9ueTOBuXKTW+22I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-gYFElgWXMImczVozR5YyPQ-1; Fri, 15 Nov 2019 16:07:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3BB62F2A;
        Fri, 15 Nov 2019 21:07:41 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F5CC69193;
        Fri, 15 Nov 2019 21:07:36 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Sam Ravnborg" <sam@ravnborg.org>, "Lyude Paul" <lyude@redhat.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Sean Paul" <seanpaul@chromium.org>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        "Peteris Rudzusiks" <peteris.rudzusiks@gmail.com>
Subject: [PATCH 0/3] MST BPC fixes for nouveau
Date:   Fri, 15 Nov 2019 16:07:17 -0500
Message-Id: <20191115210728.3467-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: gYFElgWXMImczVozR5YyPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realized when I moved nouveau over to using the atomic DP MST VCPI
helpers that I forgot to ensure that we clamp the BPC to 8 to make us
less likely to run out of bandwidth on a topology when enabling multiple
displays that support >8 BPC - something we want to do until we have
support for dynamically selecting the bpc based on the topology's
available bandwidth, since userspace isn't really using HDR yet anyway.
This matches the behavior that i915 has, along with the behavior of
amdgpu and should fix some people's displays not turning on.

Lyude Paul (3):
  drm/nouveau/kms/nv50-: Call outp_atomic_check_view() before handling
    PBN
  drm/nouveau/kms/nv50-: Store the bpc we're using in nv50_head_atom
  drm/nouveau/kms/nv50-: Limit MST BPC to 8

 drivers/gpu/drm/nouveau/dispnv50/atom.h |   1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 102 ++++++++++++++----------
 drivers/gpu/drm/nouveau/dispnv50/head.c |   5 +-
 3 files changed, 64 insertions(+), 44 deletions(-)

--=20
2.21.0

