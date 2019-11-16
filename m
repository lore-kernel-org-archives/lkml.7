Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1505C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFD32089D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920232;
	bh=8kDImJjryhfnFKRIvUpsUC0GDNu64NHJvZs6pjL/zvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZ8LCV6Xz6r0JDMSnelMFNUHNwqMKY6qZ/Yhvw9eIzP4/rfxJtUXTMiYJfVnQKlqr
	 3LHf+OHMYwnZnxZXcd8FXuzIsnwk8s0NLM+HBZ4a6Xh4gwZrBOYaVSSfrEYB9lBvFn
	 /T9kd5S/9PWj76LT/xJNAABwrWlCt6irXxRJdUDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfKPQDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbfKPPv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:51:58 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEECC20859;
        Sat, 16 Nov 2019 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919518;
        bh=8kDImJjryhfnFKRIvUpsUC0GDNu64NHJvZs6pjL/zvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NH7uylT/xdEUJ6PY5cdkYkkuFvBjHwoZwmlYQQfslpmiOUJ02BoSvQ1ROuUHoFYe5
         5KuAnEJgBaR9kVkDXMZ8JF3jDRaM3A+lrLqLWzEBnW1yZzkeeQpUewv2e8HzKvzFuD
         pr8U2NGx/Yuc9BbHZBg7V61CnG8UdyTgXpAYwZE8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 39/99] ceph: fix dentry leak in ceph_readdir_prepopulate
Date:   Sat, 16 Nov 2019 10:50:02 -0500
Message-Id: <20191116155103.10971-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
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
index 7fcddaaca8a5d..049cff197d2a1 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1630,7 +1630,6 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			if (IS_ERR(realdn)) {
 				err = PTR_ERR(realdn);
 				d_drop(dn);
-				dn = NULL;
 				goto next_item;
 			}
 			dn = realdn;
-- 
2.20.1

