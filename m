Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC53C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E4F206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806553;
	bh=BznVoR+FiBUgaFlz9uhoR8AQG6axRGqhTctpnfjZEQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qQ7l/LXr1Ap2wpYvNqI9VxnboOZ7v3v84xKAlmmGFUmg1Fw47W9vhdIDtxR2dzB+O
	 LfdHnQLmpCaVau9yIxofJUCCauHaUg/Kq9SNw7alWXC8PRYl+C5mhR4SEsjSECyRwU
	 4K+WmMrUA5Fdbr2L5QLmABE/vIquTsqXnzkyFuos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfFQVWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbfFQVW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B7A2063F;
        Mon, 17 Jun 2019 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806545;
        bh=BznVoR+FiBUgaFlz9uhoR8AQG6axRGqhTctpnfjZEQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXx4CEurr+Y/eFZhB5kL4QtbuRwUgNX5WqPNgHt9Wcu/7bfhVplsotAgstRDvpJ4u
         o7+XZltJREfOEfVQYwaAcW6Ex0vTYb/lXOXL7BM0qXtfbhzZnaxdvTI9FG43CNtuG+
         JNu+50AQnBdxgMWjz1AafyTFEGCZKWpvJvV93XEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 087/115] KVM: LAPIC: Fix lapic_timer_advance_ns parameter overflow
Date:   Mon, 17 Jun 2019 23:09:47 +0200
Message-Id: <20190617210804.414958400@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0e6edceb8f18a4e31526d83e6099fef1f29c3af5 ]

After commit c3941d9e0 (KVM: lapic: Allow user to disable adaptive tuning of
timer advancement), '-1' enables adaptive tuning starting from default
advancment of 1000ns. However, we should expose an int instead of an overflow
uint module parameter.

Before patch:

/sys/module/kvm/parameters/lapic_timer_advance_ns:4294967295

After patch:

/sys/module/kvm/parameters/lapic_timer_advance_ns:-1

Fixes: c3941d9e0 (KVM: lapic: Allow user to disable adaptive tuning of timer advancement)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index efc8adf7ca0e..b07868eb1656 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -143,7 +143,7 @@ module_param(tsc_tolerance_ppm, uint, S_IRUGO | S_IWUSR);
  * tuning, i.e. allows priveleged userspace to set an exact advancement time.
  */
 static int __read_mostly lapic_timer_advance_ns = -1;
-module_param(lapic_timer_advance_ns, uint, S_IRUGO | S_IWUSR);
+module_param(lapic_timer_advance_ns, int, S_IRUGO | S_IWUSR);
 
 static bool __read_mostly vector_hashing = true;
 module_param(vector_hashing, bool, S_IRUGO);
-- 
2.20.1



