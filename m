Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58AC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4288521D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468897;
	bh=wvVGmq4XE2oHNlB21bRNNlRnCfW+IKBgGPSVORd4Cv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QkazGq6M0yuf3ZOFO1eR7p+HK/VOLH5ZEZekjl+J7ufTH7aw+OFh7pPxXYn6j8NuN
	 TeW+6zqxEosrwJ6gGxOUMGzqupJkh5A4DUZRxmdwLJ6dEr7uVzqpSSrGhvPHiEwAgs
	 7K4+975sgv39ScOL7RQOKrNDWI+8uBBT8cu7+7hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfL0RsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:48:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbfL0Ror (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C4B821582;
        Fri, 27 Dec 2019 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468687;
        bh=wvVGmq4XE2oHNlB21bRNNlRnCfW+IKBgGPSVORd4Cv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bo18kt42VO3VyEHCWPLJzYDvMVBoWXdbvnAl+PQqur3buYJLUq5yY/zVduF2nXKIZ
         DS76y9g/FBqgf9h2ZVKKXlLoG7+P0nRkK2rcNYnZ7cmUIMvCAK9Viv2vN2jCv9zLNI
         y5hEIszq85Yu4hJusEz2ItIgHvSHmSqhh7Mt5Q+U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/84] bpf: Clear skb->tstamp in bpf_redirect when necessary
Date:   Fri, 27 Dec 2019 12:43:13 -0500
Message-Id: <20191227174352.6264-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenz Bauer <lmb@cloudflare.com>

[ Upstream commit 5133498f4ad1123a5ffd4c08df6431dab882cc32 ]

Redirecting a packet from ingress to egress by using bpf_redirect
breaks if the egress interface has an fq qdisc installed. This is the same
problem as fixed in 'commit 8203e2d844d3 ("net: clear skb->tstamp in forwarding paths")

Clear skb->tstamp when redirecting into the egress path.

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/bpf/20191213180817.2510-1-lmb@cloudflare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index e6fa88506c00..91b950261975 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2007,6 +2007,7 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	skb->dev = dev;
+	skb->tstamp = 0;
 
 	__this_cpu_inc(xmit_recursion);
 	ret = dev_queue_xmit(skb);
-- 
2.20.1

