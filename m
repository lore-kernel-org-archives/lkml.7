Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E6C04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436152084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556974336;
	bh=//1NGHpmFF4ruGDyNiUBAO4duFir28UQ8qk3M3GuEYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZT+Jrw+7mcm+hMrCKB5zDxIidexsBIq0h2wStFAOnBnlW2RQCCWRn2m+b8Y+XItDU
	 UX77jp7h/9l3tJBqnpbTVEFEIKxAfAo/6WSIud9SmrASoUXIyL7d1n4VOjjaAXAMXq
	 +HQpVA04YHq9D29+yXbZOsT4hyStSElrqVFkyBos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfEDMwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 08:52:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfEDMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:52:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC2DB8553A;
        Sat,  4 May 2019 12:52:11 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1056E5C298;
        Sat,  4 May 2019 12:52:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/8] sysfs: Add sysfs_update_groups function
Date:   Sat,  4 May 2019 14:52:00 +0200
Message-Id: <20190504125207.24662-2-jolsa@kernel.org>
In-Reply-To: <20190504125207.24662-1-jolsa@kernel.org>
References: <20190504125207.24662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 04 May 2019 12:52:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding sysfs_update_groups function to update
multiple groups.

TODO:

I'm not sure how to handle error path in here,
currently it removes the whole updated group
together with already existing (not updated)
attributes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 fs/sysfs/group.c      | 43 ++++++++++++++++++++++++++++---------------
 include/linux/sysfs.h |  2 ++
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 57038604d4a8..8fff9673dd5f 100644
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
@@ -191,24 +211,17 @@ EXPORT_SYMBOL_GPL(sysfs_create_group);
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

