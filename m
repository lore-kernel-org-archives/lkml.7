Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BC6C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 15:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C212173C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 15:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XEQ5es30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfHKPj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 11:39:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51212 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfHKPj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 11:39:56 -0400
Received: from zn.tnic (p200300EC2F223C0008446A0D13A93A85.dip0.t-ipconnect.de [IPv6:2003:ec:2f22:3c00:844:6a0d:13a9:3a85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAE191EC01AF;
        Sun, 11 Aug 2019 17:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565537995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=3HsRb5ViLKgbAWKr6B3v1ObIayaTZFMopI3vyEZMeNg=;
        b=XEQ5es30W3jUufq2l7cROu/NisbZZX9DHcbark8rUpz5ih8i2SKsSK/OZ9YhPye6QvfbAI
        UHQ/37GmDFZivO3gfoooj9jNe+NHKKN1EYHdYUEpHdKZBI8qtdC8GZEGLUsVRJhLcgieQG
        78gS1iMndYTtTi7f6gjc1jMVfjUOCbU=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>, x86@kernel.org
Subject: [PATCH] x86/apic/32: Fix yet another implicit fallthrough warning
Date:   Sun, 11 Aug 2019 17:40:36 +0200
Message-Id: <20190811154036.29805-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fix

  arch/x86/kernel/apic/probe_32.c: In function ‘default_setup_apic_routing’:
  arch/x86/kernel/apic/probe_32.c:146:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
      if (!APIC_XAPIC(version)) {
         ^
  arch/x86/kernel/apic/probe_32.c:151:3: note: here
   case X86_VENDOR_HYGON:
   ^~~~

for 32-bit builds.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/apic/probe_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 0ac9fd667c99..67b33d67002f 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -147,7 +147,8 @@ void __init default_setup_apic_routing(void)
 				def_to_bigsmp = 0;
 				break;
 			}
-			/* If P4 and above fall through */
+			/* P4 and above */
+			/* fall through */
 		case X86_VENDOR_HYGON:
 		case X86_VENDOR_AMD:
 			def_to_bigsmp = 1;
-- 
2.21.0

