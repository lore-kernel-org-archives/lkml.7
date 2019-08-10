Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377DC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77DD2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kl6g8Yku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfHJE7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 00:59:48 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.61]:49703 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfHJE7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 00:59:48 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 2B59A3CBA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2019 23:59:47 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wJTnhgc7jiQerwJTnh3Xpz; Fri, 09 Aug 2019 23:59:47 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qRQ8eDsqvITl9pDigv6pwCWOIzgWAlQMa3gsXpIr07c=; b=kl6g8Yku/aKWWMbhRaecPeJnVV
        Hn9Q4k1dDH/PAtfNi62cIw7BT5pcDCwUSgcrNN+oypA4/YQPA3ejmMKARfpsBykHvDiRFjly3mDdl
        wIMkoDdJEVgT5Q3qKjF4He8nLKOz2XhCCUgaB0UvMspF+rOK1ETI/G2Pqsy2Q1E4k44Li28OhIHbV
        vQcD8T5WV9lZMWOeOpVxds1HbJRdLwK8j+giaoWDTdMA+sOYKahCCsWUW5kIQEY710u1kXypy2Y42
        vQU3Br1oyfzB9KJdSeeSicU2F0K9nxNrpnhsA82h7lW04PTw6hOryZpv/OsxKVIalwLk69cmGalL1
        m0gaJHoA==;
Received: from [187.192.11.120] (port=56642 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hwJTl-000X5X-Ld; Fri, 09 Aug 2019 23:59:46 -0500
Date:   Fri, 9 Aug 2019 23:59:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] sh: kernel: hw_breakpoint: Fix missing break in switch
 statement
Message-ID: <20190810045944.GA13815@embeddedor>
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
X-Exim-ID: 1hwJTl-000X5X-Ld
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:56642
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing break statement in order to prevent the code from
erroneously falling through to case SH_BREAKPOINT_WRITE.

Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---

If no one cares, I'll apply this to my tree and queue it up for 5.3-rc4.

 arch/sh/kernel/hw_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index 3bd010b4c55f..f10d64311127 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -157,6 +157,7 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
 	switch (sh_type) {
 	case SH_BREAKPOINT_READ:
 		*gen_type = HW_BREAKPOINT_R;
+		break;
 	case SH_BREAKPOINT_WRITE:
 		*gen_type = HW_BREAKPOINT_W;
 		break;
-- 
2.22.0

