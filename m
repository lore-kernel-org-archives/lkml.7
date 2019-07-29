Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9DDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBA7217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428464;
	bh=erNs80+xO89ji3FxGHqrr4RJNC78SHV0qgHFA/oqA5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5AwqLrRyBI10/4eLKoLYQHzjzcFgETFJmGqRq+r19xDV8rjGum6iW9ndQoNNZSs+
	 Afr0NNVehf0GzbUWADdXAs9LytzqAUDbi61MygIqQMVdLgncwwfvJG5w71vieX616g
	 iG6uvYjq/mBJciYoJ3dZKOJtbQGmdDHKkHGJjS2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfG2T1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388361AbfG2T1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:27:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779422070B;
        Mon, 29 Jul 2019 19:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428460;
        bh=erNs80+xO89ji3FxGHqrr4RJNC78SHV0qgHFA/oqA5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9UcqCgxBLGqvhPf2oXugU+AkOPQbQdNFzPXKnDDm1+fjaU7wb4d3bSPvnKDvekQm
         3PP4tvbczTbxy2ro+k1wXhcXteqw4gC9a5fIzftiXYSNe+O75RkeTSkkK/OM7P2vde
         gxJhqrz3Fd8zv3Xt28+X7YS2zL9MupBe3U0m49a4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 083/293] rslib: Fix handling of of caller provided syndrome
Date:   Mon, 29 Jul 2019 21:19:34 +0200
Message-Id: <20190729190830.981410509@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ef4d6a8556b637ad27c8c2a2cff1dda3da38e9a9 ]

Check if the syndrome provided by the caller is zero, and act
accordingly.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190620141039.9874-6-ferdinand.blomqvist@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/reed_solomon/decode_rs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 8eed0f9ac495..a5d313381539 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -42,8 +42,18 @@
 	BUG_ON(pad < 0 || pad >= nn);
 
 	/* Does the caller provide the syndrome ? */
-	if (s != NULL)
-		goto decode;
+	if (s != NULL) {
+		for (i = 0; i < nroots; i++) {
+			/* The syndrome is in index form,
+			 * so nn represents zero
+			 */
+			if (s[i] != nn)
+				goto decode;
+		}
+
+		/* syndrome is zero, no errors to correct  */
+		return 0;
+	}
 
 	/* form the syndromes; i.e., evaluate data(x) at roots of
 	 * g(x) */
-- 
2.20.1



