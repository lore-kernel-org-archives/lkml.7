Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D3EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1218521734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E6X+aRgl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JjTv4Or/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfD3N4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:56:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3N4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:56:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FE0660247; Tue, 30 Apr 2019 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556632563;
        bh=V74Xn+4Xecuy8X76IYwMZ5DL3OaMc8SDcfUZGzNca7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=E6X+aRglJUsJVbGzBifTMnPRqeKI7HJochINZKgypPMQJwwqiTHQXXE9OGUxOMBXC
         SyGk2Jcrvg1vkWIa+Kw8K0aU8TKoAhhkLpn1vTPZzec9KUjN6A/d7Frji1u6d3s0JG
         Lr7IyX0Z2zKSbpSEGWppEI7GCkq0D2uwmnmPBOF4=
Received: from prsood-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D44360247;
        Tue, 30 Apr 2019 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556632562;
        bh=V74Xn+4Xecuy8X76IYwMZ5DL3OaMc8SDcfUZGzNca7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=JjTv4Or/8PdZiHbNn1HIJXS4YfXdaOZwWvx4MakDXa09Ye6adoak74p6FPzrzUMgO
         Zqyb62K0guI1yigEVqRzcjNXRJ2Fwjo8X9Rwt2dalh8LBoGHSCfD294htWSx3/y6YK
         Y0UZzE5bX6rxmNCjvBcypEwv0lzvByKaau/Eqjtg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D44360247
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     sramana@codeaurora.org, prsood@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: core: Remove glue dirs early only when refcount is 1
Date:   Tue, 30 Apr 2019 19:25:40 +0530
Message-Id: <1556632540-17382-1-git-send-email-prsood@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While loading firmware blobs parallely in different threads, it is possible
to free sysfs node of glue_dirs in device_del() from a thread while another
thread is trying to add subdir from device_add() in glue_dirs sysfs node.

    CPU1                                           CPU2
_request_firmware_load()
  device_add()
    get_device_parent()
      class_dir_create_and_add()
        kobject_add_internal()
          create_dir() // glue_dir

                                           _request_firmware_load()
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

