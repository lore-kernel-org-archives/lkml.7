Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8748CC06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBBF206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055145;
	bh=2bcg2DM1IE8ugKmuof6Mw84sS9E6si19t81ORiMJElU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tjW5lOYljzAkKynFGTSyFuhrpS1heZ5A/TO9eNMOC8yYNVMgV+x0lMza+MhTqw3Dj
	 66mN07PBJ9R8Vz3xItX9YY++rKO0My2x2IydZUcrqj2jMpMiKNKhzgkeZv4gri+Ra6
	 V8Wt2QMpQFoUpnOEOvX77Skku1fDXPohU/7KzV8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfGBIIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbfGBIIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:08:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60422183F;
        Tue,  2 Jul 2019 08:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054931;
        bh=2bcg2DM1IE8ugKmuof6Mw84sS9E6si19t81ORiMJElU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssAf2mjPIc7LJzYCheLeGTYX1WlVb9NJGTRQ+WJukN1JSEbJRmT/seWDt/LYyHqQm
         yT1ASjA3SNqkycWzz2E0knxK/XIJzUe0pzTO9N2yfIMtzcPRDqtpU3AEkv8UAC145w
         E13hu1lAJzSkMtoRqUGilR9tJtGDFzKfCP3r4Jxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 10/43] 9p: acl: fix uninitialized iattr access
Date:   Tue,  2 Jul 2019 10:01:50 +0200
Message-Id: <20190702080124.367821117@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
References: <20190702080123.904399496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e02a53d92e197706cad1627bd84705d4aa20a145 ]

iattr is passed to v9fs_vfs_setattr_dotl which does send various
values from iattr over the wire, even if it tells the server to
only look at iattr.ia_valid fields this could leak some stack data.

Link: http://lkml.kernel.org/r/1536339057-21974-2-git-send-email-asmadeus@codewreck.org
Addresses-Coverity-ID: 1195601 ("Uninitalized scalar variable")
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 082d227fa56b..6261719f6f2a 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -276,7 +276,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 	switch (handler->flags) {
 	case ACL_TYPE_ACCESS:
 		if (acl) {
-			struct iattr iattr;
+			struct iattr iattr = { 0 };
 			struct posix_acl *old_acl = acl;
 
 			retval = posix_acl_update_mode(inode, &iattr.ia_mode, &acl);
-- 
2.20.1



