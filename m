Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A83C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13739204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To7dCAIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfCVUOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:14:44 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34998 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfCVUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:14:44 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so5351323itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=lhbKbOmtHpV/pF1JUjV1D5/KDzGY4a07jsH4EYtOhaY=;
        b=To7dCAIleFEZoS6UaisSRXnAS0gRXeUSYLWQY4tYwzzEDfnMqpen+mdTuUtRcTQwgO
         23EkKPHUN+NjlRGQnLJ2TGFaSMlNJSGVE3DVCzeL4OKJ2LYt9lWPjQloqZR3Evvgo/Sl
         bMm3KBfw6hDfu+LtHjwfuPPjvJgYEXntrT/FIjlVpZLiEEfcCkJJDG+FVKAejEwhho+n
         X49IXGeJJE2Zf5Efj7O/dL8S1KPVZKs2+1CiUUTeimRhsy0myxpbtwyTf+jvIOAVLdj+
         YJ7OTwvzjxvQlkUCOOoGuXEdtT/ZzPUvSn6mnGuBRScfIznV+O4u5I6atPojpd46VVdm
         TSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=lhbKbOmtHpV/pF1JUjV1D5/KDzGY4a07jsH4EYtOhaY=;
        b=KfBgYHWcHtzk9AQc6PNkKZVZpGv0KmTI43f1wheQpsYsicBSRpV+TuVDgTHJBIDUnl
         0J9eZiBlhtpjxfEPGuWpHxyexU5tmeDSV1rpiDDQ01+cg1lKNqE0W43f/MnSdqS9/dkv
         gGIVfiYkxB2rGMuv0kBmeFOAJNLMIIcRtXH/E1SP8egV7IqjMgXtDwQ1/p6ab4nCQ6hV
         5k/mHMtgkTfqfN4DuZcWR2UM+aeygwX3ts1ILPZju9UkiiYZoKhA+ZzAUxxLa6MSnyxK
         4hSc5aZASl3F1o8wGdDUpO4Hs39Ej+v25c33C7vsRLQGdmIXrsKP4tEQMK73Kdh3pwRT
         oQXw==
X-Gm-Message-State: APjAAAUjBElPFZR1l2BDCQZC0tUcznqHk47J7DBtbyyq0RRwn4bs8DvH
        49MI7oPGwurVFZ7loXm+EM4=
X-Google-Smtp-Source: APXvYqxFESPJ9aYBAWM2ZGsRNF1WnDFBARd22GWLOd6LpRHXnqTjJ6W79VVfU6t4nnYclEdSyhI7/A==
X-Received: by 2002:a05:660c:50:: with SMTP id p16mr2743494itk.139.1553285683152;
        Fri, 22 Mar 2019 13:14:43 -0700 (PDT)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id v10sm2154563itv.8.2019.03.22.13.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 13:14:42 -0700 (PDT)
Date:   Fri, 22 Mar 2019 16:14:40 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: Add support for default attribute groups to
 kobj_type
Message-ID: <20190322201440.GA30814@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobj_type currently uses a list of individual attributes to store
default attributes. Attribute groups are more flexible than a list of
attributes because groups provide support for attribute visibility. So,
add support for default attribute groups to kobj_type.

In future patches, the existing uses of kobj_type’s attribute list will
be converted to attribute groups. When that is complete, kobj_type’s
attribute list, “default_attrs”, will be removed.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 include/linux/kobject.h |  3 ++-
 lib/kobject.c           | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 1ab0d624fb36..e2ca0a292e21 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -139,7 +139,8 @@ static inline bool kobject_has_children(struct kobject *kobj)
 struct kobj_type {
 	void (*release)(struct kobject *kobj);
 	const struct sysfs_ops *sysfs_ops;
-	struct attribute **default_attrs;
+	struct attribute **default_attrs;	/* use default_groups instead */
+	const struct attribute_group **default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(struct kobject *kobj);
 	const void *(*namespace)(struct kobject *kobj);
 	void (*get_ownership)(struct kobject *kobj, kuid_t *uid, kgid_t *gid);
diff --git a/lib/kobject.c b/lib/kobject.c
index b72e00fd7d09..67789f34951d 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -82,6 +82,7 @@ static int populate_dir(struct kobject *kobj)
 
 static int create_dir(struct kobject *kobj)
 {
+	const struct kobj_type *ktype = get_ktype(kobj);
 	const struct kobj_ns_type_operations *ops;
 	int error;
 
@@ -95,6 +96,14 @@ static int create_dir(struct kobject *kobj)
 		return error;
 	}
 
+	if (ktype) {
+		error = sysfs_create_groups(kobj, ktype->default_groups);
+		if (error) {
+			sysfs_remove_dir(kobj);
+			return error;
+		}
+	}
+
 	/*
 	 * @kobj->sd may be deleted by an ancestor going away.  Hold an
 	 * extra reference so that it stays until @kobj is gone.
@@ -584,11 +593,16 @@ EXPORT_SYMBOL_GPL(kobject_move);
 void kobject_del(struct kobject *kobj)
 {
 	struct kernfs_node *sd;
+	const struct kobj_type *ktype = get_ktype(kobj);
 
 	if (!kobj)
 		return;
 
 	sd = kobj->sd;
+
+	if (ktype)
+		sysfs_remove_groups(kobj, ktype->default_groups);
+
 	sysfs_remove_dir(kobj);
 	sysfs_put(sd);
 
-- 
2.17.1

