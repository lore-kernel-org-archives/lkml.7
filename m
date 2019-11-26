Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449EE2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="twpQAMdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfKZRnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:43:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:26850 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfKZRnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:43:32 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Mrq56Ldsz9ty2b;
        Tue, 26 Nov 2019 18:43:29 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=twpQAMdj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kXcPbgiquUQG; Tue, 26 Nov 2019 18:43:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Mrq55GWNz9ty2Y;
        Tue, 26 Nov 2019 18:43:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574790209; bh=Nm8voP3roRsSJAwpWrKFutNy5/buSvyuxten1tQ9gTY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=twpQAMdj6a4+f20pV4DPDuYjHyRUb/LjKbcEh4ouigrnW0V8x6XCySPnGgAeK0EST
         k4aCausfd1kvRKYBzfgdeKiKY4V2CLEREHbBDsD2Vknlgau3FDGYx2ekGuZzdnhDhH
         UIYAEfaPuxzUib/oq0qgEKSghZqmoU9mG2yg7Ybc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 69C578B81A;
        Tue, 26 Nov 2019 18:43:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AG6IN_c4oP0K; Tue, 26 Nov 2019 18:43:31 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 021B08B825;
        Tue, 26 Nov 2019 18:43:30 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B1F0A6B76D; Tue, 26 Nov 2019 17:43:30 +0000 (UTC)
Message-Id: <081e3b4e3a17a8ec9fdac46b505e3a29ca15f209.1574790198.git.christophe.leroy@c-s.fr>
In-Reply-To: <05105deeaf63bc02151aea2cdeaf525534e0e9d4.1574790198.git.christophe.leroy@c-s.fr>
References: <05105deeaf63bc02151aea2cdeaf525534e0e9d4.1574790198.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] selftests/powerpc: enable range tests on 8xx in
 ptrace-hwbreak.c selftest
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ravi.bangoria@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 26 Nov 2019 17:43:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8xx is now able to support any range length so range tests can be enabled.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: new
---
 tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
index 7deedbc16b0b..fc477dfe86a2 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
@@ -455,9 +455,8 @@ run_tests(pid_t child_pid, struct ppc_debug_info *dbginfo, bool dawr)
 	if (dbginfo->features & PPC_DEBUG_FEATURE_DATA_BP_RANGE) {
 		test_sethwdebug_exact(child_pid);
 
-		if (!is_8xx)
-			test_sethwdebug_range_aligned(child_pid);
-		if (dawr && !is_8xx) {
+		test_sethwdebug_range_aligned(child_pid);
+		if (dawr || is_8xx) {
 			test_sethwdebug_range_unaligned(child_pid);
 			test_sethwdebug_range_unaligned_dar(child_pid);
 			test_sethwdebug_dawr_max_range(child_pid);
-- 
2.13.3

