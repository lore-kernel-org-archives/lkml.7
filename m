Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E521AC7D63B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25255247F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="yrsqrWs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfLMSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:08:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52146 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfLMSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:08:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so131381wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 10:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/cxA8OR7wvHTzpZtT+CV5+Gsa2e2EvgAMAg5PhtGMU=;
        b=yrsqrWs1BY9XfWRcorJXSVnwZk2X+HKuhTyAsxUPuUQSr+/GAJzVZjebOCv42OsEG2
         J39R3rEgUdBuhtYfQyZ5X4REm5t3K9E70nVP2h51B6RzqZx66WWwLJ9okKiYvZoLtniY
         awM3o9a/w3hFmTcDuzuXnHSZfrUGB2S5tNwag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/cxA8OR7wvHTzpZtT+CV5+Gsa2e2EvgAMAg5PhtGMU=;
        b=cRDBcbRfNQK9UlGD68nsvQ/1jCc+e5AY4H/Qw0JKB35YMavFR+elF5KJILNjsXigIQ
         u+ySV37NwBY6KLdb2MOEzjZ9SlWyhWLPk/6PDR6X+OfdZRvwHuGL/78iOLCRtrXgwHl4
         qPu0zezigaAOenAN4XxAXScxqgyi4PizlvktboiPT9qRaMoCuimB4x6buOkjX4m2wjLX
         b1zr4PPWhd+mXcq2jZW8cvmHQ2XBakyV+wju9tT3f0T2veCGb6PhcUsQdMOQduxnB+F8
         o+1N+dueqRgratnYIUCvP7+w2oajdIa6JBXcTeX3cbaNjVG3HLvJ32QXlWV3jBsEaYsM
         k2Sg==
X-Gm-Message-State: APjAAAVamegu4oR9heS1peZMfFi8gmCUiXDCNfoEz4/MI5/JYTO4fYuf
        NcO0OIUBxd9SfUTdlR/ye3tk2Q==
X-Google-Smtp-Source: APXvYqyRzmw1t/nhcd7tFqSwEq4NM+D3Xo/fEUCYFhdc2wqXY4e+lStCTXj/vfCE7f8Nr3vKFyJ+fA==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr14480448wme.26.1576260534942;
        Fri, 13 Dec 2019 10:08:54 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3da5:43ec:24b:e240])
        by smtp.gmail.com with ESMTPSA id d8sm10686655wrx.71.2019.12.13.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:08:54 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2] bpf: clear skb->tstamp in bpf_redirect when necessary
Date:   Fri, 13 Dec 2019 18:08:17 +0000
Message-Id: <20191213180817.2510-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213154634.27338-1-lmb@cloudflare.com>
References: <20191213154634.27338-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redirecting a packet from ingress to egress by using bpf_redirect
breaks if the egress interface has an fq qdisc installed. This is the same
problem as fixed in 'commit 8203e2d844d3 ("net: clear skb->tstamp in forwarding paths")

Clear skb->tstamp when redirecting into the egress path.

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index f1e703eed3d2..d914257763b5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2055,6 +2055,7 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	skb->dev = dev;
+	skb->tstamp = 0;
 
 	dev_xmit_recursion_inc();
 	ret = dev_queue_xmit(skb);
-- 
2.20.1

