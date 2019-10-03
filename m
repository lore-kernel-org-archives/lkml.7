Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0379CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA90C2054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121750;
	bh=7wQgprOa/A5NQw61VKjaGs5HQp9uRZ46wli16VtzPbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gzFSLZxGI2xxAb3xt3u4wwVO72HUmkPjgwr7cTxvOe7QMqoofRW2Y0IBJzK5oykjK
	 Z9IXNre1ZSWHGHAnpfkJQsJwRbw4y0iSLrAFlxpnkMsNU6mXZbfAafdl//D1fn8BQv
	 SIM0CqiPxFCp9dxgY1F+N+1++yUPQglEAF8U4d1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406117AbfJCQvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406101AbfJCQvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:51:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C40A42070B;
        Thu,  3 Oct 2019 16:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121507;
        bh=7wQgprOa/A5NQw61VKjaGs5HQp9uRZ46wli16VtzPbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sSnRhSM5kEHcWSF11kXRU+LNikCTaYCG7OD0t2cfY+0yL16s88AHOv4J+vuxednr2
         RoiklHOpfNI1tj4fLBpOo1PZLfjwsJpOu4OMxZN5PAlMVLBcZwvnQPeBnUaUDekJZN
         F1zu3fxi8h9NKPfiRtbv90itfAlWwPHkZWzn2dfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.3 266/344] kvm: x86: Add "significant index" flag to a few CPUID leaves
Date:   Thu,  3 Oct 2019 17:53:51 +0200
Message-Id: <20191003154606.614872551@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

commit a06dcd625d6181747fac7f4c140b5a4c397a778c upstream.

According to the Intel SDM, volume 2, "CPUID," the index is
significant (or partially significant) for CPUID leaves 0FH, 10H, 12H,
17H, 18H, and 1FH.

Add the corresponding flag to these CPUID leaves in do_host_cpuid().

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Steve Rutherford <srutherford@google.com>
Fixes: a87f2d3a6eadab ("KVM: x86: Add Intel CPUID.1F cpuid emulation support")
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/cpuid.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -304,7 +304,13 @@ static void do_host_cpuid(struct kvm_cpu
 	case 7:
 	case 0xb:
 	case 0xd:
+	case 0xf:
+	case 0x10:
+	case 0x12:
 	case 0x14:
+	case 0x17:
+	case 0x18:
+	case 0x1f:
 	case 0x8000001d:
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
 		break;


