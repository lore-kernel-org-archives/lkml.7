Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA01C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097B020665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599759;
	bh=7e0SJ7ednEzgDExuJhnUoj0J6DEtEKybnCPxh5zJKDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T9DITV3kM0QYLX+1XQyYQQYeOlyG7ezi+1TW95Xa29Hb6JJXhbrQZrqoGXDkSvVEo
	 v5WWEwLUMIKR4ef7/L73+kOJIbt631B33oP5M0aQONQ7syPlrUFEKTjAN8xyk/HR6b
	 SVqznGTjxIKNUvBEPiaCD+7XD553ieRtPWwjngqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfGHP3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbfGHP3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:29:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E878C204EC;
        Mon,  8 Jul 2019 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599752;
        bh=7e0SJ7ednEzgDExuJhnUoj0J6DEtEKybnCPxh5zJKDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qs6UE5lI3fG/HRVrm/sDV6OyRK+dEAg+8IKo3qmGjGJHraYophAA3BS3/9naPQkvp
         nD9+3EmrIqMxJ5WJyNZp3aKkZWbWU5U3zNahOgbiXTSiKaeVJs0rdjec7BUB0JYOtB
         T4w9WTRTUwCWJsMJjBpcMcuPQv5t2oXuix821qsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 66/90] media: s5p-mfc: fix incorrect bus assignment in virtual child device
Date:   Mon,  8 Jul 2019 17:13:33 +0200
Message-Id: <20190708150525.699017666@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1e0d0a5fd38192f23304ea2fc2b531fea7c74247 ]

Virtual MFC codec's child devices must not be assigned to platform bus,
because they are allocated as raw 'struct device' and don't have the
corresponding 'platform' part. This fixes NULL pointer access revealed
recently by commit a66d972465d1 ("devres: Align data[] to
ARCH_KMALLOC_MINALIGN").

Fixes: c79667dd93b0 ("media: s5p-mfc: replace custom reserved memory handling code with generic one")

Reported-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by:  Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 927a1235408d..ca11f8a7569d 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1089,7 +1089,6 @@ static struct device *s5p_mfc_alloc_memdev(struct device *dev,
 	device_initialize(child);
 	dev_set_name(child, "%s:%s", dev_name(dev), name);
 	child->parent = dev;
-	child->bus = dev->bus;
 	child->coherent_dma_mask = dev->coherent_dma_mask;
 	child->dma_mask = dev->dma_mask;
 	child->release = s5p_mfc_memdev_release;
-- 
2.20.1



