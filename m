Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA20C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6882175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="bw3P3xpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbfEWVJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:09:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36439 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbfEWVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:09:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so3771279pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0l7QFOq9rpOhcfdcebxs2xSgloj45bF1H4poSZVVNXU=;
        b=bw3P3xpxEOK9DYDEdoiW/viHc52zWXncC8sgrc8cjiSsjfmj00b3B7D5zPiZG8SPA2
         fw15EXzxrEqygF6v0gmsVD37IwEnqRrcrFVp2AkvIRLfWYN35RMb7TvLORt6zQNZohId
         swupTnCebcrc1tjx8+il9dv7vNmMDM/TubQ9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0l7QFOq9rpOhcfdcebxs2xSgloj45bF1H4poSZVVNXU=;
        b=JhvMfmQalpVVVFDUjTc9djr01Yl3MM7WBhcexudsyc9aCHF5pqEwdxgK5DLd6Upcel
         alHGJBj42Imz9hmSzdBTNcEFgCKC9WhD8FayHiSRGM6U8SUeqXGBKhZFo8s6WwTkAHa5
         gvUMeeKTkccebmdo5FKsDJMtg+re7eB0paB0UPNGF9rDwWNBLlAk2lvaVwZlOQFsoGNg
         JGbORN6nbYhQuGsj/OGabbLM8kfxHUJMFuJa/kR0GebG5d24yF+KNFphusMjcSMgHf/+
         1i54QS5B+Onrrnuau8K7ChY3245lQGAa6rY1FjbYXLSV+lHtzw4zBAoJLolVdLk1OD/l
         XU8g==
X-Gm-Message-State: APjAAAWrognCBRfAL9VDaqJ7YsJP1P5tsr/effzPa9bcdSkWejRfm9dp
        zD1KMvh4zXVJj2mQkBtAooEzAw==
X-Google-Smtp-Source: APXvYqwfdDfCd2q6qUNP/3/3toCKsl47hLQN2VPf2IAiYwQ3P+CC8YPLYtDyHmeV6TnMDqkJNcnwDw==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr4337153pjk.32.1558645744988;
        Thu, 23 May 2019 14:09:04 -0700 (PDT)
Received: from localhost.localdomain (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.googlemail.com with ESMTPSA id y17sm333481pfn.79.2019.05.23.14.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 14:09:04 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
Date:   Thu, 23 May 2019 14:06:48 -0700
Message-Id: <20190523210651.80902-2-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190523210651.80902-1-fklassen@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.
This can be illustrated with an updated updgso_bench_tx program which
includes the '-T' option to test for this condition.

    ./udpgso_bench_tx -4ucTPv -S 1472 -l2 -D 172.16.120.18
    poll timeout
    udp tx:      0 MB/s        1 calls/s      1 msg/s

The "poll timeout" message above indicates that TX timestamp never
arrived.

It also appears that other TX CMSG types cause similar issues, for
example trying to set SOL_IP/IP_TOS.

    ./udpgso_bench_tx -4ucPv -S 1472 -q 182 -l2 -D 172.16.120.18
    poll timeout
    udp tx:      0 MB/s        1 calls/s      1 msg/s

This patch preserves tx_flags for the first UDP GSO segment. This
mirrors the stack's behaviour for IPv4 fragments.

Fixes: ee80d1ebe5ba ("udp: add udp gso")
Signed-off-by: Fred Klassen <fklassen@appneta.com>
---
 net/ipv4/udp_offload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 065334b41d57..33de347695ae 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -228,6 +228,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	seg = segs;
 	uh = udp_hdr(seg);
 
+	/* preserve TX timestamp and zero-copy info for first segment */
+	skb_shinfo(seg)->tskey = skb_shinfo(gso_skb)->tskey;
+	skb_shinfo(seg)->tx_flags = skb_shinfo(gso_skb)->tx_flags;
+
 	/* compute checksum adjustment based on old length versus new */
 	newlen = htons(sizeof(*uh) + mss);
 	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
-- 
2.11.0

