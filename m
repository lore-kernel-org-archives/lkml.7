Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A83C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9708920643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611828;
	bh=Pxzvkw2x6G81FdU2nkh3g/UYR8UlNTL3U0Y92xeVoII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HhQ1mXaQ5GabdwghX5kGmM1wJyb+eSgjJzQkJn6CKTBsrKSYIzmU6TZd2EhnChjw6
	 ouDXSRD8dKHekoMMdPBfgvOuIvD0oYiMfGB8wZ7nZxtda+SNd+a+5XRTsJyllBcnTP
	 k1JXdIhH1VGJBLkUq8M9ikISBMChX/njRq3s1TFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404113AbfDRSXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391458AbfDRSGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BE4218AF;
        Thu, 18 Apr 2019 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610781;
        bh=Pxzvkw2x6G81FdU2nkh3g/UYR8UlNTL3U0Y92xeVoII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6ZrisV+s2+EiXwPUp9ok9TL9Uclq11D3r2ayNgOE3nM2PiCfnP5wiFnKSFdhkzz4
         nUnI6fOd0ZUiCNgci2udv8lyd3JTT6YhKrPjPVrwp2pBpI7UKz2fRaN2FxGqzKiB2B
         MXfWRw9xNdBHXjsSppTeCP7oN/ux2pl13vtlM1iQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 82/92] bpf: restrict unknown scalars of mixed signed bounds for unprivileged
Date:   Thu, 18 Apr 2019 19:57:40 +0200
Message-Id: <20190418160437.708923790@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit 9d7eceede769f90b66cfa06ad5b357140d5141ed upstream.

For unknown scalars of mixed signed bounds, meaning their smin_value is
negative and their smax_value is positive, we need to reject arithmetic
with pointer to map value. For unprivileged the goal is to mask every
map pointer arithmetic and this cannot reliably be done when it is
unknown at verification time whether the scalar value is negative or
positive. Given this is a corner case, the likelihood of breaking should
be very small.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[backported to 4.14 sblbir]
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2014,8 +2014,8 @@ static int adjust_ptr_min_max_vals(struc
 	    smin_ptr = ptr_reg->smin_value, smax_ptr = ptr_reg->smax_value;
 	u64 umin_val = off_reg->umin_value, umax_val = off_reg->umax_value,
 	    umin_ptr = ptr_reg->umin_value, umax_ptr = ptr_reg->umax_value;
+	u32 dst = insn->dst_reg, src = insn->src_reg;
 	u8 opcode = BPF_OP(insn->code);
-	u32 dst = insn->dst_reg;
 
 	dst_reg = &regs[dst];
 
@@ -2189,6 +2189,13 @@ static int adjust_ptr_min_max_vals(struc
 			verbose("R%d bitwise operator %s on pointer prohibited\n",
 				dst, bpf_alu_string[opcode >> 4]);
 		return -EACCES;
+	case PTR_TO_MAP_VALUE:
+		if (!env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
+			verbose("R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
+				off_reg == dst_reg ? dst : src);
+			return -EACCES;
+		}
+		/* fall-through */
 	default:
 		/* other operators (e.g. MUL,LSH) produce non-pointer results */
 		if (!env->allow_ptr_leaks)


