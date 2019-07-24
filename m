Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D0C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263462083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GolF7QBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfGXQAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:00:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37942 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfGXQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:00:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so12628573pgu.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qsSima7UkQ7OwBOdi4tGVB5ber34uVKcFdXhsr2axdI=;
        b=GolF7QBQdk3YAZIYlKBGZDmjztWd9K3P5SX/Qzvua3h7HwiD/Nxl6pZo4VhQe1A4H4
         pqm5VmUcuNYZkIIfjsLhu97KLdTJsCw7C+oFitH7YZqAzYRr8Jq7pbmOukAivEo3F8/z
         FxTJHtKQVBgyLCrffPSVhNlecYdwqR0vEK8pJmX300h6HP+ZVhGxnWazGyv0LNwgl4DG
         q7+CPKyCTDybMv81l5JZpESSHKwuwS+8lRY+GJ74Kx0Q8QqZlApurVo4TdHLY9tmYYMK
         DCDeeVA7DKkScsckRQUL3bH3IJpQUBjvGbebnXtG9pUucuKw4QpnY8oaP/53tYwy71hA
         eNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qsSima7UkQ7OwBOdi4tGVB5ber34uVKcFdXhsr2axdI=;
        b=Whs3lx+d4bFWgARN5HXtEGACGhX23rn5KCdVBXqKi3mVuiuDd+pZw2VxAkjtL9dozv
         ZavY7rWiCR+EkcKxHIL6iFFv50ETp/2hi0lrTpW01Q/Sp17QSxoeDe+ysog5emYUG9VK
         QsN+jle1VbjyuAKyh9+/Zz8mIUjsPf03Bbq7zWwMd+vVlAcUeyW8yvANGdEG1S0StPae
         cUGW/6Krl6Zgx/nDcvm2rqNMJQyKhY5msDfRrzlZabBCBPMtEZF0BqaD/BTWFhe46sHN
         lQpyk+mIsTODOCuiPYKqBiERM6Oyic7PSkt45IqCfcPmKjQg3rx4clxv1Y9kfeGiVLQn
         JTPg==
X-Gm-Message-State: APjAAAXaLM90Zsxr+80yM+SGiD8d7IcLQgy+zcaTWMPnfGRhy1/H02I2
        c/YCMiL5k40SqWwPTSubzPA=
X-Google-Smtp-Source: APXvYqz7MmlcY2fmES9Y/ck+2XzpYyCwhYo3EOHzhIyYtN7DbkDrAnyGpjopmctuxiK9Bmv4Fs7JSg==
X-Received: by 2002:a17:90a:21cc:: with SMTP id q70mr90951538pjc.56.1563984014502;
        Wed, 24 Jul 2019 09:00:14 -0700 (PDT)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id b136sm57850207pfb.73.2019.07.24.09.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 09:00:14 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, mojha@codeaurora.org
Cc:     benh@kernel.crashing.org, prsood@codeaurora.org,
        gkohli@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] driver core: Fix use-after-free and double free on glue directory
Date:   Thu, 25 Jul 2019 00:00:06 +0800
Message-Id: <20190724160006.21013-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition between removing glue directory and adding a new
device under the glue directory. It can be reproduced in following test:

path 1: Add the child device under glue dir
device_add()
    get_device_parent()
        mutex_lock(&gdp_mutex);
        ....
        /*find parent from glue_dirs.list*/
        list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
            if (k->parent == parent_kobj) {
                kobj = kobject_get(k);
                break;
            }
        ....
        mutex_unlock(&gdp_mutex);
        ....
    ....
    kobject_add()
        kobject_add_internal()
            create_dir()
                sysfs_create_dir_ns()
                    if (kobj->parent)
                        parent = kobj->parent->sd;
                    ....
                    kernfs_create_dir_ns(parent)
                        kernfs_new_node()
                            kernfs_get(parent)
                        ....
                        /* link in */
                        rc = kernfs_add_one(kn);
                        if (!rc)
                            return kn;

                        kernfs_put(kn)
                            ....
                            repeat:
                            kmem_cache_free(kn)
                            kn = parent;

                            if (kn) {
                                if (atomic_dec_and_test(&kn->count))
                                    goto repeat;
                            }
                        ....

path2: Remove last child device under glue dir
device_del()
    cleanup_glue_dir()
        mutex_lock(&gdp_mutex);
        if (!kobject_has_children(glue_dir))
            kobject_del(glue_dir);
        kobject_put(glue_dir);
        mutex_unlock(&gdp_mutex);

Before path2 remove last child device under glue dir, If path1 add a new
device under glue dir, the glue_dir kobject reference count will be
increase to 2 via kobject_get(k) in get_device_parent(). And path1 has
been called kernfs_new_node(), but not call kernfs_get(parent).
Meanwhile, path2 call kobject_del(glue_dir) beacause 0 is returned by
kobject_has_children(). This result in glue_dir->sd is freed and it's
reference count will be 0. Then path1 call kernfs_get(parent) will trigger
a warning in kernfs_get()(WARN_ON(!atomic_read(&kn->count))) and increase
it's reference count to 1. Because glue_dir->sd is freed by path2, the next
call kernfs_add_one() by path1 will fail(This is also use-after-free)
and call atomic_dec_and_test() to decrease reference count. Because the
reference count is decremented to 0, it will also call kmem_cache_free()
to free glue_dir->sd again. This will result in double free.

