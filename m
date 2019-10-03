Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFACBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8804220865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119718;
	bh=WV12Xj5vShY0vJCSafmIAez9hmQ3Eiy6jMF6YEac2p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qWjS4wDmZaMuFBezGkVu9B9fl1jgvqXGXRUTfqvFYIrKAjs7jgubmpnMWDXZ/n1D0
	 qF0djxjxKqsACFiniIwQdyOAQtcvcViRVQcvtI4XdMZbeuL2UGnneMmYk6B9Rwaqb9
	 08oVbMlnfFX9r2HCeqpKEBuYSoJ1xcdpfkWArNa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbfJCQV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390208AbfJCQVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:21:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5268E20865;
        Thu,  3 Oct 2019 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119711;
        bh=WV12Xj5vShY0vJCSafmIAez9hmQ3Eiy6jMF6YEac2p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwBet8gJb7XDq5OINUPTTQca5AccOAoiluT7LtODbTBFITaZTCPS3S263+Q0kB6ia
         JWKITYywtosnHO1Q2I+sjlpejv7j0s+LHNyYij2vw6iR+Ah49MnxolvgD1IZuTbaN6
         FWce+G6+AvEA07RPkLGRLXM5CazYplgIG+I8ankk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Lunev <den@virtuozzo.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 166/211] KVM: x86: set ctxt->have_exception in x86_decode_insn()
Date:   Thu,  3 Oct 2019 17:53:52 +0200
Message-Id: <20191003154525.759012107@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>

commit c8848cee74ff05638e913582a476bde879c968ad upstream.

x86_emulate_instruction() takes into account ctxt->have_exception flag
during instruction decoding, but in practice this flag is never set in
x86_decode_insn().

Fixes: 6ea6e84309ca ("KVM: x86: inject exceptions produced by x86_decode_insn")
Cc: stable@vger.kernel.org
Cc: Denis Lunev <den@virtuozzo.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/emulate.c |    2 ++
 arch/x86/kvm/x86.c     |    6 ++++++
 2 files changed, 8 insertions(+)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5368,6 +5368,8 @@ done_prefixes:
 					ctxt->memopp->addr.mem.ea + ctxt->_eip);
 
 done:
+	if (rc == X86EMUL_PROPAGATE_FAULT)
+		ctxt->have_exception = true;
 	return (rc != X86EMUL_CONTINUE) ? EMULATION_FAILED : EMULATION_OK;
 }
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6245,6 +6245,12 @@ int x86_emulate_instruction(struct kvm_v
 						emulation_type))
 				return EMULATE_DONE;
 			if (ctxt->have_exception) {
+				/*
+				 * #UD should result in just EMULATION_FAILED, and trap-like
+				 * exception should not be encountered during decode.
+				 */
+				WARN_ON_ONCE(ctxt->exception.vector == UD_VECTOR ||
+					     exception_type(ctxt->exception.vector) == EXCPT_TRAP);
 				inject_emulated_exception(vcpu);
 				return EMULATE_DONE;
 			}


