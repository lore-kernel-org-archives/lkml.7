Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F048C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E588D218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610802;
	bh=6qOpnHsiRkmL3nLfNpnfsuFeCLOVZE817/PeFrqSulE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rkw2Xl0Q8gZcT54Ov7IKcRB4mM9NC2UNA8Q7Amkw0t5dIdDrZrvcIpqCdWz/U3dYt
	 4iD+D27NEpk+1+EGuVj7gr/ilewTT88coFWGu6dUl40srVxCz+YWBG3HroloQ4C5R0
	 eQu0WrmEROF9zZVuYRIlqWaLsCVFT48lL1Ileyzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391141AbfDRSGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390497AbfDRSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D4F921871;
        Thu, 18 Apr 2019 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610797;
        bh=6qOpnHsiRkmL3nLfNpnfsuFeCLOVZE817/PeFrqSulE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZwPWsNBRhU9K/bzKCC3lwqIcPRrlrGgPLvJeXT1ND5NKGkRk6mT99+YgJqWa4Dc4
         VTgPAJJDcFePgfSyd8UhkIUGfGWCk1ls4y8PPl5VeAa00/JCF/SOd9sA61dWaVi8Mc
         Gv1DMegpCJs8icR6H0hu810wwIdssU5lGdCRsOcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Majkowski <marek@cloudflare.com>,
        Arthur Fabre <afabre@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 88/92] bpf: fix sanitation rewrite in case of non-pointers
Date:   Thu, 18 Apr 2019 19:57:46 +0200
Message-Id: <20190418160438.189578126@linuxfoundation.org>
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
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4771,7 +4771,8 @@ static int fixup_bpf_calls(struct bpf_ve
 			u32 off_reg;
 
 			aux = &env->insn_aux_data[i + delta];
-			if (!aux->alu_state)
+			if (!aux->alu_state ||
+			    aux->alu_state == BPF_ALU_NON_POINTER)
 				continue;
 
 			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;


