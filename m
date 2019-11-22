Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CA82070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452502;
	bh=aH3NgSqNTgSDxlIBCBAdPx6WOKiGSYN7EKd8mry7b34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XInaOMFNqpB+VGieHWbM7GOWPgeYzCiuZw8Bmph225fN/I8grdJwrpAQj7p54x5JC
	 tokIiVMaX9pfWwn/VeBXs2sbLTs1TMt8Te8DhM0UgAIskhyYlT1hEUwQlXf4w0EZQJ
	 of+G7VxGRLS501b3Dfm9131SZBZW+m0hnuc6TXRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfKVTzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbfKVTtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:49:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2972071C;
        Fri, 22 Nov 2019 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452143;
        bh=aH3NgSqNTgSDxlIBCBAdPx6WOKiGSYN7EKd8mry7b34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOdGghW8Vrd6gkXAncphawH1YrkWLHr9uWFGPn4TXMji8vXK9+2/Cu/lMytDcdMwQ
         nnTnPTqNuPPLgqhsz8nUTwzzNMBUuDVkqIS4uBHBy6W3n2Nw+IttolvYsHl08PRYcU
         OonkLo/q8PJSZjSJHnxm8GojX6HW/rwkiKBLSPeg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        JD <jdtxs00@gmail.com>, Paul Wouters <paul@nohats.ca>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/25] xfrm: Fix memleak on xfrm state destroy
Date:   Fri, 22 Nov 2019 14:48:36 -0500
Message-Id: <20191122194859.24508-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122194859.24508-1-sashal@kernel.org>
References: <20191122194859.24508-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 86c6739eda7d2a03f2db30cbee67a5fb81afa8ba ]

We leak the page that we use to create skb page fragments
when destroying the xfrm_state. Fix this by dropping a
page reference if a page was assigned to the xfrm_state.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Reported-by: JD <jdtxs00@gmail.com>
Reported-by: Paul Wouters <paul@nohats.ca>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 11e09eb138d60..47a8ff972a2bf 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -456,6 +456,8 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
 	}
+	if (x->xfrag.page)
+		put_page(x->xfrag.page);
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
 	xfrm_state_free(x);
-- 
2.20.1

