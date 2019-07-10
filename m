Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96001C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C5C208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562770982;
	bh=/tTCfsdxKc4/IJKdw22nCxXU0Y9hM+ovuTEz4TGz8OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lv0yK3SZNjFQegizrvPbHRuPISjPLvUCP7IhJt+9KIAdEt3O/tCd5vWvDzTDD/SD4
	 +CRxyPiJWxlKotnOIrU7ZoWoO+HtoWK6DHW9PdAQpr3ptfhm/+O3rVc4qb1bjz70L/
	 ETGkaWLWIN7GFNWZO+wR32hMSmDZpN6z/Elaww1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfGJPDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfGJPCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:02:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B17CC21530;
        Wed, 10 Jul 2019 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562770971;
        bh=/tTCfsdxKc4/IJKdw22nCxXU0Y9hM+ovuTEz4TGz8OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZ4Cm5+b9ogjQ15oXW2a1i+LFe1bgEVgVH+YknZKLpK1yt25fGNn27NMKDTN3MeH6
         ZHgY7eB+pHN08JUzhCNdC6YDC80Lo78GcrWR+uJPSLekQs0o47A5WlRmMz8c+/AQCR
         ff/i9F545GZpXKWyGDKxNe+PFqpSEPzeL2G4pNbM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 06/11] KVM: x86: degrade WARN to pr_warn_ratelimited
Date:   Wed, 10 Jul 2019 11:02:33 -0400
Message-Id: <20190710150240.6984-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710150240.6984-1-sashal@kernel.org>
References: <20190710150240.6984-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 3f16a5c318392cbb5a0c7a3d19dff8c8ef3c38ee ]

This warning can be triggered easily by userspace, so it should certainly not
cause a panic if panic_on_warn is set.

Reported-by: syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com
Suggested-by: Alexander Potapenko <glider@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b07868eb1656..37028ea85d4c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1547,7 +1547,7 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 			vcpu->arch.tsc_always_catchup = 1;
 			return 0;
 		} else {
-			WARN(1, "user requested TSC rate below hardware speed\n");
+			pr_warn_ratelimited("user requested TSC rate below hardware speed\n");
 			return -1;
 		}
 	}
@@ -1557,8 +1557,8 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 				user_tsc_khz, tsc_khz);
 
 	if (ratio == 0 || ratio >= kvm_max_tsc_scaling_ratio) {
-		WARN_ONCE(1, "Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
-			  user_tsc_khz);
+		pr_warn_ratelimited("Invalid TSC scaling ratio - virtual-tsc-khz=%u\n",
+			            user_tsc_khz);
 		return -1;
 	}
 
-- 
2.20.1

