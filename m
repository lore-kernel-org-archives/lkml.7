Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44628C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EFC218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610512;
	bh=kCJt3JwqNdm3aevF7O44+VDGjeLz5bsxXkboIaqkkII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JGTXkYl4yMay17f4ofLXBc0YCKEeD0KZFUcjBDQWtNy0vEiIePN9FH8a/amKJoTqf
	 +C5sXzYmjRSa5KBbCdj604JKFNF0Q1K1oK6+f9Tc4FnG+vhckkMkHnGyoWogYp1aWo
	 C2ZBuJVkN682tUIeHRV5I0j3Ma/QDrLcgp8AnRPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbfDRSBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390620AbfDRSBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:01:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B1E218A6;
        Thu, 18 Apr 2019 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610506;
        bh=kCJt3JwqNdm3aevF7O44+VDGjeLz5bsxXkboIaqkkII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2leX578/9TMJsJzfkNNNI78dhNcPgKDu1vsF2356jXz2N/ZL52LiVEUViUIzAYibJ
         F247PZDTnXXE6jFSFgQSoiFKDe3BDnh1ZsrtvwOaHDvHqko1ZpgG00kIh2ZuPXZz1R
         aifV18i3TJdh+DT2Vp+NKKVpIopjpejS78PebO0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rohit kumar <rohitkr@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/110] ASoC: Fix UBSAN warning at snd_soc_get/put_volsw_sx()
Date:   Thu, 18 Apr 2019 19:56:48 +0200
Message-Id: <20190418160444.116463393@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



