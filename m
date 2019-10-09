Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82863ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9E21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642297;
	bh=BYFgJp0e0Z6OyadI7GisGIAIEU45czqzFvrwyIa7xZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xr79lZkn9gDQDo2ysJs65teSKbK4iXT5ZrrfGbb8WNku5tpbJQTBN2MGXUAag31iY
	 XY7+efwf2SlSNZmiRVzM1sdOIKd5pIHKmYCF5/6I7KVbGFcg36Q3gpujXGpH6qkhWM
	 QpEUIh3NI3b05A2wcZ52RPYWfD65hUP0mtvQm4AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfJIRbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732071AbfJIRYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:00 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D35E21D7D;
        Wed,  9 Oct 2019 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641840;
        bh=BYFgJp0e0Z6OyadI7GisGIAIEU45czqzFvrwyIa7xZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDp5vv8fm2edPHebdCJ992gDrt8JUvWlekVD+ec3wbwVLazZLmvq3VXaSN3Xyel82
         fFB6sG3tiY00EYAu5fZguFreCZPneEdqnhRYxljwO2Vx2o9RSvc9TYbzuycdImuz05
         gkzuqqpY/ZgKJjfDbCMqJ7SF/nU9kGu/SbSVT2Vk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 25/68] kvm: x86: Fix a spurious -E2BIG in __do_cpuid_func
Date:   Wed,  9 Oct 2019 13:05:04 -0400
Message-Id: <20191009170547.32204-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

[ Upstream commit a1a640b8c0cd8a2a7f84ab694f04bc64dc6988af ]

Don't return -E2BIG from __do_cpuid_func when processing function 0BH
or 1FH and the last interesting subleaf occupies the last allocated
entry in the result array.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 831bf664e9c1fc ("KVM: Refactor and simplify kvm_dev_ioctl_get_supported_cpuid")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/cpuid.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e7d25f4364664..429648ae5653f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -612,16 +612,20 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 	 */
 	case 0x1f:
 	case 0xb: {
-		int i, level_type;
+		int i;
 
-		/* read more entries until level_type is zero */
-		for (i = 1; ; ++i) {
+		/*
+		 * We filled in entry[0] for CPUID(EAX=<function>,
+		 * ECX=00H) above.  If its level type (ECX[15:8]) is
+		 * zero, then the leaf is unimplemented, and we're
+		 * done.  Otherwise, continue to populate entries
+		 * until the level type (ECX[15:8]) of the previously
+		 * added entry is zero.
+		 */
+		for (i = 1; entry[i - 1].ecx & 0xff00; ++i) {
 			if (*nent >= maxnent)
 				goto out;
 
-			level_type = entry[i - 1].ecx & 0xff00;
-			if (!level_type)
-				break;
 			do_host_cpuid(&entry[i], function, i);
 			++*nent;
 		}
-- 
2.20.1