In order to avoid this happening, we also should make sure that kernfs_node
for glue_dir is released in path2 only when refcount for glue_dir kobj is
1 to fix this race.

The following calltrace is captured in kernel 4.14 with the following patch
applied:

commit 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")

--------------------------------------------------------------------------
[    3.633703] WARNING: CPU: 4 PID: 513 at .../fs/kernfs/dir.c:494
                Here is WARN_ON(!atomic_read(&kn->count) in kernfs_get().
....
[    3.633986] Call trace:
[    3.633991]  kernfs_create_dir_ns+0xa8/0xb0
[    3.633994]  sysfs_create_dir_ns+0x54/0xe8
[    3.634001]  kobject_add_internal+0x22c/0x3f0
[    3.634005]  kobject_add+0xe4/0x118
[    3.634011]  device_add+0x200/0x870
[    3.634017]  _request_firmware+0x958/0xc38
[    3.634020]  request_firmware_into_buf+0x4c/0x70
....
[    3.634064] kernel BUG at .../mm/slub.c:294!
                Here is BUG_ON(object == fp) in set_freepointer().
....
[    3.634346] Call trace:
[    3.634351]  kmem_cache_free+0x504/0x6b8
[    3.634355]  kernfs_put+0x14c/0x1d8
[    3.634359]  kernfs_create_dir_ns+0x88/0xb0
[    3.634362]  sysfs_create_dir_ns+0x54/0xe8
[    3.634366]  kobject_add_internal+0x22c/0x3f0
[    3.634370]  kobject_add+0xe4/0x118
[    3.634374]  device_add+0x200/0x870
[    3.634378]  _request_firmware+0x958/0xc38
[    3.634381]  request_firmware_into_buf+0x4c/0x70
--------------------------------------------------------------------------

Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")

Signed-off-by: Muchun Song <smuchun@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---

Change in v6:
       1. Remove hardcoding "1 "
Change in v5:
       1. Revert to the v1 fix.
       2. Add some comment to explain why we need do this in
          cleanup_glue_dir().
Change in v4:
       1. Add some kerneldoc comment.
       2. Remove unlock_if_glue_dir().
       3. Rename get_device_parent_locked_if_glue_dir() to
          get_device_parent_locked.
       4. Update commit message.
Change in v3:
       Add change log.
Change in v2:
       Fix device_move() also.

 drivers/base/core.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c92bda..49bcb01e44cd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1820,12 +1820,67 @@ static inline struct kobject *get_glue_dir(struct device *dev)
  */
 static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 {
+	unsigned int ref;
+
 	/* see if we live in a "glue" directory */
 	if (!live_in_glue_dir(glue_dir, dev))
 		return;
 
 	mutex_lock(&gdp_mutex);
-	if (!kobject_has_children(glue_dir))
+	/**
+	 * There is a race condition between removing glue directory
+	 * and adding a new device under the glue directory.
+	 *
+	 * path 1: Add the child device under glue dir
+	 * device_add()
+	 *	get_device_parent()
+	 *		mutex_lock(&gdp_mutex);
+	 *		....
+	 *		list_for_each_entry(k, &dev->class->p->glue_dirs.list,
+	 *				    entry)
+	 *		if (k->parent == parent_kobj) {
+	 *			kobj = kobject_get(k);
+	 *			break;
+	 *		}
+	 *		....
+	 *		mutex_unlock(&gdp_mutex);
+	 *		....
+	 *	....
+	 *	kobject_add()
+	 *		kobject_add_internal()
+	 *		create_dir()
+	 *			....
+	 *			if (kobj->parent)
+	 *				parent = kobj->parent->sd;
+	 *			....
+	 *			kernfs_create_dir_ns(parent)
+	 *				....
+	 *
+	 * path2: Remove last child device under glue dir
+	 * device_del()
+	 *	cleanup_glue_dir()
+	 *		....
+	 *		mutex_lock(&gdp_mutex);
+	 *		if (!kobject_has_children(glue_dir))
+	 *			kobject_del(glue_dir);
+	 *		....
+	 *		mutex_unlock(&gdp_mutex);
+	 *
+	 * Before path2 remove last child device under glue dir, if path1 add
+	 * a new device under glue dir, the glue_dir kobject reference count
+	 * will be increase to 2 via kobject_get(k) in get_device_parent().
+	 * And path1 has been called kernfs_create_dir_ns(). Meanwhile,
+	 * path2 call kobject_del(glue_dir) beacause 0 is returned by
+	 * kobject_has_children(). This result in glue_dir->sd is freed.
+	 * Then the path1 will see a stale "empty" but still potentially used
+	 * glue dir around.
+	 *
+	 * In order to avoid this happening, we also should make sure that
+	 * kernfs_node for glue_dir is released in path2 only when refcount
+	 * for glue_dir kobj is 1.
+	 */
+	ref = kref_read(&glue_dir->kref);
+	if (!kobject_has_children(glue_dir) && !--ref)
 		kobject_del(glue_dir);
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
-- 
2.17.1

