Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1B8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A282E2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euFSA05C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439520AbfJYL32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:29:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439203AbfJYL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWR0FeiNl3309mlO6E0ZvUU8kwY1OBQz216A0AG4Xw4=;
        b=euFSA05CFfQyqCAil6I7w+3kNQl+pDCFe5Jqv2lQGxWblaRHZxQV3e1fvxd5PLKmq2Gp9R
        tynOoBUzAJRopYSXCSGmToy9+YLPtjn+3wNYx5XYJn2qY9KhFP92o+Q0gWzL43JNf24Z0K
        fDaSgYfmKfYrAXq1f7EVC3Ibs+/Bk50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-uDlnIiajOLqZTg7uz4n9jg-1; Fri, 25 Oct 2019 07:29:24 -0400
Received: by mail-wr1-f72.google.com with SMTP id r8so924501wrx.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECMzKToI8lUs7uXqHIyGRHyiocaJAiDHNlfvJlo41SA=;
        b=OlOs8jlQ3WMIjEhDdzMWJEEq/fj+q12tNiltNT0fQIs0TH293DD20BoWTqzZ2NGs8o
         fOQq8iEuHgnm0e3w4Hh7zaS5KRwtzYnxKbxIlAGptucF0lWG9/ih5i3KrU0Eu09Sf67k
         SxGHiIPdCjHFb26yTZFXHzbL5VoWTSm5AA7eb6QwQCBg2oAJW0dQuxuQM7hNKZ56D7Cx
         JcC4QU2fgXso9+3D2bcOIlHBsPQmjwGi3RHHfw7jKkWTrLE9SKldeiliq7JeK9vvnp06
         g7tUTZ1Wn5FQQFQ7wSBrA/lxlkpDbe833IB+xDyyoAR4EHXO54S7tsGRW3H+nmVlZsDe
         zOlA==
X-Gm-Message-State: APjAAAVGkRDUjkKVjrKyFRXrq86A0OqXRRs17xCJl1HZYQ+xuCiQxXn7
        NwFRaVwXq3Yn0LVuHADvb9AF+ZDZYodKlSIPnU0JxqJ4MYyXc+H06VRBP2HL+1LIwagfRTp6jZY
        K51FHIt4bbsHJgdiNjtc3gNEy
X-Received: by 2002:a5d:4945:: with SMTP id r5mr2503170wrs.37.1572002962863;
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxZN9Mnc+StD4TaIv7j6jidJ6uc4Izr0imiWOZEmOA/aRp1o/R0zlvUyoK2S2AsyuHVsjk0Q==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr2503154wrs.37.1572002962677;
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] ovl: ignore failure to copy up unknown xattrs
Date:   Fri, 25 Oct 2019 13:29:14 +0200
Message-Id: <20191025112917.22518-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: uDlnIiajOLqZTg7uz4n9jg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue came up with NFSv4 as the lower layer, which generates
"system.nfs4_acl" xattrs (even for plain old unix permissions).  Prior to
this patch this prevented copy-up from succeeding.

The overlayfs permission model mandates that permissions are checked
locally for the task and remotely for the mounter(*).  NFS4 ACLs are not
supported by the Linux kernel currently, hence they cannot be enforced
locally.  Which means it is indifferent whether this attribute is copied or
not.

Generalize this to any xattr that is not used in access checking (i.e. it's
not a POSIX ACL and not in the "security." namespace).

Incidentally, best effort copying of xattrs seems to also be the behavior
of "cp -a", which is what overlayfs tries to mimic.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..ed6e2d6cf7a1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -36,6 +36,13 @@ static int ovl_ccup_get(char *buf, const struct kernel_p=
aram *param)
 module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
 MODULE_PARM_DESC(check_copy_up, "Obsolete; does nothing");
=20
+static bool ovl_must_copy_xattr(const char *name)
+{
+=09return !strcmp(name, XATTR_POSIX_ACL_ACCESS) ||
+=09       !strcmp(name, XATTR_POSIX_ACL_DEFAULT) ||
+=09       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN)=
;
+}
+
 int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
 =09ssize_t list_size, size, value_size =3D 0;
@@ -107,8 +114,13 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *=
new)
 =09=09=09continue; /* Discard */
 =09=09}
 =09=09error =3D vfs_setxattr(new, name, value, size, 0);
-=09=09if (error)
-=09=09=09break;
+=09=09if (error) {
+=09=09=09if (error !=3D -EOPNOTSUPP || ovl_must_copy_xattr(name))
+=09=09=09=09break;
+
+=09=09=09/* Ignore failure to copy unknown xattrs */
+=09=09=09error =3D 0;
+=09=09}
 =09}
 =09kfree(value);
 out:
--=20
2.21.0

