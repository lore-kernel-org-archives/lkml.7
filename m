Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B5C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B63220842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749196;
	bh=fG5gKSURpvl8cm1v+OZybGwKNiFssUS3aCFzr7Uketo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0oxV31bs2XYo1S2HD59PVGXwe/NHKhLvcIUxzXWB3jfNCIf7mMKDmBBYSag08aIVH
	 f7bzzWLeIr+ky3//E2XXiFcj0ukmvhirZaQ2eU2oQN2nlp45Hii40NuqegwZ7MMJJO
	 8D0F1syFVgHpndKaGuZCEfVZ+tNsRfqxM7QaTyk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfHNCTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfHNCTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:19:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29862084D;
        Wed, 14 Aug 2019 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749176;
        bh=fG5gKSURpvl8cm1v+OZybGwKNiFssUS3aCFzr7Uketo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDPiDtMhlWrIrG1TVscC5A7ZQNO5aFEFHj6FnSFoqUxlesYtXEKsiJ7ioy98F3ZRI
         KDrZV1Trsok7RS7bVeol2Sjcuviv37ai38ngY66lPTNhKB3RMaojtRJmm7lJphFAKD
         6lZkdl72LO18Ytg66cy6uJUrWJj0SwbSjNWYZS8Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Deepak Rawat <drawat@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 40/44] drm/vmwgfx: fix memory leak when too many retries have occurred
Date:   Tue, 13 Aug 2019 22:18:29 -0400
Message-Id: <20190814021834.16662-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021834.16662-1-sashal@kernel.org>
References: <20190814021834.16662-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 6b7c3b86f0b63134b2ab56508921a0853ffa687a ]

Currently when too many retries have occurred there is a memory
leak on the allocation for reply on the error return path. Fix
this by kfree'ing reply before returning.

Addresses-Coverity: ("Resource leak")
Fixes: a9cd9c044aa9 ("drm/vmwgfx: Add a check to handle host message failure")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 97000996b8dc5..50cc060cc552a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -300,8 +300,10 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 		break;
 	}
 
-	if (retries == RETRIES)
+	if (retries == RETRIES) {
+		kfree(reply);
 		return -EINVAL;
+	}
 
 	*msg_len = reply_len;
 	*msg     = reply;
-- 
2.20.1

