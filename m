Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E62C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF2E216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595443;
	bh=GNN0sR4e16+0nWy1iWP+tAoGWftpGYQrJW02a8FU0ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfNqOLkWUA9CBmKAYftJF+H3YKuJVjKwaGTvvK9ER5FmYNLroae/9CJrayqu5ecx4
	 erb48QysZtJaJV4cUVTJfGcAD/i0tbqssXAtuv3BADpEcLo6G8SiPPg8URqbMMoD3Z
	 Q8VHfn1yBfvck4g3YlNc9w7XP53NxS4lXAWVUIZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF0Aam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:30:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbfF0Aaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:30:39 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383872083B;
        Thu, 27 Jun 2019 00:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595438;
        bh=GNN0sR4e16+0nWy1iWP+tAoGWftpGYQrJW02a8FU0ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jegRJs3ookQ0BMngcB28E9xH2+03lAD6pKUZO8QMkCY6DOZ18mo+ba2QfNKDk5QBw
         UrDlE657er4lwOeDsnEv+F412nmb0DX2RL9KWQPKnP7DdWuvOwRR62efZj9I23brkF
         HSnK8Ufew+hvTPcfFmA79GPdk2AZDnM3Z9tTtvo0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 05/95] soc: brcmstb: Fix error path for unsupported CPUs
Date:   Wed, 26 Jun 2019 20:28:50 -0400
Message-Id: <20190627003021.19867-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 490cad5a3ad6ef0bfd3168a5063140b982f3b22a ]

In case setup_hifcpubiuctrl_regs() returns an error, because of e.g:
an unsupported CPU type, just catch that error and return instead of
blindly continuing with the initialization. This fixes a NULL pointer
de-reference with the code continuing without having a proper array of
registers to use.

Fixes: 22f7a9116eba ("soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 6d89ebf13b8a..c16273b31b94 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -246,7 +246,9 @@ static int __init brcmstb_biuctrl_init(void)
 	if (!np)
 		return 0;
 
-	setup_hifcpubiuctrl_regs(np);
+	ret = setup_hifcpubiuctrl_regs(np);
+	if (ret)
+		return ret;
 
 	ret = mcp_write_pairing_set();
 	if (ret) {
-- 
2.20.1

