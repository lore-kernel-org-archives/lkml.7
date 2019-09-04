Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B19C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CBB2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613835;
	bh=NCKSJd3yW93ThPjxg8k5p+Y2bbx7TMPopGxJbJ3B2/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPjPhSdJ8pJnkf/aoap0ee6h74q1GHq45djuuL/kjVLsUXAN5rKVc3Hs/OwhaY1NJ
	 QiA2Oy6uBgYeZ6SgSKRUZYnzxv2zKrELJBVqWgaFGDytG1dgtTID6fNm+Gk3wkF4FG
	 8c/kQ3HDAxBLYcTjTED3rmcf1pxFiLa35eIQ31uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfIDP7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732283AbfIDP7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2110B2087E;
        Wed,  4 Sep 2019 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612750;
        bh=NCKSJd3yW93ThPjxg8k5p+Y2bbx7TMPopGxJbJ3B2/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJZl8q2XjiPL+j4HYnSxzWt7j3AVZ1StvjmWQsQK8ilf4m1uu0xp8BW+79p7+Y3wT
         ILI+La3wSJqGti/1hW860iYlHcbrgnbfjdyqz7aBM2EXy2bNwhUBb/VJhIyJOnem9o
         cWZOgPYROaQWFfZFsDIGT7a928vpnXV7u2BlSeQg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 60/94] cifs: Use kzfree() to zero out the password
Date:   Wed,  4 Sep 2019 11:57:05 -0400
Message-Id: <20190904155739.2816-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 478228e57f81f6cb60798d54fc02a74ea7dd267e ]

It's safer to zero out the password so that it can never be disclosed.

Fixes: 0c219f5799c7 ("cifs: set domainName when a domain-key is used in multiuser")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 2beaa14519f5d..85b2107e8a3d7 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3081,7 +3081,7 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 			rc = -ENOMEM;
 			kfree(vol->username);
 			vol->username = NULL;
-			kfree(vol->password);
+			kzfree(vol->password);
 			vol->password = NULL;
 			goto out_key_put;
 		}
-- 
2.20.1

