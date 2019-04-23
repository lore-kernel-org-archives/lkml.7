Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53872C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2N/wnv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfDWOd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:33:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35615 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:33:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so7602323pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qshmh+j3N2cEmPAwZ9NFL3U3v1NaKXn9ajF7H4kyf0g=;
        b=q2N/wnv5wQc+h5Bfl56OZ0bZR25KVw/ACo6jOSolv7M/sld80LZDt2g0mKMnD+vAdd
         Kns5hqrs66Rdhnx7fbNELavi7WLg8eIu3i/w90KYK0hEEAbyABsVLDbCUIw8yVmey9bN
         zC49aEqpt9olC4lfLa5JcMLkclBGcaCqptYK26HDb3SEMP08GLk/v4C+UEr7JX375VlH
         TBZ6skQ/MxSk/ZOLWs5G6gIlqxtmgP6uoyqED8W0+R0rElLn0tZ+sM7xoGGmRqSZIqIo
         +WpapRV+vMSVy20oD2dvG2pzogq0Hwf44v7YSy5i4b4M3uWC0ac5YU9CP3LfbXtchxlO
         2P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qshmh+j3N2cEmPAwZ9NFL3U3v1NaKXn9ajF7H4kyf0g=;
        b=RB+P1/9qrXGZhnkAnSOaXFh1NZga8jWis/GMUMekDlVGo2nMW4Rbh4jt7a9v9psFz0
         cbdBIerTTbr24veelHDMJSmi4zZoGfU6fcpGPc6QtmnGFX+rwcNPOOkFsP3v9H7HCPM3
         aorasPWRHMTkUYGfJIAg4OMmLJ6ZyYxy+4FyQ+SjIGGFPBGOZPldw8TuSxsrgmhW8bO1
         qOxWGwyn4o42rcKvLj8mPXhkFmkxrgNHjNtCaiM6cMvru1Gd4SB55BuXtSCoEytAMUC2
         ARa5MFxwy0XsgabwTocQ8ffBIPXvR440XVRBYYSVd6LIKtddkfPeRF7CL5SeTtjHNzKv
         9mmw==
X-Gm-Message-State: APjAAAVUaHI9AiKaHE0bwyNLIeqjhu05Ol9wop8xBxpq5lrp4F+/IU5k
        Rhdr0AKeA98ynQrU2lxS1e4=
X-Google-Smtp-Source: APXvYqykOHaHWmo1qxItGkL9Uk+JkjYvjEnMYgmWZmAbu4hnbgg3ZQ5+tBjiCW/Dd0aZTTWq8c2KSA==
X-Received: by 2002:a65:4342:: with SMTP id k2mr25172421pgq.178.1556030006282;
        Tue, 23 Apr 2019 07:33:26 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id 75sm25669088pfr.55.2019.04.23.07.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:33:25 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Fix use-after-free and double free on glue directory
Date:   Tue, 23 Apr 2019 22:32:58 +0800
Message-Id: <20190423143258.96706-1-smuchun@gmail.com>
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
    cleanup_device_parent()
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

In order to avoid this happening, we we should not call kobject_del() on
path2 when the reference count of glue_dir is greater than 1. So we add a
conditional statement to fix it.

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
                Hrer is BUG_ON(object == fp) in set_freepointer().
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
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c92bda..5ac5376ae9af 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1825,7 +1825,7 @@ static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 		return;
 
 	mutex_lock(&gdp_mutex);
-	if (!kobject_has_children(glue_dir))
+	if (!kobject_has_children(glue_dir) && kref_read(&glue_dir->kref) == 1)
 		kobject_del(glue_dir);
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
-- 
2.17.1

