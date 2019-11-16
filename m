Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B95C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC2221844
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921446;
	bh=IjvQhKnlcixplGYef5OlTSVczlEn23RmU4lkJjnJ5sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hz/9hZBTNuZCOqGQBlVv/q+GrjTB9e1Fllo1Eb6cW5LKL4lBf3TDzy9kQlCm50pps
	 Mp2r45zqe5YeRTrfOcuCvhCjLJzpc1OOD82iw6zd3gBX1FewSFqGDxO8AuZntV6G7f
	 lbtoErjpEA7EdKjCWQmcMzU0DmQlfWGCpXcS5iMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfKPQYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:24:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbfKPPmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:44 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DB62083E;
        Sat, 16 Nov 2019 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918964;
        bh=IjvQhKnlcixplGYef5OlTSVczlEn23RmU4lkJjnJ5sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b43D3WsCCWOlYyrw//OpBinSqFzVDFq0iQfmWh5OnbxHlz5Ugagrtde4crE4faNJq
         MVRxaFygKE11Mf0cDdtHr5ZOJtDPXwZGxmbMMVKw/PE40HzbTjxTXyG42bewdZHIQ0
         M2nA/M6qAvC03Zys7k/1/whbd7fFnI24FB+qRp4k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 080/237] dm raid: avoid bitmap with raid4/5/6 journal device
Date:   Sat, 16 Nov 2019 10:38:35 -0500
Message-Id: <20191116154113.7417-80-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index b78a8a4d061ca..6c9b542882613 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2475,7 +2475,7 @@ static int super_validate(struct raid_set *rs, struct md_rdev *rdev)
 	}
 
 	/* Enable bitmap creation for RAID levels != 0 */
-	mddev->bitmap_info.offset = rt_is_raid0(rs->raid_type) ? 0 : to_sector(4096);
+	mddev->bitmap_info.offset = (rt_is_raid0(rs->raid_type) || rs->journal_dev.dev) ? 0 : to_sector(4096);
 	mddev->bitmap_info.default_offset = mddev->bitmap_info.offset;
 
 	if (!test_and_clear_bit(FirstUse, &rdev->flags)) {
-- 
2.20.1

