Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBC1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4283E21743
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918043;
	bh=ywIgSnUS84cGtjpQxvkxNuhTW5EDMV2bcOmUzV3Xi38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvNmH3qgk0jN6+g+A1dZRFOTxWx5If94YneUuIi+JcvKPsB+oxEeOal/aFeitIwRP
	 NyLf/EhxcdznGw/2r4dAHaGSnD79NlQT3zgOapit9IyV0EP5OwJGeCslOH2DWeCmmu
	 j7aLpBoXNxwPe6St9Q5loVCfIU0cKESWRUIjwrYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfEOLAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfEOLAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:00:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266802189F;
        Wed, 15 May 2019 11:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918037;
        bh=ywIgSnUS84cGtjpQxvkxNuhTW5EDMV2bcOmUzV3Xi38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQ/KJfBdpo1RHeTjwfvuBXkpD4KCPh33OiKHVBG8+WjMHg4GyTF+6RSQyCdzul4IR
         T6N4lMM0rXcJTXHAtwMuAqBw1MjbqG/cnaJj+tzODz4yraQuCPa6/V5wlPGDt6zq5R
         9ZTsBZ6/SDvZEdZYfqUactrhUnbl2AU2X1BFPsqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 69/86] KVM: x86: avoid misreporting level-triggered irqs as edge-triggered in tracing
Date:   Wed, 15 May 2019 12:55:46 +0200
Message-Id: <20190515090654.899445561@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7a223e06b1a411cef6c4cd7a9b9a33c8d225b10e ]

In __apic_accept_irq() interface trig_mode is int and actually on some code
paths it is set above u8:

kvm_apic_set_irq() extracts it from 'struct kvm_lapic_irq' where trig_mode
is u16. This is done on purpose as e.g. kvm_set_msi_irq() sets it to
(1 << 15) & e->msi.data

kvm_apic_local_deliver sets it to reg & (1 << 15).

Fix the immediate issue by making 'tm' into u16. We may also want to adjust
__apic_accept_irq() interface and use proper sizes for vector, level,
trig_mode but this is not urgent.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 6b06ab8748dd5..005a5b8d5628f 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -415,13 +415,13 @@ TRACE_EVENT(kvm_apic_ipi,
 );
 
 TRACE_EVENT(kvm_apic_accept_irq,
-	    TP_PROTO(__u32 apicid, __u16 dm, __u8 tm, __u8 vec),
+	    TP_PROTO(__u32 apicid, __u16 dm, __u16 tm, __u8 vec),
 	    TP_ARGS(apicid, dm, tm, vec),
 
 	TP_STRUCT__entry(
 		__field(	__u32,		apicid		)
 		__field(	__u16,		dm		)
-		__field(	__u8,		tm		)
+		__field(	__u16,		tm		)
 		__field(	__u8,		vec		)
 	),
 
-- 
2.20.1



