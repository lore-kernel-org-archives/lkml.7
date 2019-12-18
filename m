Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B21C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88081206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih9cGawQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLRAvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:51:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42688 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfLRAvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:51:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so199201pfz.9;
        Tue, 17 Dec 2019 16:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0fF3Pwrvb1XjAJmZpEQzz7NN6h0Qr1+USwjWNMBgsq4=;
        b=ih9cGawQB+5mXsRHPaE/Cnw6u9n+P13I4GrkYcSwFyTIrtVvAQWm7ify7SoNs9ROJ1
         Kzb9XCQEx75vYSrrrEVQFS5FSMrYtNakG26XANZLJIiyJo4GpuoGiLo5GCXxLJ4HkQQu
         mPdYedFxQHdPBwV4BKmIRkJMhuMXDrzoRQiUigtteIon8L20xlnoCtMyLK4QKHUnZ1pO
         CVTE+8UED6KxBQ/a+Gzpltnm2okhX5Xzk2EjR0ZyInxqKf+VnK2aVUCjTb1jOmiVnBlF
         qNLu5GZr4qt87/uS/bl/Xri2FkwBUuJcMb6TA2nyCIiH7yl51P+9XbrgUXxc1jHu+Sqk
         /G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0fF3Pwrvb1XjAJmZpEQzz7NN6h0Qr1+USwjWNMBgsq4=;
        b=h3sU7q1CTCj5nqt80QbRm8hYjW7B2mFsyxpyx1yqGct2jFaoWFuCLgS+hH34YYAeGK
         US0G3ZRitf98Y/xYy4P6kBVd+7dQmyUWxJ+cVwHP1aB5LiJG0mKWtlEXHbzLEt5utNu0
         9nE2DP16Hp6VOLEMmHSTBCjLwuW8DvQbU7Wkh4ES/R3atKblPohm1qGhXTp7dXqpDMdx
         RGPXKy9xYm6DEZHFPskYJTxyQ/Bh/MAkBhNLGnR+hHpAOv6+RmbMgmDXdKd7oFcfWDWk
         LJvnTQK9mdF8rpDkjHUThZKTByLLf/94njIXSbfaMDI244uozsJI3CoJUn2kjoB8rW1o
         wN4w==
X-Gm-Message-State: APjAAAW1n3aW2ecwJmiP0urZLwAXrTznpmVLJLH/Lyv7t+RngrCHWqHF
        PM4UFiS/pbIW28yZ7KFI5IqF1/qT
X-Google-Smtp-Source: APXvYqxRbslnVaiEfFed8OBAvigKprORjy+4ApV7ny1p4NETQVzemdSZRgcIfZAAVlsesJtp7f986g==
X-Received: by 2002:a62:6342:: with SMTP id x63mr672963pfb.103.1576630292413;
        Tue, 17 Dec 2019 16:51:32 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 81sm274819pfx.30.2019.12.17.16.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Dec 2019 16:51:32 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next v2 7/8] net: bcmgenet: Be drop monitor friendly while re-allocating headroom
Date:   Tue, 17 Dec 2019 16:51:14 -0800
Message-Id: <1576630275-17591-8-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576630275-17591-1-git-send-email-opendmb@gmail.com>
References: <1576630275-17591-1-git-send-email-opendmb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During bcmgenet_put_tx_csum() make sure we differentiate a SKB
headroom re-allocation failure from the normal swap and replace
path.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 13e9154db253..e2bca19bf10b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1499,11 +1499,12 @@ static struct sk_buff *bcmgenet_put_tx_csum(struct net_device *dev,
 		 * enough headroom for us to insert 64B status block.
 		 */
 		new_skb = skb_realloc_headroom(skb, sizeof(*status));
-		dev_kfree_skb(skb);
 		if (!new_skb) {
+			dev_kfree_skb_any(skb);
 			dev->stats.tx_dropped++;
 			return NULL;
 		}
+		dev_consume_skb_any(skb);
 		skb = new_skb;
 	}
 
-- 
2.7.4

