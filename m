Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABFBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672DC21537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561110890;
	bh=YxTzR19num6Uu7rdZtU6p08r3wKQbzxjPWJxi0JiuPM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XHTpj74gvq6hEDms9txLYLBYdYvu2dnp15wYUKuSoVRF24/IVTf286er19kign4av
	 8h6zXkFvSrjcfQ1AXChtnPZpO7LdO0wtdz8HcrNDP3NhJQHyILCxV21YpPUDR2S6tB
	 /5cl9FL/y5pWc8jZShs3DT30NNJfN3qqws19wA7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfFUJyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:54:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfFUJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wI0EAuMFs+aVQKSucBM2sTBK5ECXZZNvaUXFQdbT4O4=; b=JTpScT0W9/QGxBnSHrK8kC9QS
        aYRHK2SzsuZ0aEBEd2JXakX09pxNeNmdMLQwDXfKgKiNJ4sgL5+sSOi+wxCfxv93JrmGLykMlB3TF
        qR/u7xEOqs6xi+eg8aYmgmQynikRZ8Qwkz8sjspygzR9VY9tSEzcGDMCDkgfI1cc8CK5tZT32gv06
        +XJyPBGucyAXyP+jIVVkNn8TzjvzNkSQ06cJmJNyKscyIrYuyn02iI6lmbCX/S5eK2P+Dzh44ZcCE
        neX1lft7VJqjm9F+0rbes8JjHwZVQud+d1CfOFWSm/FbV6llKbqFm8wT2FUfbqpWDO1PzWsTNFAv0
        r8D9/bm8g==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heGFa-0004le-Q7; Fri, 21 Jun 2019 09:54:30 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heGFX-0004dt-D3; Fri, 21 Jun 2019 06:54:27 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] ABI: sysfs-driver-mlxreg-io: fix the what fields
Date:   Fri, 21 Jun 2019 06:54:25 -0300
Message-Id: <4cd2ece080041d8545cc2f3e86cb1ff7c8a91f5b.1561110859.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The author of this file should be given an award for creativity:
the What: fields on this file technically fulfills the description
at README. Yet, the way it is, it can't be parsed on a script,
and if someone would try to do something like:

	grep hwmon*/jtag_enable

It wouldn't find anything.

Fix the What fields in a way that it can be parseable by a
script and other search tools.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../ABI/stable/sysfs-driver-mlxreg-io         | 45 ++++++++-----------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index 156319fc5b80..3544968f43cc 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -1,5 +1,4 @@
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							asic_health
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/asic_health
 
 Date:		June 2018
 KernelVersion:	4.19
@@ -9,9 +8,8 @@ Description:	This file shows ASIC health status. The possible values are:
 
 		The files are read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							cpld1_version
-							cpld2_version
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld1_version
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld2_version
 Date:		June 2018
 KernelVersion:	4.19
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -20,8 +18,7 @@ Description:	These files show with which CPLD versions have been burned
 
 		The files are read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							fan_dir
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/fan_dir
 
 Date:		December 2018
 KernelVersion:	5.0
@@ -32,8 +29,7 @@ Description:	This file shows the system fans direction:
 
 		The files are read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							jtag_enable
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
 
 Date:		November 2018
 KernelVersion:	5.0
@@ -43,8 +39,7 @@ Description:	These files show with which CPLD versions have been burned
 
 		The files are read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							jtag_enable
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
 
 Date:		November 2018
 KernelVersion:	5.0
@@ -87,16 +82,15 @@ Description:	These files allow asserting system power cycling, switching
 
 		The files are write only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-							reset_aux_pwr_or_ref
-							reset_asic_thermal
-							reset_hotswap_or_halt
-							reset_hotswap_or_wd
-							reset_fw_reset
-							reset_long_pb
-							reset_main_pwr_fail
-							reset_short_pb
-							reset_sw_reset
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_aux_pwr_or_ref
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_asic_thermal
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_hotswap_or_halt
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_hotswap_or_wd
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_fw_reset
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_long_pb
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_main_pwr_fail
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_short_pb
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_sw_reset
 Date:		June 2018
 KernelVersion:	4.19
 Contact:	Vadim Pasternak <vadimpmellanox.com>
@@ -110,11 +104,10 @@ Description:	These files show the system reset cause, as following: power
 
 		The files are read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
-						reset_comex_pwr_fail
-						reset_from_comex
-						reset_system
-						reset_voltmon_upgrade_fail
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_comex_pwr_fail
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_from_comex
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_system
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_voltmon_upgrade_fail
 
 Date:		November 2018
 KernelVersion:	5.0
-- 
2.21.0

