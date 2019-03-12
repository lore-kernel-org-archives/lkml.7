Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C08C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44212183F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410776;
	bh=x3VB9QIOmkrGLGNuTZBAWi9FTOdnvnEcde/5NwhlsaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PgxtDVEuSmSGVzZRY/uEWgr3+82W4ZtBBys/kBdeplaYwwKP/A+cV5J4tt6Acn5Xy
	 F0ze7zA9g2HUpPnKAJ1s10WrAOAa/JDWxXk9nLgJqpwiZswLnQgEmyULfUydc+xsZJ
	 le5QkgEb3/9vwq2tQZwwq1Vy5SJ5yYrtoHXh2NAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfCLRMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbfCLRMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:30 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D6E206DF;
        Tue, 12 Mar 2019 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410749;
        bh=x3VB9QIOmkrGLGNuTZBAWi9FTOdnvnEcde/5NwhlsaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oD5QecJ6FtJUEIrsWEgjKT0u9VApzSOLFnaluLgJgopzW7YqSuO6k8Tz1W4bZs8b6
         AUhv4+i5TlDjku60l2H+YLnOyQ2NLDqI5JHBj+eA//eaRGHmz18l9jmVJ9Egoub00d
         ykjsEq8ltj7iKstjQozxvlZbzHlMTqPyThk/Jelw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 059/171] apparmor: Fix aa_label_build() error handling for failed merges
Date:   Tue, 12 Mar 2019 10:07:19 -0700
Message-Id: <20190312170353.246784026@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d6d478aee003e19ef90321176552a8ad2929a47f ]

aa_label_merge() can return NULL for memory allocations failures
make sure to handle and set the correct error in this case.

Reported-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/domain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 08c88de0ffda..11975ec8d566 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1444,7 +1444,10 @@ int aa_change_profile(const char *fqname, int flags)
 			new = aa_label_merge(label, target, GFP_KERNEL);
 		if (IS_ERR_OR_NULL(new)) {
 			info = "failed to build target label";
-			error = PTR_ERR(new);
+			if (!new)
+				error = -ENOMEM;
+			else
+				error = PTR_ERR(new);
 			new = NULL;
 			perms.allow = 0;
 			goto audit;
-- 
2.19.1



