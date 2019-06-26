Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32532C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D1F21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7rtGwf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfFZOiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:38:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42697 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFZOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:38:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so1459198pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LITP8a5nu6BoMPhwbxTj2Lwn5C7IrnXB3v68VoPaQI4=;
        b=n7rtGwf9XW2vS3fQS7Mtr9T4HAYc6Dk3XIUN+o3T2PZFA/AE5HLF3XJ7THYW+wMdky
         owxcHFjtINWfDL8QHpSDqqvdp4ezLtQ+acGOqQXaw1UPrkUhJufCP8ytninnZ2E/uBRm
         M36yCieciWDUyDeFyNTARIz7ZSrqqycJ0eOvRLuSQAL2jcDCFu0gc57WQV1zK9ezmqaJ
         QrbeReRV8sxweueKmMskeN4kX0Syh7nIcqpVj1jnWAuCHBsMGB78Z5+0o3kFUi9R+XKo
         09qGfdJGgSqI7u0Ltou1uDJJ6wAnAmSaVVBm1Ay8+GNzG1O/aQHfRGOx6YxscumkgLj3
         ca5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LITP8a5nu6BoMPhwbxTj2Lwn5C7IrnXB3v68VoPaQI4=;
        b=d0OD+dINhV1jw8D99SVDbZ2bSIzkhbIV0nIckDUw91jQhNvm5Gq1lAaxxmPXkDjYtW
         hs//PruxjMtH2uEzYG7+FNgnSxCG6Q0B67IPbtUSrSz1vrnQr+NZM3SyVP79VFoblEJn
         P9uYV76+xUkhbjBmuE86F9NYR6lqH3IsXRtDO0SHWrtAovqI56qg733reJK6esU32gpq
         SyLoTMI9GVkvrWCezVk5LrriayW1Qhs9tVS1uj9cwqELSuQSVK382hAkI9WN3eX1FdAQ
         Gt54Ug030Z/q6eth/erfD0i7LNHyTHAvNa7WmyF5Rq8uovljJW0oWTKanTWNkhSTLgaD
         tkfg==
X-Gm-Message-State: APjAAAXcUVueR/pdSglIQAOqLAXJzndHJOGKBz8V7EK7z1ydZCehhTkz
        zh0kzBTZwcBsHobQ9Bkzhkg=
X-Google-Smtp-Source: APXvYqzR9EjMIANiupeq8oPDPbndhmZLsAdI1rL5XMUh+wP3dmNvVzkiZR/6Dss4yicsm5II+fecCA==
X-Received: by 2002:a63:3d0f:: with SMTP id k15mr3284717pga.343.1561559933170;
        Wed, 26 Jun 2019 07:38:53 -0700 (PDT)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id 5sm17739909pfh.109.2019.06.26.07.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:38:52 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     benh@kernel.crashing.org, prsood@codeaurora.org,
        mojha@codeaurora.org, gkohli@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 OPT1] driver core: Fix use-after-free and double free on glue directory
Date:   Wed, 26 Jun 2019 22:38:23 +0800
Message-Id: <20190626143823.7048-1-smuchun@gmail.com>
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

In order to avoid this happening, we should not call kobject_del() on
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
---

Hi Greg,

This fix patch is based on the refcount. It is also the original fix method.
Another fix patch is based on the mutex lock.

It can reference to:
        Subject: [PATCH v4 OPT2] driver core: Fix use-after-free and double free on glue directory

I am hoping you would chose which solution you prefered here. Thanks.

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

