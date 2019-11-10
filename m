Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4910BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15608214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353667;
	bh=LwqOr4I4zulBalz0R9isVxO+q7yNbwDmSBSJJrSTNSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKxELietQlrImpa4dbOye/NTNIZJwOK7iBeHc652vxLvfCPVW08WlwKg/DYIhrwul
	 LiXry7j8XzEPNCrRk393+el7cz7n/Mb8K2VMnFpqdusp/XGylSBF3BVnwPMkvvUSLN
	 5bmBrwvfgMVU4YWUQnjGAHr5UdQy7+nFswZFrq84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKJClF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfKJCkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:40:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623472184C;
        Sun, 10 Nov 2019 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353637;
        bh=LwqOr4I4zulBalz0R9isVxO+q7yNbwDmSBSJJrSTNSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFEqicX5bpzpWdB956ffG689808F47PivI1oFVB5lk9f/r6UD8M8+/M9AZ8Ac7cns
         XxCy46xCqAQ1uBVsoN7xWQZEaxDhgoPlxJ9/PHXUJEMzuM6G6xkIrG8O+ARouxeZoS
         b74Ay97M7IbhAgd2Uee0EG26U9jE1AVou0QBCtbo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 020/191] ipmi_si: fix potential integer overflow on large shift
Date:   Sat,  9 Nov 2019 21:37:22 -0500
Message-Id: <20191110024013.29782-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 97a103e6b584442cd848887ed8d47be2410b7e09 ]

Shifting unsigned char b by an int type can lead to sign-extension
overflow. For example, if b is 0xff and the shift is 24, then top
bit is sign-extended so the final value passed to writeq has all
the upper 32 bits set.  Fix this by casting b to a 64 bit unsigned
before the shift.

Detected by CoverityScan, CID#1465246 ("Unintended sign extension")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_si_mem_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_mem_io.c b/drivers/char/ipmi/ipmi_si_mem_io.c
index 638f4ab88f445..75583612ab105 100644
--- a/drivers/char/ipmi/ipmi_si_mem_io.c
+++ b/drivers/char/ipmi/ipmi_si_mem_io.c
@@ -51,7 +51,7 @@ static unsigned char mem_inq(const struct si_sm_io *io, unsigned int offset)
 static void mem_outq(const struct si_sm_io *io, unsigned int offset,
 		     unsigned char b)
 {
-	writeq(b << io->regshift, (io->addr)+(offset * io->regspacing));
+	writeq((u64)b << io->regshift, (io->addr)+(offset * io->regspacing));
 }
 #endif
 
-- 
2.20.1

