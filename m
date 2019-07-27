Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9FCC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 03:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EDA217D9
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 03:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsQ65Ko1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfG0DVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 23:21:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45356 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfG0DVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 23:21:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so25601730pgp.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qdYopa8yacP8k3G7bShYLnBRz0nWK8PU35rQCw1ZN1U=;
        b=nsQ65Ko1z5pzcCks5lqtmh6ul2FpWxtYovxWQau5L16ZcX1lv8mP+0BBd/aRPiHkAN
         g7exeNQE5zRnvFLjl8K2Z/ctY9jHbKKyBTnShPFN0/kccJi0vx1kObSwnS3mvOv960vi
         IEY3NwTrYHMSa/UdidNcYNWVMOLXdXVm9561Pj3UomW5fqptdjGwcMVm0bVL+zQsZtHr
         Gsl998I75up31k+Fm3DlKOOMMo+q0sw8Ppe2u8mKG7+NRSDvRUCzdHjlc7ORFiboDvwe
         jCMKu7vtfH712BTGbv9t7lD4sT8p6i1/gjRyzUFev7fd33H0pq9WYW3UbvmNVGfz/PXd
         bUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qdYopa8yacP8k3G7bShYLnBRz0nWK8PU35rQCw1ZN1U=;
        b=XIvphwoeED0RuicpGKtEe1+WyITd+NEZJg7dbUrMZyvlJtfh3NJi8cccuxAVX2sJd5
         nk5Dsn4SpKPq5SxW2gR/3DVj7WUCYQ7F+eZmn2KxdE38jGY/5NULMcd+uuHMbKFe9RIS
         uGk+l8Jybnk8F7zMucin8dwvxEu1ALGNUPAcCB48ZPPEiJ4hOrRdLP8Th1uXQnAuZILQ
         7Y+vcxDGqmksAmaHNGJHs+pyRI/qvwGGp22CUSg3cA7uu0oyJR+lrSgR+N1tejMxW+hg
         5ykIR40QTbEDd5uup6UV9ms+xohfarMzN9UqKquEjafuz3KmRVTwsFl55Liq/cCKtyBL
         WclQ==
X-Gm-Message-State: APjAAAXgZapRsoC+UhhjDZqXntwG/By0dbXe13YRJ5o1zW0dshA3NVW0
        pOr9CiMENfCdyT9mKT67WYAd8RxrUgU=
X-Google-Smtp-Source: APXvYqzl+AiJCet1QIj0gHRy0lsfILO65tC8BHEjApS/9NVSPIPN9YvqLiq2CfgBfXks+3U4hgjzfQ==
X-Received: by 2002:a62:5252:: with SMTP id g79mr25145264pfb.18.1564197694522;
        Fri, 26 Jul 2019 20:21:34 -0700 (PDT)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id b190sm44632040pga.37.2019.07.26.20.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 20:21:33 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, mojha@codeaurora.org
Cc:     benh@kernel.crashing.org, prsood@codeaurora.org,
        gkohli@codeaurora.org, songmuchun@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7] driver core: Fix use-after-free and double free on glue directory
Date:   Sat, 27 Jul 2019 11:21:22 +0800
Message-Id: <20190727032122.24639-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race condition between removing glue directory and adding a new
device under the glue dir. It can be reproduced in following test:

CPU1:                                         CPU2:

device_add()
  get_device_parent()
    class_dir_create_and_add()
      kobject_add_internal()
        create_dir()    // create glue_dir

                                              device_add()
                                                get_device_parent()
                                                  kobject_get() // get glue_dir

device_del()
  cleanup_glue_dir()
    kobject_del(glue_dir)

                                                kobject_add()
                                                  kobject_add_internal()
                                                    create_dir() // in glue_dir
                                                      sysfs_create_dir_ns()
                                                        kernfs_create_dir_ns(sd)

      sysfs_remove_dir() // glue_dir->sd=NULL
      sysfs_put()        // free glue_dir->sd

                                                          // sd is freed
                                                          kernfs_new_node(sd)
                                                            kernfs_get(glue_dir)
                                                            kernfs_add_one()
                                                            kernfs_put()

Before CPU1 remove last child device under glue dir, if CPU2 add a new
device under glue dir, the glue_dir kobject reference count will be
increase to 2 via kobject_get() in get_device_parent(). And CPU2 has
been called kernfs_create_dir_ns(), but not call kernfs_new_node().
Meanwhile, CPU1 call sysfs_remove_dir() and sysfs_put(). This result in
glue_dir->sd is freed and it's reference count will be 0. Then CPU2 call
kernfs_get(glue_dir) will trigger a warning in kernfs_get() and increase
it's reference count to 1. Because glue_dir->sd is freed by CPU1, the next
call kernfs_add_one() by CPU2 will fail(This is also use-after-free)
and call kernfs_put() to decrease reference count. Because the reference
count is decremented to 0, it will also call kmem_cache_free() to free
the glue_dir->sd again. This will result in double free.

In order to avoid this happening, we also should make sure that kernfs_node
for glue_dir is released in CPU1 only when refcount for glue_dir kobj is
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

Change in v7:
       1. Update commit message.
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

 drivers/base/core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c92bda..edc55160c5f0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1820,12 +1820,63 @@ static inline struct kobject *get_glue_dir(struct device *dev)
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
+	 * CPU1:                                         CPU2:
+	 *
+	 * device_add()
+	 *   get_device_parent()
+	 *     class_dir_create_and_add()
+	 *       kobject_add_internal()
+	 *         create_dir()    // create glue_dir
+	 *
+	 *                                               device_add()
+	 *                                                 get_device_parent()
+	 *                                                   kobject_get() // get glue_dir
+	 *
+	 * device_del()
+	 *   cleanup_glue_dir()
+	 *     kobject_del(glue_dir)
+	 *
+	 *                                               kobject_add()
+	 *                                                 kobject_add_internal()
+	 *                                                   create_dir() // in glue_dir
+	 *                                                     sysfs_create_dir_ns()
+	 *                                                       kernfs_create_dir_ns(sd)
+	 *
+	 *       sysfs_remove_dir() // glue_dir->sd=NULL
+	 *       sysfs_put()        // free glue_dir->sd
+	 *
+	 *                                                         // sd is freed
+	 *                                                         kernfs_new_node(sd)
+	 *                                                           kernfs_get(glue_dir)
+	 *                                                           kernfs_add_one()
+	 *                                                           kernfs_put()
+	 *
+	 * Before CPU1 remove last child device under glue dir, if CPU2 add
+	 * a new device under glue dir, the glue_dir kobject reference count
+	 * will be increase to 2 in kobject_get(k). And CPU2 has been called
+	 * kernfs_create_dir_ns(). Meanwhile, CPU1 call sysfs_remove_dir()
+	 * and sysfs_put(). This result in glue_dir->sd is freed.
+	 *
+	 * Then the CPU2 will see a stale "empty" but still potentially used
+	 * glue dir around in kernfs_new_node().
+	 *
+	 * In order to avoid this happening, we also should make sure that
+	 * kernfs_node for glue_dir is released in CPU1 only when refcount
+	 * for glue_dir kobj is 1.
+	 */
+	ref = kref_read(&glue_dir->kref);
+	if (!kobject_has_children(glue_dir) && !--ref)
 		kobject_del(glue_dir);
 	kobject_put(glue_dir);
 	mutex_unlock(&gdp_mutex);
-- 
2.17.1

