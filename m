Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDEEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6435E208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770434;
	bh=s59kYc5ldaHcMzBRUiORUpy7Oc+zmC4Krr2i6Zh94RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=p1mO+h9GxsegSLQAEr/5474caqFda+zM+IHjJDgaINEOwQ6ZTS9LH8BpMBor8Vu0I
	 nUi6hyaCEjM7Sgw9WbvA761Mabh6bDwF04et2A2iNVxLy+J+8TRr0541SJDyIlkt4Z
	 J0zLuO9h8cIdgV4nQXW4Ujp9J80RYWYvi2H7hXY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbfEMSAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:00:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36617 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbfEMR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so7156234pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=EqYgwV/DljsSwmFELEFQhJ3qI+LrWWEch0hPKLG0mz8=;
        b=Dro0llPK2WjF5ahCi3YbRxtCRKwEtGygtm2d5j8RNT1Jz9qF1lJ4oCnlVWD2FxAVfC
         q69lCANswQNOhyEEKN7jZbJoL10RM0fZPPcCn4DTRCb23pqMgU+azOEidtCLIB5d5f7L
         32eB0hKhMSocJwPV7ezEFTT/umOOl5q6Q+W347OTiV4llt88pWC6hjm3dJES9zdnViwH
         DpfKpUQ9MF79vYw3X8HQdGd9SDzTJO6YjKzrTFzor+pDRlu6oXxExHcSqIUWdQKyOB1h
         eVUMe98gFA+0AYArueKxwbloCj9FdDV1EklpowvrDQHBcpa27jvK/Qy0msntff86dqqY
         k8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=EqYgwV/DljsSwmFELEFQhJ3qI+LrWWEch0hPKLG0mz8=;
        b=XblWmecYAzdv23/sGoHcWYnT5Fm8eeDn8p7hLXjModge5zjcvBG9zmOmKBQQ7KnoeJ
         DTJmt55h+yz7tlbJe6HHmAI5Cc0vNDBnfdaeAvZgUo+83aEA88OCNpKUainV7rufSoEd
         tFx+3pGA4YL+eJf4yXuB6REr8SEo+yuYT4tzmftv3b3mJY6e3ss3LMInFNwBmFhRffjX
         w79n/Le5mB097f8hPYNPpHt4A7S9SqjMfJiXh3zpv9xiag1G6w7COyaHW6kgFO/Df+4s
         2Au+P4Zimm7o666HX9lQKch7Z7gCoWDl5mJbCosi9TCgPHO+qZ6e8/B5fDEE5qzhi50n
         C/hA==
X-Gm-Message-State: APjAAAW1S6KpYPzADetks+L5FpwQU8F4arhmDmEdwNrLxmC5C8Kc2dyc
        zJ6nYBn5ylQ6EiLa5/gDqKU=
X-Google-Smtp-Source: APXvYqwwI/rdbWrUew0xuWJ7ipgexXtwLRyDj2nhhmQ5jaCUGuLtM8Bdc7ORrqRhIdgSZ9MIPJjOlw==
X-Received: by 2002:a62:e043:: with SMTP id f64mr35868389pfh.76.1557770367117;
        Mon, 13 May 2019 10:59:27 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:26 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 08/19] thermal/x86_pkg_temp_thermal: Support multi-die/package
Date:   Mon, 13 May 2019 13:58:52 -0400
Message-Id: <281695c854d38d3bdec803480c3049c36198ca44.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
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

