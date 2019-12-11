Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872F1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B23822B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077945;
	bh=51SOyI+EKKS5ycsMnBeLTwGuk/aW9dfAvgoCWfGVoKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/sgF1DJOb8dV+aYysAXXthVNPDtkZclNCnWUjWfD58u9axqiQSOHPWD6pa1/7hO6
	 lIz0zlZhLl4R7ATY9w05Pq9r5QdjGS39nWGy//pxUWg3VpWfpOjQd27Xiy629Uv8Ob
	 ioNRkab8RPa36d+sLOc9AQ86oSux6TX7r45MNphM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbfLKPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733025AbfLKPZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:25:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F33D222C4;
        Wed, 11 Dec 2019 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077939;
        bh=51SOyI+EKKS5ycsMnBeLTwGuk/aW9dfAvgoCWfGVoKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/qs6PvHoKfccAQtYqiMtEixSvJn7q755ymQ94OxXtswK9iGRCX3ja8zWpOj/8BHA
         +T7+6S8tDgngePocjtz3142627nIfNPibKUmk9k3t2H6+P6TzXcAnVM6Z8sUYKtxjs
         IVowzoO7cjZkr7t8cUQPEwh0KFqo2JtI1NWmA46Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 227/243] KVM: x86: fix presentation of TSX feature in ARCH_CAPABILITIES
Date:   Wed, 11 Dec 2019 16:06:29 +0100
Message-Id: <20191211150354.659526097@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit cbbaa2727aa3ae9e0a844803da7cef7fd3b94f2b upstream.

KVM does not implement MSR_IA32_TSX_CTRL, so it must not be presented
to the guests.  It is also confusing to have !ARCH_CAP_TSX_CTRL_MSR &&
!RTM && ARCH_CAP_TAA_NO: lack of MSR_IA32_TSX_CTRL suggests TSX was not
hidden (it actually was), yet the value says that TSX is not vulnerable
to microarchitectural data sampling.  Fix both.

Cc: stable@vger.kernel.org
Tested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1174,10 +1174,15 @@ u64 kvm_get_arch_capabilities(void)
 	 * If TSX is disabled on the system, guests are also mitigated against
 	 * TAA and clear CPU buffer mitigation is not required for guests.
 	 */
-	if (boot_cpu_has_bug(X86_BUG_TAA) && boot_cpu_has(X86_FEATURE_RTM) &&
-	    (data & ARCH_CAP_TSX_CTRL_MSR))
+	if (!boot_cpu_has(X86_FEATURE_RTM))
+		data &= ~ARCH_CAP_TAA_NO;
+	else if (!boot_cpu_has_bug(X86_BUG_TAA))
+		data |= ARCH_CAP_TAA_NO;
+	else if (data & ARCH_CAP_TSX_CTRL_MSR)
 		data &= ~ARCH_CAP_MDS_NO;
 
+	/* KVM does not emulate MSR_IA32_TSX_CTRL.  */
+	data &= ~ARCH_CAP_TSX_CTRL_MSR;
 	return data;
 }
 


