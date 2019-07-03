Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9047EC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601122187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120206;
	bh=hDN+aGT3OiKMxarLMhNarocFprAxKpWY3qy8Dxr1DEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E8y0e3LVCc/hmput6ObTqRRikWBFPmsoxJxMpB5Zsg0MqBr/5pQWjCTk0rUWPg2sO
	 wVtOOUkUJHsoS/d2GRui1wwMQ5NpZsKvEWB9Ar2PE0AQtt9BIlBuU7B7XRbh7kKAop
	 5e+QWnjDzr4G2azvkFG5eJtZBthIFiiu3bYAMTTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfGCCQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfGCCQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:16:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E636521880;
        Wed,  3 Jul 2019 02:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120200;
        bh=hDN+aGT3OiKMxarLMhNarocFprAxKpWY3qy8Dxr1DEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pv37dDIZM3yBs3Kj5nB+ojADNmzLGT/6s1wiLXXBR4ZOnPFogmDgo8QY+J/3YYt7J
         Q/kCMAovG2SytcVIAbZOiMJ5uEPcQfQNeAsWLN0u02u3ho5GDj57+2vbU5Vr5zLkQN
         uKfCtZ/mI1Dx5JJmzp03Jp0KewCc0Eq4fgSJgjR0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roland Hii <roland.king.guan.hii@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/26] net: stmmac: fixed new system time seconds value calculation
Date:   Tue,  2 Jul 2019 22:16:10 -0400
Message-Id: <20190703021625.18116-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021625.18116-1-sashal@kernel.org>
References: <20190703021625.18116-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Hii <roland.king.guan.hii@intel.com>

[ Upstream commit a1e5388b4d5fc78688e5e9ee6641f779721d6291 ]

When ADDSUB bit is set, the system time seconds field is calculated as
the complement of the seconds part of the update value.

For example, if 3.000000001 seconds need to be subtracted from the
system time, this field is calculated as
2^32 - 3 = 4294967296 - 3 = 0x100000000 - 3 = 0xFFFFFFFD

Previously, the 0x100000000 is mistakenly written as 100000000.

This is further simplified from
  sec = (0x100000000ULL - sec);
to
  sec = -sec;

Fixes: ba1ffd74df74 ("stmmac: fix PTP support for GMAC4")
Signed-off-by: Roland Hii <roland.king.guan.hii@intel.com>
Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
Signed-off-by: Voon Weifeng <weifeng.voon@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 8d9cc2157afd..7423262ce590 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -122,7 +122,7 @@ static int adjust_systime(void __iomem *ioaddr, u32 sec, u32 nsec,
 		 * programmed with (2^32 – <new_sec_value>)
 		 */
 		if (gmac4)
-			sec = (100000000ULL - sec);
+			sec = -sec;
 
 		value = readl(ioaddr + PTP_TCR);
 		if (value & PTP_TCR_TSCTRLSSR)
-- 
2.20.1

