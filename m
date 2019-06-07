Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE7DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37B720868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfFGLz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:55:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfFGLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:55:24 -0400
Received: from 5HSWXM1.fritz.box ([87.191.24.82]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPA (Nemesis) id
 1Mw8gc-1gjamE2nbQ-00s3b8; Fri, 07 Jun 2019 13:54:58 +0200
From:   Rolf Evers-Fischer <embedded24@evers-fischer.de>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH] sh: dma: Add missing IS_ERR test
Date:   Fri,  7 Jun 2019 13:54:03 +0200
Message-Id: <20190607115404.4557-1-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ce3ts2O0iZ57+RglddOjLV+R0qlmX9ewLMWZ1Bbc/nTeQW1plrV
 jzudvx7RybZoXkQRwCyNmYdGsy2r/B2a8wgZxfHYBzqpJ1xmYaThftmalstTF/zo+HJ2SMI
 Zkb6vq41xlK+G31qDKw8BNoAjlN3vs/59AZ9xSwzlWtR9rg+hKn5jBB8zY/wGTjhtyETOIE
 t8SLrx9nAvlbrQdCxe/Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QhXLAK0sRAo=:58gbdxswKj8/4gkyq4fcIW
 giHTV5cOnZSo72dKaef3QqseMt7AuWOYRiBG50Y6m1OZGoPdGFk8CyzhdPB05s1BuK8qmsF9B
 P2y2hXJTjH+euX47uSPe2ZN3DKNFMWGYp+SYl9zqLnv+JLXKii5nyDKWbAEab6kOIOftmM28e
 4FC7GGPhoYaNdYTfwnv1Lo77sf/PMPsQdyEq5EF4paQ8Zl0TrhhXNMBL7ku8x7IC7VTfieKH3
 PFMj2jWZY17/H7Zuy8WDdBfFphRucLrpIKasiw3RDpOfhU2QC1VqZswBBsH1Q4Mg2gQ2FTQHs
 6Ll2pnUuVBipdjJXXU0qtaUebGrTzO4bg6fQnQtCg8foxL5ei9Z53K3wizu0A4E5Wcs7IbHfp
 typPctz8LWAmrFy+PP3g0I2oUAPpZ+TCZtUL6sUMCtC12FwbuSoNq2ptD8blR6dD9R4wc4vmM
 nQgt4QHv6MKeK/SzwmmhUXx8O9iiAoEfbVDnTYhobzyd15QFdPeKl+NGCTwRROkUdZe3ImFTq
 eapN0Uvc7xP8GHHnF+rODqnei+01vS2seprnftS66Kar6YA87Qev9vZPdzImxiFmGqO1KYZZ/
 3S6nkOeZWZ/fOqX8HX68BheHFoJ+VjkTSFMOi+xyIN7Pptl4E2Clko7QZVk4O066EFQq8BMxV
 vS5qLhnvnuGCBSPQIhng1Or0RsRnsW8rAXtHRhxJX8cvx1+93udRKRDRtJu2M88fT7ARapY8D
 u561Ivqp1tQo7Y0rT2lm9MczXf26F9aUEJpmkOTrjCkrPzB+aznLMy++SSc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_dma_channel may return ERR_PTR, so a check is added.

Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
---
 arch/sh/drivers/dma/dma-api.c   | 20 +++++++++++++++++++-
 arch/sh/drivers/dma/dma-sysfs.c |  2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index ab9170494dcc..5d6f1a46cc5e 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -94,7 +94,7 @@ int get_dma_residue(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
-	if (info->ops->get_residue)
+	if (!IS_ERR(channel) && (info->ops->get_residue))
 		return info->ops->get_residue(channel);
 
 	return 0;
@@ -195,6 +195,9 @@ int request_dma(unsigned int chan, const char *dev_id)
 	int result;
 
 	channel = get_dma_channel(chan);
+	if (IS_ERR(channel))
+		return PTR_ERR(channel);
+
 	if (atomic_xchg(&channel->busy, 1))
 		return -EBUSY;
 
@@ -217,6 +220,9 @@ void free_dma(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return;
+
 	if (info->ops->free)
 		info->ops->free(channel);
 
@@ -229,6 +235,9 @@ void dma_wait_for_completion(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return;
+
 	if (channel->flags & DMA_TEI_CAPABLE) {
 		wait_event(channel->wait_queue,
 			   (info->ops->get_residue(channel) == 0));
@@ -274,6 +283,9 @@ void dma_configure_channel(unsigned int chan, unsigned long flags)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return;
+
 	if (info->ops->configure)
 		info->ops->configure(channel, flags);
 }
@@ -285,6 +297,9 @@ int dma_xfer(unsigned int chan, unsigned long from,
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return PTR_ERR(channel);
+
 	channel->sar	= from;
 	channel->dar	= to;
 	channel->count	= size;
@@ -299,6 +314,9 @@ int dma_extend(unsigned int chan, unsigned long op, void *param)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return PTR_ERR(channel);
+
 	if (info->ops->extend)
 		return info->ops->extend(channel, op, param);
 
diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 8ef318150f84..6ba5b569d446 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -30,7 +30,7 @@ static ssize_t dma_show_devices(struct device *dev,
 		struct dma_info *info = get_dma_info(i);
 		struct dma_channel *channel = get_dma_channel(i);
 
-		if (unlikely(!info) || !channel)
+		if (unlikely(!info) || IS_ERR_OR_NULL(channel))
 			continue;
 
 		len += sprintf(buf + len, "%2d: %14s    %s\n",
-- 
2.21.0

