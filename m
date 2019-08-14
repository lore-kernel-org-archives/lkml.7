Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B857CC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF8B21721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748967;
	bh=1tO7IzmyXmBKGPRjkYYiQe4X081UKGtbvVd4HDr63qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zhcs7zMETvS2OuuJfE1hha6cyHs2LLLfUrIzC+T+uo0NoPiCX7CFVEgXTiUaBCccJ
	 dEbnIdh82eFV5jc1CQIxFkQSDXMS2z0y/q/0GfArLC5gDWW2/5XSmBiW8QygrOAeMM
	 Od4t9PuAdjls9qxHOR7PLqrx6qYa16ZHQFo9YQc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfHNCQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfHNCQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:16:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA90920989;
        Wed, 14 Aug 2019 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748961;
        bh=1tO7IzmyXmBKGPRjkYYiQe4X081UKGtbvVd4HDr63qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jq+kVT9SaV5gFlKJU9BCgAdt8w1UXuH6I8ok/Xszklj1ClFhlMD1Fli53/Ij+rHj5
         H228GcMcSKgHY21MXvTyu1QiXGtvbGwoDi0ZouiJc6dFN1GAVK0zmjV9KR/2QFM2uq
         A15pLblcLThUIPhq0vco6c94sgKgRi5g1fof6j1w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>, Andrey Ignatov <rdna@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/68] selftests/bpf: fix sendmsg6_prog on s390
Date:   Tue, 13 Aug 2019 22:14:46 -0400
Message-Id: <20190814021548.16001-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021548.16001-1-sashal@kernel.org>
References: <20190814021548.16001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit c8eee4135a456bc031d67cadc454e76880d1afd8 ]

"sendmsg6: rewrite IP & port (C)" fails on s390, because the code in
sendmsg_v6_prog() assumes that (ctx->user_ip6[0] & 0xFFFF) refers to
leading IPv6 address digits, which is not the case on big-endian
machines.

Since checking bitwise operations doesn't seem to be the point of the
test, replace two short comparisons with a single int comparison.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/sendmsg6_prog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/sendmsg6_prog.c b/tools/testing/selftests/bpf/sendmsg6_prog.c
index 5aeaa284fc474..a680628204108 100644
--- a/tools/testing/selftests/bpf/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/sendmsg6_prog.c
@@ -41,8 +41,7 @@ int sendmsg_v6_prog(struct bpf_sock_addr *ctx)
 	}
 
 	/* Rewrite destination. */
-	if ((ctx->user_ip6[0] & 0xFFFF) == bpf_htons(0xFACE) &&
-	     ctx->user_ip6[0] >> 16 == bpf_htons(0xB00C)) {
+	if (ctx->user_ip6[0] == bpf_htonl(0xFACEB00C)) {
 		ctx->user_ip6[0] = bpf_htonl(DST_REWRITE_IP6_0);
 		ctx->user_ip6[1] = bpf_htonl(DST_REWRITE_IP6_1);
 		ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
-- 
2.20.1

