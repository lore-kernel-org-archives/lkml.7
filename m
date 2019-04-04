Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615EAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2820C20643
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+fvvhYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfDDNyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:54:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33966 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfDDNyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:54:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so3962337wrq.1;
        Thu, 04 Apr 2019 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11v4AO806JscAOcPzzzWQaBapK5W4lxcfqi8MRVtNX8=;
        b=e+fvvhYwuE3RPIzpf2wqA48CyKJJmh9Sy8M7VvQKTpFq687KBnYZ0hMCoq2cwx+bol
         kJKIR4eT/JNXbgl1F6q0Oqph3G2I7LRLuGkM/k29D6Po7IpAT1xBOxtX8HkdfBhNq6dp
         LX8SKf9BNgCGe1nAdpLuZcb64EVNjZAPvLBMCzchmaRSa7SC5yN2yG0XJe/KSnBV8HQ6
         zDyvLwtCqqnTGJ16NDdKm+Vy7h/XHVtgFDid5o8ajYqbEy5VWrnA23QM5eKNPIPmtI8n
         erTeVXINku/iRyEiUw5z6l9crkXXZzth2wCFjN7gWCyVAlOuaEtDaKSn6W+7feHxqm50
         mnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11v4AO806JscAOcPzzzWQaBapK5W4lxcfqi8MRVtNX8=;
        b=DKr+k2kAjJv8lbF4JG2Gphe9QFNkqhrJEkiNmcPwLFe0CnIoB/w5lZDNYTwke538n/
         nWHSDJruQu9QDWemK8+izSbECU+uH90rlrGuqjEx2+qwl0TDeuRCXvHOug+10fiJzEdf
         rN1KCa23tExQtNg9jXxU2EVVouqZScf3xORHS1GTmncRUQi/PgJNi2XM7iXrDKF2USTv
         PNJKxWTuntZvVe287dQEbk+BNgDODb+1AbCLDjML5XJBHRBu05ssxzZaaWuebHwyxWPU
         HCTquUkgqLR0aHd//2p7sh/7PdFQho81KH4cp3jNjF04xatp+lMg3W0fViPNR+FlLXS5
         SxTw==
X-Gm-Message-State: APjAAAWoI32Cod0Wx/dKGPN2j9owZ59UjUmA2ppBGjnqLWzEOND2BvxZ
        F2a4NnvCpq7K/Sp+FHHI4CA=
X-Google-Smtp-Source: APXvYqzPqmGvGP201ovYwWltyAg/BFyiG59YHq4rlcURzq6dNDyYqphXizj4IecMG9idwX6INznwOg==
X-Received: by 2002:adf:deca:: with SMTP id i10mr4086609wrn.88.1554386058063;
        Thu, 04 Apr 2019 06:54:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id w18sm28998092wru.24.2019.04.04.06.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 06:54:17 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/2] dt-bindings: watchdog: sunxi: Add H6 compatible
Date:   Thu,  4 Apr 2019 15:57:35 +0200
Message-Id: <20190404135736.8491-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 WDT is compatible with A31, so add this in the device-tree bindings.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
index 46055254e8dd..e65198d82a2b 100644
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	"allwinner,sun4i-a10-wdt"
 	"allwinner,sun6i-a31-wdt"
 	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
+	"allwinner,sun50i-h6-wdt","allwinner,sun6i-a31-wdt"
 	"allwinner,suniv-f1c100s-wdt", "allwinner,sun4i-a10-wdt"
 - reg : Specifies base physical address and size of the registers.
 
-- 
2.17.1

