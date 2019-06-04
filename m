Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F8CC28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EAF206C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690575;
	bh=66hOY2fBtQRs/WlfFucZlqG6SUvnQxfmiGeG7HznvFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRlDBlgdgnFm62muQD/G4tlWldEBRpUwwMxcIZ84lPQCL3vNy78ZgZQIZfZyXdn03
	 DbOxF886orDmzVao3dXYQ5FmPrL7KEhhxv7YNdVkVuK3vx41n9JJzSj6Qegn59e8/B
	 13bv5LR9jznlq5Pe0dleC0irfYspfTKMuNmfqIts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfFDXWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfFDXWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:22:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36DF420863;
        Tue,  4 Jun 2019 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690571;
        bh=66hOY2fBtQRs/WlfFucZlqG6SUvnQxfmiGeG7HznvFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szIKkU80u6EavR5yIQEaETIy6ElQRBKN1jhNvXWZOWNoypc+qMyhuZ2wuX0VwISt4
         jSCed1sXaJcCKo2UquS7MHxrvcudAsTAczQwTh6yo/Q9Xnqws3gXqM6FxddOsnAs/x
         zZXV/mhgF0Or7BBFy7IGQIrECC4uuWgNJ0Td1vpE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Arika Chen <eaglesora@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 24/60] bpf, tcp: correctly handle DONT_WAIT flags and timeo == 0
Date:   Tue,  4 Jun 2019 19:21:34 -0400
Message-Id: <20190604232212.6753-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 5fa2ca7c4a3fc176f31b495e1a704862d8188b53 ]

The tcp_bpf_wait_data() routine needs to check timeo != 0 before
calling sk_wait_event() otherwise we may see unexpected stalls
on receiver.

Arika did all the leg work here I just formatted, posted and ran
a few tests.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Reported-by: Arika Chen <eaglesora@gmail.com>
Suggested-by: Arika Chen <eaglesora@gmail.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 4a619c85daed..3d1e15401384 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -27,7 +27,10 @@ static int tcp_bpf_wait_data(struct sock *sk, struct sk_psock *psock,
 			     int flags, long timeo, int *err)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int ret;
+	int ret = 0;
+
+	if (!timeo)
+		return ret;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-- 
2.20.1

