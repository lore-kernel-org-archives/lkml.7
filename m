Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2716ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74662070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572095864;
	bh=qqvNnOjqCOD1FypEMsgnyT4VFPIZF5ZQH7kISA2LnS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNj56imGn1UcJ9GfgLD+lGGtM4E0wlJVcY7d65ePFKUT5Ub6u8guhOgEuTG+K94xQ
	 N/YXZnAAp/U6n6bD+INPey3lF1Orfxypo9TUh8Ck3cbcs1ur9ZRvWr2eGO8S9X8jNs
	 TRVPvCPpzGo6nf5rcSJsLssVp5ET+nYd79weOO/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfJZNRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbfJZNRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:17:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0699222BE;
        Sat, 26 Oct 2019 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095858;
        bh=qqvNnOjqCOD1FypEMsgnyT4VFPIZF5ZQH7kISA2LnS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Krj6lR9dVs9d7WbbPv3Ilr2e2Y9XMm+0XKnktvYD5oaLMtRDF1X2ryCL7KU8se5Y2
         yrrMiWLsynddnx2nZgMEVo0lNNZgumJO0o8Pn+hfOfNRoQCv8qdMa4XUeIn3NVL9Zg
         y+FDFFQf1JT8us0Ln+eE6S++rQAHLO/AM9D2GbXc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 51/99] net: avoid possible false sharing in sk_leave_memory_pressure()
Date:   Sat, 26 Oct 2019 09:15:12 -0400
Message-Id: <20191026131600.2507-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 503978aca46124cd714703e180b9c8292ba50ba7 ]

As mentioned in https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance
a C compiler can legally transform :

if (memory_pressure && *memory_pressure)
        *memory_pressure = 0;

to :

if (memory_pressure)
        *memory_pressure = 0;

Fixes: 0604475119de ("tcp: add TCPMemoryPressuresChrono counter")
Fixes: 180d8cd942ce ("foundations of per-cgroup memory pressure controlling.")
Fixes: 3ab224be6d69 ("[NET] CORE: Introducing new memory accounting interface.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 3aa93af51d48d..650873f5b9ce2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2331,8 +2331,8 @@ static void sk_leave_memory_pressure(struct sock *sk)
 	} else {
 		unsigned long *memory_pressure = sk->sk_prot->memory_pressure;
 
-		if (memory_pressure && *memory_pressure)
-			*memory_pressure = 0;
+		if (memory_pressure && READ_ONCE(*memory_pressure))
+			WRITE_ONCE(*memory_pressure, 0);
 	}
 }
 
-- 
2.20.1

