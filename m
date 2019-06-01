Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E36EC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE98D273D5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395632;
	bh=8dJthh1jYsngYIJ74T3O79DJE0/Xj/gr+R9BWBUL8gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DhqCrB/Gghh1bpXFhp8bO8SqBt9Ys0jZ58ldQxydrIxeCt55NzEFbjp6kNmgKG35Z
	 LEIaknxEcij644N8Gd2wtoDxt3kTyQ+s9iEgJhbmZ+1cz/LSmAZbaT9PoppBfELSrs
	 6QIB+QZ6e3HyquDE94lXjHUH9f/gh16Vl3Wp4M7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfFAN1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfFAN1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:27:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F68E273CB;
        Sat,  1 Jun 2019 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395625;
        bh=8dJthh1jYsngYIJ74T3O79DJE0/Xj/gr+R9BWBUL8gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYWQApqnLTC9qgr+xT2ocmHVtgLxAz9de3iN/SXsm+NfU01/VNcHVytZtQoDnNmft
         IdKf0dzUWlSqAg2Ux7pnozO1L4Is1zugq2SEd/FS+v35+vdJ69UEeTGEzrSscGjAAw
         GYejvMfDwACv8Lr1EgSeDQ0Hr3whOdv44Btkm8+s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Xiao Ni <xni@redhat.com>,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 38/56] md: add mddev->pers to avoid potential NULL pointer dereference
Date:   Sat,  1 Jun 2019 09:25:42 -0400
Message-Id: <20190601132600.27427-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit ee37e62191a59d253fc916b9fc763deb777211e2 ]

When doing re-add, we need to ensure rdev->mddev->pers is not NULL,
which can avoid potential NULL pointer derefence in fallowing
add_bound_rdev().

Fixes: a6da4ef85cef ("md: re-add a failed disk")
Cc: Xiao Ni <xni@redhat.com>
Cc: NeilBrown <neilb@suse.com>
Cc: <stable@vger.kernel.org> # 4.4+
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 07f307402351b..f71cca28dddac 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2690,8 +2690,10 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 			err = 0;
 		}
 	} else if (cmd_match(buf, "re-add")) {
-		if (test_bit(Faulty, &rdev->flags) && (rdev->raid_disk == -1) &&
-			rdev->saved_raid_disk >= 0) {
+		if (!rdev->mddev->pers)
+			err = -EINVAL;
+		else if (test_bit(Faulty, &rdev->flags) && (rdev->raid_disk == -1) &&
+				rdev->saved_raid_disk >= 0) {
 			/* clear_bit is performed _after_ all the devices
 			 * have their local Faulty bit cleared. If any writes
 			 * happen in the meantime in the local node, they
-- 
2.20.1

