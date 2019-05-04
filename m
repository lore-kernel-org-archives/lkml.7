Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F8C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876B620645
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFTA/RmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEDN41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 09:56:27 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34844 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfEDN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 09:56:27 -0400
Received: by mail-pf1-f202.google.com with SMTP id c12so4959372pfb.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JSrtuewaX5VqV5KEE7CkJwOl54n3BURDRsoqf/77RX0=;
        b=nFTA/RmWclTIQySWEdCzmd1lLYksmm5vaBLdRXUchgXFFNHd+zZlQv16VQicvpZub3
         pQVx01zeJHFxe+RG3R5G9EX394R0wyRXUMxLauxLn4dBIS1kSgH9hY0l7XtkH3sELrmH
         FdI4IvlWbKbpBJq0tA57PH1H2RdsS1eQJbR17R2TLAPrGa36SP9pHZwBsIbiTriVx6Ag
         6MZbl0gHJNFrvJweQb+069G/SPmEFoWbEm2QuaeeV6siVefhQgcZ/cjQeYcPpLKEbKsN
         zlIuEVCiPyiRLVAWUKvawpM1CbAPp4s9jdp7hlxvhCwxJuDmT2N2OJC517IZqEU1UQfj
         sRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JSrtuewaX5VqV5KEE7CkJwOl54n3BURDRsoqf/77RX0=;
        b=tHYi1LxElhyv4ogQ4lVRe+ge9tZT8EjxB4waGv2mlvSKQGddGCpgiVSqdMaCz7ETqc
         oYmKHz1TOpcw4RaZMY15puAMPa5XUPenD/xQVTZDQ+mZpszT/AMkGDhAeGRcDP4N02tb
         Du7EIZHt2Hds7LkyVUsEP3Bi2x+RcNh1GC0QlOZzeJVA+gvtCFo3rYtxLIyAV/L+m7Z9
         wmSNwMejjXV4fzcz+/b6d0ydAm7zFxaNYZjSqAJjIMYI6L7Y4U+Tvl/AK5zpyaG3TPpG
         J4PuVIPSzFcA3rqtI6oFwLN2oSqnO0IlypIMO300N4gyDspcm2YmYgZxEiwzq1EIpzj3
         v/kg==
X-Gm-Message-State: APjAAAUDvFxfLMKMojQ8+AxctRFktOIdgnoVhDnSuMiapSQ8EqHGpjIJ
        zjwOSIeEMjn3KfiZsifRsUK+JGqL5A==
X-Google-Smtp-Source: APXvYqwbdu22XftC0bn82oDLV8X4k+EHpOS9LhjD6BT9cKcaF5Y+vEfKpTyD0IiMzeK8sRw3xwN4OHo1jg==
X-Received: by 2002:a63:5c24:: with SMTP id q36mr18654620pgb.314.1556978185813;
 Sat, 04 May 2019 06:56:25 -0700 (PDT)
