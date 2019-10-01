Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CDC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9069F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569949435;
	bh=vp8BY+ig8VH0RV4ooBLtwJ7jzgPrMoIacvhyxXcgS8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A8LLnbFJtBxHGUcKgOEf83aRRp7vkdDCcT+B2bFUR++5+3D4HU3ZtnnOnACesjJWC
	 QSG+4/gd/GgcF+tDMfybEDZD4DpndNfgk2iXjfFxQuc1Kx4VM/lz2ljw3jOkc+DU/Q
	 Ok1KLFtyjeFW0FSy5RugK8cN2hvu2+l8Xz/CR+aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfJARDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfJAQjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:39:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5429F21924;
        Tue,  1 Oct 2019 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569947981;
        bh=vp8BY+ig8VH0RV4ooBLtwJ7jzgPrMoIacvhyxXcgS8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yZtBPBf3zc6ZJs6zhuaWFkTOlBkOXlMlL5zhhjQW8clrV1Efn6e9XUqSx30E5UmYO
         V93pSZcSbdNypGL37CwiRyAe2kh7Wlrapo48QmCPYjjbMBX88SqSqRyP52b1iW08JZ
         Xd6zLR2fB6dX0RdTGs9P4IIH3ch4DGoNhFlTDgog=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 13/71] ceph: fetch cap_gen under spinlock in ceph_add_cap
Date:   Tue,  1 Oct 2019 12:38:23 -0400
Message-Id: <20191001163922.14735-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 606d102327a45a49d293557527802ee7fbfd7af1 ]

It's protected by the s_gen_ttl_lock, so we should fetch under it
and ensure that we're using the same generation in both places.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index ce0f5658720ab..8fd5301128106 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -645,6 +645,7 @@ void ceph_add_cap(struct inode *inode,
 	struct ceph_cap *cap;
 	int mds = session->s_mds;
 	int actual_wanted;
+	u32 gen;
 
 	dout("add_cap %p mds%d cap %llx %s seq %d\n", inode,
 	     session->s_mds, cap_id, ceph_cap_string(issued), seq);
@@ -656,6 +657,10 @@ void ceph_add_cap(struct inode *inode,
 	if (fmode >= 0)
 		wanted |= ceph_caps_for_mode(fmode);
 
+	spin_lock(&session->s_gen_ttl_lock);
+	gen = session->s_cap_gen;
+	spin_unlock(&session->s_gen_ttl_lock);
+
 	cap = __get_cap_for_mds(ci, mds);
 	if (!cap) {
 		cap = *new_cap;
@@ -681,7 +686,7 @@ void ceph_add_cap(struct inode *inode,
 		list_move_tail(&cap->session_caps, &session->s_caps);
 		spin_unlock(&session->s_cap_lock);
 
-		if (cap->cap_gen < session->s_cap_gen)
+		if (cap->cap_gen < gen)
 			cap->issued = cap->implemented = CEPH_CAP_PIN;
 
 		/*
@@ -775,7 +780,7 @@ void ceph_add_cap(struct inode *inode,
 	cap->seq = seq;
 	cap->issue_seq = seq;
 	cap->mseq = mseq;
-	cap->cap_gen = session->s_cap_gen;
+	cap->cap_gen = gen;
 
 	if (fmode >= 0)
 		__ceph_get_fmode(ci, fmode);
-- 
2.20.1

