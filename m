Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8AC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 12:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEE121670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 12:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AvZHXP3d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A6ohC+RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEAMAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 08:00:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfEAMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 08:00:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51EDE6090F; Wed,  1 May 2019 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556712012;
        bh=9rtvZnnz1whlALLucRxf79SHTv6CCJrhXnJEzAtE3+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvZHXP3dipofRkwuHPfMA6dGubTH1LGIDWoqPUF5lRechhCahm989QFC9bdE2zJvF
         9z73DVxmds4QLGhnIvORlI8Q627787VCQvVxKh4Eapf2ay+0YtWikuJpDao7TNexaH
         yQxPWLOdc25hEmheL3nSDuMsyAEP8oe7ECVXK+qI=
Received: from prsood-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0AF2E60863;
        Wed,  1 May 2019 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556712011;
        bh=9rtvZnnz1whlALLucRxf79SHTv6CCJrhXnJEzAtE3+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6ohC+RUAFeMno2zutZ2eD13JHfJbxe+GzFW3Cy0yyB2sUNFRyrs7/T/wTUfDG7BL
         Mzeb70n0v4dgtiCwrhf1XKRBdHY1YuU240F6Ga+2hFNDW4mUEG0rDgnhugQacV36cK
         fvDOyVSS+e5fkFgXhGbxbdgsB41EwCJD7AVb4rEo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AF2E60863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     sramana@codeaurora.org, prsood@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] drivers: core: Remove glue dirs early only when refcount is 1
Date:   Wed,  1 May 2019 17:29:59 +0530
Message-Id: <1556711999-16898-1-git-send-email-prsood@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20190501065313.GA30616@kroah.com>
References: <20190501065313.GA30616@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While loading firmware blobs parallely in different threads, it is possible
to free sysfs node of glue_dirs in device_del() from a thread while another
thread is trying to add subdir from device_add() in glue_dirs sysfs node.

    CPU1                                           CPU2
fw_load_sysfs_fallback()
  device_add()
    get_device_parent()
      class_dir_create_and_add()
        kobject_add_internal()
          create_dir() // glue_dir

                                           fw_load_sysfs_fallback()
                                             device_add()
                                               get_device_parent()
                                                 kobject_get() //glue_dir

  device_del()
    cleanup_glue_dir()
      kobject_del()

                                               kobject_add()
                                                 kobject_add_internal()
                                                   create_dir() // in glue_dir
                                                     kernfs_create_dir_ns()

       sysfs_remove_dir() //glue_dir->sd=NULL
       sysfs_put() // free glue_dir->sd

                                                       kernfs_new_node()
                                                         kernfs_get(glue_dir)

Fix this race by making sure that kernfs_node for glue_dir is released only
when refcount for glue_dir kobj is 1.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>

---

Changes from v2->v3:
 - Added patch version change related comments.

Changes from v1->v2:
 - Updated callstack from _request_firmware_load() to fw_load_sysfs_fallback().


 drivers/base/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c..3955d07 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1820,12 +1820,15 @@ static inline struct kobject *get_glue_dir(struct device *dev)
  */
 static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 {
+	unsigned int refcount;
+
 	/* see if we live in a "glue" directory */
 	if (!live_in_glue_dir(glue_dir, dev))
 		return;
 
 	mutex_lock(&gdp_mutex);
-	if (!kobject_has_children(glue_dir))
+	refcount = kref_read(&glue_dir->kref);
+	if (!kobject_has_children(glue_dir) && !--refcount)
 		kobject_del(glue_dir);
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

