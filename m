Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A666C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDD52081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHgcPnKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCHFd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:33:56 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36678 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHFd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:33:56 -0500
Received: by mail-yw1-f65.google.com with SMTP id 189so15405191ywi.3;
        Thu, 07 Mar 2019 21:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EkDVjMyOS0P+o/2ObOAgmHD8EBelE89N4wctZePlspc=;
        b=eHgcPnKHRRjhl94tNB2VXy5pngknJ5GJX1CLY/3dh7SPNWbr9LwiyrfWe5/kDYHSRs
         6Ym/mDoU2chlSdb+HVQkK8qcHojNZ9FCpPiW+0pnXbIK03oHHcIJwiAaGLwoNcFkfYJ7
         KcSc3xG+g9CZR8BsYbkXXsX1DMOM7RlHLmQqqQsVC8HF9Te9FQhuNveiWfqMHlEbZw7P
         9acZRMEw6sAwzCLmDu9Cl7qKQK+3eJXQ9aebvbALLrFhVsjDqyCn8/a4C5o+fqSWoEmj
         52K+KTYSkte4yFM3Duot6hHt7meEAXAR476PRf3y6gqSfY+7Dx2pg+VyXOJG8eX7Y4v3
         Af/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EkDVjMyOS0P+o/2ObOAgmHD8EBelE89N4wctZePlspc=;
        b=k2UrmdZf/kXY6tkqkI1pbdO4GArA4mcYYJh26lxAUbhEGjS1qFxmbd4be7E1sb5am0
         XhgbZqND9p1dfJnG4cFZhfpQjl9fsT5rMNS2+xviyY72vOcrOIjLOZbAKAcsrwfKEQyl
         0gLM/krcmka7yDLx2vzRCQt1bb2yu79JRUFeOaHcc0RJHD9O96dj8KG8IqOQwpVUWXLt
         rXhitIseRP5wms+gFARyEfvn9s6V4yqvbuJmCk/k+B7VopT5PsGfXwMRMjgCuNlqt4qK
         AmBBafCwTbMu4AHF7P22+32Jx5pvGy0Ej03EAH7DMGqbmz3u+vEOn6pLMsGRLipHK7kc
         tdsg==
X-Gm-Message-State: APjAAAXi843jZIuRvHyYZKBbLWwCHSwLvRp7AR4tk0x+aXzgYKCLnW+8
        LEukKhaljLbd2uanLvKzi+Q=
X-Google-Smtp-Source: APXvYqwYx5dpHnDU+ZZ5nAIy+z0b39f6L1C3RZ4D3m40wbtfl78cr6wpSZtIgrGVH2Vf4lEY+3hF0Q==
X-Received: by 2002:a0d:d648:: with SMTP id y69mr1704114ywd.453.1552023234977;
        Thu, 07 Mar 2019 21:33:54 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 130sm2342975ywp.54.2019.03.07.21.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 21:33:54 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net
Cc:     Bo YU <tsu.yubo@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH 1/2] net: bonding: fix restricted __be16 degrades to integer
Date:   Fri,  8 Mar 2019 00:33:50 -0500
Message-Id: <2a069375f8393bf05a44669e00281714063a8530.1552023000.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1552023000.git.tsu.yubo@gmail.com>
References: <cover.1552023000.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some warning when:

sudo make C=1 CF=-D__CHECK_ENDIAN__ drivers/net/bonding/

drivers/net/bonding/bond_main.c:2385:26: warning: restricted __be16 degrades to integer
drivers/net/bonding/bond_main.c:2391:20: warning: restricted __be16 degrades to integer
...
drivers/net/bonding/bond_main.c:3241:60: warning: restricted __be16 degrades to integer
drivers/net/bonding/bond_main.c:3241:60: warning: restricted __be16 degrades to integer

So fix it.

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b59708c35faf..135fec28daa9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2382,13 +2382,13 @@ static void bond_arp_send(struct net_device *slave_dev, int arp_op,
 		return;
 	}
 
-	if (!tags || tags->vlan_proto == VLAN_N_VID)
+	if (!tags || be16_to_cpu(tags->vlan_proto) == VLAN_N_VID)
 		goto xmit;
 
 	tags++;
 
 	/* Go through all the tags backwards and add them to the packet */
-	while (tags->vlan_proto != VLAN_N_VID) {
+	while (be16_to_cpu(tags->vlan_proto) != VLAN_N_VID) {
 		if (!tags->vlan_id) {
 			tags++;
 			continue;
@@ -3238,7 +3238,7 @@ static inline u32 bond_eth_hash(struct sk_buff *skb)
 
 	ep = skb_header_pointer(skb, 0, sizeof(hdr_tmp), &hdr_tmp);
 	if (ep)
-		return ep->h_dest[5] ^ ep->h_source[5] ^ ep->h_proto;
+		return ep->h_dest[5] ^ ep->h_source[5] ^ be16_to_cpu(ep->h_proto);
 	return 0;
 }
 
-- 
2.11.0

