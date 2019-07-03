Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FEBC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0472A21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562138223;
	bh=9eS1SfFN/DQeB0SBj50dGXz76NdDRWW4miNGhy9ozWI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=chZP43KYsoLtpcye57HW6lWDucNCOQ8A0stJ1xjNu1YsdvROqluiPeeHzrQlXIl1A
	 W98JksCoeFe5TUDCG0jatsQSMP7stDwvrdf61Wfy9Xo15cBHqpR3Qn3PSFP//bK6NG
	 I5Q5MRiwyPE8m4eFW1PwXMK1sfxanduaaNUqDWHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGCHRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfGCHRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:17:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBAE42187F;
        Wed,  3 Jul 2019 07:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562138220;
        bh=9eS1SfFN/DQeB0SBj50dGXz76NdDRWW4miNGhy9ozWI=;
        h=From:To:Cc:Subject:Date:From;
        b=ODKuRX812iSc3xOeNYnNpogCA8BaPgQ8YclrWQBL4PGaRfwXl+PWeGVZmn70ezDyw
         bB1ZROcCgToYifC+J8712yye2XEQg4K6woa7uBkpybJ9+5aX8i7m40wBDGVoLGOP0U
         ygjvaPaDkNAOh83vb9JlcuUfGMhr07YfizjwDvBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] debugfs: provide pr_fmt() macro
Date:   Wed,  3 Jul 2019 09:16:52 +0200
Message-Id: <20190703071653.2799-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a common "debugfs: " prefix for all pr_* calls in a single place.

Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index acef14ad53db..f04c8475d9a1 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -9,6 +9,8 @@
  *  See ./Documentation/core-api/kernel-api.rst for more details.
  */
 
+#define pr_fmt(fmt)	"debugfs: " fmt
+
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
@@ -285,7 +287,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 	int error;
 
-	pr_debug("debugfs: creating file '%s'\n",name);
+	pr_debug("creating file '%s'\n", name);
 
 	if (IS_ERR(parent))
 		return parent;
-- 
2.22.0

