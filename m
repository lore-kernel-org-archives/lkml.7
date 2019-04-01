Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224452146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139964;
	bh=H/LZ39xYocGMnqNCEj9JxI4m1SB6vD/VOYOmtmTPPN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d6xKa1QQEMvFnOx1GsqHh43JIIRtwy+TJcn7VumPlmkbCpF3TojsVplnUuLhpca/J
	 YJib1tm6zomfsnmSKMCZk7HwmeLFa4biFFEzO8oQd80U65RgAY+uq1AmmM8QaZ4M4l
	 PsoAd54LDfeeIZyHjvAYzi3NhTM67YcM2Z83cHT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfDARcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387512AbfDARck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44FEA2070B;
        Mon,  1 Apr 2019 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139958;
        bh=H/LZ39xYocGMnqNCEj9JxI4m1SB6vD/VOYOmtmTPPN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzbODklLKSE0qK8scPFSPYb4Z5pFSgNXRqOR3LViujCxA51BsuLPQ7j2Rp3fbG7ap
         bQJucKiLGl/LS52prd5qmNE/akFQ2aWrmMIvxSfsuk5XZRxNzE87NWRJoY7BgeU8vJ
         fB8DHYKbkxSELbCYZC5IKRLeWOXlpLM/VTyHsfFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 064/131] stm class: Fix unbalanced module/device refcounting
Date:   Mon,  1 Apr 2019 19:02:14 +0200
Message-Id: <20190401170057.595258447@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f7c81c7176c72c7899390754b4b038a64b296e4d ]

STM code takes references to the stm device and its module for the
duration of the character device's existence or the stm_source link.
Dropping these references is not well balanced everywhere, which may
lead to leaks.

This patch balances the acquisition and releasing of these two
references and annotates each site so that it's easier to verify
correctness by reading the code.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index f8e46c38b565..cdc692d6cedd 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -114,6 +114,7 @@ struct stm_device *stm_find_device(const char *buf)
 
 	stm = to_stm_device(dev);
 	if (!try_module_get(stm->owner)) {
+		/* matches class_find_device() above */
 		put_device(dev);
 		return NULL;
 	}
@@ -126,7 +127,7 @@ struct stm_device *stm_find_device(const char *buf)
  * @stm:	stm device, previously acquired by stm_find_device()
  *
  * This drops the module reference and device reference taken by
- * stm_find_device().
+ * stm_find_device() or stm_char_open().
  */
 void stm_put_device(struct stm_device *stm)
 {
@@ -369,6 +370,8 @@ static int stm_char_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 
 err_free:
+	/* matches class_find_device() above */
+	put_device(dev);
 	kfree(stmf);
 
 	return err;
@@ -379,6 +382,11 @@ static int stm_char_release(struct inode *inode, struct file *file)
 	struct stm_file *stmf = file->private_data;
 
 	stm_output_free(stmf->stm, &stmf->output);
+
+	/*
+	 * matches the stm_char_open()'s
+	 * class_find_device() + try_module_get()
+	 */
 	stm_put_device(stmf->stm);
 	kfree(stmf);
 
@@ -540,10 +548,8 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 		ret = stm->data->link(stm->data, stmf->output.master,
 				      stmf->output.channel);
 
-	if (ret) {
+	if (ret)
 		stm_output_free(stmf->stm, &stmf->output);
-		stm_put_device(stmf->stm);
-	}
 
 err_free:
 	kfree(id);
@@ -680,6 +686,7 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 	return 0;
 
 err_device:
+	/* matches device_initialize() above */
 	put_device(&stm->dev);
 err_free:
 	vfree(stm);
@@ -792,7 +799,6 @@ static int stm_source_link_add(struct stm_source_device *src,
 
 fail_free_output:
 	stm_output_free(stm, &src->output);
-	stm_put_device(stm);
 
 fail_detach:
 	mutex_lock(&stm->link_mutex);
@@ -906,8 +912,10 @@ static ssize_t stm_source_link_store(struct device *dev,
 		return -EINVAL;
 
 	err = stm_source_link_add(src, link);
-	if (err)
+	if (err) {
+		/* matches the stm_find_device() above */
 		stm_put_device(link);
+	}
 
 	return err ? : count;
 }
-- 
2.19.1



