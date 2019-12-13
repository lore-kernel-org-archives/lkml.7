Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68179C341C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0E9246C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EwfZKJpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfLMPrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:47:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37858 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfLMPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:47:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so7175165wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zy/1vxmK7IESgZ5MufAb5lMH5M1hrx2tBtD49AP8IGg=;
        b=EwfZKJpHgTZfq2oP7jePrJKUK8ZNAm4PsQGN32QF3UGr1NkO0kMWQMhpx3xpKJd4k2
         qCENKuKt9VkU+QR6qzO73xgYJPkZkW515/0DMsa4G85AiuMp+AxljrIpsZKE+TY8ngmk
         /8dv3fPgl/f9PgecfmougTtKhSdBMssa8PEsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zy/1vxmK7IESgZ5MufAb5lMH5M1hrx2tBtD49AP8IGg=;
        b=r7wPOeYwgPrFqzae2EMM5mtaryuTN6zXsbWdLi4pFtgZardb5bOEQPpkf+d1kR3Ol7
         hp+5leibEdzfDXWI2aP/2fV8kUxdowNIw+hxAhaAfSfVNhwtVqtemU/zUJmb6tz2C0xv
         OWBcthbEabjqvOgPlfjyu0odjQQlc6LmL5sYg6qWLNXFm4hxmEbVkXKYliaZmZhfgAEy
         /PptvoiOp0PjMql/TveKq5qBYqYGfmxS8Na5u8eILL0EjWvf6frxCfMpSArZ0Gtz3C85
         uOGbQU2jG2yjR1zOxXEkNzQ7WE8D8mwXgt9kEQMUT72iu3oF90Eh1cSD7D3ZsvHKgfCm
         H0sg==
X-Gm-Message-State: APjAAAXTz9RHw80H/7zKV25edaLTJhdAfx8cXpwOeAOtPXhm3f+i/ocL
        86V6pnQvhaug3P8DhBAEtuYCbw==
X-Google-Smtp-Source: APXvYqxDDCsPNF553NwXAaiIZEZtJCqKHvMMr8OTf4QdQlkxPgrUbkSbZGoxyJoE0pe94MnpErfvJQ==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr14079175wrp.2.1576252064539;
        Fri, 13 Dec 2019 07:47:44 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3da5:43ec:24b:e240])
        by smtp.gmail.com with ESMTPSA id s8sm10140295wrt.57.2019.12.13.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:47:43 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net,
        "David S. Miller" <davem@davemloft.net>,
        Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>,
        Richard Cochran <rcochran@linutronix.de>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf] bpf: clear skb->tstamp in bpf_redirect when necessary
Date:   Fri, 13 Dec 2019 15:46:34 +0000
Message-Id: <20191213154634.27338-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redirecting a packet from ingress to egress by using bpf_redirect
breaks if the egress interface has an fq qdisc installed. This is the same
problem as fixed in 8203e2d8 ("net: clear skb->tstamp in forwarding paths").

Clear skb->tstamp when redirecting into the egress path.

Fixes: 80b14de ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5 ("tcp/fq: move back to CLOCK_MONOTONIC")
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

