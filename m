Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14072C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D650420C01
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="JTNpck1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfHETci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:32:38 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.52]:38721 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbfHETci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:32:38 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id DE7099B393
        for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2019 14:32:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uiiihrwRR90onuiiihiBvo; Mon, 05 Aug 2019 14:32:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qLbVQ1du0xq48vlZ6w7a2uILpIHafL4P5rDN+g/q510=; b=JTNpck1wYdOYUwgJOixJg2E7YD
        OjaPO6sUauGcckryVKRVet/9533GS6vgJmjJZy4LEEsx7gTlTqdoSPWgjO8PYCpdtY9dWQVOFDWrl
        ucQXLdqSqUi3lpdSWVf4liF7ldL42Vva2oVplWx4bSYQK05J/kGe9q9vjBYwGwXKRetcfJpwKTSw1
        2258J68aemgVCw1+mIwCB6fstuUNWD/ANuL7764ckWpMVIEapv5STSoN35I7QJa0FGbGCUwjhbcl3
        UWvK5jOkgHJkLPveZiJe/rSwyG35L78hjD4a1nCQsKND5a5Rdm3AUiIbKizpwaVHW690Ny3aNDsn9
        ehlU/Zzw==;
Received: from [187.192.11.120] (port=37864 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1huiih-003HUC-QA; Mon, 05 Aug 2019 14:32:35 -0500
Date:   Mon, 5 Aug 2019 14:32:32 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ARC: unwind: Mark expected switch fall-throughs
Message-ID: <20190805193232.GA12826@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1huiih-003HUC-QA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:37864
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings (Building: haps_hs_defconfig arc):

arch/arc/kernel/unwind.c:827:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/arc/kernel/unwind.c:836:20: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arc/kernel/unwind.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index c2663fce7f6c..445e4d702f43 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -826,7 +826,7 @@ static int processCFI(const u8 *start, const u8 *end, unsigned long targetLoc,
 			case DW_CFA_def_cfa:
 				state->cfa.reg = get_uleb128(&ptr.p8, end);
 				unw_debug("cfa_def_cfa: r%lu ", state->cfa.reg);
-				/*nobreak*/
+				/* fall through */
 			case DW_CFA_def_cfa_offset:
 				state->cfa.offs = get_uleb128(&ptr.p8, end);
 				unw_debug("cfa_def_cfa_offset: 0x%lx ",
@@ -834,7 +834,7 @@ static int processCFI(const u8 *start, const u8 *end, unsigned long targetLoc,
 				break;
 			case DW_CFA_def_cfa_sf:
 				state->cfa.reg = get_uleb128(&ptr.p8, end);
-				/*nobreak */
+				/* fall through */
 			case DW_CFA_def_cfa_offset_sf:
 				state->cfa.offs = get_sleb128(&ptr.p8, end)
 				    * state->dataAlign;
-- 
2.22.0

