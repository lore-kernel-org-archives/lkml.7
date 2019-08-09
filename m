Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D62C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C359720C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ehV5teT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfHIWVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:21:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37724 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:21:19 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79MLDhL021121;
        Fri, 9 Aug 2019 17:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565389273;
        bh=0sRKy0ahKs6KSh6b8fYHSjedNqmA9zJmx8GJm3JPAbA=;
        h=From:To:CC:Subject:Date;
        b=ehV5teT2Z/L2AK55GBDmjtWhaRlrqNkVDmF64pBhmYrjqUl3QTiFZLPpqzvpOmL21
         THMrNPqWM8jk+5B0+oQBKSqxpS3MNqEvfd2FOTj+IhMdhpH4tPdUNeJB9MPGFdaniT
         yQowAC48yFxNy7F38U1ym5iMCAptFcw+peOyaE+Y=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79MLDNG095931
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 17:21:13 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 17:21:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 17:21:13 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79MLCgL080777;
        Fri, 9 Aug 2019 17:21:12 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x79MLCZ28077;
        Fri, 9 Aug 2019 17:21:12 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH] remoteproc: Add a sysfs interface for name
Date:   Fri, 9 Aug 2019 17:20:57 -0500
Message-ID: <20190809222057.13924-1-s-anna@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a sysfs interface that provides the name of the
remote processor to userspace. This allows the userspace to identify
a remote processor as the remoteproc devices themselves are created
based on probe order and can change from one boot to another or
at runtime.

The name is made available in debugfs originally, and is being
retained for now. This can be cleaned up after couple of releases
once users get familiar with the new interface.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 Documentation/ABI/testing/sysfs-class-remoteproc | 10 ++++++++++
 drivers/remoteproc/remoteproc_sysfs.c            | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
index c3afe9fab646..36094fbeb974 100644
--- a/Documentation/ABI/testing/sysfs-class-remoteproc
+++ b/Documentation/ABI/testing/sysfs-class-remoteproc
@@ -48,3 +48,13 @@ Description:	Remote processor state
 
 		Writing "stop" will attempt to halt the remote processor and
 		return it to the "offline" state.
+
+What:		/sys/class/remoteproc/.../name
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Suman Anna <s-anna@ti.com>
+Description:	Remote processor name
+
+		Reports the name of the remote processor. This can be used by
+		userspace in exactly identifying a remote processor and ease
+		up the usage in modifying the 'firmware' or 'state' files.
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index fa4131930106..7f8536b73295 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -113,9 +113,20 @@ static ssize_t state_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(state);
 
+/* Expose the name of the remote processor via sysfs */
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct rproc *rproc = to_rproc(dev);
+
+	return sprintf(buf, "%s\n", rproc->name);
+}
+static DEVICE_ATTR_RO(name);
+
 static struct attribute *rproc_attrs[] = {
 	&dev_attr_firmware.attr,
 	&dev_attr_state.attr,
+	&dev_attr_name.attr,
 	NULL
 };
 
-- 
2.22.0

