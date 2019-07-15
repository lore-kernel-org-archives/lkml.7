Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1755AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAD82081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198812;
	bh=S0bbORhRFnIJAGx6S1IDtqfVKMPjhZ7N064ANcYDjt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yibJ0yKVVIqi1adlIIuxMg44seR4LzIg3tZIW6qTPni04KsLk5RPLTHL7dWpzWNHW
	 5GjgSSglLmpbNYflTh4qAZX2J12jslKgZPCTuSexNxF2B5Jl3zRCZzhsp5/RC/U6s7
	 PlIH3sR+7ozjH4xK8LRcsUmXBT8eizAHjUvKUoUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfGONxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732391AbfGONx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:53:28 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4FF2081C;
        Mon, 15 Jul 2019 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198807;
        bh=S0bbORhRFnIJAGx6S1IDtqfVKMPjhZ7N064ANcYDjt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohnBMqOAssAX8FTDqtpXry2lek+OzAJCAtIZb60NLfOe0+gvcoME0Vys2bqrGtjUz
         B3toanC9SuPoO38gv9wvOuFxIa0gqFRUUonIRfX8VigGUyKWwX1bAP95Xs15Rnvw6x
         0Gpw/aNBcBEKGnAHHxeTIHTUpHk7hLr1ixr/Oas0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Anirudh Gupta <anirudh.gupta@sophos.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 110/249] xfrm: fix sa selector validation
Date:   Mon, 15 Jul 2019 09:44:35 -0400
Message-Id: <20190715134655.4076-110-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit b8d6d0079757cbd1b69724cfd1c08e2171c68cee ]

After commit b38ff4075a80, the following command does not work anymore:
$ ip xfrm state add src 10.125.0.2 dst 10.125.0.1 proto esp spi 34 reqid 1 \
  mode tunnel enc 'cbc(aes)' 0xb0abdba8b782ad9d364ec81e3a7d82a1 auth-trunc \
  'hmac(sha1)' 0xe26609ebd00acb6a4d51fca13e49ea78a72c73e6 96 flag align4

In fact, the selector is not mandatory, allow the user to provide an empty
selector.

Fixes: b38ff4075a80 ("xfrm: Fix xfrm sel prefix length validation")
CC: Anirudh Gupta <anirudh.gupta@sophos.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 76ad7e201626..b88ba45ff1ac 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -167,6 +167,9 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 	}
 
 	switch (p->sel.family) {
+	case AF_UNSPEC:
+		break;
+
 	case AF_INET:
 		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
 			goto out;
-- 
2.20.1

