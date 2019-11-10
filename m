Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC6BC17444
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 12:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF0921D7B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 12:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5tCu1Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKJMoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 07:44:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45594 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfKJMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 07:44:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so10831819ljg.12;
        Sun, 10 Nov 2019 04:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y83C4uV1+CMS9qXxIDGEDkXZDlFcKiUT+tBB2iKcZ/8=;
        b=S5tCu1Q/bUWUzoqui0dPCRpuzi6ZO6mnhyySQUfJ8Wq0Sw21KjmuAhUeqMLtXFQIgp
         /CuDTn6oX6LgJcIkQQW5NO0JEqDaHfh8mS2lOf/KCLK8EERkNsE44C3on2wsOQ6pOjYl
         H1P/W6x5qGi+QAJOrQOiqlj/I9dcvNEwyBzIkvDXGk66zCb0DfYWInfROuSUe+q3W1+o
         0Q6umV52sYXfDemaam8ueHnzdPNcWnEbzjGUDisxUgqNSmQ86L8i1l5CrRSN926q04c/
         CAzAkuvfZm0OCMYchvxZJG7l7F2PDMbngOIXDx+prmkP2nYs6q7J7LhtafWXJgC2yANx
         RzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y83C4uV1+CMS9qXxIDGEDkXZDlFcKiUT+tBB2iKcZ/8=;
        b=hxDvxlEfA9bIwJ640waOgPV46swpFjoWfDd9IE/5EDLWrnO0yFZt7Cug0+B1l0E4Hb
         MQgtDhZw3bD5NkjLEYaB/So8yw3mf81nd9971qWnR3LDAr43qJUmyg62xAqAlft2Rn7M
         kn+D+CQHocqIP3ZUr2yqchYUKQwlWhxxkHxbg5tpRTlnW9q4wQyVXyfQpsxseoEKMUvu
         ok0901P0rLV6bcO4x1568TEkyDKwUc5nVDUlIMb4eoNVGplhKU7Ya2c6MmEpKWNy7iLQ
         Posr/8gNEJGxanDivckszyA4ZMon72eVSvce+K9/zCQHRUCv++6IncKFKJ0vhbHnL3PE
         nyUA==
X-Gm-Message-State: APjAAAWhdLdnf9lSlztgxxYlbSkEYJlLvbzIJ3orrWe0JGFzhSC7CiML
        THOOxPSvC35hxR/G42M7n6U=
X-Google-Smtp-Source: APXvYqxUIUlp45THMZfcuhEJlbzNkjAeA1+yMttaZdWaX6nYzo2jbjepxuvD6mbt0FR9mIQCgtKtxA==
X-Received: by 2002:a2e:98d4:: with SMTP id s20mr13111304ljj.128.1573389841582;
        Sun, 10 Nov 2019 04:44:01 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id r7sm5377486ljc.74.2019.11.10.04.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 04:44:00 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     megous@megous.com
Cc:     arnd@arndb.de, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, icenowy@aosc.io, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, mark.rutland@arm.com,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        robh+dt@kernel.org, tglx@linutronix.de, wens@csie.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH v2] phy: allwinner: Fix GENMASK misuse
Date:   Sun, 10 Nov 2019 13:43:55 +0100
Message-Id: <20191110124355.1569-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191020134229.1216351-3-megous@megous.com>
References: <20191020134229.1216351-3-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments are supposed to be ordered high then low.

Fixes: a228890f9458 ("phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Tested-by: Ondrej Jirman <megous@megous.com>
---
v1->v2: Add fixes tax. Add Ondrejs Tested-by. No functional change.

 drivers/phy/allwinner/phy-sun50i-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
index 1169f3e83a6f..b1c04f71a31d 100644
--- a/drivers/phy/allwinner/phy-sun50i-usb3.c
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -49,7 +49,7 @@
 #define SUNXI_LOS_BIAS(n)		((n) << 3)
 #define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
 #define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
-#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
+#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(2, 0)
 
 struct sun50i_usb3_phy {
 	struct phy *phy;
-- 
2.24.0

