Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C80C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6590E21900
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139961;
	bh=PNonACxxPXri/mxrl6PiMEY5U0UiypwG6FeMrVzEPvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ToKdDRLtlL7irgXD8VEELBU+1E4MaTHTBIs1aCZyDjUwt+Bobp0gNWSEIxAOZdLhc
	 R9a29cFAcHsZyMwsXC88nse75g5saphAJXjxHTLPm2FREs4Cq4lkLwdeI4w0DusuaK
	 bQ0LvnhMDzY5mfDDQSuvZcl1Wby2Ya6Qr6fFu0NY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbfDARcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732847AbfDARcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513262070B;
        Mon,  1 Apr 2019 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139954;
        bh=PNonACxxPXri/mxrl6PiMEY5U0UiypwG6FeMrVzEPvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tUmyxHolFQydcrkMQPccSIcjkddsQ3AnChTzxI7t38OKdxFPqxxzSbjaAgFy8IETC
         unIYhWgM4E9a0eG8SbvJiGsZ30hws6ZUMLezQAxMzBETkwR4P8lc0f/Qt3Smh5yHJf
         Y/Mo37NEBqprmfHESSzhBakhVVRlhYNzdm2tI2Hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 063/131] stm class: Guard output assignment against concurrency
Date:   Mon,  1 Apr 2019 19:02:13 +0200
Message-Id: <20190401170057.530266433@linuxfoundation.org>
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

[ Upstream commit cde4ad8368840e414ecf67db258fe1dabaa5fd2e ]

It is possible to concurrently assign the same output (a character
device writer or an stm_source device) to different stm devices,
which sets off a strategically placed warning in stm_output_assign().

To avoid this, use a spinlock to serialize (un)assignments between
outputs and stm devices.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 17 +++++++++++++++++
 drivers/hwtracing/stm/stm.h  |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index d4deac108578..f8e46c38b565 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -186,6 +186,9 @@ static void stm_output_claim(struct stm_device *stm, struct stm_output *output)
 {
 	struct stp_master *master = stm_master(stm, output->master);
 
+	lockdep_assert_held(&stm->mc_lock);
+	lockdep_assert_held(&output->lock);
+
 	if (WARN_ON_ONCE(master->nr_free < output->nr_chans))
 		return;
 
@@ -200,6 +203,9 @@ stm_output_disclaim(struct stm_device *stm, struct stm_output *output)
 {
 	struct stp_master *master = stm_master(stm, output->master);
 
+	lockdep_assert_held(&stm->mc_lock);
+	lockdep_assert_held(&output->lock);
+
 	bitmap_release_region(&master->chan_map[0], output->channel,
 			      ilog2(output->nr_chans));
 
@@ -292,6 +298,7 @@ static int stm_output_assign(struct stm_device *stm, unsigned int width,
 	}
 
 	spin_lock(&stm->mc_lock);
+	spin_lock(&output->lock);
 	/* output is already assigned -- shouldn't happen */
 	if (WARN_ON_ONCE(output->nr_chans))
 		goto unlock;
@@ -308,6 +315,7 @@ static int stm_output_assign(struct stm_device *stm, unsigned int width,
 
 	ret = 0;
 unlock:
+	spin_unlock(&output->lock);
 	spin_unlock(&stm->mc_lock);
 
 	return ret;
@@ -316,11 +324,18 @@ static int stm_output_assign(struct stm_device *stm, unsigned int width,
 static void stm_output_free(struct stm_device *stm, struct stm_output *output)
 {
 	spin_lock(&stm->mc_lock);
+	spin_lock(&output->lock);
 	if (output->nr_chans)
 		stm_output_disclaim(stm, output);
+	spin_unlock(&output->lock);
 	spin_unlock(&stm->mc_lock);
 }
 
+static void stm_output_init(struct stm_output *output)
+{
+	spin_lock_init(&output->lock);
+}
+
 static int major_match(struct device *dev, const void *data)
 {
 	unsigned int major = *(unsigned int *)data;
@@ -343,6 +358,7 @@ static int stm_char_open(struct inode *inode, struct file *file)
 	if (!stmf)
 		return -ENOMEM;
 
+	stm_output_init(&stmf->output);
 	stmf->stm = to_stm_device(dev);
 
 	if (!try_module_get(stmf->stm->owner))
@@ -953,6 +969,7 @@ int stm_source_register_device(struct device *parent,
 	if (err)
 		goto err;
 
+	stm_output_init(&src->output);
 	spin_lock_init(&src->link_lock);
 	INIT_LIST_HEAD(&src->link_entry);
 	src->data = data;
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index 97ee02241440..4e8c6926260f 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -57,6 +57,7 @@ struct stm_device {
 	container_of((_d), struct stm_device, dev)
 
 struct stm_output {
+	spinlock_t		lock;
 	unsigned int		master;
 	unsigned int		channel;
 	unsigned int		nr_chans;
-- 
2.19.1



