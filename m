Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB85C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282EA20830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256629;
	bh=Qal5UGXYrZXxPW+SVeVYlFIQoRcQTy9Elq3K67swYI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8pPSgfsVuznhl4kgi0iGEhgstZi1beVGNXbl4N4+sKUvWsiDtLRca4HISURk57y/
	 t0drzpBapakx+hPlw897uG7Riw6yzEHVCHsmiHKTameZN4pa/xU1qqsAScpkox4d4U
	 Kg8+sBxZ8tqf5AV5ImHheegY7wSQwXbFj1h8bGN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbfCVMK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389408AbfCVMKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE5D20830;
        Fri, 22 Mar 2019 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256617;
        bh=Qal5UGXYrZXxPW+SVeVYlFIQoRcQTy9Elq3K67swYI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/fJlEYtLXtECWdUXZoyTl+Pe5BRI9+texkF4AnjKVs1U/Rbh8w/nNf858HnW+uGI
         aKUtydoKSdqyAvNB37EntrRNXNIQQt1WO8uCW8ejdCv7gBHP1MaJVKWXH9jhHTiBdK
         v6vCNzkJMukT8UxigizW+dqJNdfu4TSozD/5iP8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Tracy <ctracy@engr.scu.edu>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 243/280] nfsd: fix performance-limiting session calculation
Date:   Fri, 22 Mar 2019 12:16:36 +0100
Message-Id: <20190322111339.897437668@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit c54f24e338ed2a35218f117a4a1afb5f9e2b4e64 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1514,16 +1514,16 @@ static u32 nfsd4_get_drc_mem(struct nfsd
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


