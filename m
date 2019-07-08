Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44130C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152162166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599099;
	bh=u5OHYWXogRGyjPJCzh9MC2XrxCMiu/h0Ez/huW086Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6JyPBxPq9UYCk2prTf5lmVk357Zk/AdbCLblvKCFyyx5AGPyQ6ej10j3wIsMXqlZ
	 9VykFkJ1qpDD6At+VXH5jKIAcHEM2XS0cpCHu0QoSzMORn3mf2ALjoLUNkVLySMmC6
	 /dVGpbUx+5GLSWyPBCTZK7ocvEQxPGWH+9dzHq9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfGHPSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbfGHPSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:18:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43EF216C4;
        Mon,  8 Jul 2019 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599091;
        bh=u5OHYWXogRGyjPJCzh9MC2XrxCMiu/h0Ez/huW086Vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtSf5Abfl+gdlceY4i9RJ+XWPTedq6pEYWSSIBRihSOU89pg/EO4/QSejE7It8lJ0
         VC096cDqSlTIYIp2moczyljMrAOJVMQHgOlTlIyFrch+MtzomiA3MuIO1hLbGgggAM
         rsRSoD+4H/xfQuW5TvPL7cw2Z0lKZgrMik48Jx3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 32/73] 9p: acl: fix uninitialized iattr access
Date:   Mon,  8 Jul 2019 17:12:42 +0200
Message-Id: <20190708150522.953751349@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
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
index c30c6ceac2c4..d02ee4026e32 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -282,7 +282,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 	switch (handler->flags) {
 	case ACL_TYPE_ACCESS:
 		if (acl) {
-			struct iattr iattr;
+			struct iattr iattr = { 0 };
 			struct posix_acl *old_acl = acl;
 
 			retval = posix_acl_update_mode(inode, &iattr.ia_mode, &acl);
-- 
2.20.1



