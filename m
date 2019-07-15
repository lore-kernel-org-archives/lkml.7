Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F64C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036602067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202188;
	bh=EPsXqdZLhRsdKOXkLoqo+HP5IhR6Qd8g4VyJae6nne0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yZgRNqS37Bkiy47nRrlqBYgdwnAs9MuhTa292GpAUHD4k3vZfolwD1tIbrLE6ZoUG
	 kwAqs4xgLEdyAykq63vgEDPmUqGLjsNCrxP/W0t0du8gs+cuB0ZDmQFfIGop2MrIKq
	 ArbCkOmWPAhEEDOpacgjQCCuJJQA4tiPBYPRNlBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404815AbfGOOtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392174AbfGOOrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:47:25 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19552067C;
        Mon, 15 Jul 2019 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563202044;
        bh=EPsXqdZLhRsdKOXkLoqo+HP5IhR6Qd8g4VyJae6nne0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLk+nuYrbOKG4RmGCXfmLmGYGcgCTAtW1IH2xzpaWAjWl6/Zgk62NExhOFueNwM1n
         JeVZUWoyhtDGuyStGpEstnHP5EoGgJ9AvsUxmxnrmpD0m7NuHbAhCB5Ihabv+28A2L
         5nCIOy9o34lWPoK8YopGrom8yiSB2HTHij/WRPME=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Anirudh Gupta <anirudh.gupta@sophos.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 31/53] xfrm: fix sa selector validation
Date:   Mon, 15 Jul 2019 10:45:13 -0400
Message-Id: <20190715144535.11636-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715144535.11636-1-sashal@kernel.org>
References: <20190715144535.11636-1-sashal@kernel.org>
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
index 10fda9a39cc2..8cc2a9df84fd 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -166,6 +166,9 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
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

