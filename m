Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2773620663
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077471;
	bh=wTOKYoN1hkwRLsnXsfoUdKsY9axvXnpmtkXwjRKK4/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F9Dy8XQ/87v41DkJbqODqQnpVz+qwWlp7C8VwQs2Ax6/9JOzA9NDbwRb2ImLXW0y0
	 SAERA7vAXKGEvLcqaH/jBaXEnn2QmguO3ZmfxnSleAYXNlW9FlqTPvlMQi6uliVtld
	 br+/QdYm/2pJ76RNdrSPNFoVgMHJWTsmz2tt7z4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfLKPRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731758AbfLKPRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:17:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772BD22527;
        Wed, 11 Dec 2019 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077467;
        bh=wTOKYoN1hkwRLsnXsfoUdKsY9axvXnpmtkXwjRKK4/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahjN4SJE6xmL6x8p9g6iejhbGHnp33PF+Mc56QGqQjKqJHVCjlFKwgibhX+HYGiZS
         ozZHLc6TO+ZGZYCTjFsTe/G1vYQdyGa1Bu8v8qH/tdprkOt7TEf1nB4vGPfN6B5Qlh
         vVvGFZf8tqCDE3h+HoCcq64LnxZy+5J7vpWJ20ds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/243] dlm: fix missing idr_destroy for recover_idr
Date:   Wed, 11 Dec 2019 16:03:32 +0100
Message-Id: <20191211150342.474126697@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Teigland <teigland@redhat.com>

[ Upstream commit 8fc6ed9a3508a0435b9270c313600799d210d319 ]

Which would leak memory for the idr internals.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lockspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 6a1529e478f3d..f1261fa0af8a1 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -807,6 +807,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_delete_debug_file(ls);
 
+	idr_destroy(&ls->ls_recover_idr);
 	kfree(ls->ls_recover_buf);
 
 	/*
-- 
2.20.1



