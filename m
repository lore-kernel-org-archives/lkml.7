Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7394C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E03217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evcK4Zux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgACBDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:03:44 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36297 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgACBDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:03:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id n59so4070227pjb.1;
        Thu, 02 Jan 2020 17:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3e2pmpdtRSb5w927ol9J3ozYI0WGUYA6/KUGnZGZ6w=;
        b=evcK4Zux9t/ZEnAQZs9Wk8UWEDzoPxaYxPf4jDOU917ig6c7toT3M9IainOD482M/x
         aqBQwo2oQ/8j0azqFZIxr3OPR7rXaXAJu4Wr+XaCUIP/GFQ7yeQ7c3QCgU7iYLFvhhk6
         9jt0PtxIrLxHhwOdSMiGgD33c3uWfaqzP+0idgLWql5S2f7ft0Zx53YSNh9ghSA3h+gZ
         5nwRtXY83M4rl4Dux0gOhobtf+LILiUFgzkD2iPqBg0WZCKQX2GBWvWHOI+VW5OULGVu
         Ru1aMC3q4hDZ//7CelHjQo/EmzNf4ugjR96A0YUk7vmH1lhx1X5sqP/dTm43iNil//Pq
         NQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3e2pmpdtRSb5w927ol9J3ozYI0WGUYA6/KUGnZGZ6w=;
        b=FAS9MH4Ghue3RUEw189hplxPpXVZ9eOQBR+u2GTee/gLmIm0zcZZ2/7MMW9S8VV+uv
         GXGnpEauwj6Va8V1j4cz8Qg5qJPMlDWo/kgctRrkq6zmUI7h1RibnYcKs2zY4UF6KAEH
         KWXKfNC8giKzKPP802OV/opgaJXQpYYrsv3eeZEe2uWwVphwGv/hfuvotg7iFonTbbFk
         pyfyEEZ71z7txZJcp1LmNRNZJpQFZ1hEchXTdNkeqMpEqb0NiaS4pgqwmbjldgg2O1Mt
         JI1+9Bo6zeR/rp0BdpxzAZyVRw3BEQZ+rCckdLV4p7mGvfIfgCBboBeXwjF7Huh8sKiE
         NNrQ==
X-Gm-Message-State: APjAAAWYfqPqUMSeqyh4j3Eb2EOBW27YJyB1h9LhsV64MVx4O3ikkURh
        YSUuxfeqroE4RqW+o4T48eg=
X-Google-Smtp-Source: APXvYqyrApHb/dgDqwvcYOpc6KpzMuWfkABXmM1ZzQO3FgBBCXHS8OnpajiSSlyaHBHE+iXzz1nSiQ==
X-Received: by 2002:a17:902:d694:: with SMTP id v20mr48567049ply.127.1578013404436;
        Thu, 02 Jan 2020 17:03:24 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 5sm12780784pjt.28.2020.01.02.17.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 17:03:24 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 1/3] net: phylink: switch to using fwnode_gpiod_get_index()
Date:   Thu,  2 Jan 2020 17:03:18 -0800
Message-Id: <20200103010320.245675-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200103010320.245675-1-dmitry.torokhov@gmail.com>
References: <20200103010320.245675-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fwnode_get_named_gpiod() that I plan to hide away, let's use
the new fwnode_gpiod_get_index() that mimics gpiod_get_index(), but
works with arbitrary firmware node.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/net/phy/phylink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ba9468cc8e134..3f7fa634134a1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -186,8 +186,8 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 			pl->link_config.pause |= MLO_PAUSE_ASYM;
 
 		if (ret == 0) {
-			desc = fwnode_get_named_gpiod(fixed_node, "link-gpios",
-						      0, GPIOD_IN, "?");
+			desc = fwnode_gpiod_get_index(fixed_node, "link", 0,
+						      GPIOD_IN, "?");
 
 			if (!IS_ERR(desc))
 				pl->link_gpio = desc;
-- 
2.24.1.735.g03f4e72817-goog

