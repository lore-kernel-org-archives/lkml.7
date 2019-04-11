Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1113FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC92020818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgWIZrIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDKWE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:04:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45065 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:04:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so1387376lfl.12;
        Thu, 11 Apr 2019 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0g4W32KpOFEIBf/b/mgiwGkgi29MbSE0goELOf/fPg=;
        b=VgWIZrIAUDoOKW+DXqMPzdrKiZFpXiFpG/YOM/Vg+z4ehUonO2RG7mffYfnwFNqvXx
         HtsBbEOkjoe8H6xxzdc3DpZVJPYTIlCmT1UzLmM0G1jx5t74fHt4qtPi6Fptx3Wxl19s
         AAPaxtzV1OQVwBogAVJP5/hx5Rs/5StM0uK4ZL69OE/2PMfO9DzRLTQa8OikiO+F4LGV
         4Tw8DZjBQVgRfUV217u4FRGTf2/G6Y0n2YoKYVxPQ4ChwfdDy0pUfMJ68ISaKroZtmUS
         2vUGgxlVoWvxCwC806KJ4uAmuG2H8Ecrw5rDXzes9x1LxUBsQqKg5MOccIn7FOE1MFAl
         6Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0g4W32KpOFEIBf/b/mgiwGkgi29MbSE0goELOf/fPg=;
        b=QiD9qCWNtBoMW6Z9lhM5ksN1vGRkzXkjppXfrDTIbauclu5t/02v0PEJP/XMawwhE5
         V4ytsBgnn9Ypml2k/KEvMmkuZTFPeFC4UH9O7eQRvvOpCmVFLObW7TIumjtvvGpM1KvQ
         1vDK8+gAsg8aJQeQlyIciehjEzZmP2TyIy1LUk4dZpNquZlpHxYSpKQEtL+DRUOHATx5
         TIVyMbhcePZdB2ntgWFXrTUvtoKmUefvZrg2ml9SdHxM2N9F8J0n8hXAqlG/9y6KyPkp
         Ipn8eji8VC/0UDquqLPP5rRMt8zH9wkLCXRUpiYWITEDntWGlMYv4VRL7qj/prkGZ7H+
         A9FA==
X-Gm-Message-State: APjAAAVnPOOrPcue6WqoGVJmWQO28qOnq4V/AOa8vtNQOK88kTqDK8IK
        gQKki8E3N079Gb8cz0117J5DNTMq
X-Google-Smtp-Source: APXvYqw1rom/1R9Vw5aZrrc8EANBM2736XvxHrLCus65r0gBONHcX4rwaIVWxb81tTFF/qH1PteNXQ==
X-Received: by 2002:ac2:51d9:: with SMTP id u25mr1459238lfm.91.1555020263548;
        Thu, 11 Apr 2019 15:04:23 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e18sm7887808ljb.12.2019.04.11.15.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:04:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] clk: tegra: emc: Don't enable EMC clock manually
Date:   Fri, 12 Apr 2019 01:02:26 +0300
Message-Id: <20190411220230.21726-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220230.21726-1-digetx@gmail.com>
References: <20190411220230.21726-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EMC clock marked as critical, hence it is already enabled at the
registration time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-emc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 0621a3a82ea6..23416982e7c7 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -532,7 +532,5 @@ struct clk *tegra_clk_register_emc(void __iomem *base, struct device_node *np,
 	/* Allow debugging tools to see the EMC clock */
 	clk_register_clkdev(clk, "emc", "tegra-clk-debug");
 
-	clk_prepare_enable(clk);
-
 	return clk;
 };
-- 
2.21.0

