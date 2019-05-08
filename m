Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859E0C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520F620879
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6ZI9PRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEHBs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:48:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37348 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfEHBs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:48:58 -0400
Received: by mail-it1-f196.google.com with SMTP id l7so1439327ite.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o7lcyB5s0oTEYvy3/wHbgG7UILE/7QogHJKGt1FxaBM=;
        b=L6ZI9PRIK8DoLR58x1qB/Lw9xq543AAQprEDzs/cg+03ifpuGgsmRzrjX63HCBsjv9
         KfYtHyc7CJwOA9FlfNy0Z45pwr/Ku927wvXIasxUPybmvW16TTPbAIRO0hu7afSl0al3
         uxZjQhdZHiULov9X9eK+jn8zDeifTLZzlb6Trk9qXXo76nFPjzWYzTQifXsKmxnNlGiD
         SqAaKhP4WEFndLPX+nLxL9heO/n8mhzhRUEpLyJIC2VHJZLHEpPSdPnghcZ3DWDMCJ3I
         4meHp0cyCUBJ10WnUWHXT/B58vwCx3wmDP+opfDX+Ufk5M3v9w98d3zubuXn9trTTqBR
         yG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o7lcyB5s0oTEYvy3/wHbgG7UILE/7QogHJKGt1FxaBM=;
        b=P2uMYxC/7CHk90g68BING2somkZuipVGQ8klWYVrBl6O4l6IgxCSD68+bFBHnzWKj1
         EcYXC1fqAHJuHW6z8MiyvLlnMTzldCHV4leuF5zCxS3GHkpdYmgdDKbY9V4lCtvyiENI
         vNUDq+99G8DwxWt5RTCtc0mJsh6+XJ91OJPDgUEUELLX/eCid6hstqKdA3vPRW3F10jv
         CztBTVi+mHrAOX2jj4zz/jXFBMVQ0jQVWW3KHxAi9BqcdO02bOSA1q5bhdvR0ZBlqf5U
         MfF5xcQeUvMG7CG8e63v6ogeF6CzF5B55UC/7Qm+ksXRS9TCaJd55eh0XKVpgnWWaTx3
         ISJA==
X-Gm-Message-State: APjAAAWenibkKcTj4gU1kOn9rmMgjauYqwzUOYFT1mnF7A43CYhg7Z0q
        n5OGv6GBLRdHE8CehKtjZ9mcEbNoQ28=
X-Google-Smtp-Source: APXvYqxvQgjj28jgLRfY2BL7CgVmEj527sBLG1fKApNyOjUsz3dhX3wUGBgSVcCrfwP0qig61eJpIA==
X-Received: by 2002:a02:8815:: with SMTP id r21mr2015578jai.88.1557280137987;
        Tue, 07 May 2019 18:48:57 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-f514-433e-0658-d461.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:f514:433e:658:d461])
        by smtp.gmail.com with ESMTPSA id c72sm446207itc.22.2019.05.07.18.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 18:48:57 -0700 (PDT)
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: Replace default_attrs in dlm_ktype with default_groups
Date:   Tue,  7 May 2019 21:48:05 -0400
Message-Id: <20190508014805.28715-1-kimbrownkd@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field, so replace the default_attrs field in dlm_ktype
with default_groups. Use the ATTRIBUTE_GROUPS macro to create
dlm_groups.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---

This patch depends on a patch in the driver-core tree: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=aa30f47cf666111f6bbfd15f290a27e8a7b9d854

Greg KH can take this patch through the driver-core tree, or this patch
can wait a release cycle and go through the subsystem's tree, whichever
the subsystem maintainer is more comfortable with.


 fs/dlm/lockspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index db43b98c4d64..762f08bb2bf2 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -160,6 +160,7 @@ static struct attribute *dlm_attrs[] = {
 	&dlm_attr_recover_nodeid.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(dlm);
 
 static ssize_t dlm_attr_show(struct kobject *kobj, struct attribute *attr,
 			     char *buf)
@@ -189,7 +190,7 @@ static const struct sysfs_ops dlm_attr_ops = {
 };
 
 static struct kobj_type dlm_ktype = {
-	.default_attrs = dlm_attrs,
+	.default_groups = dlm_groups,
 	.sysfs_ops     = &dlm_attr_ops,
 	.release       = lockspace_kobj_release,
 };
-- 
2.17.1

