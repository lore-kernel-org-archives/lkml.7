Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB14C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A96214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411528;
	bh=n7nHvhE3rU26KZ6W37IyrqJczcqrN6WSmzxXeW4dMy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uf6kHQdK2K4Xe+oQMx/FXokRMPjgXSZZXQca/Nl1w4YO/LccukqZ1vNqMhZRYXIeu
	 KIIfwjMr/5lcjQCWUh/HjU2DGfC07cvj0Vr6rGHwSoh7BVdSLUsskdb91SXXVugHzt
	 ojTLrx/QPCR55NVFjGenGCzCARlKdO85J80zyJBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfCLRRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbfCLRQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:45 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C9B21741;
        Tue, 12 Mar 2019 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411004;
        bh=n7nHvhE3rU26KZ6W37IyrqJczcqrN6WSmzxXeW4dMy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmulW07oq74MnfEzQc6W25VWLB7sGxzNvTHlfmhw0Hv43VJYDgU57WbGp+X5XwOh9
         r3tsdrrDMVG5NBwlGngyC5k3nA4gRGTT3ySxvV7hvjd8tc5wtWlU5Tzsb9oI+PF1Yc
         I924wRqAhLDjzHyH6UliNyY4bRYY5fSJfT2+tDCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 090/135] bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()
Date:   Tue, 12 Mar 2019 10:08:57 -0700
Message-Id: <20190312170349.473643842@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c9e4576743eeda8d24dedc164d65b78877f9a98c ]

When sock recvbuff is set by bpf_setsockopt(), the value must by
limited by rmem_max. It is the same with sendbuff.

Fixes: 8c4b4c7e9ff0 ("bpf: Add setsockopt helper function to bpf")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 41ede90fc28f..61396648381e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3081,10 +3081,12 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 		/* Only some socketops are supported */
 		switch (optname) {
 		case SO_RCVBUF:
+			val = min_t(u32, val, sysctl_rmem_max);
 			sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
 			sk->sk_rcvbuf = max_t(int, val * 2, SOCK_MIN_RCVBUF);
 			break;
 		case SO_SNDBUF:
+			val = min_t(u32, val, sysctl_wmem_max);
 			sk->sk_userlocks |= SOCK_SNDBUF_LOCK;
 			sk->sk_sndbuf = max_t(int, val * 2, SOCK_MIN_SNDBUF);
 			break;
-- 
2.19.1



