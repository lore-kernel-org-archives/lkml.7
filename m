Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7D3C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA5720684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="w5anBHod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfHLSkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:40:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHLSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:40:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CIe4mL1022863
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 11:40:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CIe4mL1022863
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565635204;
        bh=VVkFdFVroGhyDmjRnt7VReyMUDVmBw2IDP2RscEgPX4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=w5anBHodtsn7EumhnQjtsZ4bEfoZwttNwSnsOC1z3UM6TIrxJzd7hO2TxRw75DfLe
         V97UKhKDTrDM1HdfM+vnLAws2Ht9C1AtFVEeesb6RERHUvFBI9XdXTELgpTBGqe+DS
         NeaUV0A+fcND2hk29Ewjas42ysBiniumFYs5F1RqDYfXBvXvp7VKvOpn/DKFK79NLs
         iSyExCsbobq8D0tRt5cz6+rXS4WWwDKyuQDXfMGl5nm7F7wuEjN8Dtd7LkHCbhorGA
         oeAdTkA3IHgtL8CGUE8Ti/+5nsCOuOCu2Wh+7M6kq1PmSTStneIh9dakts1xPsrrE9
         5DTvYRNwznoeQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CIe40I1022859;
        Mon, 12 Aug 2019 11:40:04 -0700
Date:   Mon, 12 Aug 2019 11:40:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-5785675dfef4f9edcee66edef7b3af21618d2707@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, bp@suse.de
In-Reply-To: <20190811154036.29805-1-bp@alien8.de>
References: <20190811154036.29805-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic/32: Fix yet another implicit fallthrough
 warning
Git-Commit-ID: 5785675dfef4f9edcee66edef7b3af21618d2707
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5785675dfef4f9edcee66edef7b3af21618d2707
Gitweb:     https://git.kernel.org/tip/5785675dfef4f9edcee66edef7b3af21618d2707
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sun, 11 Aug 2019 17:40:36 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 12 Aug 2019 20:35:04 +0200

x86/apic/32: Fix yet another implicit fallthrough warning

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190811154036.29805-1-bp@alien8.de

---
 arch/x86/kernel/apic/probe_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 1492799b8f43..ee2d91e382f1 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -184,7 +184,8 @@ void __init default_setup_apic_routing(void)
 				def_to_bigsmp = 0;
 				break;
 			}
-			/* If P4 and above fall through */
+			/* P4 and above */
+			/* fall through */
 		case X86_VENDOR_HYGON:
 		case X86_VENDOR_AMD:
 			def_to_bigsmp = 1;
