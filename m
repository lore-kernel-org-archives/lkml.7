Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309542183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553910062;
	bh=grw32U0dqpgwD1a6Hxj9EFSfLAWiwA5F8XAHInIRm8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nzYUocDNNVgDsWzOiv4tp3Kx65fn8D7E6cj3P4cgya0nOumN19qvB7GxGx26hnvY2
	 hSc6OvTFK4aSAnYYRDeynNaGcRp8MynoNsXXtfDHlu1Axor8vdWlRNJc6xpx5YKkbo
	 GIZ2uNIr8eamu1EC99s+K0lLx9jKUO5mekv5S1YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbfC3BlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730740AbfC3B3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6346E218FC;
        Sat, 30 Mar 2019 01:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909343;
        bh=grw32U0dqpgwD1a6Hxj9EFSfLAWiwA5F8XAHInIRm8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y97U5r8RWGdefVzkyQMVcanbAC6BMgYN60TF5hjXEOt7QCfHdseLFRKKiBmX1Vd+4
         Y0nzvCZcTwXdikiMibFqioaF1ZbLj+bpU4U3vsc6sYgA49EXRgq5NPg5+ADFO+HT41
         YK6QYsjDCgFfMbt262JurQwo5SLE9fxF/xSI1isY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 07/57] ASoC: Fix UBSAN warning at snd_soc_get/put_volsw_sx()
Date:   Fri, 29 Mar 2019 21:28:00 -0400
Message-Id: <20190330012854.32212-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohit kumar <rohitkr@codeaurora.org>

[ Upstream commit ae7d1247d8673ebfd686b17e759d4be391165368 ]

In functions snd_soc_get_volsw_sx() or snd_soc_put_volsw_sx(),
if the result of (min + max) is negative, then fls() returns
signed integer with value as 32. This leads to signed integer
overflow as complete operation is considered as signed integer.

UBSAN: Undefined behaviour in sound/soc/soc-ops.c:382:50
signed integer overflow:
-2147483648 - 1 cannot be represented in type 'int'
Call trace:
[<ffffff852f746fe4>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffffff852f746fe4>] dump_stack+0xec/0x158 lib/dump_stack.c:51
[<ffffff852f7b5f3c>] ubsan_epilogue+0x18/0x50 lib/ubsan.c:164
[<ffffff852f7b6840>] handle_overflow+0xf8/0x130 lib/ubsan.c:195
[<ffffff852f7b68f0>] __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:211
[<ffffff85307971a0>] snd_soc_get_volsw_sx+0x1a8/0x1f8 sound/soc/soc-ops.c:382

Typecast the operation to unsigned int to fix the issue.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 592efb370c44..f4dc3d445aae 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -373,7 +373,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
 	unsigned int val;
 	int ret;
 
@@ -418,7 +418,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	int min = mc->min;
-	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
+	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;
 	int err = 0;
 	unsigned int val, val_mask, val2 = 0;
 
-- 
2.19.1

