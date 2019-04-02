Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BF72070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2yI100D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfDBCvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:51:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56310 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:51:22 -0400
Received: by mail-it1-f194.google.com with SMTP id z126so2638282itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 19:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UseFaWs5h+hZ0WQrC8pbZE1l+7ZH8j4Nk73vmfbqRtk=;
        b=T2yI100DodRJyYfxsLjIhv381qK9ysU3jRZ2PceCA2yAXV52Kz6Xe1xml9B1BmcSX0
         yhYzqVhvtGPvPWMC+5+CkeccJnJMaYikoFOEXFHxGtschAjBG6zbzzxR+uIRlj17HZPk
         3+k+NTIYeCXYClslz9sUYaMZQ004maakoOfWVna+982u0eY3szyDlx0qSwyTH1wUo/B9
         mJc9Ed/Rs12OnM7PqVT5s6pZ0ZaGd0mlGEUt9WeUJfVEqEbHRahBMxuBUYPpsKzGdDW8
         HHKZy1KZ4ZbVvYx6/zDf3HBvfS4LE8xOCodNh4nvXEK8IlF1UlnaA69J3d3TYrsFs3V5
         EHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UseFaWs5h+hZ0WQrC8pbZE1l+7ZH8j4Nk73vmfbqRtk=;
        b=Du/sKV8xuQzbq1mQbUa5Nx+Tjm17fCqvKIiEqSSrOSqJQua1gyN4rD9nAhP55ODKYj
         EBbLltI8wN2PUtA7G+nb81HeOV3UlIvV+gxeBkcI9FJCZ4CMXAeV8H7oGV/i51VlTxbr
         ATExZJ7M228syNg4Sj2kPV/mbr7Aff79v3qtc1pliDiEzOLkE/PGuAw1oyJtmQoIjVlT
         sGSpN/9SFXiF1dMyZFyUFJW2m4DjQ+8o2T5zE0PYr+Z+IO5cQXN+gfvGkjMHpjJJZ1DI
         Ae19GG0K75yVvEb9al+utWHjETzU7rQvncVP7J3lFiKQ85PvdUAcCME+xaFO53XfnEBR
         cZIA==
X-Gm-Message-State: APjAAAXS3eMWUqT/KdpLwMTXQWc85IAHTDrMpL00kmx0Eq/QPgBaBH+8
        Dj9iSBG+OJdIyrZY/RE5oQg=
X-Google-Smtp-Source: APXvYqycVurb8NbPpXiCKBW7A3TfrKkY+MQ7t7fVo42UIlk7fAyzTboE+SzTmvUXDiSfeE2EBek5/g==
X-Received: by 2002:a24:9dca:: with SMTP id f193mr2472706itd.72.1554173481534;
        Mon, 01 Apr 2019 19:51:21 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-984d-b4e8-0abe-7e26.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:984d:b4e8:abe:7e26])
        by smtp.gmail.com with ESMTPSA id f204sm6707638itc.26.2019.04.01.19.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:51:20 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:51:18 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] kobject: Add support for default attribute groups to
 kobj_type
Message-ID: <b2ef2b7d773c5f227d92438d8bb6cade61c73894.1554151487.git.kimbrownkd@gmail.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1554151487.git.kimbrownkd@gmail.com>
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
index aa89edcd2b63..ede40005db28 100644
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

