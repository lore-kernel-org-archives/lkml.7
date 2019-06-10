Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC345C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F3120859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560197046;
	bh=EEM60hx0Cg11HZyZntSFHA/iscCPUJpHnXsJkgBcK8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJ6UULMiSfuq38zxG8fwfBIT0gZsJMyYcn/kLjYLFXfen42UPClu880B56GPlIoSB
	 g0jnc1Qm9AASsi/4ol1GLjJCIL6vK3y6+QR9o09pLfjkAJKjDGX9UvuzvoenP+LY45
	 8YXkE0aDm4bXLeNI/pSRBMWtIVjHEwJkIWjzJJQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbfFJUEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389170AbfFJUEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:04:05 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA517206E0;
        Mon, 10 Jun 2019 20:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560197044;
        bh=EEM60hx0Cg11HZyZntSFHA/iscCPUJpHnXsJkgBcK8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pv8oFNoQVwT2RW5VbB++HK+2YgQbfWB6yNMakBTBXq4KSdDzBNEiM5ZRHCNqkvNbC
         d04saLAExi3vGh4ehkF/90ufwgCGmRL2AGVLySoXfPpK40lFp++Mcm0TydQ8QGrot5
         liPTCrEuS50F0cZpYV/3Be9CSQIuv1s3ITaRkAGw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] cfg80211: fix memory leak of wiphy device name
Date:   Mon, 10 Jun 2019 13:02:19 -0700
Message-Id: <20190610200219.241300-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <00000000000026f98d058a0944ed@google.com>
References: <00000000000026f98d058a0944ed@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In wiphy_new_nm(), if an error occurs after dev_set_name() and
device_initialize() have already been called, it's necessary to call
put_device() (via wiphy_free()) to avoid a memory leak.

Reported-by: syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com
Fixes: 1f87f7d3a3b4 ("cfg80211: add rfkill support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/wireless/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 037816163e70d..458f5e0906875 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -514,7 +514,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 				   &rdev->rfkill_ops, rdev);
 
 	if (!rdev->rfkill) {
-		kfree(rdev);
+		wiphy_free(&rdev->wiphy);
 		return NULL;
 	}
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

