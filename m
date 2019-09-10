Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49ECC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C9D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h8oaeBJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393894AbfIJPRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:17:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33032 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:17:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so11718791pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H157UG66oVBF0CE+GcGR3RktSFA6GpYH6ZsD2j5f4J8=;
        b=h8oaeBJTIeOV82VeqekQ2UqUGTVzTgI6xiOei7R2+xf+tqNgf/t9Wtxgg5bG07uZTb
         PO79c++JGwNHSKfkiFY3XSGC42tAyoG8rUXE9e9C7GrOSbv1+5UqH1jL9QBiUwy+Yhfx
         +4DdWm+T49W/6Q2OQobmdXwg2CyOMQkmF1/Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H157UG66oVBF0CE+GcGR3RktSFA6GpYH6ZsD2j5f4J8=;
        b=IBskhInfqzP3ZYts9slazmkuJIr/8jhReiNE1UQkNcGKu76VNwITCHKvPUvM7nItJ9
         sNskqJ6us23X8bn6s+gplMmcHCyHKsYyNGgerErHBXzB48ApbY0b130ZYY26LFtFON7f
         OwR4AuSgdCo4XmYHrH6lKviv+RM+Obz864jGXUcgitQHzKb0S2rT0SPNKB5v9YMTtO9f
         ZWgohTTPvYzGrIY6e62pPHPfIGPM5eToW8wGQPxirXCFoBUne1gqBcteT5nbyLF7NsBl
         7k7LsnFso1A+Vn9tiGBi3W/QzXnFG50CUeY64TR8Med0UhknSMkq7QhvmiuXzGeXFr9k
         mfgw==
X-Gm-Message-State: APjAAAV76OaPQtZRdw2xr/2N/HMjUKQMcMr1B8YCiQHPbDPKYbtDzDBV
        qQXNhWNEeoo2M3ZWqYNsCtc/uA==
X-Google-Smtp-Source: APXvYqylhMT43MbF/EElVo76qxnlZRTqEDEkqV/LE4j2vEGL2JUVmis+WrXfTVcDoeLenZLOB+06kA==
X-Received: by 2002:a62:1cd2:: with SMTP id c201mr36887188pfc.51.1568128628109;
        Tue, 10 Sep 2019 08:17:08 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j18sm20255634pfh.70.2019.09.10.08.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 08:17:07 -0700 (PDT)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>
Cc:     tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH] firmware: broadcom: add OP-TEE based BNXT f/w manager
Date:   Tue, 10 Sep 2019 20:47:04 +0530
Message-Id: <1568128624-2902-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vikas Gupta <vikas.gupta@broadcom.com>

This driver registers on TEE bus to interact with OP-TEE based
BNXT firmware management modules

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/firmware/broadcom/Kconfig             |   8 +
 drivers/firmware/broadcom/Makefile            |   1 +
 drivers/firmware/broadcom/tee_bnxt_fw.c       | 447 ++++++++++++++++++++++++++
 include/linux/firmware/broadcom/tee_bnxt_fw.h |  17 +
 4 files changed, 473 insertions(+)
 create mode 100644 drivers/firmware/broadcom/tee_bnxt_fw.c
 create mode 100644 include/linux/firmware/broadcom/tee_bnxt_fw.h

diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
index 6468082..a846a21 100644
--- a/drivers/firmware/broadcom/Kconfig
+++ b/drivers/firmware/broadcom/Kconfig
@@ -22,3 +22,11 @@ config BCM47XX_SPROM
 	  In case of SoC devices SPROM content is stored on a flash used by
 	  bootloader firmware CFE. This driver provides method to ssb and bcma
 	  drivers to read SPROM on SoC.
+
+config TEE_BNXT_FW
+	bool "Broadcom BNXT firmware manager"
+	depends on ARCH_BCM_IPROC && OPTEE
+	default ARCH_BCM_IPROC
+	help
+	  This module help to manage firmware on Broadcom BNXT device. The module
+	  registers on tee bus and invoke calls to manage firmware on BNXT device.
diff --git a/drivers/firmware/broadcom/Makefile b/drivers/firmware/broadcom/Makefile
index 72c7fdc..17c5061 100644
--- a/drivers/firmware/broadcom/Makefile
+++ b/drivers/firmware/broadcom/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BCM47XX_NVRAM)		+= bcm47xx_nvram.o
 obj-$(CONFIG_BCM47XX_SPROM)		+= bcm47xx_sprom.o
