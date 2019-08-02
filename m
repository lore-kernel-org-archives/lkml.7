Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B560AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7D217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738512;
	bh=7tUjJMCnonz3h5QbK3ueb5c4qh4LMWMkL26XF54Rwps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jXYtF7V8mbZYmL3ng+g70YyN0aVLm8lEEaMSa080eGMUi+2cA/XVs6LuczH62y388
	 htvnDYPygnff92q7R5KX9skv2hpTiQRxDtqlLa0I8OA16QnoOWI524myuXUNk9dRSv
	 Dz9tkoQ3nCjMs+UB+F1lSaebmz+zBtB9zsMcLZbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbfHBJfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391607AbfHBJfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:35:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31BD217D7;
        Fri,  2 Aug 2019 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738507;
        bh=7tUjJMCnonz3h5QbK3ueb5c4qh4LMWMkL26XF54Rwps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHZw6F1iR4rT5UXoI5oXWaSs7P2LD5ZzQyIaU4e43E8ccH7OA7wB2JluFCFADF5bA
         VWkZJD8p8jHsyoDj2zC8Bp9RUiPytH3+7NryQsLsEiXGBMOoVfp+6pWvSfxTYEYWS9
         OQ5luBKN8aUCBhtgvJSvWKmNPi9AibTbVfZrk3pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Tracy <ctracy@engr.scu.edu>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 104/158] nfsd: fix performance-limiting session calculation
Date:   Fri,  2 Aug 2019 11:28:45 +0200
Message-Id: <20190802092225.622320812@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c54f24e338ed2a35218f117a4a1afb5f9e2b4e64 ]

We're unintentionally limiting the number of slots per nfsv4.1 session
to 10.  Often more than 10 simultaneous RPCs are needed for the best
performance.

This calculation was meant to prevent any one client from using up more
than a third of the limit we set for total memory use across all clients
and sessions.  Instead, it's limiting the client to a third of the
maximum for a single session.

Fix this.

Reported-by: Chris Tracy <ctracy@engr.scu.edu>
Cc: stable@vger.kernel.org
Fixes: de766e570413 "nfsd: give out fewer session slots as limit approaches"
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eb0f8af5203a..1e1abf1d5769 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1391,16 +1391,16 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
 {
 	u32 slotsize = slot_bytes(ca);
 	u32 num = ca->maxreqs;
-	int avail;
+	unsigned long avail, total_avail;
 
 	spin_lock(&nfsd_drc_lock);
-	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION,
-		    nfsd_drc_max_mem - nfsd_drc_mem_used);
+	total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
+	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
 	/*
 	 * Never use more than a third of the remaining memory,
 	 * unless it's the only way to give this client a slot:
 	 */
-	avail = clamp_t(int, avail, slotsize, avail/3);
+	avail = clamp_t(int, avail, slotsize, total_avail/3);
 	num = min_t(int, num, avail / slotsize);
 	nfsd_drc_mem_used += num * slotsize;
 	spin_unlock(&nfsd_drc_lock);
-- 
2.20.1



