Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DA5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC5322CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148450;
	bh=yXJQA+pGZ+E5vV29tiqAeD/EY+FD385k/53yYskFo6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBwGYKFPirVPudJjQXXwCXl68LJ3l9w86dAyjEGMrO+JbbMHUY+D22rn2gy7gt3OO
	 bptC3te1mlXcu3QJw50BEzdo3U1o5UXokaKSB+rFIJNuG//Z1AgFQ2kZ8928BP9ye9
	 arroydwFIl77GEY2hAVo3rKwrthrGNuuLQhin/F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfGZNkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387575AbfGZNkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:40:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB83222BF5;
        Fri, 26 Jul 2019 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148445;
        bh=yXJQA+pGZ+E5vV29tiqAeD/EY+FD385k/53yYskFo6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1z93rfvb3/mS1VcK/2pFAOje4kM9kTnxXD/lACXC/rMNLMMSaLLWJhgzIjtu5Qrhr
         ByhqywDNyWreVHrUgCJYCX7PQdkCSXlW1eloRRefINAUTEzTxm6I781lOUz9vau46F
         awA9sy8gCE1Snf8uL1tyjFO3+P1GR4q41OO4vz4w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.2 43/85] x86: kvm: avoid constant-conversion warning
Date:   Fri, 26 Jul 2019 09:38:53 -0400
Message-Id: <20190726133936.11177-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a6a6d3b1f867d34ba5bd61aa7bb056b48ca67cff ]

clang finds a contruct suspicious that converts an unsigned
character to a signed integer and back, causing an overflow:

arch/x86/kvm/mmu.c:4605:39: error: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -205 to 51 [-Werror,-Wconstant-conversion]
                u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
                   ~~                               ^~
arch/x86/kvm/mmu.c:4607:38: error: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -241 to 15 [-Werror,-Wconstant-conversion]
                u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
                   ~~                              ^~
arch/x86/kvm/mmu.c:4609:39: error: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -171 to 85 [-Werror,-Wconstant-conversion]
                u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
                   ~~                               ^~

Add an explicit cast to tell clang that everything works as
intended here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://github.com/ClangBuiltLinux/linux/issues/95
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 98f6e4f88b04..8d95c81b2c82 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4593,11 +4593,11 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 		 */
 
 		/* Faults from writes to non-writable pages */
-		u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
+		u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
+		u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
 		/* Faults from fetches of non-executable pages*/
-		u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
+		u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
 		/* Faults from kernel mode fetches of user pages */
 		u8 smepf = 0;
 		/* Faults from kernel mode accesses of user pages */
-- 
2.20.1