+obj-$(CONFIG_TEE_BNXT_FW)		+= tee_bnxt_fw.o
diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
new file mode 100644
index 00000000..89a48fd
--- /dev/null
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Broadcom.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+
+#include <linux/firmware/broadcom/tee_bnxt_fw.h>
+
+#define DRIVER_NAME	"tee-bnxt-fw"
+
+#define MAX_SHM_MEM_SZ	SZ_4M
+
+#define MAX_TEE_PARAM_ARRY_MEMB		4
+
+enum ta_cmd {
+/*
+ * TA_CMD_BNXT_FASTBOOT - boot bnxt device by copying f/w into sram
+ *
+ * param[0] unused
+ * param[1] unused
+ * param[2] unused
+ * param[3] unused
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_ITEM_NOT_FOUND - Corrupt f/w image found on memory
+ */
+	TA_CMD_BNXT_FASTBOOT = 0,
+
+/*
+ * TA_CMD_BNXT_HEALTH_STATUS - to check health of bnxt device
+ *
+ * param[0] (out value) - value.a: health status
+ * param[1] unused
+ * param[2] unused
+ * param[3] unused
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+	TA_CMD_BNXT_HEALTH_STATUS,
+
+/*
+ * TA_CMD_BNXT_HANDSHAKE - to check bnxt device is booted
+ *
+ * param[0] (in value)  - value.a: max timeout value
+ * param[0] (out value) - value.a: boot status
+ * param[1] unused
+ * param[2] unused
+ * param[3] unused
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+	TA_CMD_BNXT_HANDSHAKE,
+
+/*
+ * TA_CMD_BNXT_COPY_COREDUMP - copy the core dump into shm
+ *
+ * param[0] (in value) - value.a: offset at which data to be copied from
+ *			 value.b: size of the data
+ * param[1] unused
+ * param[2] unused
+ * param[3] unused
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ * TEE_ERROR_ITEM_NOT_FOUND - Corrupt core dump
+ */
+	TA_CMD_BNXT_COPY_COREDUMP,
+
+/*
+ * TA_CMD_BNXT_FW_UPGRADE - upgrade the bnxt firmware
+ *
+ * param[0] (in value) - value.a: size of the f/w image
+ * param[1] unused
+ * param[2] unused
+ * param[3] unused
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+	TA_CMD_BNXT_FW_UPGRADE,
+};
+
+/**
+ * struct tee_bnxt_fw_private - OP-TEE bnxt private data
+ * @dev:		OP-TEE based bnxt device.
+ * @ctx:		OP-TEE context handler.
+ * @session_id:		TA session identifier.
+ */
+struct tee_bnxt_fw_private {
+	struct device *dev;
+	struct tee_context *ctx;
+	u32 session_id;
+	struct tee_shm *fw_shm_pool;
+};
+
+static struct tee_bnxt_fw_private pvt_data;
+
+static inline void prepare_args(int cmd,
+				struct tee_ioctl_invoke_arg *inv_arg,
+				struct tee_param *param)
+{
+	memset(inv_arg, 0, sizeof(*inv_arg));
+	memset(param, 0, (MAX_TEE_PARAM_ARRY_MEMB * sizeof(*param)));
+
+	inv_arg->func = cmd;
+	inv_arg->session = pvt_data.session_id;
+	inv_arg->num_params = MAX_TEE_PARAM_ARRY_MEMB;
+
+	/* Fill invoke cmd params */
+	switch (cmd) {
+	case TA_CMD_BNXT_HEALTH_STATUS:
+		param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+		break;
+	case TA_CMD_BNXT_HANDSHAKE:
+		param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
+		break;
+	case TA_CMD_BNXT_COPY_COREDUMP:
+	case TA_CMD_BNXT_FW_UPGRADE:
+		param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
+		param[0].u.memref.shm = pvt_data.fw_shm_pool;
+		param[0].u.memref.size = MAX_SHM_MEM_SZ;
+		param[0].u.memref.shm_offs = 0;
+		param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+		break;
+	case TA_CMD_BNXT_FASTBOOT:
+	default:
+		/* Nothing to do */
+		break;
+	}
+}
+
+/**
+ * tee_bnxt_fw_load() - Load the bnxt firmware
+ *		    Uses an OP-TEE call to start a secure
+ *		    boot process.
+ * Returns 0 on success, negative errno otherwise.
+ */
+int tee_bnxt_fw_load(void)
+{
+	int ret = 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMB];
+
+	if (!pvt_data.ctx)
+		return -ENODEV;
+
+	prepare_args(TA_CMD_BNXT_FASTBOOT, &inv_arg, param);
+
+	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_BNXT_LOAD invoke err: %x\n",
+			(ret < 0) ? ret : inv_arg.ret);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tee_bnxt_fw_load);
+
+/**
+ * tee_bnxt_health_status() - Get the health status
+ *		    Uses an OP-TEE call to get health
+ *		    status of bnxt device.
+ * @status:	    status is returned on this pointer
+ * Returns 0 on success, negative errno otherwise.
+ */
+int tee_bnxt_health_status(u32 *status)
+{
+	int ret = 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMB];
+
+	if (!pvt_data.ctx)
+		return -ENODEV;
+
+	prepare_args(TA_CMD_BNXT_HEALTH_STATUS, &inv_arg, param);
+
+	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_BNXT_HEALTH_STATUS invoke err: %x\n",
+			(ret < 0) ? ret : inv_arg.ret);
+		return -EINVAL;
+	}
+
+	*status = param[0].u.value.a;
+
+	return 0;
+}
+EXPORT_SYMBOL(tee_bnxt_health_status);
+
+/**
+ * tee_bnxt_handshake() - Get the handshake status
+ *		    Uses an OP-TEE call to get handshake
+ *		    status after bnxt device`s boot process.
+ * @timeout:	    max timeout to wait for handshake
+ * @status:	    status is populated
+ * Returns 0 on success, negative errno otherwise.
+ */
+int tee_bnxt_handshake(u32 timeout, u32 *status)
+{
+	int ret = 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMB];
+
+	if (!pvt_data.ctx)
+		return -ENODEV;
+
+	prepare_args(TA_CMD_BNXT_HANDSHAKE, &inv_arg, param);
+
+	/* Fill additional invoke cmd params */
+	param[0].u.value.a = timeout;
+
+	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_BNXT_HANDSHAKE invoke err: %x\n",
+			(ret < 0) ? ret : inv_arg.ret);
+		return -EINVAL;
+	}
+
+	*status = param[0].u.value.a;
+
+	return 0;
+}
+EXPORT_SYMBOL(tee_bnxt_handshake);
+
+/**
+ * tee_bnxt_copy_coredump() - Copy coredump from the allocated memory
+ *			    Uses an OP-TEE call to copy coredump
+ * @buf:	desintation buffer where core dump is copied into
+ * @offset:	offset from the base address of core dump area
+ * @size:	size of the dump
+ *
+ * Returns 0 on success, negative errno otherwise.
+ */
+int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
+{
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMB];
+	void *core_data;
+	u32 rbytes = size;
+	u32 nbytes = 0;
+	int ret = 0;
+
+	if (!pvt_data.ctx)
+		return -ENODEV;
+
+	if (!buf)
+		return -EINVAL;
+
+	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &inv_arg, param);
+
+	while (rbytes)  {
+		nbytes = rbytes;
+
+		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
+
+		/* Fill additional invoke cmd params */
+		param[1].u.value.a = offset;
+		param[1].u.value.b = nbytes;
+
+		ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+		if ((ret < 0) || (inv_arg.ret != 0)) {
+			dev_err(pvt_data.dev,
+				"TA_CMD_BNXT_COPY_COREDUMP invoke err: %x\n",
+				(ret < 0) ? ret : inv_arg.ret);
+			return -EINVAL;
+		}
+
+		core_data = tee_shm_get_va(pvt_data.fw_shm_pool, 0);
+		if (IS_ERR(core_data)) {
+			dev_err(pvt_data.dev, "tee_shm_get_va failed\n");
+			return PTR_ERR(core_data);
+		}
+
+		memcpy(buf, core_data, nbytes);
+
+		rbytes -= nbytes;
+		buf += nbytes;
+		offset += nbytes;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tee_bnxt_copy_coredump);
+
+/**
+ * bnxt_fw_upgrade() - Upgrade the bnxt firmware and configuration of
+ *		       bnxt device into the flash device.
+ *		       Uses an OP-TEE call to upgrade firmware.
+ * @buf:	source buffer of firmware image
+ * @size:	size of the image
+ *
+ * Returns 0 on success, negative errno otherwise.
+ */
+int bnxt_fw_upgrade(void *buf, u32 size)
+{
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMB];
+	void *fw_image_dst;
+	int ret = 0;
+
+	if (!pvt_data.ctx)
+		return -ENODEV;
+
+	/* we do not expect firmware size more than allocated tee shm size */
+	if (!buf || size > MAX_SHM_MEM_SZ)
+		return -EINVAL;
+
+	prepare_args(TA_CMD_BNXT_FW_UPGRADE, &inv_arg, param);
+
+	/* Fill additional invoke cmd params */
+	param[1].u.value.a = size;
+
+	fw_image_dst = tee_shm_get_va(pvt_data.fw_shm_pool, 0);
+	if (IS_ERR(fw_image_dst)) {
+		dev_err(pvt_data.dev, "tee_shm_get_va failed\n");
+		return PTR_ERR(fw_image_dst);
+	}
+
+	memcpy(fw_image_dst, buf, size);
+
+	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_BNXT_FW_UPGRADE invoke err: %x\n",
+			(ret < 0) ? ret : inv_arg.ret);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(bnxt_fw_upgrade);
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
+		return 1;
+	else
+		return 0;
+}
+
+static int tee_bnxt_fw_probe(struct device *dev)
+{
+	struct tee_client_device *bnxt_device = to_tee_client_device(dev);
+	int ret, err = -ENODEV;
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct tee_shm *fw_shm_pool;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	/* Open context with TEE driver */
+	pvt_data.ctx = tee_client_open_context(NULL, optee_ctx_match, NULL,
+					       NULL);
+	if (IS_ERR(pvt_data.ctx))
+		return -ENODEV;
+
+	/* Open session with Bnxt load Trusted App */
+	memcpy(sess_arg.uuid, bnxt_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
+	sess_arg.num_params = 0;
+
+	ret = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
+	if ((ret < 0) || (sess_arg.ret != 0)) {
+		dev_err(dev, "tee_client_open_session failed, err: %x\n",
+			sess_arg.ret);
+		err = -EINVAL;
+		goto out_ctx;
+	}
+	pvt_data.session_id = sess_arg.session;
+
+	pvt_data.dev = dev;
+
+	fw_shm_pool = tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
+				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	if (IS_ERR(fw_shm_pool)) {
+		tee_client_close_context(pvt_data.ctx);
+		dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
+		err = PTR_ERR(fw_shm_pool);
+		goto out_sess;
+	}
+
+	pvt_data.fw_shm_pool = fw_shm_pool;
+
+	return 0;
+
+out_sess:
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+out_ctx:
+	tee_client_close_context(pvt_data.ctx);
+
+	return err;
+}
+
+static int tee_bnxt_fw_remove(struct device *dev)
+{
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+	tee_client_close_context(pvt_data.ctx);
+	pvt_data.ctx = NULL;
+
+	return 0;
+}
+
+static const struct tee_client_device_id tee_bnxt_fw_id_table[] = {
+	{UUID_INIT(0x6272636D, 0x2019, 0x0716,
+		    0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(tee, tee_bnxt_fw_id_table);
+
+static struct tee_client_driver tee_bnxt_fw_driver = {
+	.id_table	= tee_bnxt_fw_id_table,
+	.driver		= {
+		.name		= DRIVER_NAME,
+		.bus		= &tee_bus_type,
+		.probe		= tee_bnxt_fw_probe,
+		.remove		= tee_bnxt_fw_remove,
+	},
+};
+
+static int __init tee_bnxt_fw_mod_init(void)
+{
+	return driver_register(&tee_bnxt_fw_driver.driver);
+}
+
+static void __exit tee_bnxt_fw_mod_exit(void)
+{
+	driver_unregister(&tee_bnxt_fw_driver.driver);
+}
+
+module_init(tee_bnxt_fw_mod_init);
+module_exit(tee_bnxt_fw_mod_exit);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("Broadcom bnxt firmware manager");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/firmware/broadcom/tee_bnxt_fw.h b/include/linux/firmware/broadcom/tee_bnxt_fw.h
new file mode 100644
index 00000000..d3b7206
--- /dev/null
+++ b/include/linux/firmware/broadcom/tee_bnxt_fw.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright 2019 Broadcom.
+ */
+
+#ifndef _BROADCOM_TEE_BNXT_FW_H
+#define _BROADCOM_TEE_BNXT_FW_H
+
+#include <linux/types.h>
+
+int tee_bnxt_fw_load(void);
+int tee_bnxt_health_status(u32 *status);
+int tee_bnxt_handshake(u32 timeout, u32 *status);
+int tee_bnxt_fw_update(void *buf, u32 size);
+int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size);
+
+#endif /* _BROADCOM_TEE_BNXT_FW_H */
-- 
1.9.1

