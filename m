Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4FCC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D8E21741
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvABPtNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfDPQW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:22:29 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:43655 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfDPQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:22:28 -0400
Received: by mail-yb1-f201.google.com with SMTP id d2so16037160ybs.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BelyAusOx0YfiakkT+ISkR4vR8JMKkPLQAmRbMojJck=;
        b=nvABPtNO6Lg9G2r0uL7lHQpP3tXFz2i5Qqd2QyfCuqSD4AqUuggZKu0I48SjXBnKl/
         +OzKJjgTExCF9MzhGXQzTe7x5CQs2P4x5C4RbGLQkyokAkkbX/zeGH1cOelAnwg2Trc9
         k3KMjogiB8pDMRJcTR4VXPT88UZv+ocDyLfLAnoiFvj5DC1ri4lOIYxvGBtFm0HzxQX3
         xlf3Hpe83YKyMDEaoc7iVu/9Ut2DyzW3StRq5ArUsIHiYbVPDlP19NkRrU/LgPevMdZC
         Zva5aeBk8chzsj6Xq4FA3JsnjCWtO3mvJDQr/7jdM5rLJc2E+Rc+6k+Cu6wOpLbxHAfU
         EAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BelyAusOx0YfiakkT+ISkR4vR8JMKkPLQAmRbMojJck=;
        b=q4oDBsvhH4oOocku8hAJ83LyROX3QMrlHsZO4/aHtBwOOPDzZic7U+Z/j57Qa8861X
         rwTktDAM6qx68atqf6JU1ibfzFfqoK/xhMDY9gaifEnoZLQvQVvJdq/fiyePB/hKUaWO
         PGc42TXM1a4f50DtaqonTNZ1CRpFa8DdABzWGtCoTF4wlRl+q14GMIPBMMHpD6BESWRW
         tujvWpTWpGNFovBZJ6A9VZIZfjzPqt/PqyzsfDCcGzHudLF8se5tEuKkHcoooUfsOYEh
         8outW+UcXMski7cjUZxrsWjuJq/qOnZcGrb++JifmJ50j/RA0j8jF5ssiaedGaC74s8e
         yuJg==
X-Gm-Message-State: APjAAAU87+p3BQHRcdg0fVH1BzFEk3+O0gZVYuJ5UOJXaaFH3TmCeWLZ
        tLa8lwDdpfzFhG7Mf7hGoYX5+MRHP0uh
X-Google-Smtp-Source: APXvYqxv9nfTEuvVY34Q+m+TiayX7m8XCPbwroqmXgonTqTIk8WLKclTe6eJdFH3s97gDXhAPBvSrQXshjJd
X-Received: by 2002:a25:3494:: with SMTP id b142mr977209yba.48.1555431747602;
 Tue, 16 Apr 2019 09:22:27 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:21:50 -0700
In-Reply-To: <20190416162150.150154-1-venture@google.com>
Message-Id: <20190416162150.150154-3-venture@google.com>
Mime-Version: 1.0
References: <20190416162150.150154-1-venture@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 2/3] ARM: dts: aspeed: zaius: update 12V brick I2C address
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au
Cc:     Robert Lippert <rlippert@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Lippert <rlippert@google.com>

The I2C address of the brick is different depending on the board SKU.

Update the values to instantiate addresses which work for most boards.

Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 63e892f16d050..51265af622574 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -328,10 +328,21 @@
 	 *   LM5066I PMBUS @10h
 	 */
 
-	/* 12V Quarter Brick DC/DC Converter Q54SJ12050 @61h */
-	power-brick@61 {
+	/*
+	 * Brick will be one of these types/addresses.  Depending
+	 * on the board SKU only one is actually present and will successfully
+	 * instantiate while the others will fail the probe operation.
+	 * These are the PVT (and presumably beyond) addresses:
+	 *    12V Quarter Brick DC/DC Converter Q54SJ12050 @6Ah
+	 *    12V Quarter Brick DC/DC Converter Q54SH12050 @30h
+	 */
+	power-brick@6a {
+		compatible = "delta,dps800";
+		reg = <0x6a>;
+	};
+	power-brick@30 {
 		compatible = "delta,dps800";
-		reg = <0x61>;
+		reg = <0x30>;
 	};
 
 	/* CPU0 VR ISL68137 0.7V, 0.96V PMBUS @64h */
@@ -342,7 +353,6 @@
 	/* Master selector PCA9541A @70h (other master: CPU0)
 	 *   LM5066I PMBUS @10h
 	 */
-	/* 12V SMPS Q54SH12050NNDH @61h */
 };
 
 &i2c8 {
-- 
2.21.0.392.gf8f6787159e-goog

