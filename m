Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B46BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6774C20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198553;
	bh=ZMdH6IpTdtJlILAyBh8ahoFq2arfO69OR6oQyyq6Pu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B5COLA17yvlWZ+cHh9WoS10nG1eLp55yviFNvwoZCFpOQp9Hc6r5MmuJaCmxDsEkJ
	 BX3WroJrKh3boNTg3OYq4JHhxGMRMgbJoc68+QLXSJtsgU5CerikpCO4O1XCY1mwcv
	 6/1VnpKFpeLQIUvXqx3KTy7bRZCWq3wNyD6abxeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfGONtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731659AbfGONtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:49:06 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A0E217F4;
        Mon, 15 Jul 2019 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198545;
        bh=ZMdH6IpTdtJlILAyBh8ahoFq2arfO69OR6oQyyq6Pu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbaOUVMStdcPd69GAXb4P0KW/F3p5GWT8RIkBPyNowS0AEv/CBG4FVuqO8AzyHf+2
         nE+6b+e9IJX6U9u+WyN/wyY6hBjSoYyGPeKJHft9dVNcRadKIpc/TNtxAUAsAV5xec
         eK06fq2rkClDHDiTDr+fWT+C8UbsOuzR5zUW67GE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anirudh Gupta <anirudhrudr@gmail.com>,
        Anirudh Gupta <anirudh.gupta@sophos.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 041/249] xfrm: Fix xfrm sel prefix length validation
Date:   Mon, 15 Jul 2019 09:43:26 -0400
Message-Id: <20190715134655.4076-41-sashal@kernel.org>
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

From: Anirudh Gupta <anirudhrudr@gmail.com>

[ Upstream commit b38ff4075a80b4da5cb2202d7965332ca0efb213 ]

Family of src/dst can be different from family of selector src/dst.
Use xfrm selector family to validate address prefix length,
while verifying new sa from userspace.

Validated patch with this command:
ip xfrm state add src 1.1.6.1 dst 1.1.6.2 proto esp spi 4260196 \
reqid 20004 mode tunnel aead "rfc4106(gcm(aes))" \
0x1111016400000000000000000000000044440001 128 \
sel src 1011:1:4::2/128 sel dst 1021:1:4::2/128 dev Port5

Fixes: 07bf7908950a ("xfrm: Validate address prefix lengths in the xfrm selector.")
Signed-off-by: Anirudh Gupta <anirudh.gupta@sophos.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 173477211e40..76ad7e201626 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -151,6 +151,22 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 
 	err = -EINVAL;
 	switch (p->family) {
+	case AF_INET:
+		break;
+
+	case AF_INET6:
+#if IS_ENABLED(CONFIG_IPV6)
+		break;
+#else
+		err = -EAFNOSUPPORT;
+		goto out;
+#endif
+
+	default:
+		goto out;
+	}
+
+	switch (p->sel.family) {
 	case AF_INET:
 		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
 			goto out;
-- 
2.20.1

