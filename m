Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B88FC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B44E217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="iZLEYn7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbfHHDBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:01:50 -0400
Received: from gateway20.websitewelcome.com ([192.185.68.24]:33056 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728059AbfHHDBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:01:49 -0400
X-Greylist: delayed 1414 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Aug 2019 23:01:49 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 408C2400C5B69
        for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2019 20:34:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vYJihZxjz2qH7vYJihaY80; Wed, 07 Aug 2019 21:38:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w1RwkvHqtPdK7/AYAKy9lm1SQOT6wXcGzEyuBPgukXs=; b=iZLEYn7q3mZHuiGswr40xVFFlS
        /arE8YYN5eZrF1eMoIs/gi8JC2gB43UC99ugzMRpjryYZToRvUih7YhjG2b77ThWVX5tWMQfRujle
        fl7bjJeiGimpDVaOebzmjpxAO8n+6QF8w0yzxu6l2arcFo1LQy2SPSvm9WRwlPNma7YWGzflAPSEP
        EkYcwRa7TDoXB1/gN3d+fqb3PU0TeSEgXerNHnaL4YRTKZPLTuLpWnHqWL3fPqoNSN3W9upwHx9B3
        J9vGNU7VepvWZP0GT657zplqIGT8uowUy6SJgmEqBXFWIpkgADoWDnSIApbQdcepjzzlRxGd00H2p
        /3axGsSQ==;
Received: from [187.192.11.120] (port=32960 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hvYJh-001Kkt-Cq; Wed, 07 Aug 2019 21:38:13 -0500
Date:   Wed, 7 Aug 2019 21:38:11 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ARM: ep93xx: Mark expected switch fall-through
Message-ID: <20190808023811.GA14001@embeddedor>
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
X-Exim-ID: 1hvYJh-001Kkt-Cq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:32960
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

Fix the following warnings (Building: arm-ep93xx_defconfig arm):

arch/arm/mach-ep93xx/crunch.c: In function 'crunch_do':
arch/arm/mach-ep93xx/crunch.c:46:3: warning: this statement may
fall through [-Wimplicit-fallthrough=]
      memset(crunch_state, 0, sizeof(*crunch_state));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-ep93xx/crunch.c:53:2: note: here
     case THREAD_NOTIFY_EXIT:
     ^~~~

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/mach-ep93xx/crunch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ep93xx/crunch.c b/arch/arm/mach-ep93xx/crunch.c
index 1c9a4be8b503..1c05c5bf7e5c 100644
--- a/arch/arm/mach-ep93xx/crunch.c
+++ b/arch/arm/mach-ep93xx/crunch.c
@@ -49,6 +49,7 @@ static int crunch_do(struct notifier_block *self, unsigned long cmd, void *t)
 		 * FALLTHROUGH: Ensure we don't try to overwrite our newly
 		 * initialised state information on the first fault.
 		 */
+		/* Fall through */
 
 	case THREAD_NOTIFY_EXIT:
 		crunch_task_release(thread);
-- 
2.22.0

