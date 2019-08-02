Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053D720B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739277;
	bh=dULMVbLsM2Us/w7nK3XKknKq53cj9uoxHhCAqrBHDwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ickASlExtHpFpHw5Z+SGCXkv0vncDThwEqnW8twrV3rPkSWjQLozKmmG/N7maPAS3
	 VOUzx0T7FXxbEwlQBmnes8r7ypRb8SojYzITK5kWXH73GDrH+4998DjGJBXt7nGvZB
	 g+30NJIH4PKXmw0RM5qoO50cIyTkeRE5uLJq4+Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405761AbfHBJr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405745AbfHBJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:47:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 769212086A;
        Fri,  2 Aug 2019 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739272;
        bh=dULMVbLsM2Us/w7nK3XKknKq53cj9uoxHhCAqrBHDwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3OvZ7VoOiBy3Nt9miJlFM8WG+1BpH4ytMpIeiYaV4rElaFf70TZkfG+IFNoW+6/5
         /HG7uZ/wrJaZoJo08wO7kTBTKRD5q+srREb4zaCqC/TxUCdaBh8Z/Kj0zOIUpr1BP0
         7h7rfma1UWCeuTLMPvwwmGU4fkQ9njvkIsYBsLIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 155/223] nfsd: increase DRC cache limit
Date:   Fri,  2 Aug 2019 11:36:20 +0200
Message-Id: <20190802092248.400563878@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 44d8660d3bb0a1c8363ebcb906af2343ea8e15f6 ]

An NFSv4.1+ client negotiates the size of its duplicate reply cache size
in the initial CREATE_SESSION request.  The server preallocates the
memory for the duplicate reply cache to ensure that we'll never fail to
record the response to a nonidempotent operation.

To prevent a few CREATE_SESSIONs from consuming all of memory we set an
upper limit based on nr_free_buffer_pages().  1/2^10 has been too
limiting in practice; 1/2^7 is still less than one percent.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 5c4800626f13..60291d10f8e4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -430,7 +430,7 @@ void nfsd_reset_versions(void)
  */
 static void set_max_drc(void)
 {
-	#define NFSD_DRC_SIZE_SHIFT	10
+	#define NFSD_DRC_SIZE_SHIFT	7
 	nfsd_drc_max_mem = (nr_free_buffer_pages()
 					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
 	nfsd_drc_mem_used = 0;
-- 
2.20.1



