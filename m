Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40CAC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FD22077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UIbI760C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfG1Xno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:43:44 -0400
Received: from gateway36.websitewelcome.com ([192.185.198.13]:20861 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfG1Xno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:43:44 -0400
X-Greylist: delayed 1461 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 19:43:43 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 22AE0400C34D5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 17:43:25 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rsRmh1Yd1dnCersRmhV4Os; Sun, 28 Jul 2019 18:19:22 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PY6E13tVfIgBq9qTq9qmjg7C5IhkGMS1k4wt9WQOgBg=; b=UIbI760Cqp3d3ijjcmuaqmwDtN
        kyrvcLfNZF4clUbxV+4FTx7Mak7xcRTjZsTWsnlo9CfF0ahFDUsML2mQDkCqLcJClVkNS+GWRjWbe
        X5MdRtFHZJcebXg7ocKkwPJyJSCfTmQMHwH8sjxayXUiZbTQWRcGLMXVqEs0W24Y6IepyptAzDdC3
        sQE8X+gLM4VseJflhpewJhF4OPJLigjqiJC1cNCmdqVKleFtgxa44iLdWvP5Q43Hkz93pJw4NTHsk
        bDV0rPCJs84J5vPbLA4I67uK9urFp268W0EFB3m2WodxyEcb2cg5CQY30ZcsYhy7jl567pkV5H40E
        wg0swe8Q==;
Received: from [187.192.11.120] (port=39058 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrsRl-003XoU-2P; Sun, 28 Jul 2019 18:19:21 -0500
Date:   Sun, 28 Jul 2019 18:19:20 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ARM: alignment: Mark expected switch fall-throughs
Message-ID: <20190728231920.GA22247@embeddedor>
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
X-Exim-ID: 1hrsRl-003XoU-2P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:39058
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

arch/arm/mm/alignment.c: In function 'thumb2arm':
arch/arm/mm/alignment.c:688:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if ((tinstr & (3 << 9)) == 0x0400) {
      ^
arch/arm/mm/alignment.c:700:2: note: here
  default:
  ^~~~~~~
arch/arm/mm/alignment.c: In function 'do_alignment_t32_to_handler':
arch/arm/mm/alignment.c:753:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
   poffset->un = (tinst2 & 0xff) << 2;
   ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
arch/arm/mm/alignment.c:754:2: note: here
  case 0xe940:
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/mm/alignment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 8cdb78642e93..04b36436cbc0 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -695,7 +695,7 @@ thumb2arm(u16 tinstr)
 			return subset[(L<<1) | ((tinstr & (1<<8)) >> 8)] |
 			    (tinstr & 255);		/* register_list */
 		}
-		/* Else fall through for illegal instruction case */
+		/* Else, fall through - for illegal instruction case */
 
 	default:
 		return BAD_INSTR;
@@ -751,6 +751,8 @@ do_alignment_t32_to_handler(unsigned long *pinstr, struct pt_regs *regs,
 	case 0xe8e0:
 	case 0xe9e0:
 		poffset->un = (tinst2 & 0xff) << 2;
+		/* Fall through */
+
 	case 0xe940:
 	case 0xe9c0:
 		return do_alignment_ldrdstrd;
-- 
2.22.0

