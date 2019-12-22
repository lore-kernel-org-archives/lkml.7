Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41E7C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 19:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA86206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 19:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK3u6NGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfLVTIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 14:08:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46077 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfLVTIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 14:08:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so6322173pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t2pcE/zB/zRFa+D+0DGOcMCSuy9rY9vAk3qxszJwLvo=;
        b=eK3u6NGTjCt3W6n8+0kujic7kEYU+S23lpnUv4W0WBuW1drRdllW/DFgThMGZVF8/Z
         w6PtNPkCPEpyp7kEn/OIqwWI7FlvrHh7pbKWdlUpDP4qMfOB8p8NvSyVkaC9CmlENc5m
         9HbwVrK+GgovJWWsH7G4QJID9V00e9WIpcGVgNblJx+/tGXFWKpQVfV+xZEzUV8ZN1bk
         tfUV2NjuIcskaaBE7v8wywg9z2+BUYgsrCq8xfnfsYfZTO9uu1/7KDQsPsQgs21EObjo
         knHrkV3QDFsg7oToxZ/iVXjdN1R/TNuA4FmrJzpZhkuEWx0De3Lnp8Q1XFcuuWvV9ets
         dCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t2pcE/zB/zRFa+D+0DGOcMCSuy9rY9vAk3qxszJwLvo=;
        b=AIvbyU02EYh6vHfbNunXZYqdMD7+6cO6hFaxWAz6UFJ6pS87jVitp1RY1bIQUvj1Fu
         5Lu9lEJuitP39cNyEZNMbEpelfCJYlFDFV2UMyfihgKVFRXFHCH6Fvt6Py0GhDjrI435
         i7OpqC2ENMwZKpis4vehkfrhQkc1jq6oAbtMQamX+1xvkvv8dmGwzLltL+TZ0EICY3zH
         9xcilFBEEM4zIVRBq0xRPBtzcMpmRFUUghisBtP4OeIyswlReKpWQMdGE+2qqbWPG2IU
         vxF7YJtk1W8Uzv8mg2GGVBgfU9DQP0mObnadb+PfHxfjIDfJRQGdIHucr3ahuQKsjAH4
         7YPQ==
X-Gm-Message-State: APjAAAXzTdse5N1tiuv4AL2ijRACobP4/eItgDQKmQdMrCQDXO6bhmLZ
        9bCaACdPovVQPPUuyRm7z2g=
X-Google-Smtp-Source: APXvYqz39Vp0a6zPzR6fPNDFQyU57GdaiKA8kXCxB1r5wua09/6D53xwbX3AciCIHG6yNWbyBak+nw==
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr13130220pjr.100.1577041722010;
        Sun, 22 Dec 2019 11:08:42 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id p28sm19181262pgb.93.2019.12.22.11.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 11:08:41 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] virtio-mmio: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 19:08:39 +0000
Message-Id: <20191222190839.4863-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code, which
contains platform_get_resource, devm_request_mem_region and
devm_ioremap.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/virtio/virtio_mmio.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e09edb5c5e06..97d5725fd9a2 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -531,18 +531,9 @@ static void virtio_mmio_release_dev(struct device *_d)
 static int virtio_mmio_probe(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev;
-	struct resource *mem;
 	unsigned long magic;
 	int rc;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -EINVAL;
-
-	if (!devm_request_mem_region(&pdev->dev, mem->start,
-			resource_size(mem), pdev->name))
-		return -EBUSY;
-
 	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
 	if (!vm_dev)
 		return -ENOMEM;
@@ -554,9 +545,9 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&vm_dev->virtqueues);
 	spin_lock_init(&vm_dev->lock);
 
-	vm_dev->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (vm_dev->base == NULL)
-		return -EFAULT;
+	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(vm_dev->base))
+		return PTR_ERR(vm_dev->base);
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
-- 
2.17.1

