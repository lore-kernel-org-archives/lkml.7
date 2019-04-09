Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D06EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1353120880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDIH3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:29:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43548 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfDIH3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:29:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CC38C2001CA;
        Tue,  9 Apr 2019 09:29:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CA182001E8;
        Tue,  9 Apr 2019 09:29:02 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3941540318;
        Tue,  9 Apr 2019 15:28:58 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, leoyang.li@nxp.com
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [V3 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data Path DMA Interface) support
Date:   Tue,  9 Apr 2019 15:22:11 +0800
Message-Id: <20190409072212.15860-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MC exports the DPDMAI object as an interface to operate the DPAA2 QDMA
Engine. The DPDMAI enables sending frame-based requests to QDMA and receiving
back confirmation response on transaction completion, utilizing the DPAA2 QBMan
infrastructure. DPDMAI object provides up to two priorities for processing QDMA
requests.
The following list summarizes the DPDMAI main features and capabilities:
	1. Supports up to two scheduling priorities for processing service
	requests.
	- Each DPDMAI transmit queue is mapped to one of two service priorities,
	allowing further prioritization in hardware between requests from
	different DPDMAI objects.
	2. Supports up to two receive queues for incoming transaction completion
	confirmations.
	- Each DPDMAI receive queue is mapped to one of two receive priorities,
	allowing further prioritization between other interfaces when associating
	the DPDMAI receive queues to DPIO or DPCON objects.
	3. Supports different scheduling options for processing received packets:
	- Queues can be configured either in 'parked' mode (default), oattached
	to a DPIO object, or attached to DPCON object.
	4. Allows interaction with one or more DPIO objects for dequeueing/enqueueing
	frame descriptors(FD) and for acquiring/releasing buffers.
	5. Supports enable, disable, and reset operations.
