Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4963C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8220421848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201225;
	bh=wNbhLMKQuLLNMYHuSnqZyPUBsHbPAsv1kUi64ou1XLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VNFIY+QTPRWN4SP28v6vlOs+HYK72vf3L9MzMD+SB/F3S4DyUFe5q3ZRPkuJcdl/Z
	 gww9lQZvWwvHr4a9Iq7st4rX+jEwjd9tht9OeMU4fNCnBnWqp/PvEv2CpY2itcMokb
	 EI7SR64b+Zo2J1Xxt9vweW/D76W8bdtj2YaX/DzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbfGOOdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404095AbfGOOdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:33:40 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF41921530;
        Mon, 15 Jul 2019 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201220;
        bh=wNbhLMKQuLLNMYHuSnqZyPUBsHbPAsv1kUi64ou1XLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+6n/oImA2jCxiXTlz//595qXOYp083RZsK/WfmTQ5xGlM0ZY6F3Leit3y2hkuIgM
         pqYcWvlCMW7bZh6Ca9WsObx92L6cYc4MB1USpI30jofN8HFitdUZJdOgejhl4/c99k
         TGr/yj5Hi/It8CVQ81uZZNvzU/cL8a5v//0BUFk0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 081/105] rslib: Fix decoding of shortened codes
Date:   Mon, 15 Jul 2019 10:28:15 -0400
Message-Id: <20190715142839.9896-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715142839.9896-1-sashal@kernel.org>
References: <20190715142839.9896-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>

[ Upstream commit 2034a42d1747fc1e1eeef2c6f1789c4d0762cb9c ]

The decoding of shortenend codes is broken. It only works as expected if
there are no erasures.

When decoding with erasures, Lambda (the error and erasure locator
polynomial) is initialized from the given erasure positions. The pad
parameter is not accounted for by the initialisation code, and hence
Lambda is initialized from incorrect erasure positions.

The fix is to adjust the erasure positions by the supplied pad.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190620141039.9874-3-ferdinand.blomqvist@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/reed_solomon/decode_rs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 0ec3f257ffdf..8eed0f9ac495 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -99,9 +99,9 @@
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
 		lambda[1] = alpha_to[rs_modnn(rs,
-					      prim * (nn - 1 - eras_pos[0]))];
+					prim * (nn - 1 - (eras_pos[0] + pad)))];
 		for (i = 1; i < no_eras; i++) {
-			u = rs_modnn(rs, prim * (nn - 1 - eras_pos[i]));
+			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
 				if (tmp != nn) {
-- 
2.20.1

