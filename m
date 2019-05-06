Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BC3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068E620578
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178058;
	bh=s59kYc5ldaHcMzBRUiORUpy7Oc+zmC4Krr2i6Zh94RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=RDf29iRcQQkS+e7pQyW4Ba0pXLpHdPvIJNnamfWYdv/h0BXfkqq+foQU+ttLOcnlo
	 5ZLk8e4q+b5JBcRnNoMcUSNCb/jBKr3rOzRbU2TF2QperBKKGHWg+chezNsxC+AOi3
	 tiOvkzWx8bbTLYNwZ7CRBIV4HZW0XjupwOCutOsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEFV0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35059 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfEFV0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:40 -0400
Received: by mail-it1-f195.google.com with SMTP id l140so22355119itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=EqYgwV/DljsSwmFELEFQhJ3qI+LrWWEch0hPKLG0mz8=;
        b=at+zyniC8e9Sj0M+k1eETZBS47E5W5QsPJIrVM+hdV+9bsbeG6PrXTT4kEbZXIStgS
         vbkgz0AeiB2lSKHZJybJxuE/Zmhjkr2SlIXIi2jgiZUzQKpj6fjpAhIPEnti4gwFEih+
         IiEZNwGBbkvkJyW9KTQc066ZujAmj1N0qb+sz0TBdQLKsFMTbayFMqST5TN60vmjZon+
         aGiIEO361TQi57+IrLml4q4AnadMZzC8CVX2VNy7QrsVkfvPk6lxZIRRqiAbTCn6JAwI
         7l9qma6uI9FPKkI6s460d09FFhcC/O9ZimXyf9w9aApVEhcZyTeUSGnl/GUntf7FRVpg
         aMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=EqYgwV/DljsSwmFELEFQhJ3qI+LrWWEch0hPKLG0mz8=;
        b=BudhNwFaZpojwLk54g1iWGEkaT97wI2PDkFRARkisyp8v3/qDNPNbCSJeJf1kcB0AG
         k+/sgZO3Wo75So/gIpk/olNaNWzFr1kDTldoz0JHbmRo3+144PK4QAAa4M58nmqjUODb
         WoXR3AuCPxDZpd72Z3K1P8JXeUVG1ry4bdWPGDeIkp4ZYxbjFCRUirMu9Dso5el8YYe0
         NbZ+SjFprJ11rfxuZQVib1nYOQhv2oGS7uFQ46hTeenyd0z6F+u8t6SrsOi9bWVvDRKn
         t0bJWbYr62ltYl+hAberumX4k64fr+t2Z7bQkZVZgLCJJHVxAvb7/WbttlGwNlSKQJj4
         XnTw==
X-Gm-Message-State: APjAAAW3wBEPDV82GvIcFG8lUDKvxVuvCVatiRQBIiBdfPka6IfBMC7b
        24yQpV38vL8I74ybJAmNX6w=
X-Google-Smtp-Source: APXvYqyG8mbyY9CJ/yPzso34292W5kYMCs8EYUi1bJaYvqdtKtp80ygQfliROQb6ZbdeFIYWo1uWoA==
X-Received: by 2002:a24:dcc5:: with SMTP id q188mr3440418itg.64.1557177999141;
        Mon, 06 May 2019 14:26:39 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:38 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 11/22] thermal/x86_pkg_temp_thermal: Support multi-die/package
Date:   Mon,  6 May 2019 17:26:06 -0400
Message-Id: <e6a6fcd9ad6a1cb8da31d467277dd519eecdbd31.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Package temperature sensors are actually implemented in hardware per-die.
Thus, the new multi-die/package systems sport mulitple package thermal
zones for each package.

Update the x86_pkg_temp_thermal to be "multi-die-aware", so it can
expose multiple zones per package, instead of just one.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1ef937d799e4..405b3858900a 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -122,7 +122,7 @@ static int pkg_temp_debugfs_init(void)
  */
 static struct pkg_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return packages[pkgid];
@@ -353,7 +353,7 @@ static int pkg_thermal_notify(u64 msr_val)
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 	u32 tj_max, eax, ebx, ecx, edx;
 	struct pkg_device *pkgdev;
 	int thres_count, err;
@@ -449,7 +449,7 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	 * worker will see the package anymore.
 	 */
 	if (lastcpu) {
-		packages[topology_logical_package_id(cpu)] = NULL;
+		packages[topology_logical_die_id(cpu)] = NULL;
 		/* After this point nothing touches the MSR anymore. */
 		wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
 		      pkgdev->msr_pkg_therm_low, pkgdev->msr_pkg_therm_high);
@@ -515,7 +515,7 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 	packages = kcalloc(max_packages, sizeof(struct pkg_device *),
 			   GFP_KERNEL);
 	if (!packages)
-- 
2.18.0-rc0

