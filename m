Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95A1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A68820715
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890553;
	bh=VE3R3aiHUNjnBCnPqcjznNJBj+dctkdav0mNL+LP5Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=chMIFeC61P4z24y/Iki3LtVJmEWiqgx18X59UR5rk9A3R5VCtn3ErTmyp51nNS/X+
	 pcDc2FCliRESttRtNWsRX//sp4R9swsRS77QsarWwlhy+VbIY3kdNrC68HRxIMHNUJ
	 qer+gkNbsetKWwVhR0f0unrMs+PGgPLIm12ZqnG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfK0Vfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbfK0Us6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:48:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0B9217C3;
        Wed, 27 Nov 2019 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887738;
        bh=VE3R3aiHUNjnBCnPqcjznNJBj+dctkdav0mNL+LP5Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwcm+NZMUCgWTk0Y/Ad6AJ/QnuJP1DJXayBewyL8lCeGCvLJmMSXJXC2pQE7CdIpD
         dtmFTcAwmoMR3KRXhLNWgkeLs7L6FmVXB7YgEqwFjP/XIPBOIzBVmeCBtTv+UDFfJj
         0dY2w7SlcoHlHQK/gRTGc8WnopmSvRj1nbm/bOa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 075/211] ceph: fix dentry leak in ceph_readdir_prepopulate
Date:   Wed, 27 Nov 2019 21:30:08 +0100
Message-Id: <20191127203100.909688424@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
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



