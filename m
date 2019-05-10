Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9163DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DEA2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IdUEGaJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEJPDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:03:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:19200 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727402AbfEJPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:03:20 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AErj2U004972;
        Fri, 10 May 2019 17:03:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=g2r1PYprYm0q7r69H59lG9W4hLpzhwRj6BRor0lcTYE=;
 b=IdUEGaJqYsICsGxEYfIkHvelTV9PxamE7CYGCbTmf5gtnTnV1OX86aM2Wn2618V4znAx
 LjEQ1cnVSRFS6DcRgCSAaFsIk9VzaT/kO4QZ6x61YeH3TVE2hDhiyP6CfYt9e9baKIBx
 MJ6y1yhuHI7aZrlR4fwzjRHwbt1lkSCKLchiupWv15/Ma5tIv4P/0hg5kbn+x4b41/PK
 UwPjaFc39pkk6SdmYypVTgZlkYkA0PD1EInUJQCBwcOA5Nj5MY63iIpzj9w3wejt/3xb
 EYffdbPdjMdKu8jOO2D/xU9e+AmqONWqndW5qMLvjS9rUsGj5+SMflCY+3qcewPziMw5 Ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sc9s4k49p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 17:03:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 511A131;
        Fri, 10 May 2019 15:03:08 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C7C92AB8;
        Fri, 10 May 2019 15:03:08 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May
 2019 17:03:08 +0200
Received: from localhost (10.48.0.131) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May 2019 17:03:07 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     <arnaud.pouliquen@st.com>, Fabien DESSENNE <fabien.dessenne@st.com>
Subject: [PATCH v2 1/2] rpmsg: core: add possibility to get message payload length
Date:   Fri, 10 May 2019 17:02:56 +0200
Message-ID: <1557500577-22366-2-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
References: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the rpmsg buffer payload size for sending message, so rpmsg users
can split a long message in several sub rpmsg buffers.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/rpmsg/rpmsg_core.c       | 20 ++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h   |  2 ++
 drivers/rpmsg/virtio_rpmsg_bus.c | 11 +++++++++++
 include/linux/rpmsg.h            | 10 ++++++++++
 4 files changed, 43 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 8122807db380..75c8c403ffe5 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -283,6 +283,26 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 }
 EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
+/**
+ * rpmsg_get_buf_payload_size()
+ * This function returns buffer payload size available for sending messages.
+ *
+ * @ept: the rpmsg endpoint
+ *
+ * Returns buffer payload size on success and an appropriate error value on
+ * failure.
+ */
+int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->get_buf_payload_size)
+		return -ENXIO;
+
+	return ept->ops->get_buf_payload_size(ept);
+}
+EXPORT_SYMBOL(rpmsg_get_buf_payload_size);
+
 /*
  * match an rpmsg channel with a channel info struct.
  * this is used to make sure we're not creating rpmsg devices for channels
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 0d791c30b7ea..6f733a556139 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -46,6 +46,7 @@ struct rpmsg_device_ops {
  * @trysend:		see @rpmsg_trysend(), required
  * @trysendto:		see @rpmsg_trysendto(), optional
  * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
+ * @get_buf_payload_size: see @rpmsg_get_buf_payload_size(), optional
  *
  * Indirection table for the operations that a rpmsg backend should implement.
  * In addition to @destroy_ept, the backend must at least implement @send and
@@ -65,6 +66,7 @@ struct rpmsg_endpoint_ops {
 			     void *data, int len);
 	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
 			     poll_table *wait);
+	int (*get_buf_payload_size)(struct rpmsg_endpoint *ept);
 };
 
 int rpmsg_register_device(struct rpmsg_device *rpdev);
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 5d3685bd76a2..82753e76e377 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -175,6 +175,7 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
 				  int len, u32 dst);
 static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 					   u32 dst, void *data, int len);
+static int virtio_get_buf_payload_size(struct rpmsg_endpoint *ept);
 
 static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.destroy_ept = virtio_rpmsg_destroy_ept,
@@ -184,6 +185,7 @@ static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
 	.trysend = virtio_rpmsg_trysend,
 	.trysendto = virtio_rpmsg_trysendto,
 	.trysend_offchannel = virtio_rpmsg_trysend_offchannel,
+	.get_buf_payload_size = virtio_get_buf_payload_size,
 };
 
 /**
@@ -699,6 +701,15 @@ static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
 	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
 }
 
+static int virtio_get_buf_payload_size(struct rpmsg_endpoint *ept)
+{
+	struct rpmsg_device *rpdev = ept->rpdev;
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	int size = vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
+
+	return size < 0 ? -EMSGSIZE : size;
+}
+
 static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 			     struct rpmsg_hdr *msg, unsigned int len)
 {
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d1c018..250df2165086 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -135,6 +135,8 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 			poll_table *wait);
 
+int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept);
+
 #else
 
 static inline int register_rpmsg_device(struct rpmsg_device *dev)
@@ -242,6 +244,14 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
 	return 0;
 }
 
+static int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+
 #endif /* IS_ENABLED(CONFIG_RPMSG) */
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
-- 
2.7.4

