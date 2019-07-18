Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB6C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD2820880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/erVWvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbfGRK1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:27:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41442 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfGRK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:27:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so26770979ljg.8;
        Thu, 18 Jul 2019 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CTzA0mQSX6E47LpcppeqTyEneaomnmHbIOubDMZudK0=;
        b=O/erVWvoh8NFIDf748Kxi+xjNbM4DWAWHafjSL6Uo+YxpPQH2Bw68sGU0SN2gks9jz
         jusCdVYMibb7vdakufKuhF/X8ebgx93XDykEF39ssQ6JbCCeT/gW2CvNQDDQHFdlNqr2
         9tmXhysj0fuwOvhrP61Utgl0z96BBP43FVZyF8j6cSIXhkPkD/AnNZpli6jq+6Glf5X7
         dilNbIax+HVDYn8OhRPGaAqi2i6m+TaAbnOXf+LEpgDkRupMGSFlqXpwb7huV/ogpoX7
         pvMVA/3/D3zG0TPaS/+IFluis577k0pkc//NQF2TQeH37bplocKpXGzLzsV4djghF4Mu
         yX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CTzA0mQSX6E47LpcppeqTyEneaomnmHbIOubDMZudK0=;
        b=rfJONGJyo8S/8/gSwEqzuFfYg7iZeMfg7gfTVJTFRhpAzI4EfjpAImVqBC730FI7u7
         pKRX8Lu/h8fpf7d7ppcidgayhawbYuuNvyR249Bk7egzeh1+R00w2lgqhacvlZbJR1bp
         9Cj1jkkN+bCpRNAdULdW1Rw4ZvN1jZntxh3XuLMJg8HPb82GcYIDUoAzCLaAL/rjvKbq
         1+4d3hj7uj8JHA+d2mg0hkdNubJ++xobgTmrct0B+rixLj4vi7p/L7HPgORih+Y+hMW+
         88r42sW/ld8eRITq5CsEljprzdqXwGv0Xic7oSqo3MaeMjUQajmqjpsQqT6Tl6iUsJKl
         7FlQ==
X-Gm-Message-State: APjAAAXxN20wjtNhzLhyxNTnp5IyJp3939EAnex49OMF0w+UX7VlH1sm
        Kx7FEot4tJewU9knqSJ/Z/g=
X-Google-Smtp-Source: APXvYqyt7eV3lUulX+41r2RetIzxtfsevPiEn1vh8b8VbPpRvO2Dw47qb8/UIx27OdyQRTbZXeqXFw==
X-Received: by 2002:a2e:63cd:: with SMTP id s74mr23521248lje.164.1563445630790;
        Thu, 18 Jul 2019 03:27:10 -0700 (PDT)
Received: from peter.cuba.int. ([83.220.32.68])
        by smtp.googlemail.com with ESMTPSA id y5sm4989913ljj.5.2019.07.18.03.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 03:27:09 -0700 (PDT)
From:   Peter Kosyh <p.kosyh@gmail.com>
To:     p.kosyh@gmail.com
Cc:     davem@davemloft.net, David Ahern <dsa@cumulusnetworks.com>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Signed-off-by: Peter Kosyh <p.kosyh@gmail.com>
Date:   Thu, 18 Jul 2019 13:26:55 +0300
Message-Id: <20190718102655.17619-1-p.kosyh@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vrf_process_v4_outbound() and vrf_process_v6_outbound() do routing
using ip/ipv6 addresses, but don't make sure the header is available in
skb->data[] (skb_headlen() is less then header size).

The situation may occures while forwarding from MPLS layer to vrf, for example.

So, patch adds pskb_may_pull() calls in is_ip_tx_frame(), just before call
to vrf_process_... functions.

Signed-off-by: Peter Kosyh <p.kosyh@gmail.com>
---
 drivers/net/vrf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 54edf8956a25..7c0200bc46f9 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -292,13 +292,16 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
 {
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct iphdr)))
+			break;
 		return vrf_process_v4_outbound(skb, dev);
 	case htons(ETH_P_IPV6):
+		if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct ipv6hdr)))
+			break;
 		return vrf_process_v6_outbound(skb, dev);
-	default:
-		vrf_tx_error(dev, skb);
-		return NET_XMIT_DROP;
 	}
+	vrf_tx_error(dev, skb);
+	return NET_XMIT_DROP;
 }
 
 static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
2.11.0

