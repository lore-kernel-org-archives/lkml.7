Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFA32465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781128;
	bh=mN6YQ+PzkcvOkuHpK70M6xy2RAC+WMY5QHxUamRj06U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SRzg/q07Rq9+qeRScedWwojbP7ErEQKndGzLnjMxSlCnMYUPrtRLOqdrgag05k7ho
	 aYV0HDysd1OLT/KldsknPrTiRBsT2Y23k9ZeZsbbdmHslSmXU+s+sySPYH0zTb81+7
	 fspR6U5A/EugE5YKKyWCDlDHUgJs+lNL/Faz6Y/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfLSSp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbfLSSpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:45:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D452465E;
        Thu, 19 Dec 2019 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781123;
        bh=mN6YQ+PzkcvOkuHpK70M6xy2RAC+WMY5QHxUamRj06U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/6O/YqeF8/LeeSFZtjRcTyjF0/UOriqrODmlAS96QuKx/ZoYKWdhzjp6T+dSbcVb
         Q1ktx57NDq5MIyBE6jPJXlFWUvQxhgyvNZCgfadZi1vMpGt28c1VbnpZEPdExXQN+u
         hGVPHZV2Sh9PCzvxrMqtu+ewDx/Lo1AUphikEYeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e3f4897236c4eeb8af4f@syzkaller.appspotmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 093/199] KVM: x86: fix out-of-bounds write in KVM_GET_EMULATED_CPUID (CVE-2019-19332)
Date:   Thu, 19 Dec 2019 19:32:55 +0100
Message-Id: <20191219183220.072569008@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 433f4ba1904100da65a311033f17a9bf586b287e upstream.

The bounds check was present in KVM_GET_SUPPORTED_CPUID but not
KVM_GET_EMULATED_CPUID.

Reported-by: syzbot+e3f4897236c4eeb8af4f@syzkaller.appspotmail.com
Fixes: 84cffe499b94 ("kvm: Emulate MOVBE", 2013-10-29)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/cpuid.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -389,7 +389,7 @@ static inline int __do_cpuid_ent(struct
 
 	r = -E2BIG;
 
-	if (*nent >= maxnent)
+	if (WARN_ON(*nent >= maxnent))
 		goto out;
 
 	do_cpuid_1_ent(entry, function, index);
@@ -691,6 +691,9 @@ out:
 static int do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 func,
 			u32 idx, int *nent, int maxnent, unsigned int type)
 {
+	if (*nent >= maxnent)
+		return -E2BIG;
+
 	if (type == KVM_GET_EMULATED_CPUID)
 		return __do_cpuid_ent_emulated(entry, func, idx, nent, maxnent);
 


