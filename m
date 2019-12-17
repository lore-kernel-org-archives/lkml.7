Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D73FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484262072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576600790;
	bh=cjwyw5XX6rHi/JiwHly7w1BPiUCYdP8L4KYVRfVJbDA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=z5qGaSV6sEI+8gNruCAEeygV6SFKLhryh/gYuaWnOADkUKmDzDKAoVGQ9mJuecmhy
	 +3wXbTn/bFVbo09gGT1fdrJnBMxjHVDcNW7uvPglUrkVC61UAEa+JPmgieyr7gyaxF
	 oGBmkXPcj1desx74HM0XUMsXpZ7jAd5R2SPAhj1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfLQQjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:39:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35786 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfLQQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:39:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id k4so1506411oik.2;
        Tue, 17 Dec 2019 08:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FQXepPjODALKwBSGmvnI626nvPCyXuF/Gz5QtqNwjz0=;
        b=m/l1gF9g80kMTKpqAleJet4slwjphXO/hXSkyk1WSp4GJk9j5JP7vitw+UecYBu2P/
         SOVfMWNJtOqo1OEnf38N3tEdMcYxPL9goVWLuyxggmA+QIPYF+UrhswEIeLULhRh47n0
         t1PTO6tdID/frITGv46kQz5LoX+qNelsPIQm9C/cw22hZIH04n5yx52dGpx9SeNrzpue
         bOUr947Y1+cDLgPpFgSb+cy1wunK+5QJ9QrDXNVhsw4rVWpOG26ySwUxEeO0ncUqobAW
         14HUxdhOx2GDvIBVXFk4uGMy0c0EjnCgpMSHMIP0d+mZc1KT/swEb3mrO/VkOJ9sN2rV
         LLOQ==
X-Gm-Message-State: APjAAAUlCr+XW+K0FoMnHHQtf+cEXOTrv1GF24bCZrvBIchhPY2GKjvw
        n2jjus+9QicQdLwqbpUVkhZVBuM=
X-Google-Smtp-Source: APXvYqzVlefm3KM6A23hWqlPPbDdTcYce3iPL46mvJF3fNG92N17VS6twDJQbqt/xZskF6mWsj6jSg==
X-Received: by 2002:aca:a9c5:: with SMTP id s188mr925723oie.154.1576600787852;
        Tue, 17 Dec 2019 08:39:47 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 15sm8040164oix.46.2019.12.17.08.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 08:39:47 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] dt-bindings: Add missing 'properties' keyword enclosing 'snps,tso'
Date:   Tue, 17 Dec 2019 10:39:46 -0600
Message-Id: <20191217163946.25052-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT property definitions must be under a 'properties' keyword. This was
missing for 'snps,tso' in an if/then clause. A meta-schema fix will
catch future errors like this.

Fixes: 7db3545aef5f ("dt-bindings: net: stmmac: Convert the binding to a schemas")
Cc: Maxime Ripard <mripard@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4845e29411e4..e08cd4c4d568 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -347,6 +347,7 @@ allOf:
               - st,spear600-gmac
 
     then:
+      properties:
         snps,tso:
           $ref: /schemas/types.yaml#definitions/flag
           description:
-- 
2.20.1

