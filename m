Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C6DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B29E22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="POs2PF0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfGZLNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:13:08 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:39820 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGZLNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:13:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id F1DCB27F72CA;
        Fri, 26 Jul 2019 13:13:06 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JqJjdZHQZdj5; Fri, 26 Jul 2019 13:12:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 0883A27F72C9;
        Fri, 26 Jul 2019 13:12:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 0883A27F72C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1564139579;
        bh=Bj5HRa3sifxOkkPcOfbSK4if2+V+DuYidb3uYI8U2BI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=POs2PF0mPKFwyyL/qe5U3TPFIPNCKpOHLCRE+WWveHVrX6MCk6qhN+yWU62IpSPUy
         8N9Qu9y8sqtSQAFKV0wiSFg7ZmSHhVu2GoXuSQ2xpVEDHy/iXuvMFnr78DcXE3kLmX
         vMLqpnSzEMoRMGqABUhCjThaX3rVZ5bBkz9WYGMA=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qpea2s4p4ha8; Fri, 26 Jul 2019 13:12:58 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id E4E5D27EA079;
        Fri, 26 Jul 2019 13:12:58 +0200 (CEST)
Date:   Fri, 26 Jul 2019 13:12:58 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <1650083683.43071998.1564139578872.JavaMail.zimbra@kalray.eu>
Subject: [PATCH] nvme: allow 64-bit results in passthru commands
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Index: 4NjlYkYesgt9TrvRxAPb6DQR1Krwnw==
Thread-Topic: nvme: allow 64-bit results in passthru commands
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to get 64-bit results from the passthru commands,
what prevents from getting for the Capabilities (CAP) property value.

This issue has been already discussed [1], but without a solution.

This patch solves the problem by adding new ioctls with a new
passthru structure, including 64-bit results. The older ioctls stay
unchanged.

[1] http://lists.infradead.org/pipermail/linux-nvme/2018-June/018791.html

Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
---
 drivers/nvme/host/core.c        | 98 ++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/nvme_ioctl.h | 23 ++++++++++
 2 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc09b81..c77d7ea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -849,7 +849,7 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, u32 *result, unsigned timeout)
+		u32 meta_seed, u64 *result, unsigned timeout)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -890,7 +890,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	else
 		ret = nvme_req(req)->status;
 	if (result)
-		*result = le32_to_cpu(nvme_req(req)->result.u32);
+		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (meta && !ret && !write) {
 		if (copy_to_user(meta_buffer, meta, meta_len))
 			ret = -EFAULT;
@@ -1324,13 +1324,61 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 		nvme_queue_scan(ctrl);
 }
 
-static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
+static int nvme_user_cmd32(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			   struct nvme_passthru_cmd __user *ucmd)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
 	u32 effects;
