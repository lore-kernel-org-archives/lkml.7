Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C82820843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919743;
	bh=Zd5htjnTZHwxXTw8yCHhhFB/DukgYUXollEOlGdgmfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LabW7bQG4vOaSidkfT5BiAXY13drtaoPZL96yxEEWBeGE7cel2OdZhKzvAU7+9j+v
	 Agrc6Ud3MwSPpoV/hqhMFXI++zhjdMJAYJ9DDFU1+sZmPKUTyJUGDH1+K6KXlk1Lwl
	 w8YPg+++AqFXJ2rZSJW2W+1L/bueXnWnNO5R20cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfEOL3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732455AbfEOL27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:28:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D9D7206BF;
        Wed, 15 May 2019 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919738;
        bh=Zd5htjnTZHwxXTw8yCHhhFB/DukgYUXollEOlGdgmfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3IxbHZmxOeKWGDC6Hn3turgR28wrGzb+mg0JV5Z7vmoqki/byInpbsH8dxcIzPkR
         /1RLM76tOBiTtVHRRUrefCXfcN7mg7YiHsrOgdqq1KRIp9obb+pPUOfszFklJqP47W
         +37kNw0RWdcjUwj8l3UoOtl9d43eUpiYJQfEiCRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 073/137] drm/sun4i: Fix component unbinding and component master deletion
Date:   Wed, 15 May 2019 12:55:54 +0200
Message-Id: <20190515090658.734078697@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
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
index c6b65a9699794..9a5713fa03b25 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -148,6 +148,8 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	of_reserved_mem_device_release(dev);
 	drm_dev_put(drm);
+
+	component_unbind_all(dev, NULL);
 }
 
 static const struct component_master_ops sun4i_drv_master_ops = {
@@ -395,6 +397,8 @@ static int sun4i_drv_probe(struct platform_device *pdev)
 
 static int sun4i_drv_remove(struct platform_device *pdev)
 {
+	component_master_del(&pdev->dev, &sun4i_drv_master_ops);
+
 	return 0;
 }
 
-- 
2.20.1



