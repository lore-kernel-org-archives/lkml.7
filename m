Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F8BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E61721826
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887722;
	bh=3mBeHU26KDoJnerDrK7TIAfbbYuBh2vF/7RxufJMUZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VKccVZnWZIzDFSVH04vknlPTboKYSkiMORvuXXE6skXD/R9u8r6xDoyBLTnnU4q7j
	 nWmhAFKjl7tMgn/zOA5WbZCdDMrmsWRbqbdPSUW9MIzGWJycfK5gt8qgYKM6/RlhfJ
	 xC/u3UFU6TDOzSdu+sOqhPY1j/cgP4L08G0IaMbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfK0Usl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbfK0Usi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:48:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 580AD217C3;
        Wed, 27 Nov 2019 20:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887717;
        bh=3mBeHU26KDoJnerDrK7TIAfbbYuBh2vF/7RxufJMUZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qncvGCimdKXda/LaYRTYYu997lybQkBV6IinT1Htt6JOnDUqT1uwV5OovbgXkcn6A
         c9c1Gf5dxWqUW8Pww3wL9vA23/9nNl5xuhXbZva43BIqscg90bu+O+m6TfEEjfhBYs
         Ked5yn6b0zkMwoX2DG+E3wGXddlR8DpweBLQeSE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/211] dm raid: avoid bitmap with raid4/5/6 journal device
Date:   Wed, 27 Nov 2019 21:30:00 +0100
Message-Id: <20191127203100.242392723@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit d857ad75edf3c0066fcd920746f9dc75382b3324 ]

With raid4/5/6, journal device and write intent bitmap are mutually exclusive.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 151211b4cb1ba..2c5912e755148 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2441,7 +2441,7 @@ static int super_validate(struct raid_set *rs, struct md_rdev *rdev)
 	}
 
 	/* Enable bitmap creation for RAID levels != 0 */
-	mddev->bitmap_info.offset = rt_is_raid0(rs->raid_type) ? 0 : to_sector(4096);
+	mddev->bitmap_info.offset = (rt_is_raid0(rs->raid_type) || rs->journal_dev.dev) ? 0 : to_sector(4096);
 	mddev->bitmap_info.default_offset = mddev->bitmap_info.offset;
 
 	if (!test_and_clear_bit(FirstUse, &rdev->flags)) {
-- 
2.20.1



