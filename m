Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35908C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAEA20803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413292;
	bh=6ziXoorEpCDVd81qU1RUbKYkrr9kZ2VkhGB1ugj7cXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jb1dKcrv3EY74Z53iuAyqtqYKi6VXOQBtjzt4u42bEUlqQSu3Yiso+F30Itth52tx
	 DvJ/P5HIn1dFzfZk2lazk0hq5md4qM8L51o9N7YBK60Ac9PlkI/fB92ZvBjWLj7MIx
	 3ensP4QyhLrm1C0uvYVnQFgpAOV2Aeutz7tHRvgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfLCWsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfLCWsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:48:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2E620656;
        Tue,  3 Dec 2019 22:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413286;
        bh=6ziXoorEpCDVd81qU1RUbKYkrr9kZ2VkhGB1ugj7cXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kldZUAHwHejz1e4fddtUy+NNVz1f6eehkeyDxoghDKoF+aKmUEenHLYdB5g2gXNV9
         jJZk68vU78kToTYweLoNmRsDLG4fGhSgpmr6lGHff/lMXn9CmbpDgQTbA49tZYKXUj
         Fysb4x/IJtur1zod3ok0P2PKwxC9XS5zeLrA2TKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/321] net/fq_impl: Switch to kvmalloc() for memory allocation
Date:   Tue,  3 Dec 2019 23:31:49 +0100
Message-Id: <20191203223429.350978817@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 71e67c3bd127cfe7863f54e4b087eba1cc8f9a7a ]

The FQ implementation used by mac80211 allocates memory using kmalloc(),
which can fail; and Johannes reported that this actually happens in
practice.

To avoid this, switch the allocation to kvmalloc() instead; this also
brings fq_impl in line with all the FQ qdiscs.

Fixes: 557fc4a09803 ("fq: add fair queuing framework")
Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/20191105155750.547379-1-toke@redhat.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/fq_impl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index 89a012905ef0b..4b3e18ff8e6f2 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -312,7 +312,7 @@ static int fq_init(struct fq *fq, int flows_cnt)
 	fq->limit = 8192;
 	fq->memory_limit = 16 << 20; /* 16 MBytes */
 
-	fq->flows = kcalloc(fq->flows_cnt, sizeof(fq->flows[0]), GFP_KERNEL);
+	fq->flows = kvcalloc(fq->flows_cnt, sizeof(fq->flows[0]), GFP_KERNEL);
 	if (!fq->flows)
 		return -ENOMEM;
 
@@ -330,7 +330,7 @@ static void fq_reset(struct fq *fq,
 	for (i = 0; i < fq->flows_cnt; i++)
 		fq_flow_reset(fq, &fq->flows[i], free_func);
 
-	kfree(fq->flows);
+	kvfree(fq->flows);
 	fq->flows = NULL;
 }
 
-- 
2.20.1



