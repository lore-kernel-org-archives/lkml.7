Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2A8C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA86123429
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102539;
	bh=JvqJEB55stf2gf4IFOdP9UEaXddRwXadDHyrHsyqYa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VODB5NKe4qPbz26OJYElrHMfxXMe7kpbckulr9XI94hK80PhL74/5b7eH96SjoFzl
	 LR/DWMDPR0ZUe03c+mUwf+gpqbsIxcZ6MBsopph9qnamYwspP9zvLAIbJ19Um2UEFo
	 akL+KJuwimUftWXTu8M81JjwLA7HnMQjIU/McV30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfH2SPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbfH2SPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:15:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB83423404;
        Thu, 29 Aug 2019 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102535;
        bh=JvqJEB55stf2gf4IFOdP9UEaXddRwXadDHyrHsyqYa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+JsQlVX8kGVgjvXj19Xp1yVSF9sC7SKtrGXa74UtY5tRc68KZY1V4bJ5zld6HgGi
         7Izc/4+Niv9rk52BDjKDqOFTmdpxzzpwmywVQYcoV0PvF9E6gJC1uq7StXxUFXkXVv
         BM+x1WWAHTvyDpA5JM6EUmDaXpsfoYm3dOOr8SDY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 70/76] afs: Fix leak in afs_lookup_cell_rcu()
Date:   Thu, 29 Aug 2019 14:13:05 -0400
Message-Id: <20190829181311.7562-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit a5fb8e6c02d6a518fb2b1a2b8c2471fa77b69436 ]

Fix a leak on the cell refcount in afs_lookup_cell_rcu() due to
non-clearance of the default error in the case a NULL cell name is passed
and the workstation default cell is used.

Also put a bit at the end to make sure we don't leak a cell ref if we're
going to be returning an error.

This leak results in an assertion like the following when the kafs module is
unloaded:

	AFS: Assertion failed
	2 == 1 is false
	0x2 == 0x1 is false
	------------[ cut here ]------------
	kernel BUG at fs/afs/cell.c:770!
	...
	RIP: 0010:afs_manage_cells+0x220/0x42f [kafs]
	...
	 process_one_work+0x4c2/0x82c
	 ? pool_mayday_timeout+0x1e1/0x1e1
	 ? do_raw_spin_lock+0x134/0x175
	 worker_thread+0x336/0x4a6
	 ? rescuer_thread+0x4af/0x4af
	 kthread+0x1de/0x1ee
	 ? kthread_park+0xd4/0xd4
	 ret_from_fork+0x24/0x30

Fixes: 989782dcdc91 ("afs: Overhaul cell database management")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/cell.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index a2a87117d2626..fd5133e26a38b 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -74,6 +74,7 @@ struct afs_cell *afs_lookup_cell_rcu(struct afs_net *net,
 			cell = rcu_dereference_raw(net->ws_cell);
 			if (cell) {
 				afs_get_cell(cell);
+				ret = 0;
 				break;
 			}
 			ret = -EDESTADDRREQ;
@@ -108,6 +109,9 @@ struct afs_cell *afs_lookup_cell_rcu(struct afs_net *net,
 
 	done_seqretry(&net->cells_lock, seq);
 
+	if (ret != 0 && cell)
+		afs_put_cell(net, cell);
+
 	return ret == 0 ? cell : ERR_PTR(ret);
 }
 
-- 
2.20.1

