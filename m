Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED03C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B6D208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaFvHIj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfCHShc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:37:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43279 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfCHShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:37:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so17159653ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qm0FJBZB2BvYmG2ziqGd4FN9RTC6OY7BmwU6Jdqsji4=;
        b=AaFvHIj83NcgPFjiBlABx9n6l5QhinKxrDCmEYkeBFixi/hN/cB9ib9SiX5h7CQeNr
         DFNHh4xInut7dcLL+cAk8kSy1Zhd3TxhoxqhMmEMWyzPh8O5GbvjryuzyxJZefBDq2ZE
         xnGssxXQNal2CdAcm9RxXaM9ooaLjA3kIBhvZYZdUF3l2akjXkwpLx625yHvYKQe+66I
         nXpQ+VkH3RqHk8PYlUW382yjZvHLxGzEvquJHGdeJoOADP15/8OODUfB36M+KVm0aw6R
         cmbVmDtF3lgVARe0JRpLZ6DiMrYrt633I1xsqOu5Q7bzOF1jjdU2VDuonhnUZto//SsN
         JLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qm0FJBZB2BvYmG2ziqGd4FN9RTC6OY7BmwU6Jdqsji4=;
        b=FP24b7+QdBRmdX5JMa8n9MXaoYBmh+AfoAhNYbOgjelBC6h4NJGmr3r6S3MnMEjNwy
         F2eFQLuXDlnGjqNgT0ZEp7cvob9y4rrvvT4TsIWbzu0gMIe7E+nD1LfNlvt4elk0KF0W
         y47Dw28tnLY3cd9fEvHzrYxjS51ZZNgt1y3GMzG8aXOcfsxXwV+PWZyn/hBwWKZmlxl3
         nUkGzVuQ/H3uDEnDF4vW1QH8SOIDYN75dWAwe5+R+vmegJ8z0nUBcXVr6IYC4iyVdUpF
         IOdJrCLYyqwk1XCA2bfmpcKLUsyU8TpL/rD45zjHlLQXVGYpb8GADm/CPNldegrl93H5
         o1/A==
X-Gm-Message-State: APjAAAVajT0qjbbqX/xjJ6+nTKNaDoMdQ8w+xLnR6sO+twGnPuGP6tuy
        IoCaABqPhopWsDQYso4Vt7A=
X-Google-Smtp-Source: APXvYqya0HfUb66/MLKHKe2lNPO6yxEpw2AWqUF5EV6GVp5/hLuVCg0CoITfKnBcYrZTWwFfeAjiyw==
X-Received: by 2002:a50:d508:: with SMTP id u8mr34174554edi.51.1552070250112;
        Fri, 08 Mar 2019 10:37:30 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s6sm2359132eda.90.2019.03.08.10.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 10:37:29 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: rockchip: add shutdown function to poweroff VOP and HDMI TX
Date:   Fri,  8 Mar 2019 19:37:18 +0100
Message-Id: <20190308183718.21409-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a MK808 TV-stick with RK3066 processor
is given a poweroff command, the monitor doesn't turn blank,
but freezes. The VOP and HDMI share the same power domain,
so that means that both there clocks were never turned off.
Fix the disable of the VOP and HDMI TX by adding an extra
shutdown function that will unbind both drivers.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 8d7a634c1..66a8e99a3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -448,6 +448,13 @@ static int rockchip_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &rockchip_drm_ops);
+
+	rockchip_drm_match_remove(&pdev->dev);
+}
+
 static const struct of_device_id rockchip_drm_dt_ids[] = {
 	{ .compatible = "rockchip,display-subsystem", },
 	{ /* sentinel */ },
@@ -457,6 +464,7 @@ MODULE_DEVICE_TABLE(of, rockchip_drm_dt_ids);
 static struct platform_driver rockchip_drm_platform_driver = {
 	.probe = rockchip_drm_platform_probe,
 	.remove = rockchip_drm_platform_remove,
+	.shutdown = rockchip_drm_platform_shutdown,
 	.driver = {
 		.name = "rockchip-drm",
 		.of_match_table = rockchip_drm_dt_ids,
-- 
2.11.0

