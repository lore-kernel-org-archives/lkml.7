Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA547C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27FD2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798953;
	bh=7Xw0QoSwiCAilYPRBt1bdNY9DKHi7cJfewbH0qGOk2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rpg3+d2L7nmBqDpmGCg637m7TDjmSglgBiXlfJhqIpJhuWr0c8c2R+zHynsPvEJZ5
	 zdATa4t9K2iaU3NR8vitmlSI3CI2wZtK8DTJNdiVSKPsrEuDmjStQzGRZs/41dW4hP
	 JsSaWujTCWwRAO2GeDEgeYAWvSvOB+orhKee4s/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfKOGWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfKOGWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:22:25 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2AD2053B;
        Fri, 15 Nov 2019 06:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798945;
        bh=7Xw0QoSwiCAilYPRBt1bdNY9DKHi7cJfewbH0qGOk2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pse1r60oV4VI0W5N7h0pyHxWO30vZOhORIx4/HTaYuLDxwjdACDG7OY00UBeM58Qt
         JqqGP0+PFrjxw3u9yrveFTN5B0aIcr9KwKDEQB9KRj/5p7CQYFzT2Sd8AkHQejGAU5
         04gLBwIE0OXr8g3cw4N48ofHZAVnmGyTiGSSikkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 22/31] KVM: x86: change kvm_mmu_page_get_gfn BUG_ON to WARN_ON
Date:   Fri, 15 Nov 2019 14:20:51 +0800
Message-Id: <20191115062018.282579382@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit e9f2a760b158551bfbef6db31d2cae45ab8072e5 upstream.

Note that in such a case it is quite likely that KVM will BUG_ON
in __pte_list_remove when the VM is closed.  However, there is no
immediate risk of memory corruption in the host so a WARN_ON is
enough and it lets you gather traces for debugging.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -781,10 +781,16 @@ static gfn_t kvm_mmu_page_get_gfn(struct
 
 static void kvm_mmu_page_set_gfn(struct kvm_mmu_page *sp, int index, gfn_t gfn)
 {
-	if (sp->role.direct)
-		BUG_ON(gfn != kvm_mmu_page_get_gfn(sp, index));
-	else
+	if (!sp->role.direct) {
 		sp->gfns[index] = gfn;
+		return;
+	}
+
+	if (WARN_ON(gfn != kvm_mmu_page_get_gfn(sp, index)))
+		pr_err_ratelimited("gfn mismatch under direct page %llx "
+				   "(expected %llx, got %llx)\n",
+				   sp->gfn,
+				   kvm_mmu_page_get_gfn(sp, index), gfn);
 }
 
 /*


