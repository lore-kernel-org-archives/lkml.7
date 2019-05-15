Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8933C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB79A20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919388;
	bh=tv5sSD4QG+b2/BgGkiVVFz8fwcDGrsiYsFuS41YjUJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A4xeIXf9f2sWVFvoHc3wcJcqKRUgcZMLh/xMJql4Y/AxFoNrBqaTWhssB5R0YzuV/
	 h7yAz5xDg4Z5JGiYwT8M95mjUMp7bCbHJiSTC1gFTc2Ku7O+r+CdezY+S4Px7JWrY7
	 qmfFnqcuT/WeDRLc6Ll1jVW8NKYJVUeyRkXIWIeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfEOLXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbfEOLW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:22:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4C120818;
        Wed, 15 May 2019 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919377;
        bh=tv5sSD4QG+b2/BgGkiVVFz8fwcDGrsiYsFuS41YjUJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtajeGnQSk7ZofYvkNTGvcyZpSc4PeF1CV2Zg7dgfjebjezc59O8Iphzy17AW5+aK
         xzTuu1UO5vlZ3Yg+IwpaJg35KL1+/j28p4dlsg8RczAUOoaGVXWeMUm9ja1VACKEzE
         xRaO26XFGtTaG2jFcaaAG1m0xfq0q2iktvPFw4do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/113] drm/sun4i: Fix component unbinding and component master deletion
Date:   Wed, 15 May 2019 12:55:44 +0200
Message-Id: <20190515090657.671008019@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f5a9ed867c83875546c9aadd4ed8e785e9adcc3c ]

For our component-backed driver to be properly removed, we need to
delete the component master in sun4i_drv_remove and make sure to call
component_unbind_all in the master's unbind so that all components are
unbound when the master is.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190418132727.5128-4-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 7cac01c72c027..62703630090aa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -160,6 +160,8 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	of_reserved_mem_device_release(dev);
 	drm_dev_put(drm);
+
+	component_unbind_all(dev, NULL);
 }
 
 static const struct component_master_ops sun4i_drv_master_ops = {
@@ -407,6 +409,8 @@ static int sun4i_drv_probe(struct platform_device *pdev)
 
 static int sun4i_drv_remove(struct platform_device *pdev)
 {
+	component_master_del(&pdev->dev, &sun4i_drv_master_ops);
+
 	return 0;
 }
 
-- 
2.20.1



