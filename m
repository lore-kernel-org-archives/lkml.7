Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88018C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D22E2072C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 13:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpLqyLlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgAENWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:22:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28161 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726240AbgAENWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 08:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578230533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=In+0vCYCUg5srKg9dQl7QsQxw+2F0g+Q33KWDu01COk=;
        b=JpLqyLlZt2ZUbUWT0ZXRavpoi60XmKSGxIpgDf/2KUx/xdl7Rd45wKWFfvm58cqi3n/ekj
        d6OoGaGgarV2SHzUFxDXdT9oUsRKDzM6YDHIBL3umYXfJcsCboScd4MIGv6gHYqaTZo8lW
        hGdEQPAVt0ZoBXurbhqB96vJokDgIBo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-vucn-IfQMR2SiHv6Kxi4Zg-1; Sun, 05 Jan 2020 08:22:12 -0500
X-MC-Unique: vucn-IfQMR2SiHv6Kxi4Zg-1
Received: by mail-qt1-f198.google.com with SMTP id l1so32587310qtp.21
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 05:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=In+0vCYCUg5srKg9dQl7QsQxw+2F0g+Q33KWDu01COk=;
        b=JZdUE0roAXHDdLJktgLhoWKwcvKXiGkGtEjE1/DzzD4bSfqLPt/05XVx8f3QpnNzhR
         0zxvGJmV7WMI79QPd3I3QVXDviCAWwh4VUfSioNlW4ZHJSsw6E5wAiL2JYp2qYPEDPfz
         /0eKsHx2nuQ8WrqOOL6WyfX2/rpO+mpPAc35fnB4vlOjrMAPbWzlnH2AGs7AXcyIcAT3
         gUzGVN10dkF2FGTyY0++lfpYFzNFMq40qitijuWW2XR+8NPFlch6C4h7K8WDLuoyP45r
         PtReuHsN/1nT/9Bu3d5TEAEpM52C75UnJgZHX2Z+fkaTM9MO89PQje5fSirBBJj/ouu9
         DY9w==
X-Gm-Message-State: APjAAAUkU+n4FlQixHXdUuhfln49Aifb8yhqxqaQmCzUIiOs5lkzIs9F
        Ud3Y3ubFaVkxWwwIm6DjYOSRrWTxyhCyI/7ouja2RvkS6s2FbgY+gzqTHqASo1cvS+3FEI5GNGI
        cpi4/bFncn2D1GDNbawoNyhOw
X-Received: by 2002:a0c:f24a:: with SMTP id z10mr76733958qvl.33.1578230531870;
        Sun, 05 Jan 2020 05:22:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyUWCiAw1lxoCGQUnGp+u8A3Lfb79bSc8yodanv1kN0I5K95cgXC7zaFq0VLZPOw2HTPs0EQ==
X-Received: by 2002:a0c:f24a:: with SMTP id z10mr76733944qvl.33.1578230531679;
        Sun, 05 Jan 2020 05:22:11 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id g16sm19273900qkk.61.2020.01.05.05.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 05:22:10 -0800 (PST)
Date:   Sun, 5 Jan 2020 08:22:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Delva <adelva@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v2] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
Message-ID: <20200105132120.92370-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only way for guest to control offloads (as enabled by
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) is by sending commands
through CTRL_VQ. So it does not make sense to
acknowledge VIRTIO_NET_F_CTRL_GUEST_OFFLOADS without
VIRTIO_NET_F_CTRL_VQ.

The spec does not outlaw devices with such a configuration, so we have
to support it. Simply clear VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
Note that Linux is still crashing if it tries to
change the offloads when there's no control vq.
That needs to be fixed by another patch.

Reported-by: Alistair Delva <adelva@google.com>
Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Same patch as v1 but update documentation so it's clear it's not
enough to fix the crash.

 drivers/net/virtio_net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4d7d5434cc5d..7b8805b47f0d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2971,6 +2971,15 @@ static int virtnet_validate(struct virtio_device *vdev)
 	if (!virtnet_validate_features(vdev))
 		return -EINVAL;
 
+	/* VIRTIO_NET_F_CTRL_GUEST_OFFLOADS does not work without
+	 * VIRTIO_NET_F_CTRL_VQ. Unfortunately spec forgot to
+	 * specify that VIRTIO_NET_F_CTRL_GUEST_OFFLOADS depends
+	 * on VIRTIO_NET_F_CTRL_VQ so devices can set the later but
+	 * not the former.
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
+			__virtio_clear_bit(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS);
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
 		int mtu = virtio_cread16(vdev,
 					 offsetof(struct virtio_net_config,
-- 
MST