+	u64 result;
+	int status;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
+		return -EFAULT;
+	if (cmd.flags)
+		return -EINVAL;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = cmd.opcode;
+	c.common.flags = cmd.flags;
+	c.common.nsid = cpu_to_le32(cmd.nsid);
+	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
+	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
+	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
+	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
+	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
+	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
+	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
+	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
+
+	if (cmd.timeout_ms)
+		timeout = msecs_to_jiffies(cmd.timeout_ms);
+
+	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
+	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
+			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
+			(void __user *)(uintptr_t)cmd.metadata,
+			cmd.metadata_len, 0, &result, timeout);
+	nvme_passthru_end(ctrl, effects);
+
+	if (status >= 0) {
+		if (put_user(result, &ucmd->result))
+			return -EFAULT;
+	}
+
+	return status;
+}
+
+static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			   struct nvme_passthru_cmd64 __user *ucmd)
+{
+	struct nvme_passthru_cmd64 cmd;
+	struct nvme_command c;
+	unsigned timeout = 0;
+	u32 effects;
 	int status;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1371,6 +1419,16 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
+static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			void __user *argp, unsigned int cmd)
+{
+	if (cmd == NVME_IOCTL_ADMIN_CMD)
+		return nvme_user_cmd32(ctrl, ns, argp);
+	else if (cmd == NVME_IOCTL_ADMIN64_CMD)
+		return nvme_user_cmd64(ctrl, ns, argp);
+	return -EINVAL;
+}
+
 /*
  * Issue ioctl requests on the first available path.  Note that unlike normal
  * block layer requests we will not retry failed request on another controller.
@@ -1401,6 +1459,13 @@ static void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
 		srcu_read_unlock(&head->srcu, idx);
 }
 
+static bool is_admin_cmd(unsigned int cmd)
+{
+	if ((cmd == NVME_IOCTL_ADMIN_CMD) || (cmd == NVME_IOCTL_ADMIN64_CMD))
+		return true;
+	return false;
+}
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -1418,14 +1483,14 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	 * seperately and drop the ns SRCU reference early.  This avoids a
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
-	if (cmd == NVME_IOCTL_ADMIN_CMD || is_sed_ioctl(cmd)) {
+	if (is_admin_cmd(cmd) || is_sed_ioctl(cmd)) {
 		struct nvme_ctrl *ctrl = ns->ctrl;
 
 		nvme_get_ctrl(ns->ctrl);
 		nvme_put_ns_from_disk(head, srcu_idx);
 
-		if (cmd == NVME_IOCTL_ADMIN_CMD)
-			ret = nvme_user_cmd(ctrl, NULL, argp);
+		if (is_admin_cmd(cmd))
+			ret = nvme_user_cmd(ctrl, NULL, argp, cmd);
 		else
 			ret = sed_ioctl(ctrl->opal_dev, cmd, argp);
 
@@ -1439,11 +1504,14 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		ret = ns->head->ns_id;
 		break;
 	case NVME_IOCTL_IO_CMD:
-		ret = nvme_user_cmd(ns->ctrl, ns, argp);
+		ret = nvme_user_cmd32(ns->ctrl, ns, argp);
 		break;
 	case NVME_IOCTL_SUBMIT_IO:
 		ret = nvme_submit_io(ns, argp);
 		break;
+	case NVME_IOCTL_IO64_CMD:
+		ret = nvme_user_cmd64(ns->ctrl, ns, argp);
+		break;
 	default:
 		if (ns->ndev)
 			ret = nvme_nvm_ioctl(ns, cmd, arg);
@@ -2754,7 +2822,8 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
+			     unsigned int cmd)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -2778,7 +2847,10 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp);
+	if (cmd == NVME_IOCTL_IO_CMD)
+		ret = nvme_user_cmd32(ctrl, ns, argp);
+	else
+		ret = nvme_user_cmd64(ctrl, ns, argp);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -2795,9 +2867,11 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
+	case NVME_IOCTL_ADMIN64_CMD:
+		return nvme_user_cmd(ctrl, NULL, argp, cmd);
 	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp);
+	case NVME_IOCTL_IO64_CMD:
+		return nvme_dev_user_cmd(ctrl, argp, cmd);
 	case NVME_IOCTL_RESET:
 		dev_warn(ctrl->device, "resetting controller\n");
 		return nvme_reset_ctrl_sync(ctrl);
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 1c215ea..e168dc5 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -45,6 +45,27 @@ struct nvme_passthru_cmd {
 	__u32	result;
 };
 
+struct nvme_passthru_cmd64 {
+	__u8	opcode;
+	__u8	flags;
+	__u16	rsvd1;
+	__u32	nsid;
+	__u32	cdw2;
+	__u32	cdw3;
+	__u64	metadata;
+	__u64	addr;
+	__u32	metadata_len;
+	__u32	data_len;
+	__u32	cdw10;
+	__u32	cdw11;
+	__u32	cdw12;
+	__u32	cdw13;
+	__u32	cdw14;
+	__u32	cdw15;
+	__u32	timeout_ms;
+	__u64	result;
+};
+
 #define nvme_admin_cmd nvme_passthru_cmd
 
 #define NVME_IOCTL_ID		_IO('N', 0x40)
@@ -54,5 +75,7 @@ struct nvme_passthru_cmd {
 #define NVME_IOCTL_RESET	_IO('N', 0x44)
 #define NVME_IOCTL_SUBSYS_RESET	_IO('N', 0x45)
 #define NVME_IOCTL_RESCAN	_IO('N', 0x46)
+#define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
1.8.3.1

