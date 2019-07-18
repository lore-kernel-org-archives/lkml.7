Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7EEC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7355D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419313;
	bh=dzAAhdj6ZpCSbriRU5PnpOzikiVL8RSDfIQwRm8t+O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hh/qYNtM6gaQHB9rOc0z/20ma6xusr7hDepEtiY0t1G3oN39gLGn4dTEhZH+vvSVT
	 DqlMeoBd8X7qFzv02XeHClruTj72mQIsrYyK24H4U2y4NN9X91QYi96ypEtfAmXCC2
	 n9sAb51gclMdZYXdsQlA3k592CwUERItvjJBeNTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390768AbfGRDIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390739AbfGRDI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:08:26 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AECF72077C;
        Thu, 18 Jul 2019 03:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419306;
        bh=dzAAhdj6ZpCSbriRU5PnpOzikiVL8RSDfIQwRm8t+O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruPIiell5HI9FP9aL5ba1A5TELG4ZRBHhcPXQHtW9fcmDb1c9j72LRfk8bOPZ43qv
         CIRMbrEuh5naawojPP0zqRkJSHTpg4H7Pps22hHjt5AlYvp2QCGHSeYWDr/OM/D1lp
         3TUeVU0bxWouO4W6GW09DfdFw4UhB+ZRhBPBpRKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 47/47] x86/entry/32: Fix ENDPROC of common_spurious
Date:   Thu, 18 Jul 2019 12:02:01 +0900
Message-Id: <20190718030052.723143571@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1cbec37b3f9cff074a67bef4fc34b30a09958a0a ]

common_spurious is currently ENDed erroneously. common_interrupt is used
in its ENDPROC. So fix this mistake.

Found by my asm macros rewrite patchset.

Fixes: f8a8fe61fec8 ("x86/irq: Seperate unused system vectors from spurious entry again")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190709063402.19847-1-jslaby@suse.cz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d7b64c8d1907..8059d4fd915c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1119,7 +1119,7 @@ common_spurious:
 	movl	%esp, %eax
 	call	smp_spurious_interrupt
 	jmp	ret_from_intr
-ENDPROC(common_interrupt)
+ENDPROC(common_spurious)
 #endif
 
 /*
-- 
2.20.1



