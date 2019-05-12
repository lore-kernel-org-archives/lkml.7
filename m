Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD49C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BC62173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557676527;
	bh=FAQGgfenGMOMuQpBtQ3vYlLJwWwOBrgsBS4rSHQuDvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J6oZ2lBhSO2KSrenhpEqYyz4h7hzB4K9R2AVZp/5EZDJXpasGygkwkKN2KE32/1t+
	 r4FSp6XSKF9+XrdhB4U1sFZ4Ld6yfMNEZOwrJ/4STrztV2ipd37T5dgOUyf3Gk8pGa
	 POpIBNHpvpBYoFVNVwYtG/YKIAnG1YbOvF4lpBG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfELPzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:55:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfELPzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:55:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 581D85946B;
        Sun, 12 May 2019 15:55:24 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 577F54B6;
        Sun, 12 May 2019 15:55:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/9] sysfs: Add sysfs_update_groups function
Date:   Sun, 12 May 2019 17:55:10 +0200
Message-Id: <20190512155518.21468-2-jolsa@kernel.org>
In-Reply-To: <20190512155518.21468-1-jolsa@kernel.org>
References: <20190512155518.21468-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 12 May 2019 15:55:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding sysfs_update_groups function to update
multiple groups.

  sysfs_update_groups - given a directory kobject, create a bunch of attribute groups
  @kobj:      The kobject to update the group on
  @groups:    The attribute groups to update, NULL terminated

This function update a bunch of attribute groups.  If an error occurs when
updating a group, all previously updated groups will be removed together
with already existing (not updated) attributes.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 fs/sysfs/group.c      | 54 +++++++++++++++++++++++++++++++------------
 include/linux/sysfs.h |  2 ++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 57038604d4a8..d41c21fef138 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -175,6 +175,26 @@ int sysfs_create_group(struct kobject *kobj,
 }
 EXPORT_SYMBOL_GPL(sysfs_create_group);
 
+static int internal_create_groups(struct kobject *kobj, int update,
+				  const struct attribute_group **groups)
+{
+	int error = 0;
+	int i;
+
+	if (!groups)
+		return 0;
+
+	for (i = 0; groups[i]; i++) {
+		error = internal_create_group(kobj, update, groups[i]);
+		if (error) {
+			while (--i >= 0)
+				sysfs_remove_group(kobj, groups[i]);
+			break;
+		}
+	}
+	return error;
+}
+
 /**
  * sysfs_create_groups - given a directory kobject, create a bunch of attribute groups
  * @kobj:	The kobject to create the group on
@@ -191,24 +211,28 @@ EXPORT_SYMBOL_GPL(sysfs_create_group);
 int sysfs_create_groups(struct kobject *kobj,
 			const struct attribute_group **groups)
 {
-	int error = 0;
-	int i;
-
-	if (!groups)
-		return 0;
-
-	for (i = 0; groups[i]; i++) {
-		error = sysfs_create_group(kobj, groups[i]);
-		if (error) {
-			while (--i >= 0)
-				sysfs_remove_group(kobj, groups[i]);
-			break;
-		}
-	}
-	return error;
+	return internal_create_groups(kobj, 0, groups);
 }
 EXPORT_SYMBOL_GPL(sysfs_create_groups);
 
+/**
+ * sysfs_update_groups - given a directory kobject, create a bunch of attribute groups
+ * @kobj:	The kobject to update the group on
+ * @groups:	The attribute groups to update, NULL terminated
+ *
+ * This function update a bunch of attribute groups.  If an error occurs when
+ * updating a group, all previously updated groups will be removed together
+ * with already existing (not updated) attributes.
+ *
+ * Returns 0 on success or error code from sysfs_update_group on failure.
+ */
+int sysfs_update_groups(struct kobject *kobj,
+			const struct attribute_group **groups)
+{
+	return internal_create_groups(kobj, 1, groups);
+}
+EXPORT_SYMBOL_GPL(sysfs_update_groups);
+
 /**
  * sysfs_update_group - given a directory kobject, update an attribute group
  * @kobj:	The kobject to update the group on
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 786816cf4aa5..d13db254fb99 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -268,6 +268,8 @@ int __must_check sysfs_create_group(struct kobject *kobj,
 				    const struct attribute_group *grp);
 int __must_check sysfs_create_groups(struct kobject *kobj,
 				     const struct attribute_group **groups);
+int __must_check sysfs_update_groups(struct kobject *kobj,
+				     const struct attribute_group **groups);
 int sysfs_update_group(struct kobject *kobj,
 		       const struct attribute_group *grp);
 void sysfs_remove_group(struct kobject *kobj,
-- 
2.20.1

