Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B751AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8550B217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893440;
	bh=VOBrXKGBSwVOlpOn6lPZW63CEq/o4um1ONSFvoetJZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qQPt5HQhOhQ06L1zS7b7LHKfFYqd7z0a3Bm1gcMrknKDQtgP4OWdi9P4W5vrz5QhO
	 PiPtZrHfMJyZOwFBFJwGOYUvV4aKpyKn5sT4UMN9WZYkNWUBwvDjCaTMblhXAt9xoy
	 7XsISJef+1hICnjdDct5p35SKcMADvE/UkgUhDUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfH0IKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731972AbfH0IC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:02:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E3A2186A;
        Tue, 27 Aug 2019 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892948;
        bh=VOBrXKGBSwVOlpOn6lPZW63CEq/o4um1ONSFvoetJZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWraExVKpwYFcDB6b0YbMjA1AgKUZrT96ImJjTwkF+z1NFvYt8ESh1Adio+S5gqjV
         /Ml7FrbU8bIKkzAFs9aR+cbfhVouhr6lxry19+CaCAsC+COJdJBovBbmQa77I4Bewy
         t6BVAsd5MHoYwUAPAkqFIOLpAbKkoJYlcLmLAiiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 071/162] NFSv4: Fix a credential refcount leak in nfs41_check_delegation_stateid
Date:   Tue, 27 Aug 2019 09:49:59 +0200
Message-Id: <20190827072740.607306162@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c39a39e28b86a4021d9be314ce01019bafa5fdc ]

It is unsafe to dereference delegation outside the rcu lock, and in
any case, the refcount is guaranteed held if cred is non-zero.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 63edda145d1b8..420f2350c2781 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2752,8 +2752,7 @@ static void nfs41_check_delegation_stateid(struct nfs4_state *state)
 	if (status == -NFS4ERR_EXPIRED || status == -NFS4ERR_BAD_STATEID)
 		nfs_finish_clear_delegation_stateid(state, &stateid);
 
-	if (delegation->cred)
-		put_cred(cred);
+	put_cred(cred);
 }
 
 /**
-- 
2.20.1



