Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFA8C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FF2206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199997;
	bh=ZAfC2BdUPmM5ghEIJn/MUgbjJZjPlBS0RDiZJpaogD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWvNAFFbQb6rdIx4GSoohmSIYfCw2ir3FaSp24nIr0Q2ShF42scQGPVorlLd00TX1
	 bECpFeU9pJSsmL/q20Rr9IbT2v8jU9dss7IEg5pKz9EszQJJvhR5bIQZoV1qmPxuoJ
	 69+9sXqGBDWgwPIswfCMToSVUWSRfcgpeXPHEvi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbfGOONQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389172AbfGOONP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:13:15 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 190E420868;
        Mon, 15 Jul 2019 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199994;
        bh=ZAfC2BdUPmM5ghEIJn/MUgbjJZjPlBS0RDiZJpaogD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdI5YUZy9ovon1Bc2AH0UKUielKB79+pBsekz3ZKiJkPVghboQiyIUs6okfbMdXiH
         0NNuD+2Xby+6kLjFAoLvl6cybdbuU7QbCI7bA+4be1996MKoCutiIjBaXAhM7tJZn1
         ZUfCYiojKNvMU6g/n/pSq3KpaUTQwO47sJDSTPbc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 155/219] rslib: Fix decoding of shortened codes
Date:   Mon, 15 Jul 2019 10:02:36 -0400
Message-Id: <20190715140341.6443-155-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
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
index 1db74eb098d0..3313bf944ff1 100644
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

