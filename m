Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E569C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338FC21537
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202107;
	bh=wNbhLMKQuLLNMYHuSnqZyPUBsHbPAsv1kUi64ou1XLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vef2W6ur8+M28L+eRMsVg3f7XKtMeYLxxDtZk20MoYnz5FGxN/+R2vTy4gfzwvs/G
	 SV2ocPQU2v08bnL/0JgW40oOsWPY04PWwvyNPhkUcNKhG9F7gBnIxv8VY8Ulzdu+iq
	 hAbzhrhax3tPirAU3Ad0ObdCdK8x1rGVQS74OEog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404430AbfGOOsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392363AbfGOOsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:48:21 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28C22067C;
        Mon, 15 Jul 2019 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563202100;
        bh=wNbhLMKQuLLNMYHuSnqZyPUBsHbPAsv1kUi64ou1XLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcVC0o/U/7LTvMs17GHqW780Yw0Yq5XSYHvBKufqF1W2kibxqVZlXDjBn0Wk694i5
         kLlKs0NyrRjjm2ssYhxKJNec8zPYyn0xi7Vq3XzaboSBkJWBeFsnDTKDrszM4lyXlk
         5KCspaAVdtt2PRjG91oEAHr3sjQCV7TLnBCnBKuk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 45/53] rslib: Fix decoding of shortened codes
Date:   Mon, 15 Jul 2019 10:45:27 -0400
Message-Id: <20190715144535.11636-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715144535.11636-1-sashal@kernel.org>
References: <20190715144535.11636-1-sashal@kernel.org>
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

