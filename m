Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE78C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F39206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367323;
	bh=QVLh0zGMUC9S/xw0SKfHJQerJR43UP5yFgxU0Z+Fxco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NFdWZpEgL9E0akCu45J2erYLkFLcgd200C9Bu8FOZ9b/cyqkwz++IUV+qi/kPRA5A
	 4lF4IO6+I8FtkOdLfPQ38W3dTq+yYY2ijP1Mi8tDv6X6V3tf334ctHH2bleQZl5Adn
	 ELYTwSVoocyNpxjStGbtwpLKp47Ek/pDd2rPJLNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfB1PWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388515AbfB1PNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6C5218E0;
        Thu, 28 Feb 2019 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366824;
        bh=QVLh0zGMUC9S/xw0SKfHJQerJR43UP5yFgxU0Z+Fxco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUtgKJMMaSbs62J3+xUPCP10WgHu4zxyDTUMhS5+GztZbTiokB6hTFfBkLDgH4cui
         8sHCBrn6xr//vU3HkaxBEyyrirAlUDMSuGyr8jMepCiKwZW4te5DrzKMUiEiuMAinz
         iV0rCEIZlRwNFYa2dfbCYExbdyXvRPs50gSvnt+A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/36] bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()
Date:   Thu, 28 Feb 2019 10:13:05 -0500
Message-Id: <20190228151337.12176-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

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
index 41ede90fc28f5..61396648381e5 100644
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

