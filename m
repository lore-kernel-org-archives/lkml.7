Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E6FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0B8215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887293;
	bh=VELRZtSvY3YuVIIJoHg3cIBVp/wCiKzd5UlQOaQz6LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1zHR6VjzzeUHcxTZBuZjYS514YhPiO1aWJlhm2Zod4X/v2FqSKPimVz4ru7BC3GwR
	 axZq4uhSm8LCsgd1jicQMswjVtp31W802eJw1Ej2wUaK49JnNjXhrrb/NUccgrSBOE
	 AFr8os3QkYeqGeL8C/ElZyU7MAvaIny25POhEir0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfK0Ulc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbfK0Ul1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:41:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29A720863;
        Wed, 27 Nov 2019 20:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887287;
        bh=VELRZtSvY3YuVIIJoHg3cIBVp/wCiKzd5UlQOaQz6LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAMso0V6Qa/oIymqmC5XS2oGlTy8MBARZAXZYxzE2R824GH4vSpwSIguu+jmVMQdp
         a21830BLsEc/DM3VxIiJPG0e35Zg9DD9SsaDnGwF80o2j58HCmnVkRM7G6/fZ2SJFh
         0YaBrjfg4vbUfsu1oqWP93ZOkm4djYEP0ASP4Qz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 051/151] ceph: fix dentry leak in ceph_readdir_prepopulate
Date:   Wed, 27 Nov 2019 21:30:34 +0100
Message-Id: <20191127203030.638117798@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan, Zheng <zyan@redhat.com>

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



