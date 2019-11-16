Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D10C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0E1206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920686;
	bh=FxaI0AtZm8o+30OUmW076oITI5YzZZ7hU76fw6RC0yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JQfkLHaCVHcTlRkk1Bd5m/w4MYPC0fRGXESrE9QoUJmmV3E4qfA/ZAaHAQrVG8UXG
	 qAr0TKd5hLNC81tKvIfEMAtom2BiuTN1iwkkl11JvEY2xb2qqlMiO/9K0/uy+HQO2s
	 +rr+VybOLYX1IUvo8y1xgPRurZsMKcHTATqvod3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfKPQLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbfKPPsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:39 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9255207FA;
        Sat, 16 Nov 2019 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919319;
        bh=FxaI0AtZm8o+30OUmW076oITI5YzZZ7hU76fw6RC0yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2J/hQuFPWXlYwT0XrcodhSoHu4V9qJv3CFKXsq/ja9rHLJ7N1cGbGuOXRWC57g19u
         hKiQq2DJoOsn1XmO9c0lVs3Q5cOhsQEjMRUQTX+hmVB4Jgms4UxlBc4Jg26v6B45JZ
         1d0QZnXH/H7wiNH7+Cs82V2tt1eoeRSrQ4cqaUn0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 060/150] ceph: fix dentry leak in ceph_readdir_prepopulate
Date:   Sat, 16 Nov 2019 10:45:58 -0500
Message-Id: <20191116154729.9573-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yan, Zheng" <zyan@redhat.com>

[ Upstream commit c58f450bd61511d897efc2ea472c69630635b557 ]

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 3818027c12f5a..5999d806de788 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1631,7 +1631,6 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			if (IS_ERR(realdn)) {
 				err = PTR_ERR(realdn);
 				d_drop(dn);
-				dn = NULL;
 				goto next_item;
 			}
 			dn = realdn;
-- 
2.20.1

