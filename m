Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568A8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EC4206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892836;
	bh=/1ggGKG6R9qFZgUoKcGccH4o7kaImZSKokgM6jrCZHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yj6ql0iC0q6oM8QRqN1sICK0vsbbs5Llmwijin3XguVXmAWQuNwvqZHhdjhsrKeEn
	 Dfuh3C7YL5FKpVfNiZIF2HnAcxkGYvgN4VGMcPXMzmYEMvr83KiA+PYMzHkay7Vd4n
	 tVIatt0zapUy19DInSXaLWejx1oAaqYSPWQ4EBOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfH0IAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbfH0IAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:00:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 851452186A;
        Tue, 27 Aug 2019 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892832;
        bh=/1ggGKG6R9qFZgUoKcGccH4o7kaImZSKokgM6jrCZHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DR04/dyc128F273VOt/hmIDUcMgEOMOnPEnuJD18/Oyhjqz7QgpRezBzuccaU1dbA
         xraObcOQlMZ3SBUftWuvxgehZeLkj/qn9s5el9j3GqXEPpT3ys7QgYxHcKdD7TUsNp
         ewZmyRxQHukbRw7waQXujnAx2lVBL06W35+jrvNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 030/162] selftests/bpf: add another gso_segs access
Date:   Tue, 27 Aug 2019 09:49:18 +0200
Message-Id: <20190827072739.343508012@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit be69483bf4f3abaaca5d5ba460dbb50239463552 ]

Use BPF_REG_1 for source and destination of gso_segs read,
to exercise "bpf: fix access to skb_shared_info->gso_segs" fix.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/verifier/ctx_skb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index b0fda2877119c..d438193804b21 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -974,6 +974,17 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 },
+{
+	"read gso_segs from CGROUP_SKB",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1,
+		    offsetof(struct __sk_buff, gso_segs)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+},
 {
 	"write gso_segs from CGROUP_SKB",
 	.insns = {
-- 
2.20.1



