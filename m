Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EBEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17FC21848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkNFXV2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFNRts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:49:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43266 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFNRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:49:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so3414774qtj.10;
        Fri, 14 Jun 2019 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBWvx4SecNd9W3xzBh2uvjqXZGxdkurPogbc13r+iOI=;
        b=UkNFXV2iARrjR+3Dr1EEcShbXlhmXRTwuBrcNeUpPBYTbbrAdOzPgl5r059hdZoTKD
         dSEYfBP5p4aZlcvHt4XIzXpekMhlKoikUDhxeZ/ucDQOJeq1taFVCzmCElDPU5A8kXeU
         DCrRzyRMqpK2EFnIGT98LkhdqL3gIPnzRzMqTiQjdTPQw9eVsQ8PnGTFVjGe5yyEwMEJ
         CJkA3uJ7VjrdlQ3x+mV7Wat+jKNwdYZWFTborA78U7G3so9TGDfmhDkKPHpUX4LxwvBY
         wQBiv7R+1H6GGFPg+1mOslVHAt3M0dCvZQOb9ozT0EQh7m2mTMFUiiYRp9lTXVuGuya1
         RPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBWvx4SecNd9W3xzBh2uvjqXZGxdkurPogbc13r+iOI=;
        b=GHEbDAt0GNJSUePXnrJa7K0vhXp//mDZ/8LsEdbwhu1dliOgi+GWxypBfX2ozejz1T
         T0W/K/R9Mt+3Pca7gn28YaQFUCRT3biG/FZWtSiuBIX7pdR5B8HEIwg8sjqtohpaCo5F
         HHeST/PQZ4dtepSlTFPFNG6CSgt2c//5XwWKQPVQ2PaKCq+mGkyJKDOMvvjV1TVRkalY
         IG/jkHb4D0cKdxr7xCrQ0SVCyYXjHqjqC+wt3P4iSdmMeCXRYQNm11/9nivwNXzhrtcs
         jBWVBIeMepRiQl1bEjBNOCKZAFuVxTBMrl9SMq0kKWMyqz0+AYoNLZa2+FoIafotJUR3
         1YrA==
X-Gm-Message-State: APjAAAWLOOfbg8JUR48AwNZyzN7eZcf3quF454uEQuknOFN4X5FgeppM
        p4YOFsefa1MNIxqOdmXmeCybqiriCjI=
X-Google-Smtp-Source: APXvYqyro6G1YSOOrs9To7EPAMyvzUobwYHM55smkbFis2xkDVYxrI6HeO5ZCDyT741+/BBuPOmsfQ==
X-Received: by 2002:a0c:99d5:: with SMTP id y21mr9411120qve.106.1560534572265;
        Fri, 14 Jun 2019 10:49:32 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id t29sm2348638qtt.42.2019.06.14.10.49.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 10:49:31 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, f.fainelli@gmail.com,
        andrew@lunn.ch
Subject: [PATCH net-next v2 2/4] net: dsa: make cpu_dp non const
Date:   Fri, 14 Jun 2019 13:49:20 -0400
Message-Id: <20190614174922.2590-3-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614174922.2590-1-vivien.didelot@gmail.com>
References: <20190614174922.2590-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A port may trigger operations on its dedicated CPU port, so using
cpu_dp as const will raise warnings. Make cpu_dp non const.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/dsa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 82a2baa2dc48..1e8650fa8acc 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -181,7 +181,7 @@ struct dsa_port {
 	struct dsa_switch	*ds;
 	unsigned int		index;
 	const char		*name;
-	const struct dsa_port	*cpu_dp;
+	struct dsa_port		*cpu_dp;
 	const char		*mac;
 	struct device_node	*dn;
 	unsigned int		ageing_time;
-- 
2.21.0

