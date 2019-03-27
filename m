Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE6AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A378A2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfC0Ufw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:35:52 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:55244 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC0Ufw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:35:52 -0400
Received: from localhost.localdomain (85-76-9-223-nat.elisa-mobile.fi [85.76.9.223])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 3E53B30087;
        Wed, 27 Mar 2019 22:35:49 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "David S. Miller" <davem@davemloft.net>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 0/6] net: stmmac: fix handling of oversized frames
Date:   Wed, 27 Mar 2019 22:35:34 +0200
Message-Id: <20190327203540.1884-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Hi,

I accidentally had MTU size mismatch (9000 vs. 1500) in my network,
and I noticed I could kill a system using stmmac & 1500 MTU simply
by pinging it with "ping -s 2000 ...".

While testing a fix I encountered also some other issues that need fixing.

I have tested these only with enhanced descriptors, so the normal
descriptor changes need a careful review.

A.

Aaro Koskinen (6):
  net: stmmac: use correct DMA buffer size in the RX descriptor
  net: stmmac: ratelimit RX error logs
  net: stmmac: don't stop NAPI processing when dropping a packet
  net: stmmac: don't overwrite discard_frame status
  net: stmmac: fix dropping of multi-descriptor RX frames
  net: stmmac: don't log oversized frames

 .../net/ethernet/stmicro/stmmac/descs_com.h   | 22 +++++++-----
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/enh_desc.c    | 22 ++++++++----
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 .../net/ethernet/stmicro/stmmac/norm_desc.c   | 12 ++++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++++++++++--------
 7 files changed, 59 insertions(+), 37 deletions(-)

-- 
2.17.0

