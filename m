Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326ABC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0668B2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l7CH3GZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfEUHYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:24:22 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:22820 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUHYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:24:21 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4L7MHPr022832;
        Tue, 21 May 2019 16:22:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4L7MHPr022832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558423338;
        bh=hr8joM8Sc+Aak3eFwsotPo0Y8ZJsP4u2qZKEifJpDSc=;
        h=From:To:Cc:Subject:Date:From;
        b=l7CH3GZim9h0bMC3eGO7MyWPnzOAA8KNC8BCQDA1nQrXefb54KVJjgCD16vYHYF0F
         nSZLR5oes9Eg9Dw9BlAjPhLWfv9XTP4c4pEzm+NuMnU5gt70hwb9+AW/x+pxfEOEZR
         JMQgWpV6iF+kUEMGyFwS9L8UQPpZpA6PFtr2+7ygfw/hcYNSohDHv46+pxpgHvzWXP
         66IeVxSAK8J7Odoj6PvUODZsZNWL9/Eco9y+CEgJrGlmSsdlBFHGjANZrEm6sOC9bb
         2rnNYxZ4b6X0+fkF3ihTg2SGpbkhm8kMrQm8IXvzoOfvR1qMXxhf/araMXvjhtQB1f
         yd8HskED0bItA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/io_delay: break instead of fallthrough in switch statement
Date:   Tue, 21 May 2019 16:22:10 +0900
Message-Id: <20190521072211.21014-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code is fine since 'case CONFIG_IO_DELAY_TYPE_NONE'
does nothing, but scripts/checkpatch.pl complains about this:

  warning: Possible switch case/default not preceded by break or fallthrough comment

I like break statement better than a fallthrough comment here.
It avoids the warning and clarify the code.

No behavior change is intended.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/kernel/io_delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/io_delay.c b/arch/x86/kernel/io_delay.c
index 805b7a341aca..3dc874d5d43b 100644
--- a/arch/x86/kernel/io_delay.c
+++ b/arch/x86/kernel/io_delay.c
@@ -39,6 +39,7 @@ void native_io_delay(void)
 		 * are shorter until calibrated):
 		 */
 		udelay(2);
+		break;
 	case CONFIG_IO_DELAY_TYPE_NONE:
 		break;
 	}
-- 
2.17.1

