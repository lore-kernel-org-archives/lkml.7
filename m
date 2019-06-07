Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C0C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D50212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXoO+OEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfFGRlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:41:12 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50569 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfFGRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:41:11 -0400
Received: by mail-it1-f195.google.com with SMTP id a186so3966383itg.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mZTYGju8Lc1Vw+PBsp6ZhKXJXzOEOqXl38jTX2RDW6c=;
        b=dXoO+OElj6Gj7lrthzGFiOpNWlZZTYx7AcrAJzNvdkaHweAMtfWrnjJdIZgEOSEV6P
         wWIc4CXwAqYEitGXtCNVqVBu4v0EsF3KJ3UJWrQrh7KdTKh6w+DY+qeHetFA7SbHSXhZ
         QYUKSPnflShdpZGed0bDiyaBdEL9NPZjPdCz8JCTQzMw1OpfJH3GyBc6iLBpmDieKEgf
         AJRdI9LGgDEXXZQYqrHmgS2zXD1QNiYmPEcOewshGVmdihS0US2IZ0A3thjqZQcWxMwL
         quetjcV+cUyeEXr+TFTKVO0aDPvZaO0ny6in/SN2wn+RKYCR5R1WiL2acXx7SDAzO3FF
         3PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mZTYGju8Lc1Vw+PBsp6ZhKXJXzOEOqXl38jTX2RDW6c=;
        b=Xyo7qFYeo4wpWUSL9ztPSYCOe3qjLJoz6ROprg3rjRtiJwjc8eWN9S4T/fEQxmKIWf
         dU7FvTTrmovaEwcqp02mwwx8IJ/m6AcYZ35TWIUJnNmZ7N1VaGnA406CGxg519kXzVEL
         84FDP8TiTI83mw7jlAks9XedRhQ0iK7yV3a7AUA8n8BYjLxeE7K8i0VZnAmiWbHEaL5e
         8OD5+L1NR4cvT9z7lxyw5TjIjFd1EO9RRBPr8eJ/ydKYpkfpULhP8fk8OWwh9b6UO2S6
         VfEea/zU37Mw65XiTkubUlEhimSeaRymaK2xNSVJrMgdR5rN/jwuP6v78s/dCJCZpmkc
         k3Kg==
X-Gm-Message-State: APjAAAVVvgnhoe6PpOOM4Gys41HldqhgVwBYDskkUirt8DQ4pTzeTg/s
        G4QnfnXuosAeLqlo4I6zBXuLuT/0q2o=
X-Google-Smtp-Source: APXvYqyBPTdmHAYkX83K+3hbXN6JbcHLil/4cD/BDyW4FofdOVJsH6C3leCRNZzzFF3ODsBXIAm2mQ==
X-Received: by 2002:a02:69d7:: with SMTP id e206mr37601616jac.21.1559929270547;
        Fri, 07 Jun 2019 10:41:10 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-59ab-a761-9e83-29ee.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:59ab:a761:9e83:29ee])
        by smtp.gmail.com with ESMTPSA id 15sm910997ioe.46.2019.06.07.10.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 10:41:09 -0700 (PDT)
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com, gregkh@linuxfoundation.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: replace ktype default_attrs with default_groups
Date:   Fri,  7 Jun 2019 13:40:41 -0400
Message-Id: <20190607174041.11201-1-kimbrownkd@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace the default_attrs fields in f2fs_sb_ktype
and f2fs_feat_ktype with default_groups. Use the ATTRIBUTE_GROUPS macro
to create f2fs_groups and f2fs_feat_groups.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 fs/f2fs/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 729f46a3c9ee..5c85166677d4 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -501,6 +501,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(current_reserved_blocks),
 	NULL,
 };
+ATTRIBUTE_GROUPS(f2fs);
 
 static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_FS_ENCRYPTION
@@ -520,6 +521,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(sb_checksum),
 	NULL,
 };
+ATTRIBUTE_GROUPS(f2fs_feat);
 
 static const struct sysfs_ops f2fs_attr_ops = {
 	.show	= f2fs_attr_show,
@@ -527,7 +529,7 @@ static const struct sysfs_ops f2fs_attr_ops = {
 };
 
 static struct kobj_type f2fs_sb_ktype = {
-	.default_attrs	= f2fs_attrs,
+	.default_groups = f2fs_groups,
 	.sysfs_ops	= &f2fs_attr_ops,
 	.release	= f2fs_sb_release,
 };
@@ -541,7 +543,7 @@ static struct kset f2fs_kset = {
 };
 
 static struct kobj_type f2fs_feat_ktype = {
-	.default_attrs	= f2fs_feat_attrs,
+	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_attr_ops,
 };
 
-- 
2.17.1

