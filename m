Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E180C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671242070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="K8k/eeoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfG2Adp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 20:33:45 -0400
Received: from gateway36.websitewelcome.com ([192.185.194.2]:39665 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbfG2Ado (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:33:44 -0400
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 20:33:44 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 092D4400C7A53
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 18:37:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rtHvhkVcn2qH7rtHvhn2Ey; Sun, 28 Jul 2019 19:13:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y6S+Zz8Uy/4dcVHVPaSAGOHjMzOacfIZTOtYvDlJxZ4=; b=K8k/eeoysyU5u65TqLUOqVETuM
        WA6h3NGrolPCBXsQ+1W90mTzaMF70a1+Q7qyFZk32+ck5QrD6497mhM6YmxWFaGNh6B3PNOnAgqii
        spNvlmB0gcP7iG6wdjAYcFx5AjJkwFFxcqFCgGZTsMax6fpaNsBiHOFCPb1I1kQzXGrzUbDHXF08j
        V4IuQc/JZLDnwsYcNB27+mf31AH20AZKt92VC+WLJ2un719GJ4o8/y4g3Sv1XgTZsbxt6Klvt5VVs
        HNSrrcQsSr2OcVJLLJOhHpO9youp4L8MjOtR72hhxdu5dST2NMgJTNDHKE03PK4DOw2xnY6u0hsXG
        Be7T/3hA==;
Received: from [187.192.11.120] (port=39726 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrtHu-003tFF-Vh; Sun, 28 Jul 2019 19:13:15 -0500
Date:   Sun, 28 Jul 2019 19:13:14 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ARM: signal: Mark expected switch fall-through
Message-ID: <20190729001314.GA24747@embeddedor>
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
X-Exim-ID: 1hrtHu-003tFF-Vh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:39726
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 26
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning:

arch/arm/kernel/signal.c: In function 'do_signal':
arch/arm/kernel/signal.c:598:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
    restart -= 2;
    ~~~~~~~~^~~~
arch/arm/kernel/signal.c:599:3: note: here
   case -ERESTARTNOHAND:
   ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 09f6fdd41974..ab2568996ddb 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -596,6 +596,7 @@ static int do_signal(struct pt_regs *regs, int syscall)
 		switch (retval) {
 		case -ERESTART_RESTARTBLOCK:
 			restart -= 2;
+			/* Fall through */
 		case -ERESTARTNOHAND:
 		case -ERESTARTSYS:
 		case -ERESTARTNOINTR:
-- 
2.22.0

