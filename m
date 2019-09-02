Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024E1C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A58216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfIBNbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:31:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:44289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbfIBNbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:31:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="176322044"
Received: from doblerbe-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.100])
  by orsmga008.jf.intel.com with ESMTP; 02 Sep 2019 06:31:38 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     aklimov@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tpm: Remove duplicate code from caps_show() in tpm-sysfs.c
Date:   Mon,  2 Sep 2019 16:31:36 +0300
Message-Id: <20190902133136.24117-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace existing TPM 1.x version structs with new structs that consolidate
the common parts into a single struct so that code duplication is no longer
needed in caps_show().

Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v2: Give back the TPM 1.1 version only if tpm1_getcap() returns 0.
 drivers/char/tpm/tpm-sysfs.c | 45 ++++++++++++++++++------------------
 drivers/char/tpm/tpm.h       | 23 ++++++++----------
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index edfa89160010..3b53b3e5ec3e 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -217,6 +217,7 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);
+	struct tpm1_version *version;
 	ssize_t rc = 0;
 	char *str = buf;
 	cap_t cap;
@@ -232,31 +233,31 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 	str += sprintf(str, "Manufacturer: 0x%x\n",
 		       be32_to_cpu(cap.manufacturer_id));
 
-	/* Try to get a TPM version 1.2 TPM_CAP_VERSION_INFO */
-	rc = tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
+	/* TPM 1.2 */
+	if (!tpm1_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
 			 "attempting to determine the 1.2 version",
-			 sizeof(cap.tpm_version_1_2));
-	if (!rc) {
-		str += sprintf(str,
-			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
-			       cap.tpm_version_1_2.Major,
-			       cap.tpm_version_1_2.Minor,
-			       cap.tpm_version_1_2.revMajor,
-			       cap.tpm_version_1_2.revMinor);
-	} else {
-		/* Otherwise just use TPM_STRUCT_VER */
-		if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
-				"attempting to determine the 1.1 version",
-				sizeof(cap.tpm_version)))
-			goto out_ops;
-		str += sprintf(str,
-			       "TCG version: %d.%d\nFirmware version: %d.%d\n",
-			       cap.tpm_version.Major,
-			       cap.tpm_version.Minor,
-			       cap.tpm_version.revMajor,
-			       cap.tpm_version.revMinor);
+			 sizeof(cap.version2))) {
+		version = &cap.version2.version;
+		goto out_print;
 	}
+
+	/* TPM 1.1 */
+	if (tpm1_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
+			"attempting to determine the 1.1 version",
+			sizeof(cap.version1))) {
+		goto out_ops;
+	}
+
+	version = &cap.version1;
+
+out_print:
+	str += sprintf(str,
+		       "TCG version: %d.%d\nFirmware version: %d.%d\n",
+		       version->major, version->minor,
+		       version->rev_major, version->rev_minor);
+
 	rc = str - buf;
+
 out_ops:
 	tpm_put_ops(chip);
 	return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a7fea3e0ca86..a4f74dd02a35 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -186,19 +186,16 @@ struct	stclear_flags_t {
 	u8	bGlobalLock;
 } __packed;
 
-struct	tpm_version_t {
-	u8	Major;
-	u8	Minor;
-	u8	revMajor;
-	u8	revMinor;
+struct tpm1_version {
+	u8 major;
+	u8 minor;
+	u8 rev_major;
+	u8 rev_minor;
 } __packed;
 
-struct	tpm_version_1_2_t {
-	__be16	tag;
-	u8	Major;
-	u8	Minor;
-	u8	revMajor;
-	u8	revMinor;
+struct tpm1_version2 {
+	__be16 tag;
+	struct tpm1_version version;
 } __packed;
 
 struct	timeout_t {
@@ -243,8 +240,8 @@ typedef union {
 	struct	stclear_flags_t	stclear_flags;
 	__u8	owned;
 	__be32	num_pcrs;
-	struct	tpm_version_t	tpm_version;
-	struct	tpm_version_1_2_t tpm_version_1_2;
+	struct tpm1_version version1;
+	struct tpm1_version2 version2;
 	__be32	manufacturer_id;
 	struct timeout_t  timeout;
 	struct duration_t duration;
-- 
2.20.1

