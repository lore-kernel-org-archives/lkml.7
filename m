Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF9C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27845214DE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141850;
	bh=HcaG8+dHQM6vRbs5vZczWzHqeAXK9WrbHcV3kbOn0to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IVcekVgPpWchcjaruypIQeTO+Lcfxodewlo0+7c12l3qlG1ki1i7SjmWmERVtPFHa
	 27pmFCMRCsFTsEBtYZnCc9i3yLQY5CpnElVIuStAkz3lqitfqH+s5tAN3idcTrMJoK
	 nvIU9g05hRKkTzb9xLGb4c7kgatOhNJjaEKHjQ58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfKSFh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfKSFhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:37:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877D021823;
        Tue, 19 Nov 2019 05:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141842;
        bh=HcaG8+dHQM6vRbs5vZczWzHqeAXK9WrbHcV3kbOn0to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqqXqwTTmcSgPCDh9jYI1MMEaXH2yl5SNBtPH/rn5wLWJ0Uzx4HZ8n4q255h7efTy
         ox2aaGRQjK9YJkBrzXOM66K8KSVY7a15NaD9q3AjVYd12PFB4FWoMVGa/xHNE0zPjh
         r5WerDMC0BZT4dTwqRQ67F4oa4zlZvzLdQA0Ltmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 298/422] f2fs: avoid infinite loop in f2fs_alloc_nid
Date:   Tue, 19 Nov 2019 06:18:15 +0100
Message-Id: <20191119051418.313412348@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit f84262b0862d43b71b3e80a036cdd9d82e620367 ]

If we have an error in f2fs_build_free_nids, we're able to fall into a loop
to find free nids.

Suggested-by: Chao Yu <chao@kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index aa8f19e1bdb3d..e5d474681471c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2367,8 +2367,9 @@ retry:
 	spin_unlock(&nm_i->nid_list_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
-	f2fs_build_free_nids(sbi, true, false);
-	goto retry;
+	if (!f2fs_build_free_nids(sbi, true, false))
+		goto retry;
+	return false;
 }
 
 /*
-- 
2.20.1



