Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F25C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622C1206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642371;
	bh=/YEeQ6njC17TwdoxAHBJL0BSlzsVLxmhOigumG4djZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R97BH9mydOl89iSzzIHhyIhlHPmeAQbTUxUknm4MNsqx1HV8f1l0H79lnZ6A9fN91
	 CfraPENENUqBIph0hP4KexnzcPn7hxMxcyOEYmJZ9OSgmlgDaqrDDFHU6Ag9A7EnHS
	 DhwfqFTuE9jS+Zxo7U+ZR+2jDTUN9TOp7yxRUfGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbfL2R7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387595AbfL2R6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:58:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B580206A4;
        Sun, 29 Dec 2019 17:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642323;
        bh=/YEeQ6njC17TwdoxAHBJL0BSlzsVLxmhOigumG4djZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLwwj8DS5SCGq1Mc1DN7xAbQggZmV6c6GVAglg/EgCa1XPVf+UpwSWRubHHej5n4Q
         M4P/RK/o71yR3X8UZw/YsZTEidPu75gbx2q9yJCQF0wLePsiPtcDrXRgHtLOqB9tzf
         EwpjyLXMavJXhFd5mQ/ZJfKLQI25XFWwO9lZC3LM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 5.4 419/434] KVM: arm64: Ensure params is initialised when looking up sys register
Date:   Sun, 29 Dec 2019 18:27:52 +0100
Message-Id: <20191229172730.864689522@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 1ce74e96c2407df2b5867e5d45a70aacb8923c14 upstream.

Commit 4b927b94d5df ("KVM: arm/arm64: vgic: Introduce find_reg_by_id()")
introduced 'find_reg_by_id()', which looks up a system register only if
the 'id' index parameter identifies a valid system register. As part of
the patch, existing callers of 'find_reg()' were ported over to the new
interface, but this breaks 'index_to_sys_reg_desc()' in the case that the
initial lookup in the vCPU target table fails because we will then call
into 'find_reg()' for the system register table with an uninitialised
'param' as the key to the lookup.

GCC 10 is bright enough to spot this (amongst a tonne of false positives,
but hey!):

  | arch/arm64/kvm/sys_regs.c: In function ‘index_to_sys_reg_desc.part.0.isra’:
  | arch/arm64/kvm/sys_regs.c:983:33: warning: ‘params.Op2’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  |   983 |   (u32)(x)->CRn, (u32)(x)->CRm, (u32)(x)->Op2);
  | [...]

Revert the hunk of 4b927b94d5df which breaks 'index_to_sys_reg_desc()' so
that the old behaviour of checking the index upfront is restored.

Fixes: 4b927b94d5df ("KVM: arm/arm64: vgic: Introduce find_reg_by_id()")
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191212094049.12437-1-will@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kvm/sys_regs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2360,8 +2360,11 @@ static const struct sys_reg_desc *index_
 	if ((id & KVM_REG_ARM_COPROC_MASK) != KVM_REG_ARM64_SYSREG)
 		return NULL;
 
+	if (!index_to_params(id, &params))
+		return NULL;
+
 	table = get_target_table(vcpu->arch.target, true, &num);
-	r = find_reg_by_id(id, &params, table, num);
+	r = find_reg(&params, table, num);
 	if (!r)
 		r = find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 


