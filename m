Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F33C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2EF2173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Trn1r5D9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfJHKMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:12:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42752 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:12:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so10495277pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJBL7qyzxoDJRRddYXK54hndGf2KGEetfbRWryMKt2E=;
        b=Trn1r5D9cGQW5wjoTVdST1Vr+Nt4P4YpIV2bWoatnDDPis7Dy9jpi4NP/IkdP5+fej
         ZbRZqPfICPJGzhNgYmI6sibzynWOpiZ5k2L0YfGRG0X9mDpgl5puTbYLT5nXIT88PR7n
         VBfHcTrONdTja6s5V1shQdAHCQFgGN8IIegi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oJBL7qyzxoDJRRddYXK54hndGf2KGEetfbRWryMKt2E=;
        b=PL3zJoe6ajlNtomuOSUbZ4eCmaNwDm3djd4KULhZgFi2CUVbCUGu4snrnY1ADRBItH
         YNhlrXEQtLxYSFpCLdwu1iKxyM8/U44VUoHdgnT/+3pOKWO4dRxW0JJME9U1RYmBZxMb
         KzhIN5rmBR4ydDhsvwueXdZ3QKLynt0OeFLytK4F9ofPdJPSa4gPNxvr5z8BrphctEwB
         DUzJjQ4OcwzzCYCf9faYkmD1Wk44BUdqBarffiJGXYyzY7zYXeAqmoD9hvl1zqDT2MWw
         1hOjdHQ6G0FwQvvmJPQk/w3XjtFNkyZYlAM8JljII63gSmSL0JVVLiEICb+66NEW29fV
         j3Aw==
X-Gm-Message-State: APjAAAVpobmQ1Nc06R2mfhXrcKGCaChXNNg95Mi4t/RnNjPsa7dCgW7p
        mFexbK7SSh4MFqbWXdXYAPRJ1NR4wo8=
X-Google-Smtp-Source: APXvYqwuL/NpT53t//3HEQqYcM39S9q70cMotyVyM1K2EG7T0EBBhKzkMC/651IeZcvTwB6aGwIs8A==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr35543545pgo.133.1570529519761;
        Tue, 08 Oct 2019 03:11:59 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id t3sm1894936pje.7.2019.10.08.03.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:11:58 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Guenter Roeck <linux@roeck-us.net>,
        Hung-Te Lin <hungte@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Shuming Fan <shumingf@realtek.com>,
        sathya.prakash.m.r@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>, dgreid@chromium.org,
        tzungbi@chromium.org
Subject: [PATCH v2] firmware: vpd: Add an interface to read VPD value
Date:   Tue,  8 Oct 2019 18:11:44 +0800
Message-Id: <20191008101144.39342-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an interface for other driver to query VPD value.
This will be used for ASoC machine driver to query calibration
data stored in VPD for smart amplifier speaker resistor
calibration.

The example usage in ASoC machine driver is like:

#define DSM_CALIB_KEY "dsm_calib"
static int load_calibration_data(struct cml_card_private *ctx) {
    char *data = NULL;
    int ret;
    u32 value_len;

    /* Read calibration data from VPD. */
    ret = vpd_attribute_read(1, DSM_CALIB_KEY,
                            (u8 **)&data, &value_len);

    /* Parsing of this string...*/
}


Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
Change from v1 to v2:
- Use kmemdup to copy data.
- Set value_len according to bin_attr.size.
- Check return value of kmemdup.
- Rename the function to vpd_attribute_read.
- Add docstrings for the function.
- Returns -ENOENT when the key is not found.
- Use EXPORT_SYMBOL_GPL.

Note:

The user of this API is in ASoC machine driver cml_rt1011_rt5682.
It is pending on the initial machine driver change

https://patchwork.kernel.org/patch/11161145/

and the codec driver change to provide API to do calibration.

https://patchwork.kernel.org/patch/11179237/

The draft patch of machine driver change which uses this API is at

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1838091



 drivers/firmware/google/vpd.c              | 31 ++++++++++++++++++++++
 include/linux/firmware/google/google_vpd.h | 18 +++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 include/linux/firmware/google/google_vpd.h

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index db0812263d46..c2be0e756402 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -65,6 +65,37 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
 				       info->bin_attr.size);
 }
 
+/**
+ *	vpd_attribute_read - Read VPD value for a key.
+ *	@ro: True for RO section. False for RW section.
+ *	@key: A string for key.
+ *	@value: Where to write the VPD value on success. The caller
+ *	        must free the memory.
+ *	@value_len: The length of value in bytes.
+ *
+ *	Returns 0 on success, -ENOENT when the key is not found, and
+ *	-ENOMEM when failed to allocate memory for value.
+ */
+int vpd_attribute_read(bool ro, const char *key,
+		       u8 **value, u32 *value_len)
+{
+	struct vpd_attrib_info *info;
+	struct vpd_section *sec = ro ? &ro_vpd : &rw_vpd;
+
+	list_for_each_entry(info, &sec->attribs, list) {
+		if (strcmp(info->key, key) == 0) {
+			*value = kmemdup(info->value, info->bin_attr.size,
+					 GFP_KERNEL);
+			if (!*value)
+				return -ENOMEM;
+			*value_len = info->bin_attr.size;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(vpd_attribute_read);
+
 /*
  * vpd_section_check_key_name()
  *
diff --git a/include/linux/firmware/google/google_vpd.h b/include/linux/firmware/google/google_vpd.h
new file mode 100644
index 000000000000..4364eaa4e1e3
--- /dev/null
+++ b/include/linux/firmware/google/google_vpd.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Google VPD interface.
+ *
+ * Copyright 2019 Google Inc.
+ */
+
+/* Interface for reading VPD value on Chrome platform. */
+
+#ifndef __GOOGLE_VPD_H
+#define __GOOGLE_VPD_H
+
+#include <linux/types.h>
+
+int vpd_attribute_read(bool ro, const char *key,
+		       u8 **value, u32 *value_len);
+
+#endif  /* __GOOGLE_VPD_H */
-- 
2.23.0.581.g78d2f28ef7-goog

