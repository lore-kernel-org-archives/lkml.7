Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE1C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56449217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FulfrviT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbfKEP5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:57:16 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:36352 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389987AbfKEP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=MEhTFHAycXqkTfqbe4
        XX0vxC02FkcqiVe33GxCZFfQc=; b=FulfrviTwzzFd30cKiL95Hjs4+SCOuUM0Z
        TFiky1RZS6jTn3NDhFr59vkCEeSlvZ1NjFBXi2Fj1mh8l6Johlv6VZbtYooWrdbK
        aB6bjN7N47ug+7kZUx1NJVabxfVAmD3AgFj3KrZe13n9QOwo2QtiJhevXJvPXIgB
        rFi9LWBv4=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp4 (Coremail) with SMTP id HNxpCgBXXrKbm8FdDyEQBQ--.364S3;
        Tue, 05 Nov 2019 23:56:15 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] media: rockchip/rga: fix potential use after free
Date:   Tue,  5 Nov 2019 23:55:54 +0800
Message-Id: <1572969354-8967-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HNxpCgBXXrKbm8FdDyEQBQ--.364S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4UZr17Cr47Kr18XFW3GFg_yoWDJrbE93
        y8XF4xuF4vgrn5K3WUCw1fu3yjya9F9ryfWFyftFWxZFW8Zw1DtFs8ZrZxXF1aqa1I9F9r
        KF98XF17CrsxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjAu4UUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQABkclSIdHYMpwABsi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable vga->vfd is an alias for vfd. Therefore, releasing vfd and
then unregister vga->vfd will lead to a use after free bug. In fact, the
free operation and the unregister operation are reversed.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/media/platform/rockchip/rga/rga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index e9ff12b6b5bb..613b868fce33 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -901,9 +901,9 @@ static int rga_probe(struct platform_device *pdev)
 	return 0;
 
 rel_vdev:
-	video_device_release(vfd);
-unreg_video_dev:
 	video_unregister_device(rga->vfd);
+unreg_video_dev:
+	video_device_release(vfd);
 unreg_v4l2_dev:
 	v4l2_device_unregister(&rga->v4l2_dev);
 err_put_clk:
-- 
2.7.4

