Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D465CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042C4222CE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yki28Swl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439559AbfJYL3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:29:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28967 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438379AbfJYL32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QILxa7RqQYQ4IyTulj5DZou1wI9mDMu/Shz+xSIroTs=;
        b=Yki28SwlpvgPoa8bOoQUGKeyPe2xwwUdZxgqwPyI50c70/m6N9AOwvCimUmF+ennc4iGSj
        qjqb/XBOEoizRHEqV6/w/QU5oHffM/o3hBe723YTmn/TGdltYQyFNeKdm8wIoWa7XaEwA0
        sP1sTPdEAMO7D5wW+JlpBg1Rj5NBve4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-rncsuUpRPRCu-HCptbYYFA-1; Fri, 25 Oct 2019 07:29:25 -0400
Received: by mail-wm1-f70.google.com with SMTP id z23so820290wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+mLHdhKK+RTjZWJLR+Q9KPjFkxVfyw86WO5G8timrLo=;
        b=oMU+SYzKp52TLvshyCgBdC8IFzncW4XrwOJGPDferspneptCPCzPmUZtO4P72Je0Tm
         krnU8NFTcDOnnLQqqY0/dy3yUvcWpRFwJJ8EAZgzkib7rglmQFxv8YLtpr9Wljy/e/sT
         gWGKEyAq+FUf+5B6yHZi5NyGiZeY3acPwz61LHroOqWVgvEoKS0wrC3vCcRy7asGnn7s
         Mdatkv/B2vNYtHE8tf5UW4j8aU0hr/fr5Vjx3qaTBUHKx+2tw7WiGeb2NTa2+ZrRIvYh
         NLoUjpSbde+TJEoC3ik5zWrytVdw/xPaNK2wq18RFuGPwTVeXNVYuFQlMovN9AR3oqF8
         XfCA==
X-Gm-Message-State: APjAAAWtwEjX80Dnd9Kn1AlWab6dG6omTctdJg3+H0wHCgFTDpPbnP+1
        1fIFR+qKid0fxe++cK3wMYSyLBNax+rpIccF6rk2M3AuI3OulsNNPzIZf2+C7Q9PUXm8ztsWNoK
        N6G/tL9c0P5L951O2PzdXkIKJ
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr2584471wrc.293.1572002963916;
        Fri, 25 Oct 2019 04:29:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9N9CexvOHs1/1Nl23PU+f1edkwgpoJUCwGjuUM8lfcClQyivxqq8K4S/lkAW8ZRb5gVH90Q==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr2584455wrc.293.1572002963729;
        Fri, 25 Oct 2019 04:29:23 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:23 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] vfs: allow unprivileged whiteout creation
Date:   Fri, 25 Oct 2019 13:29:15 +0200
Message-Id: <20191025112917.22518-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: rncsuUpRPRCu-HCptbYYFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whiteouts are special, but unlike real device nodes they should not require
privileges to create.

The 0 char device number should already be reserved, but make this explicit
in cdev_add() to be on the safe side.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/char_dev.c                 |  3 +++
 fs/namei.c                    | 17 ++++-------------
 include/linux/device_cgroup.h |  3 +++
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 00dfe17871ac..8bf66f40e5e0 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -483,6 +483,9 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 =09p->dev =3D dev;
 =09p->count =3D count;
=20
+=09if (WARN_ON(dev =3D=3D WHITEOUT_DEV))
+=09=09return -EBUSY;
+
 =09error =3D kobj_map(cdev_map, dev, count, NULL,
 =09=09=09 exact_match, exact_lock, p);
 =09if (error)
diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..05ca98595b62 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3687,12 +3687,14 @@ EXPORT_SYMBOL(user_path_create);
=20
 int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_=
t dev)
 {
+=09bool is_whiteout =3D S_ISCHR(mode) && dev =3D=3D WHITEOUT_DEV;
 =09int error =3D may_create(dir, dentry);
=20
 =09if (error)
 =09=09return error;
=20
-=09if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
+=09if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
+=09    !is_whiteout)
 =09=09return -EPERM;
=20
 =09if (!dir->i_op->mknod)
@@ -4527,9 +4529,6 @@ static int do_renameat2(int olddfd, const char __user=
 *oldname, int newdfd,
 =09    (flags & RENAME_EXCHANGE))
 =09=09return -EINVAL;
=20
-=09if ((flags & RENAME_WHITEOUT) && !capable(CAP_MKNOD))
-=09=09return -EPERM;
-
 =09if (flags & RENAME_EXCHANGE)
 =09=09target_flags =3D 0;
=20
@@ -4667,15 +4666,7 @@ SYSCALL_DEFINE2(rename, const char __user *, oldname=
, const char __user *, newna
=20
 int vfs_whiteout(struct inode *dir, struct dentry *dentry)
 {
-=09int error =3D may_create(dir, dentry);
-=09if (error)
-=09=09return error;
-
-=09if (!dir->i_op->mknod)
-=09=09return -EPERM;
-
-=09return dir->i_op->mknod(dir, dentry,
-=09=09=09=09S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+=09return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 }
 EXPORT_SYMBOL(vfs_whiteout);
=20
diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index 8557efe096dc..fc989487c273 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -62,6 +62,9 @@ static inline int devcgroup_inode_mknod(int mode, dev_t d=
ev)
 =09if (!S_ISBLK(mode) && !S_ISCHR(mode))
 =09=09return 0;
=20
+=09if (S_ISCHR(mode) && dev =3D=3D WHITEOUT_DEV)
+=09=09return 0;
+
 =09if (S_ISBLK(mode))
 =09=09type =3D DEVCG_DEV_BLOCK;
 =09else
--=20
2.21.0

