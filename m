Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570F3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAB82084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888233;
	bh=rsnNf15HrUbaGOrIbi6wyozb9yMbdByNuffKHCgCcss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kDrjY3wyTTRYrwmrFtqBUUbOl5c0cmuwcSOxICyfSnYKqlQ/PWmVgFjR1ik2DkkIv
	 rGTTNsBeGyXr1sVNmb5rrolrAeFx7Bpgd2hpMJUFn0iqsQMfbG+8PRQdP0N4eg5/Iy
	 xIJTePeEweun0xIolPpyltrz18DxgCrVnhdkPN9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfK0U5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730754AbfK0U5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:57:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632A821556;
        Wed, 27 Nov 2019 20:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888221;
        bh=rsnNf15HrUbaGOrIbi6wyozb9yMbdByNuffKHCgCcss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZD49FNIyTb9tcjGVAeOV21b2IyeqxlKS+Qxhg0IrVDPuUOK7yAsGo/56tnaGIb3Q
         WOnNU2bw4heg2OJnkgEJcDH161jjfDY4GaK7aJrXUR9RKcWfE6XcbWU6opd7p1dbRA
         m94fZZoEUZ9knkCDFYvsA1fZjsgrMBG5eQPVwGPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/306] btrfs: handle error of get_old_root
Date:   Wed, 27 Nov 2019 21:28:19 +0100
Message-Id: <20191127203118.381291584@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 315bed43fea532650933e7bba316a7601d439edf ]

In btrfs_search_old_slot get_old_root is always used with the assumption
it cannot fail. However, this is not true in rare circumstance it can
fail and return null. This will lead to null point dereference when the
header is read. Fix this by checking the return value and properly
handling NULL by setting ret to -EIO and returning gracefully.

Coverity-id: 1087503
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 9fd383285f0ea..fc764f350f05a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3031,6 +3031,10 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 
 again:
 	b = get_old_root(root, time_seq);
+	if (!b) {
+		ret = -EIO;
+		goto done;
+	}
 	level = btrfs_header_level(b);
 	p->locks[level] = BTRFS_READ_LOCK;
 
-- 
2.20.1



