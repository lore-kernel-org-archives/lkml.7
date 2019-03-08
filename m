Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D55C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA6A20449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050110;
	bh=Xtf5RR5EcjhaOqshNUKxyhc3LEjR0fxhzqDZkNZxz24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HFsuc4KLfLPDExicelntnp+2kyIe9yoQhO5AA7AE8QDKUKoNBxZu3TWgzcIiRGLxy
	 RF/Mxhz3fZGsmrQpoCGngN9pEnNdZ3bgr/wX9PRHYYBDUQUvyBE//wB2CNuAMsv/xu
	 RkCIqut1Rdv01uNuwH0+YiMXvLzvfeKypi65fbaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCHNBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfCHNAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B787820811;
        Fri,  8 Mar 2019 13:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050055;
        bh=Xtf5RR5EcjhaOqshNUKxyhc3LEjR0fxhzqDZkNZxz24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4Iz28YsP/VLj2v4/qpWIm/MdfpCyc8qs7XXJZNcF7IknsYyS11sCrJiOPy+eoKXM
         3JnxvDNldSgK4VXf2TEVcydTlM3qzN3hRzyyAKNtFe2ddvoPfdY9/JwyOcYeT/axBe
         d/e/kHhh7IF8CRnGZ8VMj/FOTsv+JHz+A6riS5Sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Majkowski <marek@cloudflare.com>,
        Arthur Fabre <afabre@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.19 68/68] bpf: fix sanitation rewrite in case of non-pointers
Date:   Fri,  8 Mar 2019 13:50:38 +0100
Message-Id: <20190308124913.990256931@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

commit 3612af783cf52c74a031a2f11b82247b2599d3cd upstream.

Marek reported that he saw an issue with the below snippet in that
timing measurements where off when loaded as unpriv while results
were reasonable when loaded as privileged:

    [...]
    uint64_t a = bpf_ktime_get_ns();
    uint64_t b = bpf_ktime_get_ns();
    uint64_t delta = b - a;
    if ((int64_t)delta > 0) {
    [...]

Turns out there is a bug where a corner case is missing in the fix
d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar
type from different paths"), namely fixup_bpf_calls() only checks
whether aux has a non-zero alu_state, but it also needs to test for
the case of BPF_ALU_NON_POINTER since in both occasions we need to
skip the masking rewrite (as there is nothing to mask).

Fixes: d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar type from different paths")
Reported-by: Marek Majkowski <marek@cloudflare.com>
Reported-by: Arthur Fabre <afabre@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/netdev/CAJPywTJqP34cK20iLM5YmUMz9KXQOdu1-+BZrGMAGgLuBWz7fg@mail.gmail.com/T/
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/verifier.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6035,7 +6035,8 @@ static int fixup_bpf_calls(struct bpf_ve
 			u32 off_reg;
 
 			aux = &env->insn_aux_data[i + delta];
-			if (!aux->alu_state)
+			if (!aux->alu_state ||
+			    aux->alu_state == BPF_ALU_NON_POINTER)
 				continue;
 
 			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;


