Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C821C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB12261AB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tQr1wN4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfFCNZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:25:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47391 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCNZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:25:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DPMca609265
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:25:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DPMca609265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568323;
        bh=t9kr9yuCkA/zbbM94pKMBchEi7d5IG/nxbnPMLsEFz0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tQr1wN4No1IoeA/oCKmuCtTRKIDlLdzbDhhRctGRhfYD1YSnFtmasJs/GDBds1r11
         X1wSsBVKwKNxhg5NJ/zY2PN85uxB4hQklIPaQviMUyot4vkFAakK5t13d28mnIuwDJ
         lJ+HOyvAJYrmH37rqEGaoZa3v5+XCRD80lR1oId++lqpEoYV9k0allQhEbD3iqL/Io
         69hxqvLFPoIHfTYwUE+kFYDcShkzRQy7uoOgIe5wJj7nn+mhPNHb2trZgfcVLXMNvH
         GI5BubEuGNaAf+LqtNwp8kgqqfx7N5DCgmARf8R0tEb9xFnfh7hXgstIaypxWo4ybd
         NtivrkMXVINcw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DPKuP609262;
        Mon, 3 Jun 2019 06:25:20 -0700
Date:   Mon, 3 Jun 2019 06:25:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-aac1f7f95f115d5a5329be05b80022e72df7d080@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, jolsa@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, acme@kernel.org, namhyung@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          gregkh@linuxfoundation.org, namhyung@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, jolsa@kernel.org,
          acme@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190512155518.21468-2-jolsa@kernel.org>
References: <20190512155518.21468-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] sysfs: Add sysfs_update_groups function
Git-Commit-ID: aac1f7f95f115d5a5329be05b80022e72df7d080
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  aac1f7f95f115d5a5329be05b80022e72df7d080
Gitweb:     https://git.kernel.org/tip/aac1f7f95f115d5a5329be05b80022e72df7d080
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:10 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:20 +0200

sysfs: Add sysfs_update_groups function

Adding sysfs_update_groups function to update
multiple groups.

  sysfs_update_groups - given a directory kobject, create a bunch of attribute groups
  @kobj:      The kobject to update the group on
  @groups:    The attribute groups to update, NULL terminated

This function update a bunch of attribute groups.  If an error occurs when
updating a group, all previously updated groups will be removed together
with already existing (not updated) attributes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-2-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/sysfs/group.c      | 54 +++++++++++++++++++++++++++++++++++++--------------
 include/linux/sysfs.h |  8 ++++++++
 2 files changed, 47 insertions(+), 15 deletions(-)

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
index 786816cf4aa5..965236795750 100644
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
@@ -433,6 +435,12 @@ static inline int sysfs_create_groups(struct kobject *kobj,
 	return 0;
 }
 
+static inline int sysfs_update_groups(struct kobject *kobj,
+				      const struct attribute_group **groups)
+{
+	return 0;
+}
+
 static inline int sysfs_update_group(struct kobject *kobj,
 				const struct attribute_group *grp)
 {
