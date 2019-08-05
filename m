Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FDDC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2652067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010938;
	bh=PCg97u3p1U941e7BvgXoCYqVd4ZisV+e5YDO8vEZl8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O8S0IZ+8J7+Af33FKva+Uuc3p0Ve8rRcUu3p55JO9cf514x9IgREL4QEfT4pTffrs
	 Jw7fQELnCFgQUcKXZ0HN4Z4AopW/GoZ1xPQ1C48fgts5Ks5hc5vNN9UKmVeRa408ck
	 AXDW0ySLS5FRt4lWZpvEMcAnfvwWcJZ3bsUHibp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfHENPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbfHENHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:07:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90362075B;
        Mon,  5 Aug 2019 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010420;
        bh=PCg97u3p1U941e7BvgXoCYqVd4ZisV+e5YDO8vEZl8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BI3uZjsM6rHo9e/QdjMDx5qsQ6zW50f40nitM0Dmivbj8ZAr9gWQvmRArR2SFo1wq
         LeyI3Yfpb2nslLVavRpSImhFDymgozerYxyrHlofNcfoHnBQD6zK6cY5YbF9GfIeJn
         c8gal+JqifWm9UEKJp7uq8b33GRu20Yyi74eGRdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 17/53] x86: kvm: avoid constant-conversion warning
Date:   Mon,  5 Aug 2019 15:02:42 +0200
Message-Id: <20190805124930.002378879@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124927.973499541@linuxfoundation.org>
References: <20190805124927.973499541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index f97b533bc6e68..87a0601b1c204 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4313,11 +4313,11 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
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



