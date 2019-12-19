Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21DFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E1624679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781732;
	bh=jHk6kFfOtSMEBZVCkTM11i7PAbqCtZUHn4B97YaqBsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Au1IBGyMgY6bYkV2ZF2tqkekWE54UnBCFKhATpA9mQhmVLX8LjnwSXZSHNFTSIzVh
	 v65dvaNxc/8WIa05AErhppxyWGDCQleqkfjEoqLUr28CcC85tAJhvGjMM5HoTeuqtE
	 S04NO0dNo/Ty79PGUlbzbJkxH3km9iAJ+cpfe0uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfLSSzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:55:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbfLSSz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:55:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13419222C2;
        Thu, 19 Dec 2019 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781728;
        bh=jHk6kFfOtSMEBZVCkTM11i7PAbqCtZUHn4B97YaqBsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZ9s72sdwjJ4Jlwo8B15ElMX/SdNkFSso68N3fyNB/zvG000dUEi14VWf8kFFl5p6
         VIo2Abl0YsnLr8697XT/wKjGtP/6z8DXm1Lmc29esqSfWh7Vxpfd0YV2gQWQl1xdZ7
         IuYqnv9UP9INgQ8unNgLVMH8TRSdMVFVleFoqBpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Joe Thornber <ejt@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 56/80] dm thin metadata: Add support for a pre-commit callback
Date:   Thu, 19 Dec 2019 19:34:48 +0100
Message-Id: <20191219183130.074267108@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikos Tsironis <ntsironis@arrikto.com>

commit ecda7c0280e6b3398459dc589b9a41c1adb45529 upstream.

Add support for one pre-commit callback which is run right before the
metadata are committed.

This allows the thin provisioning target to run a callback before the
metadata are committed and is required by the next commit.

Cc: stable@vger.kernel.org
Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Acked-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin-metadata.c |   29 +++++++++++++++++++++++++++++
 drivers/md/dm-thin-metadata.h |    7 +++++++
 2 files changed, 36 insertions(+)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -189,6 +189,15 @@ struct dm_pool_metadata {
 	sector_t data_block_size;
 
 	/*
+	 * Pre-commit callback.
+	 *
+	 * This allows the thin provisioning target to run a callback before
+	 * the metadata are committed.
+	 */
+	dm_pool_pre_commit_fn pre_commit_fn;
+	void *pre_commit_context;
+
+	/*
 	 * We reserve a section of the metadata for commit overhead.
 	 * All reported space does *not* include this.
 	 */
@@ -826,6 +835,14 @@ static int __commit_transaction(struct d
 	if (unlikely(!pmd->in_service))
 		return 0;
 
+	if (pmd->pre_commit_fn) {
+		r = pmd->pre_commit_fn(pmd->pre_commit_context);
+		if (r < 0) {
+			DMERR("pre-commit callback failed");
+			return r;
+		}
+	}
+
 	r = __write_changed_details(pmd);
 	if (r < 0)
 		return r;
@@ -892,6 +909,8 @@ struct dm_pool_metadata *dm_pool_metadat
 	pmd->in_service = false;
 	pmd->bdev = bdev;
 	pmd->data_block_size = data_block_size;
+	pmd->pre_commit_fn = NULL;
+	pmd->pre_commit_context = NULL;
 
 	r = __create_persistent_data_objects(pmd, format_device);
 	if (r) {
@@ -2044,6 +2063,16 @@ int dm_pool_register_metadata_threshold(
 	return r;
 }
 
+void dm_pool_register_pre_commit_callback(struct dm_pool_metadata *pmd,
+					  dm_pool_pre_commit_fn fn,
+					  void *context)
+{
+	pmd_write_lock_in_core(pmd);
+	pmd->pre_commit_fn = fn;
+	pmd->pre_commit_context = context;
+	pmd_write_unlock(pmd);
+}
+
 int dm_pool_metadata_set_needs_check(struct dm_pool_metadata *pmd)
 {
 	int r = -EINVAL;
--- a/drivers/md/dm-thin-metadata.h
+++ b/drivers/md/dm-thin-metadata.h
@@ -230,6 +230,13 @@ bool dm_pool_metadata_needs_check(struct
  */
 void dm_pool_issue_prefetches(struct dm_pool_metadata *pmd);
 
+/* Pre-commit callback */
+typedef int (*dm_pool_pre_commit_fn)(void *context);
+
+void dm_pool_register_pre_commit_callback(struct dm_pool_metadata *pmd,
+					  dm_pool_pre_commit_fn fn,
+					  void *context);
+
 /*----------------------------------------------------------------*/
 
 #endif


