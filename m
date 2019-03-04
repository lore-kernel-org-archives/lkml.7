Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F2BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1350D20863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687776;
	bh=kc66XPygmIbvOH70qS2apadWwF8yEV6soEyUu6j7rP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yko7//+7vTvjwjoDYDpkbXvie0pBGwAzZtOStos21edKbmdJ9ujneFS0L/OeXgG1T
	 0P5bE3z7Pm9bN7GnWDeREmliCFCymVvFiHy+9vb75lptElGorDLhAyLPd6FT/xlT8D
	 NyNLK5YXEj4QkPrcdbEdBflBhV7IhwdVFLqeVayA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCDIWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfCDIWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:22:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733C920823;
        Mon,  4 Mar 2019 08:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687769;
        bh=kc66XPygmIbvOH70qS2apadWwF8yEV6soEyUu6j7rP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wbgzTEBBneIUBL0aD2FlL6OD5HT0vs7sWJ2bJ+ODXj8wjE2fjSkjnwYnohzsyj4B4
         c4b1Vu/ys1P3hFRBYLr45WR8En0m2ovb0TUTIkp0MJoRH41w7CzG49NTD/lIe6/4BH
         CrW4a9pNJqukr7PQEWfxLE0VDCQk5Yi3VU7MeOMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Hill <aa1ronham@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 15/32] drivers: thermal: int340x_thermal: Fix sysfs race condition
Date:   Mon,  4 Mar 2019 09:22:03 +0100
Message-Id: <20190304081603.378080593@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 129699bb8c7572106b5bbb2407c2daee4727ccad ]

Changes since V1:
* Use dev_info instead of printk
* Use dev_warn instead of BUG_ON

Previously, sysfs_create_group was called before all initialization had
fully run - specifically, before pci_set_drvdata was called. Since the
sysctl group is visible to userspace as soon as sysfs_create_group
returns, a small window of time existed during which a process could read
from an uninitialized/partially-initialized device.

This commit moves the creation of the sysctl group to after all
initialized is completed. This ensures that it's impossible for
userspace to read from a sysctl file before initialization has fully
completed.

To catch any future regressions, I've added a check to ensure
that proc_thermal_emum_mode is never PROC_THERMAL_NONE when a process
tries to read from a sysctl file. Previously, the aforementioned race
condition could result in the 'else' branch
running while PROC_THERMAL_NONE was set,
leading to a null pointer deference.

Signed-off-by: Aaron Hill <aa1ronham@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../processor_thermal_device.c                | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 06d46e2ff337e..1fdf6fd24cdff 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -77,7 +77,12 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 	struct pci_dev *pci_dev; \
 	struct platform_device *pdev; \
 	struct proc_thermal_device *proc_dev; \
-\
+	\
+	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
+		dev_warn(dev, "Attempted to get power limit before device was initialized!\n"); \
+		return 0; \
+	} \
+	\
 	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
 		pdev = to_platform_device(dev); \
 		proc_dev = platform_get_drvdata(pdev); \
@@ -291,11 +296,6 @@ static int proc_thermal_add(struct device *dev,
 	*priv = proc_priv;
 
 	ret = proc_thermal_read_ppcc(proc_priv);
-	if (!ret) {
-		ret = sysfs_create_group(&dev->kobj,
-					 &power_limit_attribute_group);
-
-	}
 	if (ret)
 		return ret;
 
@@ -309,8 +309,7 @@ static int proc_thermal_add(struct device *dev,
 
 	proc_priv->int340x_zone = int340x_thermal_zone_add(adev, ops);
 	if (IS_ERR(proc_priv->int340x_zone)) {
-		ret = PTR_ERR(proc_priv->int340x_zone);
-		goto remove_group;
+		return PTR_ERR(proc_priv->int340x_zone);
 	} else
 		ret = 0;
 
@@ -324,9 +323,6 @@ static int proc_thermal_add(struct device *dev,
 
 remove_zone:
 	int340x_thermal_zone_remove(proc_priv->int340x_zone);
-remove_group:
-	sysfs_remove_group(&proc_priv->dev->kobj,
-			   &power_limit_attribute_group);
 
 	return ret;
 }
@@ -357,7 +353,10 @@ static int int3401_add(struct platform_device *pdev)
 	platform_set_drvdata(pdev, proc_priv);
 	proc_thermal_emum_mode = PROC_THERMAL_PLATFORM_DEV;
 
-	return 0;
+	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PLATFORM_DEV\n");
+
+	return sysfs_create_group(&pdev->dev.kobj,
+					 &power_limit_attribute_group);
 }
 
 static int int3401_remove(struct platform_device *pdev)
@@ -434,7 +433,10 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 			dev_err(&pdev->dev, "No auxiliary DTSs enabled\n");
 	}
 
-	return 0;
+	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PCI\n");
+
+	return sysfs_create_group(&pdev->dev.kobj,
+					 &power_limit_attribute_group);
 }
 
 static void  proc_thermal_pci_remove(struct pci_dev *pdev)
-- 
2.19.1



