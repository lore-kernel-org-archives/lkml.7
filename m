Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6667C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E06E20868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200008;
	bh=9oPmWzZADG9KBbFCDoRtLvhV03Hq67ZJeep/W6VUocU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWd3zWeDQ7+XCTpdwZkE8KU1Zf+llrF0QRNlGlPDzihXyZ3ezo9Wpl/2Vo9hoHuts
	 rJURhj3NeEloTnQ2ptkECMAZHMhrdkutWqDd8rZUfHLfhMAywWYsop2bF0iQXZ7XT/
	 +W/aUWgMuabQEUv1I2w1LFIhHbP36qAxUygJ6TEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbfGOON1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388218AbfGOONZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:13:25 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596F4206B8;
        Mon, 15 Jul 2019 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200005;
        bh=9oPmWzZADG9KBbFCDoRtLvhV03Hq67ZJeep/W6VUocU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpPMX6xVE3dj1M0inypW1F7eerknt3Vg2nK+OZvUZPNd2z0rG+U+TzXQXTXPxwKf0
         kHTh9QDNX0ocSexXM8TZIoBLRScJMzX88NXTMSpXbF4z1WV83zEXH0p0WB+Ho6/FS+
         htsDCrtdbhKipK8Zhs1De0w48vXo3LFhhwGEh+3c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 157/219] rslib: Fix handling of of caller provided syndrome
Date:   Mon, 15 Jul 2019 10:02:38 -0400
Message-Id: <20190715140341.6443-157-sashal@kernel.org>
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
index 3313bf944ff1..121beb2f0930 100644
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

