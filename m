Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB3C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8720665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600179;
	bh=Ksua/iMAduhWu+zLOlCp9/5YnnI7hgB2q1RZ0J0XCFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LF/s8j5AdS55YPohAvNahs6zglTTjBbcTw2tZuhIqvo2lYBhvXhupxUr0egee9EE6
	 QxICBz4Ov/5Vib3B+PvF+Fp+8etBC4cxEF6JFVajhkjSHNCbk7/oDPJ/bIwb+Yikpf
	 J6cATw/bODJ5XuW6SbEYPurniL1iMJOukgQ/a4uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390835AbfGHPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbfGHPeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:34:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F33821537;
        Mon,  8 Jul 2019 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600049;
        bh=Ksua/iMAduhWu+zLOlCp9/5YnnI7hgB2q1RZ0J0XCFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjBjtte0w3snKjqdw3TP3VU6RW0mX5sidP/1GkK1kmRJKNiT4QXJnb/ysx2ZC3MBF
         I9I5ZybjgfamdTnGQVnaaYSo+FhScqyinsYiUcEcfGxI1TLzaWTd7FZzDneb6qy2Wd
         y/u2V8tYmQXPqUP1IhW1zfL8BkeEH94A11glh1CM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 5.1 77/96] drm/etnaviv: add missing failure path to destroy suballoc
Date:   Mon,  8 Jul 2019 17:13:49 +0200
Message-Id: <20190708150530.622307378@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

commit be132e1375c1fffe48801296279079f8a59a9ed3 upstream.

When something goes wrong in the GPU init after the cmdbuf suballocator
has been constructed, we fail to destroy it properly. This causes havok
later when the GPU is unbound due to a module unload or similar.

Fixes: e66774dd6f6a (drm/etnaviv: add cmdbuf suballocator)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -762,7 +762,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu
 	if (IS_ERR(gpu->cmdbuf_suballoc)) {
 		dev_err(gpu->dev, "Failed to create cmdbuf suballocator\n");
 		ret = PTR_ERR(gpu->cmdbuf_suballoc);
-		goto fail;
+		goto destroy_iommu;
 	}
 
 	/* Create buffer: */
@@ -770,7 +770,7 @@ int etnaviv_gpu_init(struct etnaviv_gpu
 				  PAGE_SIZE);
 	if (ret) {
 		dev_err(gpu->dev, "could not create command buffer\n");
-		goto destroy_iommu;
+		goto destroy_suballoc;
 	}
 
 	if (gpu->mmu->version == ETNAVIV_IOMMU_V1 &&
@@ -802,6 +802,9 @@ int etnaviv_gpu_init(struct etnaviv_gpu
 free_buffer:
 	etnaviv_cmdbuf_free(&gpu->buffer);
 	gpu->buffer.suballoc = NULL;
+destroy_suballoc:
+	etnaviv_cmdbuf_suballoc_destroy(gpu->cmdbuf_suballoc);
+	gpu->cmdbuf_suballoc = NULL;
 destroy_iommu:
 	etnaviv_iommu_destroy(gpu->mmu);
 	gpu->mmu = NULL;


