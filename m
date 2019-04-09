Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F2EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F105320883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554835822;
	bh=DO1p5RcKk90pI40zrNh2tNr0IQOzNUb3H3pj0C/ClcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Imc6LQ5Fy1gHDfSATpKMVNG0AGa/2WFYy5TT5pnnFk1siiA6RZIcMYMAgUlvqDRew
	 1wYmR3CYmDWwuPf90OWsETjkAKHXrEn6Y14BepI6CHKOlHInXszQGsUuKztiol9iPo
	 HvCsJotcg1QOnBW2Fae6dpOAuwPhR+0/WWIEc/ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDISuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfDISuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:50:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894A021841;
        Tue,  9 Apr 2019 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554835817;
        bh=DO1p5RcKk90pI40zrNh2tNr0IQOzNUb3H3pj0C/ClcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsb8/6GjbU4y13DW2bigObGpYihFEpIHikA1i1e75E7GLrKmznMjYF0Nq7U+MIQRb
         vVLudJHvsmsW5NnD4g0Y1a3raDgKhKX6FXwF/FNn460lfa/t7HKjeWjBGxGrcQo2ps
         NBWxZsIo1FHea+W+0QfK6rz299yUhxa4t0BdUsEw=
From:   Sasha Levin <sashal@kernel.org>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     mark.rutland@arm.com, corbet@lwn.net, robh+dt@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 2/3] ftpm: firmware TPM running in TEE
Date:   Tue,  9 Apr 2019 14:49:57 -0400
Message-Id: <20190409184958.7476-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190409184958.7476-1-sashal@kernel.org>
References: <20190409184958.7476-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for a software-only implementation of a TPM
running in TEE.

There is extensive documentation of the design here:
https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/ .

As well as reference code for the firmware available here:
https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM

Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/Kconfig        |   5 +
 drivers/char/tpm/Makefile       |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c | 346 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_ftpm_tee.h |  52 +++++
 4 files changed, 404 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
 create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 536e55d3919f..5638726641eb 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -164,6 +164,11 @@ config TCG_VTPM_PROXY
 	  /dev/vtpmX and a server-side file descriptor on which the vTPM
 	  can receive commands.
 
+config TCG_FTPM_TEE
+	tristate "TEE based fTPM Interface"
+	depends on TEE
+	---help---
+	  This driver proxies for fTPM running in TEE
 
 source "drivers/char/tpm/st33zp24/Kconfig"
 endif # TCG_TPM
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index a01c4cab902a..c354cdff9c62 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
 obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
 obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
+obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
new file mode 100644
index 000000000000..673f9a8b8603
--- /dev/null
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation
+ */
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+#include <linux/tpm.h>
+
+#include "tpm.h"
+#include "tpm_ftpm_tee.h"
+
+#define DRIVER_NAME "ftpm-tee"
+
+/*
+ * Note: ftpm_tee_tpm_op_recv and ftpm_tee_tpm_op_send are called from the
+ * same routine tpm_try_transmit in tpm-interface.c. These calls are protected
+ * by chip->tpm_mutex => There is no need for protecting any data shared
+ * between these routines ex: struct ftpm_tee_private
+ */
+
+/**
+ * ftpm_tee_tpm_op_recv retrieve fTPM response.
+ * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h.
+ * @param: buf,	the buffer to store data.
+ * @param: count, the number of bytes to read.
+ * @return: In case of success the number of bytes received.
+ *	    In other case, a < 0 value describing the issue.
+ */
+static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+	size_t len;
+
+	len = pvt_data->resp_len;
+	if (count < len) {
+		dev_err(&chip->dev,
+			"%s:Invalid size in recv: count=%zd, resp_len=%zd\n",
+			__func__, count, len);
+		return -EIO;
+	}
+
+	memcpy(buf, pvt_data->resp_buf, len);
+	pvt_data->resp_len = 0;
+
+	return len;
+}
+
+/**
+ * ftpm_tee_tpm_op_send send TPM commands through the TEE shared memory.
+ *
+ * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h
+ * @param: buf,	the buffer to send.
+ * @param: len, the number of bytes to send.
+ * @return: In case of success, returns 0.
+ *	    In other case, a < 0 value describing the issue.
+ */
+static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
+	size_t resp_len;
+	int rc;
+	u8 *temp_buf;
+	struct tpm_header *resp_header;
+	struct tee_ioctl_invoke_arg transceive_args;
+	struct tee_param command_params[4];
+	struct tee_shm *shm = pvt_data->shm;
+
+	if (len > MAX_COMMAND_SIZE) {
+		dev_err(&chip->dev,
+			"%s:len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM TA\n",
+			__func__, len);
+		return -EIO;
+	}
+
+	memset(&transceive_args, 0, sizeof(transceive_args));
+	memset(command_params, 0, sizeof(command_params));
+	pvt_data->resp_len = 0;
+
+	/* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
+	transceive_args = (struct tee_ioctl_invoke_arg) {
+		.func = FTPM_OPTEE_TA_SUBMIT_COMMAND,
+		.session = pvt_data->session,
+		.num_params = 4,
+	};
+
+	/* Fill FTPM_OPTEE_TA_SUBMIT_COMMAND parameters */
+	command_params[0] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
+		.u.memref = {
+			.shm = shm,
+			.size = len,
+			.shm_offs = 0,
+		},
+	};
+
+	temp_buf = tee_shm_get_va(shm, 0);
+	if (IS_ERR(temp_buf)) {
+		dev_err(&chip->dev, "%s:tee_shm_get_va failed for transmit\n",
+			__func__);
+		return PTR_ERR(temp_buf);
+	}
+	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
+
+	memcpy(temp_buf, buf, len);
+
+	command_params[1] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
+		.u.memref = {
+			.shm = shm,
+			.size = MAX_RESPONSE_SIZE,
+			.shm_offs = MAX_COMMAND_SIZE,
+		},
+	};
+
+	rc = tee_client_invoke_func(pvt_data->ctx, &transceive_args,
+					command_params);
+	if ((rc < 0) || (transceive_args.ret != 0)) {
+		dev_err(&chip->dev, "%s:SUBMIT_COMMAND invoke error: 0x%x\n",
+			__func__, transceive_args.ret);
+		return (rc < 0) ? rc : transceive_args.ret;
+	}
+
+	temp_buf = tee_shm_get_va(shm, command_params[1].u.memref.shm_offs);
+	if (IS_ERR(temp_buf)) {
+		dev_err(&chip->dev, "%s:tee_shm_get_va failed for receive\n",
+			__func__);
+		return PTR_ERR(temp_buf);
+	}
+
+	resp_header = (struct tpm_header *)temp_buf;
+	resp_len = be32_to_cpu(resp_header->length);
+
+	/* sanity check resp_len */
+	if (resp_len < TPM_HEADER_SIZE) {
+		dev_err(&chip->dev, "%s:tpm response header too small\n",
+			__func__);
+		return -EIO;
+	}
+	if (resp_len > MAX_RESPONSE_SIZE) {
+		dev_err(&chip->dev,
+			"%s:resp_len=%zd exceeds MAX_RESPONSE_SIZE\n",
+			__func__, resp_len);
+		return -EIO;
+	}
+
+	/* sanity checks look good, cache the response */
+	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
+	pvt_data->resp_len = resp_len;
+
+	return 0;
+}
+
+static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
+{
+	/* not supported */
+}
+
+static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
+{
+	return 0;
+}
+
+static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
+{
+	return 0;
+}
+
+static const struct tpm_class_ops ftpm_tee_tpm_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.recv = ftpm_tee_tpm_op_recv,
+	.send = ftpm_tee_tpm_op_send,
+	.cancel = ftpm_tee_tpm_op_cancel,
+	.status = ftpm_tee_tpm_op_status,
+	.req_complete_mask = 0,
+	.req_complete_val = 0,
+	.req_canceled = ftpm_tee_tpm_req_canceled,
+};
+
+/*
+ * Check whether this driver supports the fTPM TA in the TEE instance
+ * represented by the params (ver/data) to this function.
+ */
+static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	/*
+	 * Currently this driver only support GP Complaint OPTEE based fTPM TA
+	 */
+	if ((ver->impl_id == TEE_IMPL_ID_OPTEE) &&
+		(ver->gen_caps & TEE_GEN_CAP_GP))
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * Undo what has been done in ftpm_tee_probe
+ */
+static void ftpm_tee_deinit(struct ftpm_tee_private *pvt_data)
+{
+	/* Release the chip */
+	tpm_chip_unregister(pvt_data->chip);
+
+	/* frees chip */
+	if (pvt_data->chip)
+		put_device(&pvt_data->chip->dev);
+
+	if (pvt_data->ctx) {
+		/* Free the shared memory pool */
+		tee_shm_free(pvt_data->shm);
+
+		/* close the existing session with fTPM TA*/
+		tee_client_close_session(pvt_data->ctx, pvt_data->session);
+
+		/* close the context with TEE driver */
+		tee_client_close_context(pvt_data->ctx);
+	}
+
+	/* memory allocated with devm_kzalloc() is freed automatically */
+}
+
+/**
+ * ftpm_tee_probe initialize the fTPM
+ * @param: pdev, the platform_device description.
+ * @return: 0 in case of success.
+ *	 or a negative value describing the error.
+ */
+static int ftpm_tee_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct tpm_chip *chip;
+	struct device *dev = &pdev->dev;
+	struct ftpm_tee_private *pvt_data = NULL;
+	struct tee_ioctl_open_session_arg sess_arg;
+
+	pvt_data = devm_kzalloc(dev, sizeof(struct ftpm_tee_private),
+				GFP_KERNEL);
+	if (!pvt_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, pvt_data);
+
+	/* Open context with TEE driver */
+	pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
+						NULL);
+	if (IS_ERR(pvt_data->ctx)) {
+		dev_err(dev, "%s:tee_client_open_context failed\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	/* Open a session with fTPM TA */
+	memset(&sess_arg, 0, sizeof(sess_arg));
+	memcpy(sess_arg.uuid, ftpm_ta_uuid.b, TEE_IOCTL_UUID_LEN);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
+	sess_arg.num_params = 0;
+
+	rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
+	if ((rc < 0) || (sess_arg.ret != 0)) {
+		dev_err(dev, "%s:tee_client_open_session failed, err=%x\n",
+			__func__, sess_arg.ret);
+		rc = -EINVAL;
+		goto out_tee_session;
+	}
+	pvt_data->session = sess_arg.session;
+
+	/* Allocate dynamic shared memory with fTPM TA */
+	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
+				(MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE),
+				TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	if (IS_ERR(pvt_data->shm)) {
+		dev_err(dev, "%s:tee_shm_alloc failed\n", __func__);
+		rc = -ENOMEM;
+		goto out_shm_alloc;
+	}
+
+	/* Allocate new struct tpm_chip instance */
+	chip = tpm_chip_alloc(dev, &ftpm_tee_tpm_ops);
+	if (IS_ERR(chip)) {
+		dev_err(dev, "%s:tpm_chip_alloc failed\n", __func__);
+		rc = PTR_ERR(chip);
+		goto out_chip_alloc;
+	}
+
+	pvt_data->chip = chip;
+	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
+
+	/* Create a character device for the fTPM */
+	rc = tpm_chip_register(pvt_data->chip);
+	if (rc) {
+		dev_err(dev, "%s:tpm_chip_register failed with rc=%d\n",
+			__func__, rc);
+		goto out_chip;
+	}
+
+	return 0;
+
+out_chip:
+	put_device(&pvt_data->chip->dev);
+out_chip_alloc:
+	tee_shm_free(pvt_data->shm);
+out_shm_alloc:
+	tee_client_close_session(pvt_data->ctx, pvt_data->session);
+out_tee_session:
+	tee_client_close_context(pvt_data->ctx);
+
+	return rc;
+}
+
+/**
+ * ftpm_tee_remove remove the TPM device
+ * @param: pdev, the platform_device description.
+ * @return: 0 in case of success.
+ */
+static int ftpm_tee_remove(struct platform_device *pdev)
+{
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
+
+	ftpm_tee_deinit(pvt_data);
+
+	return 0;
+}
+
+static const struct of_device_id of_ftpm_tee_ids[] = {
+	{ .compatible = "microsoft,ftpm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
+
+static struct platform_driver ftpm_tee_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
+	},
+	.probe = ftpm_tee_probe,
+	.remove = ftpm_tee_remove,
+};
+
+module_platform_driver(ftpm_tee_driver);
+
+MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
+MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
new file mode 100644
index 000000000000..c1dd416d27c9
--- /dev/null
+++ b/drivers/char/tpm/tpm_ftpm_tee.h
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation
+ */
+
+#ifndef __TPM_FTPM_TEE_H__
+#define __TPM_FTPM_TEE_H__
+
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+#include <linux/tpm.h>
+
+/* The TAFs ID implemented in this TA */
+#define FTPM_OPTEE_TA_SUBMIT_COMMAND  (0)
+#define FTPM_OPTEE_TA_EMULATE_PPI     (1)
+
+/* max. buffer size supported by fTPM  */
+#define  MAX_COMMAND_SIZE       4096
+#define  MAX_RESPONSE_SIZE      4096
+
+/**
+ * struct ftpm_tee_private - fTPM's private data
+ * @chip:     struct tpm_chip instance registered with tpm framework.
+ * @state:    internal state
+ * @session:  fTPM TA session identifier.
+ * @resp_len: cached response buffer length.
+ * @resp_buf: cached response buffer.
+ * @ctx:      TEE context handler.
+ * @shm:      Memory pool shared with fTPM TA in TEE.
+ */
+struct ftpm_tee_private {
+	struct tpm_chip *chip;
+	u32 session;
+	size_t resp_len;
+	u8 resp_buf[MAX_RESPONSE_SIZE];
+	struct tee_context *ctx;
+	struct tee_shm *shm;
+};
+
+/*
+ * Note: ftpm_tee_tpm_op_recv and ftpm_tee_tpm_op_send are called from the
+ * same routine tpm_try_transmit in tpm-interface.c. These calls are protected
+ * by chip->tpm_mutex => There is no need for protecting any data shared
+ * between these routines ex: struct ftpm_tee_private
+ */
+
+/* TA_FTPM_UUID: BC50D971-D4C9-42C4-82CB-343FB7F37896 */
+static const uuid_t ftpm_ta_uuid =
+	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
+		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
+
+#endif /* __TPM_FTPM_TEE_H__ */
-- 
2.19.1

