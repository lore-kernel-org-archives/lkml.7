Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A4DC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E369021479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920070;
	bh=3ezIcSOyWYw8I4efjEO+0CwCb+ZkrQdkz6h7FNO1ffM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GfVMTPXomw2e+2qI+ztX/8oIicsWG6WddQmG9i9WYRVysfg8O8HLH/NA0YvomtXVM
	 cNUKlvmvI44FigyjL1wo/BPw+FlavgQ3v/Uk6rQxSV683Wb+ZcYSRaBsHN6/4zj6/o
	 1CXJE1v8CmRB+D3t/JYXlW4H169jgLJEFBVoPQsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfKPQBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:01:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731201AbfKPPxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:53:20 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48729218BA;
        Sat, 16 Nov 2019 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919599;
        bh=3ezIcSOyWYw8I4efjEO+0CwCb+ZkrQdkz6h7FNO1ffM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkRt9ruvp3UFCudwBp+j38WKRhb0+WBVsLb8lAtQ+NpIywaiwjo/VOQFM4ElP9LkL
         AeEJvy58BExXvcc4j+Z26gGUyi6aSZY2NZNkij7zji++Y6NdTA/lamadWr9N+hsH3u
         zauWUABt+KBV04oMwHZQO4o2Ev7h6vCl2szsEkr4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tycho Andersen <tycho@tycho.ws>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.9 87/99] dlm: fix invalid free
Date:   Sat, 16 Nov 2019 10:50:50 -0500
Message-Id: <20191116155103.10971-87-sashal@kernel.org>
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

[ Upstream commit d968b4e240cfe39d39d80483bac8bca8716fd93c ]

dlm_config_nodes() does not allocate nodes on failure, so we should not
free() nodes when it fails.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/member.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 9c47f1c14a8ba..a47ae99f7bcbc 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -683,7 +683,7 @@ int dlm_ls_start(struct dlm_ls *ls)
 
 	error = dlm_config_nodes(ls->ls_name, &nodes, &count);
 	if (error < 0)
-		goto fail;
+		goto fail_rv;
 
 	spin_lock(&ls->ls_recover_lock);
 
@@ -715,8 +715,9 @@ int dlm_ls_start(struct dlm_ls *ls)
 	return 0;
 
  fail:
-	kfree(rv);
 	kfree(nodes);
+ fail_rv:
+	kfree(rv);
 	return error;
 }
 
-- 
2.20.1

