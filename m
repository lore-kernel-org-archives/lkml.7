Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1BFC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7739F216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600806;
	bh=M3ZuKp0XDdst9JplQL3gyct4VtflnifobcVwFZFGdug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohQODHv6NxsPJmbb4xtxJbInpAMzGF9NrxDlwHnF6767wc/Jwa/AQRL7UgFcYIPzc
	 j8datPoXkOKvLLiIGpHawuL6/kGPFglWC/5Y9MUPYErS6cb0F20IHk56I8SBR+6D/l
	 6DOW/wrISX3n8bV/CEpEwrnit+EYiiLepCtz+bFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391345AbfGHPqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfGHPUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:20:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39FBD216C4;
        Mon,  8 Jul 2019 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599247;
        bh=M3ZuKp0XDdst9JplQL3gyct4VtflnifobcVwFZFGdug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/M7+Cph+QBT+BoM6X802weX+v1U1/itqaS47xnce4ylFQnnCobWWq49SiaEZVZs4
         1rv/nX1nltGU+LLdVrQga+XTJindWAX6E+AFtfQ54X2atyHL/JKk3a0hYTlvi5Xvh7
         3b9GP8QneC/73QrlyM2b4gRYZefejK/XrHbGFTeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Roland Hii <roland.king.guan.hii@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 053/102] net: stmmac: fixed new system time seconds value calculation
Date:   Mon,  8 Jul 2019 17:12:46 +0200
Message-Id: <20190708150529.189410547@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -125,7 +125,7 @@ static int stmmac_adjust_systime(void __
 		 * programmed with (2^32 – <new_sec_value>)
 		 */
 		if (gmac4)
-			sec = (100000000ULL - sec);
+			sec = -sec;
 
 		value = readl(ioaddr + PTP_TCR);
 		if (value & PTP_TCR_TSCTRLSSR)


