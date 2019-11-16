Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26157C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47412089D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920067;
	bh=5Z8syyPxu+RIe5Hu9MJdInqhpQxBkHwU4Q6mZlg2V8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvuGwKgiPiTAlywoZNc867jOhzXMbsIKN/wfDQmWV2Po6RJ3PnyGDXsJHwNPEqXrO
	 DYpancLqmmaJi0IHWPvLIjlvfPqMB5lfzG2iZZcWfbcQkAtgONxcgTrNd2vv8ffnGZ
	 9u6jS/QMxY73gOcp71PAmrNCYO+cDdzXVwtvkbH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfKPQBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbfKPPxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:53:20 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9DB2218A3;
        Sat, 16 Nov 2019 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919600;
        bh=5Z8syyPxu+RIe5Hu9MJdInqhpQxBkHwU4Q6mZlg2V8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHEcGMtJR5he/cNv7e7QD8c//hnbqvcotU12MP0Gbn9XQXEaBjRGZ0JSdImnIcYDn
         NY+3Y5fJJ+MM9JfGxytrEILXbGJo+xI5aHBpSVGE5oabiAPdfE2XeRz1vsXu8gOwUh
         IxvmF82CfV/NRoMFjsRY76vZstQLgZKz7CF1A16s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tycho Andersen <tycho@tycho.ws>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.9 88/99] dlm: don't leak kernel pointer to userspace
Date:   Sat, 16 Nov 2019 10:50:51 -0500
Message-Id: <20191116155103.10971-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tycho@tycho.ws>

[ Upstream commit 9de30f3f7f4d31037cfbb7c787e1089c1944b3a7 ]

In copy_result_to_user(), we first create a struct dlm_lock_result, which
contains a struct dlm_lksb, the last member of which is a pointer to the
lvb. Unfortunately, we copy the entire struct dlm_lksb to the result
struct, which is then copied to userspace at the end of the function,
leaking the contents of sb_lvbptr, which is a valid kernel pointer in some
cases (indeed, later in the same function the data it points to is copied
to userspace).

It is an error to leak kernel pointers to userspace, as it undermines KASLR
protections (see e.g. 65eea8edc31 ("floppy: Do not copy a kernel pointer to
user memory in FDGETPRM ioctl") for another example of this).

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 9ac65914ab5b0..57f2aacec97f5 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -700,7 +700,7 @@ static int copy_result_to_user(struct dlm_user_args *ua, int compat,
 	result.version[0] = DLM_DEVICE_VERSION_MAJOR;
 	result.version[1] = DLM_DEVICE_VERSION_MINOR;
 	result.version[2] = DLM_DEVICE_VERSION_PATCH;
-	memcpy(&result.lksb, &ua->lksb, sizeof(struct dlm_lksb));
+	memcpy(&result.lksb, &ua->lksb, offsetof(struct dlm_lksb, sb_lvbptr));
 	result.user_lksb = ua->user_lksb;
 
 	/* FIXME: dlm1 provides for the user's bastparam/addr to not be updated
-- 
2.20.1

