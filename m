Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D311C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA9924679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780621;
	bh=wlFN9d50h02PaPBfx6PlJ0M0ClduW2Tw33Yl2vxu8jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l7KAxLPiDNO7Kwj0PxBLNWhCQiFzTWVA2U5ltQ12t3pNIptKGWR1onaFCNOG5iC6P
	 UsfGBLEIk3T4PGuv0JiO7Iv/VAZTnxkbMhEw4HzXMxOq7WCTWN6OO6JXMUsiP9WXo5
	 1VrCyW8mVBCvpmZNlhod7fODkv+h42dIvce7PFa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfLSSg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfLSSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:36:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C4B24685;
        Thu, 19 Dec 2019 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780615;
        bh=wlFN9d50h02PaPBfx6PlJ0M0ClduW2Tw33Yl2vxu8jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5e4CoPkOezf88Y/en3cQjVAD3mkQxU8OGj/o1pHZQMdJaYLHbXYjGd3cJMOGpPmN
         N6HHzjqRsR6G1n3YjNrYKwQ5/I0lwG6Lt9Cx4ocbwhQ/5P37gFQUd9VfXPyGr8J5lo
         5ii5Yy9GBn6Fxj3CLRAhaPI5amKol61jvb5AF08M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 047/162] dlm: fix invalid cluster name warning
Date:   Thu, 19 Dec 2019 19:32:35 +0100
Message-Id: <20191219183210.763638053@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Teigland <teigland@redhat.com>

[ Upstream commit 3595c559326d0b660bb088a88e22e0ca630a0e35 ]

The warning added in commit 3b0e761ba83
  "dlm: print log message when cluster name is not set"

did not account for the fact that lockspaces created
from userland do not supply a cluster name, so bogus
warnings are printed every time a userland lockspace
is created.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index dd2b7416e40ae..761d74a84f92f 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -25,6 +25,7 @@
 #include "lvb_table.h"
 #include "user.h"
 #include "ast.h"
+#include "config.h"
 
 static const char name_prefix[] = "dlm";
 static const struct file_operations device_fops;
@@ -402,7 +403,7 @@ static int device_create_lockspace(struct dlm_lspace_params *params)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	error = dlm_new_lockspace(params->name, NULL, params->flags,
+	error = dlm_new_lockspace(params->name, dlm_config.ci_cluster_name, params->flags,
 				  DLM_USER_LVB_LEN, NULL, NULL, NULL,
 				  &lockspace);
 	if (error)
-- 
2.20.1



