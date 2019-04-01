Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11FFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94FF20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138970;
	bh=P3xw/PoBaxx0gliOLqBic5NXaK135RaKWxRNJQdb/1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LGKxOlwdaAMQHR35iXTjKyWeNptgFKK9etx1r0iSmgNrABeU1QnVzr6BkER33AqGa
	 Y6JpFFWrrUBC3vsV2LuA1l4wyd17+UZzmZN0p2XNB0IhZDIg4v0vI7QeAwIXC9Z8Cb
	 ReSS1EAyNY0TmR0SurLBfQwVYjdqBsr0JjW8Fhps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfDARQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730975AbfDARQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38F420856;
        Mon,  1 Apr 2019 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138966;
        bh=P3xw/PoBaxx0gliOLqBic5NXaK135RaKWxRNJQdb/1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVGXLaYakhtM5ZzFW3DQ6mkhVCtmtxe2ZW4OQp+auS/6V8eLitWWVi989NZ4mX9XT
         wRuTCBQMUe8NzudOstODFYdkZ5UfRWa+tg8qGimI6N0YtORyYE2COhEQuKZMIIVhRk
         FbEWAasCcnDm0Z5pRzrbpfEpY6cpJiCDOaR0oWyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 035/134] powerpc/fsl: Emulate SPRN_BUCSR register
Date:   Mon,  1 Apr 2019 19:01:11 +0200
Message-Id: <20190401170048.002495239@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diana Craciun <diana.craciun@nxp.com>

commit 98518c4d8728656db349f875fcbbc7c126d4c973 upstream.

In order to flush the branch predictor the guest kernel performs
writes to the BUCSR register which is hypervisor privilleged. However,
the branch predictor is flushed at each KVM entry, so the branch
predictor has been already flushed, so just return as soon as possible
to guest.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
[mpe: Tweak comment formatting]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/e500_emulate.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -277,6 +277,13 @@ int kvmppc_core_emulate_mtspr_e500(struc
 		vcpu->arch.pwrmgtcr0 = spr_val;
 		break;
 
+	case SPRN_BUCSR:
+		/*
+		 * If we are here, it means that we have already flushed the
+		 * branch predictor, so just return to guest.
+		 */
+		break;
+
 	/* extra exceptions */
 #ifdef CONFIG_SPE_POSSIBLE
 	case SPRN_IVOR32:


