Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A11C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489D32133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049860;
	bh=OZhB1E2tBJW/EYUcsxk6rnwU39375CC5Og18bBQmBYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W7V0dW0wnzTFVibvY5+xCeB4vi84Nv3WvBKgpKDZOEMhpTAd2ZR69FxdesRQY+K93
	 fns8FWniQCQ7Y+v6i9g1IZPL3vRGYhemcElzhSVQHAuwZyfb5n5I09f6+IQpvZ+rJC
	 X4NnegOtbT2ug4Wws45OFoNL/Hq1EX1OqCEx7stg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfCHM5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfCHM5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:57:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980F620811;
        Fri,  8 Mar 2019 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049854;
        bh=OZhB1E2tBJW/EYUcsxk6rnwU39375CC5Og18bBQmBYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ew0KtdoKfjhD9T+hVYp+dGf71vU1vpRvjw2yhg61MgViDjC6e7y6qWJxlZ5GBTLne
         Kxlo2BgOF9gS91dTy/fSFEwLeXPkcGysMrVNT0m5Pa4W0MEtAYed1EBPUtt0OmsPIK
         9SNGdYxmMkgOiRroG0JTQ9tysLTGmTrh98Qd2Bo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Majkowski <marek@cloudflare.com>,
        Arthur Fabre <afabre@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.20 76/76] bpf: fix sanitation rewrite in case of non-pointers
Date:   Fri,  8 Mar 2019 13:50:28 +0100
Message-Id: <20190308124917.480135207@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6428,7 +6428,8 @@ static int fixup_bpf_calls(struct bpf_ve
 			u32 off_reg;
 
 			aux = &env->insn_aux_data[i + delta];
-			if (!aux->alu_state)
+			if (!aux->alu_state ||
+			    aux->alu_state == BPF_ALU_NON_POINTER)
 				continue;
 
 			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;


