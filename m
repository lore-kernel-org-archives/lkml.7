Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786FBC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EF72080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 12:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfEAMnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 08:43:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46625 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfEAMnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 08:43:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hLoZx-0000eF-I3; Wed, 01 May 2019 12:43:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] kobject: fix dereference before null check on kobj
Date:   Wed,  1 May 2019 13:43:17 +0100
Message-Id: <20190501124317.1759-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The kobj pointer is being null-checked so potentially it could be null,
however, the ktype declaration before the null check is dereferencing kobj
hence we have a potential null pointer deference. Fix this by moving the
assignment of ktype after kobj has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: aa30f47cf666 ("kobject: Add support for default attribute groups to kobj_type")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/kobject.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index a30ee0467942..095bcb55c2ba 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -603,12 +603,13 @@ EXPORT_SYMBOL_GPL(kobject_move);
 void kobject_del(struct kobject *kobj)
 {
 	struct kernfs_node *sd;
-	const struct kobj_type *ktype = get_ktype(kobj);
+	const struct kobj_type *ktype;
 
 	if (!kobj)
 		return;
 
 	sd = kobj->sd;
+	ktype = get_ktype(kobj);
 
 	if (ktype)
 		sysfs_remove_groups(kobj, ktype->default_groups);
-- 
2.20.1

