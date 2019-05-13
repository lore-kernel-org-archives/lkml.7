Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF72C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC414208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770400;
	bh=B4QUduVoMCV84YYagV5qJ9RCTA5dFTFVSZG7fxQsbJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=UiJ01vO34F6SpSe4tVHIg/58IiaydtegZ+DM1sUXtsUJa3KYuqOdmU+ZvrkfhM35v
	 MY11B7rka0p6OQhHmA5yDoiR5KPVgQRWQGGWo3ksJZAAJPuPb98WFvY7gjjSTdM1gL
	 wPJq55bWFhmOYtNikgyrp2aOagiMpoUhw7SkVnh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfEMR77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44384 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732152AbfEMR7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id g9so7584807pfo.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=VhvKAGUYOPwKbKSmPtz845CkshJTTuAXjzJ7SSJUdR4=;
        b=QMcHjvr3lBrmESV1xppR+B/cs/3VNxDHNRx5Dmv9+y4yfTfUqNX2uw0jt3yuxUGhc8
         8e7XsqhZwZOTUNMO8f/hbFNufVwQrG0K6RDwGz3wHs5M7zbox/QEDYeJrhexwLRLW7FO
         PwpnldGD+xhLpCJt2ZrLftyP/QdG29joo42OVSg2HM0IiDA358J1GE1DW5IUr53h5Z2M
         Q61phOuL5dQBfAJ1vWE6zjqFRZl+rydctgaVjHuxtDv+dEHUI1SlgwJOEIE3rh1ansmE
         b6vHHUy/3nstWRY2nVT+RT3AIWMREU6YTAGgRNHY4kV8DMBh8nXlS4vHLV/oS0bytYq5
         I+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=VhvKAGUYOPwKbKSmPtz845CkshJTTuAXjzJ7SSJUdR4=;
        b=DC31HdnQ5Wb2s2gQuN+PSTzTpjhUI8eA998lBTYxBqszzMqZfdq5L4mPkjcnYRnmrm
         2F675ZCnU7BGP4Y7vY1cgMzOM3oBr/KFlcS/XSYR1gTudEfNr5TlXTReB/z/ZUa8YBsv
         U99dN3SNjYkPM6/Id4yxzgoTJXndZNQMJwARWyZrarmSXQJOtj6LpYM1ChE1OMfY6XS9
         HYzj77R9xUjFfVa7DDhHq+ed5q4eF+KueENYItiRkkMIxYyi07aqWcEqznuXywkUflFv
         O5Sc0Y98TG/monLVi/qKG5jREvapPnJDBBRQ/atKN/mpe3Um767qg7kNF7wqppg0oLzN
         uOgg==
X-Gm-Message-State: APjAAAXvGuGceGFEIZOmeFBVztvUeAZkPFCnKGscp5KIw16ekom1v52A
        Rx+nCH6rGy13qsqXTlV3T9w=
X-Google-Smtp-Source: APXvYqwmTs2fJWC+YTH1h6l+DELhuARjZUQWSsJ1XdVoq/GypfYw9FH7exeUq0Rt0WXmQiOt3hbuAg==
X-Received: by 2002:a62:1c06:: with SMTP id c6mr24226938pfc.168.1557770380689;
        Mon, 13 May 2019 10:59:40 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:39 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 17/19] hwmon/coretemp: Cosmetic: Rename internal variables to zones from packages
Date:   Mon, 13 May 2019 13:59:01 -0400
Message-Id: <facecfd3525d55c2051f63a7ec709aeb03cc1dc1.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
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

