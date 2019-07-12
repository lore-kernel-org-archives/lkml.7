Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAE2C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF122166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934374;
	bh=vQBdzWuLn1sqfRcFF+gUmWpDuYA8gg4YVK5T3Ukjz2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHlBT47GqrPxkvPE+hwh+UsPypce0gbO6KV2tPLWiQY1JBpmQ0o2Mop0GSAyv8U+A
	 74UEvd0GtbR8SteeM+R+tLZQ/5G3cE7QkqM/5n3/FpH/LzD4zFeAUSh55k6Ir84+Af
	 BlbADL326g5TX6QmUoZH51EtchzJTjI8CcysQkq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfGLM0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbfGLM0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:26:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF682084B;
        Fri, 12 Jul 2019 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934366;
        bh=vQBdzWuLn1sqfRcFF+gUmWpDuYA8gg4YVK5T3Ukjz2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9sVsrrhc+GeEMtUcQ0/NsIDwh6ML3Yc0tWS547HF7M2xB/Onp52h7k4gpdV9LrOS
         vHCwhs+TmQmpdKO9938cDoVdt33G0jC+rs0xjpZ7eyvoYwwMRQdJEC1HA5dWwjO27k
         zv0OUP1I/+RPvi40B/Cvp0UWHtqeAlGdreQPtw9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 009/138] soc: bcm: brcmstb: biuctrl: Register writes require a barrier
Date:   Fri, 12 Jul 2019 14:17:53 +0200
Message-Id: <20190712121629.069994333@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6b23af0783a54efb348f0bd781b7850636023dbb ]

The BIUCTRL register writes require that a data barrier be inserted
after comitting the write to the register for the block to latch in the
recently written values. Reads have no such requirement and are not
changed.

Fixes: 34642650e5bc ("soc: Move brcmstb to bcm/brcmstb")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index c16273b31b94..20b63bee5b09 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -56,7 +56,7 @@ static inline void cbc_writel(u32 val, int reg)
 	if (offset == -1)
 		return;
 
-	writel_relaxed(val,  cpubiuctrl_base + offset);
+	writel(val, cpubiuctrl_base + offset);
 }
 
 enum cpubiuctrl_regs {
-- 
2.20.1