Add dpdmai to support some platforms with dpaa2 qdma engine.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
changed for v3:
	- no changed 

 drivers/dma/fsl-dpaa2-qdma/dpdmai.c     |  483 ++++++++++++++++++++++++++++
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h     |  524 +++++++++++++++++++++++++++++++
 drivers/dma/fsl-dpaa2-qdma/dpdmai_cmd.h |  197 ++++++++++++
 3 files changed, 1204 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpdmai.c
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpdmai.h
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpdmai_cmd.h

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
new file mode 100644
index 0000000..685eabe
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2014-2018 NXP
+
+#include <linux/types.h>
+#include <linux/io.h>
+#include "dpdmai.h"
+#include "dpdmai_cmd.h"
+#include <linux/fsl/mc.h>
+
+struct dpdmai_cmd_open {
+	__le32 dpdmai_id;
+};
+
+struct dpdmai_rsp_get_attributes {
+	__le32 id;
+	u8 num_of_priorities;
+	u8 pad0[3];
+	__le16 major;
+	__le16 minor;
+};
+
+struct dpdmai_cmd_queue {
+	__le32 dest_id;
+	u8 priority;
+	u8 queue;
+	u8 dest_type;
+	u8 pad;
+	__le64 user_ctx;
+	union {
+		__le32 options;
+		__le32 fqid;
+	};
+};
+
+struct dpdmai_rsp_get_tx_queue {
+	__le64 pad;
+	__le32 fqid;
+};
+
+int dpdmai_open(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		int dpdmai_id,
+		u16 *token)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpdmai_cmd_open *cmd_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_OPEN,
+					  cmd_flags,
+					  0);
+
+	cmd_params = (struct dpdmai_cmd_open *)cmd.params;
+	cmd_params->dpdmai_id = cpu_to_le32(dpdmai_id);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	*token = mc_cmd_hdr_read_token(&cmd);
+	return 0;
+}
+
+int dpdmai_close(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CLOSE,
+					  cmd_flags, token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_create(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  const struct dpdmai_cfg *cfg,
+		  u16 *token)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CREATE,
+					  cmd_flags,
+					  0);
+	DPDMAI_CMD_CREATE(cmd, cfg);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	*token = MC_CMD_HDR_READ_TOKEN(cmd.header);
+
+	return 0;
+}
+
+int dpdmai_destroy(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DESTROY,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_enable(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_ENABLE,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_disable(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DISABLE,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_is_enabled(struct fsl_mc_io *mc_io,
+		      u32 cmd_flags,
+		      u16 token,
+		      int *en)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_IS_ENABLED,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_IS_ENABLED(cmd, *en);
+
+	return 0;
+}
+
+int dpdmai_reset(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_RESET,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_irq(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token,
+		   u8 irq_index,
+		   int *type,
+		   struct dpdmai_irq_cfg	*irq_cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_IRQ,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_GET_IRQ(cmd, irq_index);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_GET_IRQ(cmd, *type, irq_cfg);
+
+	return 0;
+}
+
+int dpdmai_set_irq(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token,
+		   u8 irq_index,
+		   struct dpdmai_irq_cfg *irq_cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_IRQ,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_SET_IRQ(cmd, irq_index, irq_cfg);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_irq_enable(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u8 irq_index,
+			  u8 *en)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_IRQ_ENABLE,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_GET_IRQ_ENABLE(cmd, irq_index);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_GET_IRQ_ENABLE(cmd, *en);
+
+	return 0;
+}
+
+int dpdmai_set_irq_enable(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u8 irq_index,
+			  u8 en)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_IRQ_ENABLE,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_SET_IRQ_ENABLE(cmd, irq_index, en);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_irq_mask(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 irq_index,
+			u32 *mask)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_IRQ_MASK,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_GET_IRQ_MASK(cmd, irq_index);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_GET_IRQ_MASK(cmd, *mask);
+
+	return 0;
+}
+
+int dpdmai_set_irq_mask(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 irq_index,
+			u32 mask)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_IRQ_MASK,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_SET_IRQ_MASK(cmd, irq_index, mask);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_irq_status(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u8 irq_index,
+			  u32 *status)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_IRQ_STATUS,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_GET_IRQ_STATUS(cmd, irq_index, *status);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_GET_IRQ_STATUS(cmd, *status);
+
+	return 0;
+}
+
+int dpdmai_clear_irq_status(struct fsl_mc_io *mc_io,
+			    u32 cmd_flags,
+			    u16 token,
+			    u8 irq_index,
+			    u32 status)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CLEAR_IRQ_STATUS,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_CLEAR_IRQ_STATUS(cmd, irq_index, status);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_attributes(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  struct dpdmai_attr *attr)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+	struct dpdmai_rsp_get_attributes *rsp_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_ATTR,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpdmai_rsp_get_attributes *)cmd.params;
+	attr->id = le32_to_cpu(rsp_params->id);
+	attr->version.major = le16_to_cpu(rsp_params->major);
+	attr->version.minor = le16_to_cpu(rsp_params->minor);
+	attr->num_of_priorities = rsp_params->num_of_priorities;
+
+	return 0;
+}
+
+int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 priority,
+			const struct dpdmai_rx_queue_cfg *cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpdmai_cmd_queue *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_RX_QUEUE,
+					  cmd_flags,
+					  token);
+
+	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
+	cmd_params->dest_id = cpu_to_le32(cfg->dest_cfg.dest_id);
+	cmd_params->priority = cfg->dest_cfg.priority;
+	cmd_params->queue = priority;
+	cmd_params->dest_type = cfg->dest_cfg.dest_type;
+	cmd_params->user_ctx = cpu_to_le64(cfg->user_ctx);
+	cmd_params->options = cpu_to_le32(cfg->options);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 priority, struct dpdmai_rx_queue_attr *attr)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpdmai_cmd_queue *cmd_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_RX_QUEUE,
+					  cmd_flags,
+					  token);
+
+	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
+	cmd_params->queue = priority;
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	attr->dest_cfg.dest_id = le32_to_cpu(cmd_params->dest_id);
+	attr->dest_cfg.priority = cmd_params->priority;
+	attr->dest_cfg.dest_type = cmd_params->dest_type;
+	attr->user_ctx = le64_to_cpu(cmd_params->user_ctx);
+	attr->fqid = le32_to_cpu(cmd_params->fqid);
+
+	return 0;
+}
+
+int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 priority,
+			struct dpdmai_tx_queue_attr *attr)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpdmai_cmd_queue *cmd_params;
+	struct dpdmai_rsp_get_tx_queue *rsp_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_TX_QUEUE,
+					  cmd_flags,
+					  token);
+
+	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
+	cmd_params->queue = priority;
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+
+	rsp_params = (struct dpdmai_rsp_get_tx_queue *)cmd.params;
+	attr->fqid = le32_to_cpu(rsp_params->fqid);
+
+	return 0;
+}
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
new file mode 100644
index 0000000..c8a7b7f
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
@@ -0,0 +1,524 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2014-2018 NXP */
+
+/*
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ * * Redistributions of source code must retain the above copyright
+ * notice, this list of conditions and the following disclaimer.
+ * * Redistributions in binary form must reproduce the above copyright
+ * notice, this list of conditions and the following disclaimer in the
+ * documentation and/or other materials provided with the distribution.
+ * * Neither the name of the above-listed copyright holders nor the
+ * names of any contributors may be used to endorse or promote products
+ * derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef __FSL_DPDMAI_H
+#define __FSL_DPDMAI_H
+
+struct fsl_mc_io;
+
+/* Data Path DMA Interface API
+ * Contains initialization APIs and runtime control APIs for DPDMAI
+ */
+
+/* General DPDMAI macros */
+
+/**
+ * Maximum number of Tx/Rx priorities per DPDMAI object
+ */
+#define DPDMAI_PRIO_NUM		2
+
+/**
+ * All queues considered; see dpdmai_set_rx_queue()
+ */
+#define DPDMAI_ALL_QUEUES	(u8)(-1)
+
+/**
+ * dpdmai_open() - Open a control session for the specified object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @dpdmai_id:	DPDMAI unique ID
+ * @token:	Returned token; use in subsequent API calls
+ *
+ * This function can be used to open a control session for an
+ * already created object; an object may have been declared in
+ * the DPL or by calling the dpdmai_create() function.
+ * This function returns a unique authentication token,
+ * associated with the specific object ID and the specific MC
+ * portal; this token must be used in all subsequent commands for
+ * this specific object.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_open(struct fsl_mc_io	*mc_io,
+		u32		cmd_flags,
+		int			dpdmai_id,
+		u16		*token);
+
+/**
+ * dpdmai_close() - Close the control session of the object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * After this function is called, no further operations are
+ * allowed on the object without opening a new control session.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_close(struct fsl_mc_io	*mc_io,
+		 u32		cmd_flags,
+		 u16		token);
+
+/**
+ * struct dpdmai_cfg - Structure representing DPDMAI configuration
+ * @priorities: Priorities for the DMA hardware processing; valid priorities are
+ *	configured with values 1-8; the entry following last valid entry
+ *	should be configured with 0
+ */
+struct dpdmai_cfg {
+	u8 priorities[DPDMAI_PRIO_NUM];
+};
+
+/**
+ * dpdmai_create() - Create the DPDMAI object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @cfg:	Configuration structure
+ * @token:	Returned token; use in subsequent API calls
+ *
+ * Create the DPDMAI object, allocate required resources and
+ * perform required initialization.
+ *
+ * The object can be created either by declaring it in the
+ * DPL file, or by calling this function.
+ *
+ * This function returns a unique authentication token,
+ * associated with the specific object ID and the specific MC
+ * portal; this token must be used in all subsequent calls to
+ * this specific object. For objects that are created using the
+ * DPL file, call dpdmai_open() function to get an authentication
+ * token first.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_create(struct fsl_mc_io		*mc_io,
+		  u32			cmd_flags,
+		  const struct dpdmai_cfg	*cfg,
+		  u16			*token);
+
+/**
+ * dpdmai_destroy() - Destroy the DPDMAI object and release all its resources.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * Return:	'0' on Success; error code otherwise.
+ */
+int dpdmai_destroy(struct fsl_mc_io	*mc_io,
+		   u32		cmd_flags,
+		   u16		token);
+
+/**
+ * dpdmai_enable() - Enable the DPDMAI, allow sending and receiving frames.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_enable(struct fsl_mc_io	*mc_io,
+		  u32		cmd_flags,
+		  u16		token);
+
+/**
+ * dpdmai_disable() - Disable the DPDMAI, stop sending and receiving frames.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_disable(struct fsl_mc_io	*mc_io,
+		   u32		cmd_flags,
+		   u16		token);
+
+/**
+ * dpdmai_is_enabled() - Check if the DPDMAI is enabled.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @en:		Returns '1' if object is enabled; '0' otherwise
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_is_enabled(struct fsl_mc_io	*mc_io,
+		      u32		cmd_flags,
+		      u16		token,
+		      int		*en);
+
+/**
+ * dpdmai_reset() - Reset the DPDMAI, returns the object to initial state.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_reset(struct fsl_mc_io	*mc_io,
+		 u32		cmd_flags,
+		 u16		token);
+
+/**
+ * struct dpdmai_irq_cfg - IRQ configuration
+ * @addr:	Address that must be written to signal a message-based interrupt
+ * @val:	Value to write into irq_addr address
+ * @irq_num: A user defined number associated with this IRQ
+ */
+struct dpdmai_irq_cfg {
+	u64	addr;
+	u32	val;
+	int		irq_num;
+};
+
+/**
+ * dpdmai_set_irq() - Set IRQ information for the DPDMAI to trigger
+ * an interrupt.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @irq_index:	Identifies the interrupt index to configure
+ * @irq_cfg:	IRQ configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_set_irq(struct fsl_mc_io		*mc_io,
+		   u32			cmd_flags,
+		   u16			token,
+		   u8			irq_index,
+		   struct dpdmai_irq_cfg	*irq_cfg);
+
+/**
+ * dpdmai_get_irq() - Get IRQ information from the DPDMAI
+ *
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @type:	Interrupt type: 0 represents message interrupt
+ *		type (both irq_addr and irq_val are valid)
+ * @irq_cfg:	IRQ attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_irq(struct fsl_mc_io		*mc_io,
+		   u32			cmd_flags,
+		   u16			token,
+		   u8			irq_index,
+		   int				*type,
+		   struct dpdmai_irq_cfg	*irq_cfg);
+
+/**
+ * dpdmai_set_irq_enable() - Set overall interrupt state.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @en:			Interrupt state - enable = 1, disable = 0
+ *
+ * Allows GPP software to control when interrupts are generated.
+ * Each interrupt can have up to 32 causes.  The enable/disable control's the
+ * overall interrupt state. if the interrupt is disabled no causes will cause
+ * an interrupt
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_set_irq_enable(struct fsl_mc_io	*mc_io,
+			  u32		cmd_flags,
+			  u16		token,
+			  u8		irq_index,
+			  u8		en);
+
+/**
+ * dpdmai_get_irq_enable() - Get overall interrupt state
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @en:			Returned Interrupt state - enable = 1, disable = 0
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_irq_enable(struct fsl_mc_io	*mc_io,
+			  u32		cmd_flags,
+			  u16		token,
+			  u8		irq_index,
+			  u8		*en);
+
+/**
+ * dpdmai_set_irq_mask() - Set interrupt mask.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @mask:		event mask to trigger interrupt;
+ *				each bit:
+ *					0 = ignore event
+ *					1 = consider event for asserting IRQ
+ *
+ * Every interrupt can have up to 32 causes and the interrupt model supports
+ * masking/unmasking each cause independently
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_set_irq_mask(struct fsl_mc_io	*mc_io,
+			u32		cmd_flags,
+			u16		token,
+			u8		irq_index,
+			u32		mask);
+
+/**
+ * dpdmai_get_irq_mask() - Get interrupt mask.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @mask:		Returned event mask to trigger interrupt
+ *
+ * Every interrupt can have up to 32 causes and the interrupt model supports
+ * masking/unmasking each cause independently
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_irq_mask(struct fsl_mc_io	*mc_io,
+			u32		cmd_flags,
+			u16		token,
+			u8		irq_index,
+			u32		*mask);
+
+/**
+ * dpdmai_get_irq_status() - Get the current status of any pending interrupts
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @status:		Returned interrupts status - one bit per cause:
+ *					0 = no interrupt pending
+ *					1 = interrupt pending
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_irq_status(struct fsl_mc_io	*mc_io,
+			  u32		cmd_flags,
+			  u16		token,
+			  u8		irq_index,
+			  u32		*status);
+
+/**
+ * dpdmai_clear_irq_status() - Clear a pending interrupt's status
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @status:	bits to clear (W1C) - one bit per cause:
+ *			0 = don't change
+ *			1 = clear status bit
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_clear_irq_status(struct fsl_mc_io	*mc_io,
+			    u32		cmd_flags,
+			    u16		token,
+			    u8		irq_index,
+			    u32		status);
+
+/**
+ * struct dpdmai_attr - Structure representing DPDMAI attributes
+ * @id: DPDMAI object ID
+ * @version: DPDMAI version
+ * @num_of_priorities: number of priorities
+ */
+struct dpdmai_attr {
+	int	id;
+	/**
+	 * struct version - DPDMAI version
+	 * @major: DPDMAI major version
+	 * @minor: DPDMAI minor version
+	 */
+	struct {
+		u16 major;
+		u16 minor;
+	} version;
+	u8 num_of_priorities;
+};
+
+/**
+ * dpdmai_get_attributes() - Retrieve DPDMAI attributes.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @attr:	Returned object's attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_attributes(struct fsl_mc_io	*mc_io,
+			  u32		cmd_flags,
+			  u16		token,
+			  struct dpdmai_attr	*attr);
+
+/**
+ * enum dpdmai_dest - DPDMAI destination types
+ * @DPDMAI_DEST_NONE: Unassigned destination; The queue is set in parked mode
+ *	and does not generate FQDAN notifications; user is expected to dequeue
+ *	from the queue based on polling or other user-defined method
+ * @DPDMAI_DEST_DPIO: The queue is set in schedule mode and generates FQDAN
+ *	notifications to the specified DPIO; user is expected to dequeue
+ *	from the queue only after notification is received
+ * @DPDMAI_DEST_DPCON: The queue is set in schedule mode and does not generate
+ *	FQDAN notifications, but is connected to the specified DPCON object;
+ *	user is expected to dequeue from the DPCON channel
+ */
+enum dpdmai_dest {
+	DPDMAI_DEST_NONE = 0,
+	DPDMAI_DEST_DPIO = 1,
+	DPDMAI_DEST_DPCON = 2
+};
+
+/**
+ * struct dpdmai_dest_cfg - Structure representing DPDMAI destination parameters
+ * @dest_type: Destination type
+ * @dest_id: Either DPIO ID or DPCON ID, depending on the destination type
+ * @priority: Priority selection within the DPIO or DPCON channel; valid values
+ *	are 0-1 or 0-7, depending on the number of priorities in that
+ *	channel; not relevant for 'DPDMAI_DEST_NONE' option
+ */
+struct dpdmai_dest_cfg {
+	enum dpdmai_dest	dest_type;
+	int			dest_id;
+	u8		priority;
+};
+
+/* DPDMAI queue modification options */
+
+/**
+ * Select to modify the user's context associated with the queue
+ */
+#define DPDMAI_QUEUE_OPT_USER_CTX	0x00000001
+
+/**
+ * Select to modify the queue's destination
+ */
+#define DPDMAI_QUEUE_OPT_DEST		0x00000002
+
+/**
+ * struct dpdmai_rx_queue_cfg - DPDMAI RX queue configuration
+ * @options: Flags representing the suggested modifications to the queue;
+ *	Use any combination of 'DPDMAI_QUEUE_OPT_<X>' flags
+ * @user_ctx: User context value provided in the frame descriptor of each
+ *	dequeued frame;
+ *	valid only if 'DPDMAI_QUEUE_OPT_USER_CTX' is contained in 'options'
+ * @dest_cfg: Queue destination parameters;
+ *	valid only if 'DPDMAI_QUEUE_OPT_DEST' is contained in 'options'
+ */
+struct dpdmai_rx_queue_cfg {
+	u32		options;
+	u64		user_ctx;
+	struct dpdmai_dest_cfg	dest_cfg;
+
+};
+
+/**
+ * dpdmai_set_rx_queue() - Set Rx queue configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @priority:	Select the queue relative to number of
+ *			priorities configured at DPDMAI creation; use
+ *			DPDMAI_ALL_QUEUES to configure all Rx queues
+ *			identically.
+ * @cfg:	Rx queue configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_set_rx_queue(struct fsl_mc_io			*mc_io,
+			u32				cmd_flags,
+			u16				token,
+			u8					priority,
+			const struct dpdmai_rx_queue_cfg	*cfg);
+
+/**
+ * struct dpdmai_rx_queue_attr - Structure representing attributes of Rx queues
+ * @user_ctx:  User context value provided in the frame descriptor of each
+ *	 dequeued frame
+ * @dest_cfg: Queue destination configuration
+ * @fqid: Virtual FQID value to be used for dequeue operations
+ */
+struct dpdmai_rx_queue_attr {
+	u64		user_ctx;
+	struct dpdmai_dest_cfg	dest_cfg;
+	u32		fqid;
+};
+
+/**
+ * dpdmai_get_rx_queue() - Retrieve Rx queue attributes.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @priority:	Select the queue relative to number of
+ *				priorities configured at DPDMAI creation
+ * @attr:	Returned Rx queue attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_rx_queue(struct fsl_mc_io		*mc_io,
+			u32			cmd_flags,
+			u16			token,
+			u8				priority,
+			struct dpdmai_rx_queue_attr	*attr);
+
+/**
+ * struct dpdmai_tx_queue_attr - Structure representing attributes of Tx queues
+ * @fqid: Virtual FQID to be used for sending frames to DMA hardware
+ */
+
+struct dpdmai_tx_queue_attr {
+	u32 fqid;
+};
+
+/**
+ * dpdmai_get_tx_queue() - Retrieve Tx queue attributes.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @priority:	Select the queue relative to number of
+ *			priorities configured at DPDMAI creation
+ * @attr:	Returned Tx queue attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_tx_queue(struct fsl_mc_io		*mc_io,
+			u32			cmd_flags,
+			u16			token,
+			u8				priority,
+			struct dpdmai_tx_queue_attr	*attr);
+
+#endif /* __FSL_DPDMAI_H */
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai_cmd.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai_cmd.h
new file mode 100644
index 0000000..071a1a7
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai_cmd.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2014-2018 NXP */
+
+#ifndef _FSL_DPDMAI_CMD_H
+#define _FSL_DPDMAI_CMD_H
+
+/* DPDMAI Version */
+#define DPDMAI_VER_MAJOR		2
+#define DPDMAI_VER_MINOR		2
+
+#define DPDMAI_CMD_BASE_VERSION		0
+#define DPDMAI_CMD_ID_OFFSET		4
+
+#define DPDMAI_CMDID_FORMAT(x)		(((x) << DPDMAI_CMD_ID_OFFSET) | \
+					DPDMAI_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPDMAI_CMDID_CLOSE		DPDMAI_CMDID_FORMAT(0x800)
+#define DPDMAI_CMDID_OPEN               DPDMAI_CMDID_FORMAT(0x80E)
+#define DPDMAI_CMDID_CREATE             DPDMAI_CMDID_FORMAT(0x90E)
+#define DPDMAI_CMDID_DESTROY            DPDMAI_CMDID_FORMAT(0x900)
+
+#define DPDMAI_CMDID_ENABLE             DPDMAI_CMDID_FORMAT(0x002)
+#define DPDMAI_CMDID_DISABLE            DPDMAI_CMDID_FORMAT(0x003)
+#define DPDMAI_CMDID_GET_ATTR           DPDMAI_CMDID_FORMAT(0x004)
+#define DPDMAI_CMDID_RESET              DPDMAI_CMDID_FORMAT(0x005)
+#define DPDMAI_CMDID_IS_ENABLED         DPDMAI_CMDID_FORMAT(0x006)
+
+#define DPDMAI_CMDID_SET_IRQ            DPDMAI_CMDID_FORMAT(0x010)
+#define DPDMAI_CMDID_GET_IRQ            DPDMAI_CMDID_FORMAT(0x011)
+#define DPDMAI_CMDID_SET_IRQ_ENABLE     DPDMAI_CMDID_FORMAT(0x012)
+#define DPDMAI_CMDID_GET_IRQ_ENABLE     DPDMAI_CMDID_FORMAT(0x013)
+#define DPDMAI_CMDID_SET_IRQ_MASK       DPDMAI_CMDID_FORMAT(0x014)
+#define DPDMAI_CMDID_GET_IRQ_MASK       DPDMAI_CMDID_FORMAT(0x015)
+#define DPDMAI_CMDID_GET_IRQ_STATUS     DPDMAI_CMDID_FORMAT(0x016)
+#define DPDMAI_CMDID_CLEAR_IRQ_STATUS	DPDMAI_CMDID_FORMAT(0x017)
+
+#define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMDID_FORMAT(0x1A0)
+#define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A1)
+#define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A2)
+
+#define MC_CMD_HDR_TOKEN_O 32  /* Token field offset */
+#define MC_CMD_HDR_TOKEN_S 16  /* Token field size */
+
+#define MAKE_UMASK64(_width) \
+	((u64)((_width) < 64 ? ((u64)1 << (_width)) - 1 : \
+	(u64)-1)) \
+
+static inline u64 mc_enc(int lsoffset, int width, u64 val)
+{
+	return (u64)(((u64)val & MAKE_UMASK64(width)) << lsoffset);
+}
+
+static inline u64 mc_dec(u64 val, int lsoffset, int width)
+{
+	return (u64)((val >> lsoffset) & MAKE_UMASK64(width));
+}
+
+#define MC_CMD_OP(_cmd, _param, _offset, _width, _type, _arg) \
+	((_cmd).params[_param] |= mc_enc((_offset), (_width), _arg))
+
+#define MC_RSP_OP(_cmd, _param, _offset, _width, _type, _arg) \
+	(_arg = (_type)mc_dec(_cmd.params[_param], (_offset), (_width)))
+
+#define MC_CMD_HDR_READ_TOKEN(_hdr) \
+	((u16)mc_dec((_hdr), MC_CMD_HDR_TOKEN_O, MC_CMD_HDR_TOKEN_S))
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_OPEN(cmd, dpdmai_id) \
+	MC_CMD_OP(cmd, 0, 0,  32, int,      dpdmai_id)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_CREATE(cmd, cfg) \
+do { \
+	MC_CMD_OP(cmd, 0, 8,  8,  u8,  (cfg)->priorities[0]);\
+	MC_CMD_OP(cmd, 0, 16, 8,  u8,  (cfg)->priorities[1]);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_IS_ENABLED(cmd, en) \
+	MC_RSP_OP(cmd, 0, 0,  1,  int,	    en)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_SET_IRQ(cmd, irq_index, irq_cfg) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  8,  u8,  irq_index);\
+	MC_CMD_OP(cmd, 0, 32, 32, u32, irq_cfg->val);\
+	MC_CMD_OP(cmd, 1, 0,  64, u64, irq_cfg->addr);\
+	MC_CMD_OP(cmd, 2, 0,  32, int,	    irq_cfg->irq_num); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_IRQ(cmd, irq_index) \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_IRQ(cmd, type, irq_cfg) \
+do { \
+	MC_RSP_OP(cmd, 0, 0,  32, u32, irq_cfg->val); \
+	MC_RSP_OP(cmd, 1, 0,  64, u64, irq_cfg->addr);\
+	MC_RSP_OP(cmd, 2, 0,  32, int,	    irq_cfg->irq_num); \
+	MC_RSP_OP(cmd, 2, 32, 32, int,	    type); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_SET_IRQ_ENABLE(cmd, irq_index, enable_state) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  8,  u8,  enable_state); \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_IRQ_ENABLE(cmd, irq_index) \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_IRQ_ENABLE(cmd, enable_state) \
+	MC_RSP_OP(cmd, 0, 0,  8,  u8,  enable_state)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_SET_IRQ_MASK(cmd, irq_index, mask) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  32, u32, mask); \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_IRQ_MASK(cmd, irq_index) \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_IRQ_MASK(cmd, mask) \
+	MC_RSP_OP(cmd, 0, 0,  32, u32, mask)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_IRQ_STATUS(cmd, irq_index, status) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  32, u32, status);\
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_IRQ_STATUS(cmd, status) \
+	MC_RSP_OP(cmd, 0, 0,  32, u32,  status)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_CLEAR_IRQ_STATUS(cmd, irq_index, status) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  32, u32, status); \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_ATTR(cmd, attr) \
+do { \
+	MC_RSP_OP(cmd, 0, 0,  32, int,	(attr)->id); \
+	MC_RSP_OP(cmd, 0, 32,  8,  u8,	(attr)->num_of_priorities); \
+	MC_RSP_OP(cmd, 1, 0,  16, u16,	(attr)->version.major);\
+	MC_RSP_OP(cmd, 1, 16, 16, u16,	(attr)->version.minor);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_SET_RX_QUEUE(cmd, priority, cfg) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  32, int,	(cfg)->dest_cfg.dest_id); \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,	(cfg)->dest_cfg.priority); \
+	MC_CMD_OP(cmd, 0, 40, 8,  u8,	priority); \
+	MC_CMD_OP(cmd, 0, 48, 4,  enum dpdmai_dest, \
+			(cfg)->dest_cfg.dest_type); \
+	MC_CMD_OP(cmd, 1, 0,  64, u64,	(cfg)->user_ctx); \
+	MC_CMD_OP(cmd, 2, 0,  32, u32,	(cfg)->options);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_RX_QUEUE(cmd, priority) \
+	MC_CMD_OP(cmd, 0, 40, 8,  u8,  priority)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_RX_QUEUE(cmd, attr) \
+do { \
+	MC_RSP_OP(cmd, 0, 0,  32, int,	(attr)->dest_cfg.dest_id);\
+	MC_RSP_OP(cmd, 0, 32, 8,  u8,	(attr)->dest_cfg.priority);\
+	MC_RSP_OP(cmd, 0, 48, 4,  enum dpdmai_dest, \
+			(attr)->dest_cfg.dest_type);\
+	MC_RSP_OP(cmd, 1, 0,  64, u64,  (attr)->user_ctx);\
+	MC_RSP_OP(cmd, 2, 0,  32, u32,  (attr)->fqid);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_TX_QUEUE(cmd, priority) \
+	MC_CMD_OP(cmd, 0, 40, 8,  u8,  priority)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_TX_QUEUE(cmd, attr) \
+	MC_RSP_OP(cmd, 1, 0,  32, u32,  (attr)->fqid)
+
+#endif /* _FSL_DPDMAI_CMD_H */
-- 
1.7.1

