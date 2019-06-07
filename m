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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5A2208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC+YMhuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfFGSXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:23:13 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38917 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbfFGSXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:23:13 -0400
Received: by mail-it1-f195.google.com with SMTP id j204so4191394ite.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GvSp4gzCgfrFcDrCwilhUDsCbSpdZAD9u0QzYjvDaf0=;
        b=PC+YMhuNaUWAWX/Lb0gLc/h+nxONJn2eHx5nbhURAcSpznHVvBeFqIXMfnhC1abY8A
         qZFVchyCFcRgRrxaNFVSL3yEE6P3zQOzLX/Q7XOspBhW4rlIiSNHcxw2oEp5ow4AJf70
         Wmhwyawxz6Yomksl10z9bCZn3o0SKde3GlZPVVO9rJQwWpttLFwExpM2j4T1MJ5KZtfU
         F32W3ZllSKXC5YJ+x3xp4eWCY86Kh0xK/SKp+aEp941V26weYBRni6CmgtX8lPPveuwq
         DfvQNv4RbGb6b+TUB/Ba2AQt01HqIcVUN0JMLz53VREhNvCTawEcfP3d13fEwamIFAtC
         63OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GvSp4gzCgfrFcDrCwilhUDsCbSpdZAD9u0QzYjvDaf0=;
        b=qWV7bPD7Ief8AgJpNMKzR0eyvWb42Vq0eezpNiFlCqc9SLxojn4CKuhgCamTK2Oes3
         Pid4A/3VP2tfS8QCfez3roAc9fFihUoDOTzig9pIxUbzvPWLf1CEfZXEE1sT0ak3c2ek
         BaLomUgjBYoTQ/Q8mkN579iaruycmrtI2wDhfEmZiA0KxlhGE8yOSCioIfLrcEpY4drg
         QM1B19v3QVDl+gfWkWPhFoLsmDjCml94eoGzoLCSNDEdp4gvR+9NPFLktuWKl/jGYwVI
         X7ShLtyrVqVPxfY6mtvrN6vSwhdUKUYYgNYHH0BO5KBuuy6kiC534+4SKkpjCki+5POm
         n0sA==
X-Gm-Message-State: APjAAAUbOgyRHcnkjLKpmThakxMO/8J30ss4aToEh4qe6grtTY8KABNb
        ZCRr1MTvaZKgmgRn6C2i0tIMCkgnxU8=
X-Google-Smtp-Source: APXvYqzA4g8acCxIswuZ9Kdgg+3nVinuOJqNEcoCUuLrDB31N619AeKy0ZE0kjyTNwf1GzC2Gy+EUA==
X-Received: by 2002:a02:9143:: with SMTP id b3mr12666954jag.12.1559931792333;
        Fri, 07 Jun 2019 11:23:12 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-59ab-a761-9e83-29ee.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:59ab:a761:9e83:29ee])
        by smtp.gmail.com with ESMTPSA id d129sm1364143ita.36.2019.06.07.11.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:23:11 -0700 (PDT)
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     rpeterso@redhat.com, agruenba@redhat.com,
        gregkh@linuxfoundation.org
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: replace ktype default_attrs with default_groups
Date:   Fri,  7 Jun 2019 14:23:00 -0400
Message-Id: <20190607182300.32457-1-kimbrownkd@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace the default_attrs field in gfs2_ktype
with default_groups. Use the ATTRIBUTE_GROUPS macro to create
gfs2_groups.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 fs/gfs2/sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 348903010911..c784034d22a8 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -299,6 +299,7 @@ static struct attribute *gfs2_attrs[] = {
 	&gfs2_attr_demote_rq.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(gfs2);
 
 static void gfs2_sbd_release(struct kobject *kobj)
 {
@@ -309,7 +310,7 @@ static void gfs2_sbd_release(struct kobject *kobj)
 
 static struct kobj_type gfs2_ktype = {
 	.release = gfs2_sbd_release,
-	.default_attrs = gfs2_attrs,
+	.default_groups = gfs2_groups,
 	.sysfs_ops     = &gfs2_attr_ops,
 };
 
-- 
2.17.1

