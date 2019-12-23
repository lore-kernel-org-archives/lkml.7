Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38473C2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017F20828
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 18:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H87+VOrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLWS7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:59:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56053 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLWS7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 13:59:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so139198pjz.5;
        Mon, 23 Dec 2019 10:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t2pcE/zB/zRFa+D+0DGOcMCSuy9rY9vAk3qxszJwLvo=;
        b=H87+VOrxrVlOydWiSP/CZqoU2QHdFei/jyBu887pLm+G9l7owgyTBs5Yc2xPwbf+cF
         2A/Z2a957FZNCq5ePoWmbgsjUXO3HoS2RterAFvRDcnuiWFq56AITBhwSig4wDQpcjod
         4UmZ3oPM57B75+90Uv4tfswd7l2D+miZNLWKs0PV7rIN2f9huUDrTjekZev4ZwKgAUda
         6IdAK5hLSt1s2wgiIbrUOfWBdEzP2VVYq8u8Y8LmWMrBcEdnkb/nE9GJJn6AL9IGTi9Y
         9UVTNDE1xGhL2hu+PsmhLP30C51H8vCllgDS25vuLUF3UF2qxiMgSIeF5F2AfFw97/ZA
         GdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t2pcE/zB/zRFa+D+0DGOcMCSuy9rY9vAk3qxszJwLvo=;
        b=KFXmbHpTkMAUg+CrFnRv7ObYSweuHQUxDiorAbQxn6Y+sqPwHzogDbSOr1wYIKqdaa
         iqd2SNY0gfaCiazJ6lToYxe3QiORsp8ex3DbZF9SxEYuZwtpMNo5GB4UjgdIBJGnKs0w
         bJT3fDXZMjRtn8uvFCp+FV65ZH9orOzaF/k89vyx2QtMbkyEasEKldiM4C6O/IAb1fn5
         zNpwLsMd/7cgT4K/gZr/+OV81KalykQc63WCgxWfeVMgXg29VgegaQ+ge5QLtflPKC9+
         EDWNkeONU09Nzs9VLVoXL1llJtEqK3YD3kJhNdm/YaBHwHXu8hf8QUFtXu4z596jnKJP
         +3Eg==
X-Gm-Message-State: APjAAAV/KQ5lGxhGFIcdwDM8xCEthd9utckPepJ77nV44RUs+mnCb6p5
        4ZJCYjqfjLNCkDI9aBP1B88=
X-Google-Smtp-Source: APXvYqxwTeofmvSQXzsVzn9vv5ovtl+Qlq7vr/WZrlMMh2w/A1BzAZFQoZorn2f8/xm484BESZek6A==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17mr31189741pll.94.1577127563256;
        Mon, 23 Dec 2019 10:59:23 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id v8sm24823853pff.151.2019.12.23.10.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Dec 2019 10:59:22 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     m.szyprowski@samsung.com, joro@8bytes.org, kgene@kernel.org,
        krzk@kernel.org, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, heiko@sntech.de,
        mst@redhat.com, jasowang@redhat.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] virtio-mmio: convert to devm_platform_ioremap_resource
Date:   Mon, 23 Dec 2019 18:59:13 +0000
Message-Id: <20191223185918.9877-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223185918.9877-1-tiny.windzz@gmail.com>
References: <20191223185918.9877-1-tiny.windzz@gmail.com>
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

