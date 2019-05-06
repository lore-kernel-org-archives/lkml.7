Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87FBC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA38020830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178028;
	bh=B4QUduVoMCV84YYagV5qJ9RCTA5dFTFVSZG7fxQsbJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=USXdMv/xPmuVhh3fuX7nMZouHW5F3fv0ORacFDwdbprP6wBFrJtGpsY1IYzc8dmBo
	 XOxUqSqp3xmeT7JgASHr3NVMDtTWWRctyiXbzYf3xSgrE2B17vtfFxnytsJsbod/43
	 JD58ruQeoQEpAY3sKAiLaXN9mxXKf9VknahGnbAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfEFV1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:27:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40001 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfEFV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:51 -0400
Received: by mail-it1-f194.google.com with SMTP id g71so7289153ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=VhvKAGUYOPwKbKSmPtz845CkshJTTuAXjzJ7SSJUdR4=;
        b=k6lbaM1FPDDY+6qCyCE0dKwahwccspWmiuCLfSp50sb2ejSUdUyxuOaA4nmahfMkn/
         UCQMU7VCqHI9mea/vz0dxyuISDgkFcWO8qEuSec+vcZ+v3oeXXHV+KQGWDGvFPUJO+wf
         +E1JKZ3QCT8f5TFaFsNh8aeT8wwNvnGzuDC1La2CQCikEr5maE40/OlAyo+PTDLjDiRj
         z5VI/rrMVH/Xluia1hvB5Z9M/VjHMj9FPbJA87LzF1jnq0IXDOhz74MCK+dYHmJYNUBZ
         hAQgtDrofP7Qckc5oxkcbvPDARwbNQRjyBFmBeDiNbAiz8Zn0Gyc47Jmgj3BshJJfE2f
         +AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=VhvKAGUYOPwKbKSmPtz845CkshJTTuAXjzJ7SSJUdR4=;
        b=YncSUndWHyU4GROGKHbjBdWIacF+FZr9Zi0g1SyMxk1eH+aK82gfd/cWtLI1nE8AMf
         upUY2D2HpRF/P4zuUHqXQDZcaUvAKkRs81mQKJfC99js5Wy9Uqji0Q6Lu5B33lDcgNHE
         By5rGmhNK2Olco+KYuZ2c04p71jOf144YjewwvtULnS5J0QI+aUT8SwSdbNQJ0+byOxC
         +XoJoEvOd9AwDx6QLd9APE+ntIHuUM08cX3bQ/Mw3oPgjpb1HLZzvxH7vg7ej2+HPat0
         wgvYAyx9z6baQYFJqe4Qiu0KF/p0tUs4iCy046BzVklotzVaA1bTZLfP9ZSL8dy9k0TJ
         8k9Q==
X-Gm-Message-State: APjAAAW3fdQDpTtVXDuWlpk4hqJy3KcTEtHldnji21VRy1w1TUnUa6Db
        wdBRP/bQh4voplvFG+5WCZk=
X-Google-Smtp-Source: APXvYqxbs1LppHIxGYTxmUT/XHL8yGKWzC1tsOqiUefryx6juF0oeZQBkxfBFW2dhqQld7ySKRjhgg==
X-Received: by 2002:a05:660c:12d2:: with SMTP id k18mr19375340itd.33.1557178010778;
        Mon, 06 May 2019 14:26:50 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:49 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 20/22] hwmon/coretemp: rename internal variables to zones from packages
Date:   Mon,  6 May 2019 17:26:15 -0400
Message-Id: <db40079ffaba56c553d3061dd43b3f7b5ca30577.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names
to use the more generic thermal "zone" terminology, instead of "package",
as the zones can refer to either packages or die.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index c64ce32d3214..4ebed90d81aa 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -109,10 +109,10 @@ struct platform_data {
 	struct device_attribute name_attr;
 };
 
-/* Keep track of how many package pointers we allocated in init() */
-static int max_packages __read_mostly;
-/* Array of package pointers. Serialized by cpu hotplug lock */
-static struct platform_device **pkg_devices;
+/* Keep track of how many zone pointers we allocated in init() */
+static int max_zones __read_mostly;
+/* Array of zone pointers. Serialized by cpu hotplug lock */
+static struct platform_device **zone_devices;
 
 static ssize_t show_label(struct device *dev,
 				struct device_attribute *devattr, char *buf)
@@ -435,10 +435,10 @@ static int chk_ucode_version(unsigned int cpu)
 
 static struct platform_device *coretemp_get_pdev(unsigned int cpu)
 {
-	int pkgid = topology_logical_die_id(cpu);
+	int id = topology_logical_die_id(cpu);
 
-	if (pkgid >= 0 && pkgid < max_packages)
-		return pkg_devices[pkgid];
+	if (id >= 0 && id < max_zones)
+		return zone_devices[id];
 	return NULL;
 }
 
@@ -544,7 +544,7 @@ static int coretemp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct platform_data *pdata;
 
-	/* Initialize the per-package data structures */
+	/* Initialize the per-zone data structures */
 	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -579,13 +579,13 @@ static struct platform_driver coretemp_driver = {
 
 static struct platform_device *coretemp_device_add(unsigned int cpu)
 {
-	int err, pkgid = topology_logical_die_id(cpu);
+	int err, zoneid = topology_logical_die_id(cpu);
 	struct platform_device *pdev;
 
-	if (pkgid < 0)
+	if (zoneid < 0)
 		return ERR_PTR(-ENOMEM);
 
-	pdev = platform_device_alloc(DRVNAME, pkgid);
+	pdev = platform_device_alloc(DRVNAME, zoneid);
 	if (!pdev)
 		return ERR_PTR(-ENOMEM);
 
@@ -595,7 +595,7 @@ static struct platform_device *coretemp_device_add(unsigned int cpu)
 		return ERR_PTR(err);
 	}
 
-	pkg_devices[pkgid] = pdev;
+	zone_devices[zoneid] = pdev;
 	return pdev;
 }
 
@@ -703,7 +703,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * the rest.
 	 */
 	if (cpumask_empty(&pd->cpumask)) {
-		pkg_devices[topology_logical_die_id(cpu)] = NULL;
+		zone_devices[topology_logical_die_id(cpu)] = NULL;
 		platform_device_unregister(pdev);
 		return 0;
 	}
@@ -741,10 +741,10 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages() * topology_max_die_per_package();
-	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
+	max_zones = topology_max_packages() * topology_max_die_per_package();
+	zone_devices = kcalloc(max_zones, sizeof(struct platform_device *),
 			      GFP_KERNEL);
-	if (!pkg_devices)
+	if (!zone_devices)
 		return -ENOMEM;
 
 	err = platform_driver_register(&coretemp_driver);
@@ -760,7 +760,7 @@ static int __init coretemp_init(void)
 
 outdrv:
 	platform_driver_unregister(&coretemp_driver);
-	kfree(pkg_devices);
+	kfree(zone_devices);
 	return err;
 }
 module_init(coretemp_init)
@@ -769,7 +769,7 @@ static void __exit coretemp_exit(void)
 {
 	cpuhp_remove_state(coretemp_hp_online);
 	platform_driver_unregister(&coretemp_driver);
-	kfree(pkg_devices);
+	kfree(zone_devices);
 }
 module_exit(coretemp_exit)
 
-- 
2.18.0-rc0