Date:   Sat,  4 May 2019 15:56:08 +0200
Message-Id: <20190504135608.176687-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] habanalabs: fix debugfs code
From:   Jann Horn <jannh@google.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes multiple things in the habanalabs debugfs code, in particular:

 - mmu_write() was unnecessarily verbose, copying around between multiple
   buffers
 - mmu_write() could write a user-specified, unbounded amount of userspace
   memory into a kernel buffer (out-of-bounds write)
 - multiple debugfs read handlers ignored the user-supplied count,
   potentially corrupting out-of-bounds userspace data
 - hl_device_read() was unnecessarily verbose
 - hl_device_write() could read uninitialized stack memory
 - multiple debugfs read handlers copied terminating null characters to
   userspace

Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only, so you might want to test this before applying the
patch

 drivers/misc/habanalabs/debugfs.c | 60 ++++++++++---------------------
 1 file changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 974a87789bd86..17ba26422b297 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -459,41 +459,31 @@ static ssize_t mmu_write(struct file *file, const char __user *buf,
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
-	char kbuf[MMU_KBUF_SIZE], asid_kbuf[MMU_ASID_BUF_SIZE],
-		addr_kbuf[MMU_ADDR_BUF_SIZE];
+	char kbuf[MMU_KBUF_SIZE];
 	char *c;
 	ssize_t rc;
 
 	if (!hdev->mmu_enable)
 		return count;
 
-	memset(kbuf, 0, sizeof(kbuf));
-	memset(asid_kbuf, 0, sizeof(asid_kbuf));
-	memset(addr_kbuf, 0, sizeof(addr_kbuf));
-
+	if (count > sizeof(kbuf) - 1)
+		goto err;
 	if (copy_from_user(kbuf, buf, count))
 		goto err;
-
-	kbuf[MMU_KBUF_SIZE - 1] = 0;
+	kbuf[count] = 0;
 
 	c = strchr(kbuf, ' ');
 	if (!c)
 		goto err;
+	*c = '\0';
 
-	memcpy(asid_kbuf, kbuf, c - kbuf);
-
-	rc = kstrtouint(asid_kbuf, 10, &dev_entry->mmu_asid);
+	rc = kstrtouint(kbuf, 10, &dev_entry->mmu_asid);
 	if (rc)
 		goto err;
 
-	c = strstr(kbuf, " 0x");
-	if (!c)
+	if (strncmp(c+1, "0x", 2))
 		goto err;
-
-	c += 3;
-	memcpy(addr_kbuf, c, (kbuf + count) - c);
-
-	rc = kstrtoull(addr_kbuf, 16, &dev_entry->mmu_addr);
+	rc = kstrtoull(c+3, 16, &dev_entry->mmu_addr);
 	if (rc)
 		goto err;
 
@@ -525,10 +515,8 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 	}
 
 	sprintf(tmp_buf, "0x%08x\n", val);
-	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
-			strlen(tmp_buf) + 1);
-
-	return rc;
+	return simple_read_from_buffer(buf, count, ppos, tmp_buf,
+			strlen(tmp_buf));
 }
 
 static ssize_t hl_data_write32(struct file *f, const char __user *buf,
@@ -559,7 +547,6 @@ static ssize_t hl_get_power_state(struct file *f, char __user *buf,
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	char tmp_buf[200];
-	ssize_t rc;
 	int i;
 
 	if (*ppos)
@@ -574,10 +561,8 @@ static ssize_t hl_get_power_state(struct file *f, char __user *buf,
 
 	sprintf(tmp_buf,
 		"current power state: %d\n1 - D0\n2 - D3hot\n3 - Unknown\n", i);
-	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
-			strlen(tmp_buf) + 1);
-
-	return rc;
+	return simple_read_from_buffer(buf, count, ppos, tmp_buf,
+			strlen(tmp_buf));
 }
 
 static ssize_t hl_set_power_state(struct file *f, const char __user *buf,
@@ -630,8 +615,8 @@ static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
 	}
 
 	sprintf(tmp_buf, "0x%02x\n", val);
-	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
-			strlen(tmp_buf) + 1);
+	rc = simple_read_from_buffer(buf, count, ppos, tmp_buf,
+			strlen(tmp_buf));
 
 	return rc;
 }
@@ -720,18 +705,9 @@ static ssize_t hl_led2_write(struct file *f, const char __user *buf,
 static ssize_t hl_device_read(struct file *f, char __user *buf,
 					size_t count, loff_t *ppos)
 {
-	char tmp_buf[200];
-	ssize_t rc;
-
-	if (*ppos)
-		return 0;
-
-	sprintf(tmp_buf,
-		"Valid values: disable, enable, suspend, resume, cpu_timeout\n");
-	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
-			strlen(tmp_buf) + 1);
-
-	return rc;
+	static const char *help =
+		"Valid values: disable, enable, suspend, resume, cpu_timeout\n";
+	return simple_read_from_buffer(buf, count, ppos, help, strlen(help));
 }
 
 static ssize_t hl_device_write(struct file *f, const char __user *buf,
@@ -739,7 +715,7 @@ static ssize_t hl_device_write(struct file *f, const char __user *buf,
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
-	char data[30];
+	char data[30] = {0};
 
 	/* don't allow partial writes */
 	if (*ppos != 0)
-- 
2.21.0.1020.gf2820cf01a-goog

