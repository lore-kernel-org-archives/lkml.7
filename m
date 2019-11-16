Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBEBC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1696121845
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919668;
	bh=iiR4kDDEhYpcJ/YEDPwQBQvkWAMELFNv0f3X0Gx+zME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MRLeWWIFr2QO7AyTn3H3hK9lrv1IGzTjnN3r4DPwDGioCnaThBeG6IclxfYJvnOEt
	 KvHd7nIpjoUMNvhaFBuIUmMNquRmZC5YAotuahWx+YGbOUIw8c66u487jni1hB99PI
	 1J4UrLHOoscRXUXFOvpPa9T5owllOyCzo9DAkbt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfKPPy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfKPPyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:54:20 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A04E9208E3;
        Sat, 16 Nov 2019 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919660;
        bh=iiR4kDDEhYpcJ/YEDPwQBQvkWAMELFNv0f3X0Gx+zME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHvaxrSK+q6PCs1eOwSmDH7FyxqLaXaAk1zjhOFpVbADTN2tUM62dwJRWU5rlXurG
         aR9xrx0nvNW+7l5eW5hlI3gf0vPui7WZeT7INRRJNAkYMZxUH9dPWeZ+afxY7xrRwi
         6yqgq0P9iV/AnvTQlyKgGgq1Otl2/owHWyloqfDk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 32/77] ceph: fix dentry leak in ceph_readdir_prepopulate
Date:   Sat, 16 Nov 2019 10:52:54 -0500
Message-Id: <20191116155339.11909-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
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
index 2ad3f4ab4dcfa..0be931cf3c44c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1515,7 +1515,6 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			if (IS_ERR(realdn)) {
 				err = PTR_ERR(realdn);
 				d_drop(dn);
-				dn = NULL;
 				goto next_item;
 			}
 			dn = realdn;
-- 
2.20.1

