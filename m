Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213EBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FB82184C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709752;
	bh=GB/tzb7UrmxmQDwStdqyaUgKDv2/kefDkBPjoOdWj90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BjZLyTUm3sRJHf08Sl8jZX0e432LYlmn1Pj1DblWE0J8yXMf1l+gd2uKrJTl7sAVO
	 KXomJgXdl4J2QH90qWH8DYbt3+2mW6NPjzlfxc5wMQV8zoLAoxJDrKqZhE+Iufvnkb
	 ziMUmEgrKRn5J/vYDSPvwfNNEqO+IBU/auoSLNAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfC0SCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbfC0SC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA6E72147C;
        Wed, 27 Mar 2019 18:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709746;
        bh=GB/tzb7UrmxmQDwStdqyaUgKDv2/kefDkBPjoOdWj90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujTB8Heyiikv2PloWo9nS0lDUNTyqEPOXUnc10QXpTPDLCO0q8MGyYTJowkkBo6ko
         pFYkBFh7s5WWjNZPK7iLdqENfg837DGUk57OFjNlSyIygpLQJk0+0kUYPbiIwkPJvB
         lo7hA9Ua0cRED6KGW2JW+h85Uu1cvIUPeJqdh3RA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 016/262] xsk: fix to reject invalid flags in xsk_bind
Date:   Wed, 27 Mar 2019 13:57:51 -0400
Message-Id: <20190327180158.10245-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

[ Upstream commit f54ba391d88f5a5d032175b4c308c176e34b80b7 ]

Passing a non-existing flag in the sxdp_flags member of struct
sockaddr_xdp was, incorrectly, silently ignored. This patch addresses
that behavior, and rejects any non-existing flags.

We have examined existing user space code, and to our best knowledge,
no one is relying on the current incorrect behavior. AF_XDP is still
in its infancy, so from our perspective, the risk of breakage is very
low, and addressing this problem now is important.

Fixes: 965a99098443 ("xsk: add support for bind for Rx")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 85e4fe4f18cc..f3031c8907d9 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -407,6 +407,10 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	if (sxdp->sxdp_family != AF_XDP)
 		return -EINVAL;
 
+	flags = sxdp->sxdp_flags;
+	if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY))
+		return -EINVAL;
+
 	mutex_lock(&xs->mutex);
 	if (xs->dev) {
 		err = -EBUSY;
@@ -425,7 +429,6 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	}
 
 	qid = sxdp->sxdp_queue_id;
-	flags = sxdp->sxdp_flags;
 
 	if (flags & XDP_SHARED_UMEM) {
 		struct xdp_sock *umem_xs;
-- 
2.19.1

