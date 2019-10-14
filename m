Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90112ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCC720854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyAstIQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbfJNRka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:40:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37272 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbfJNRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:40:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id u20so8322913plq.4;
        Mon, 14 Oct 2019 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gE9bQVVDhd4T/cCCR+Ovd6p8+MI1yTW0xdbW/J9w9Gw=;
        b=UyAstIQE0PN46Kkskyy2uxaH4f0d6TsN/vj+VzGLBWIJLXQgDpMEsxbdVBrzfgIH9z
         NDSAyqPJcMuHzfQoATESh2AqEt9eswpsHk72ncFwzPg1aMhESZ/CBgP9U2UUMWMMCDfH
         uXEZNcOGtWuG5aBUFDrnqQBeNza+FdXyDr0GmCIw1e8q4SuZPA2YDFGHeA+NAL3VNIX7
         M8fBJBwnSAq1uhQmuZq0Yz2YV4xqjyWqQOLNvOtaPvRDm7p5xMZQuZ745+L3yRfCJJwA
         5MxkQX7P/QyIAfzNL4SN7FLd6BDKe9LRttnZaEammxImLNswNPf77acTuWj0eTUtfvNi
         eVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gE9bQVVDhd4T/cCCR+Ovd6p8+MI1yTW0xdbW/J9w9Gw=;
        b=B3Cx48g+HOXFYqIHLylQslzbCa0vf8V0sOfcLDrFOESCO7rGsxZObdiN2dAg4MJhFB
         F5zK4UJFeloyaiyPbW2jQQksfMK+Ngh8QpdvCW9UZ09Wixsz0JCi6wrdfyhm/rN5euv0
         1qESso7tQu7WUJni9IS/I41Ae1rjkkIxOOKrQ4CoPm61lnRgb/3ZX9wwd1AH/gbQsa6s
         kL7YMI0kguqAqvxdyjy0kB4TMQDcbAn00EWJ33Vuc3U0c4yqVA82jPRh9sANE3RbVtx6
         GhrAEzNL/F345uXVaOe+mO+B9ujPvidMvw1TvHCcvzhang4yy5Ebt2M42uaimgpgJ+Tl
         U73Q==
X-Gm-Message-State: APjAAAXvPWcbusmDLa7Si8+Kb1U/RbIlS16fgYYbDpJV7tWJcYt5wU0D
        UsC7WOjLsCI8TnBR3QL5yrlqq1No
X-Google-Smtp-Source: APXvYqwjzyXMeRIbcqjuRlTSLxEgR8Gj0YPZbGL/pVhFDqjjFCt42nURp67dpmg3wp3EJ7748iwD9w==
X-Received: by 2002:a17:902:403:: with SMTP id 3mr29990082ple.206.1571074827255;
        Mon, 14 Oct 2019 10:40:27 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k66sm18784535pjb.11.2019.10.14.10.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:40:26 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 1/3] net: phylink: switch to using fwnode_gpiod_get_index()
Date:   Mon, 14 Oct 2019 10:40:20 -0700
Message-Id: <20191014174022.94605-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191014174022.94605-1-dmitry.torokhov@gmail.com>
References: <20191014174022.94605-1-dmitry.torokhov@gmail.com>
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
index a5a57ca94c1a..c34ca644d47e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -168,8 +168,8 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 			pl->link_config.pause |= MLO_PAUSE_ASYM;
 
 		if (ret == 0) {
-			desc = fwnode_get_named_gpiod(fixed_node, "link-gpios",
-						      0, GPIOD_IN, "?");
+			desc = fwnode_gpiod_get_index(fixed_node, "link", 0,
+						      GPIOD_IN, "?");
 
 			if (!IS_ERR(desc))
 				pl->link_gpio = desc;
-- 
2.23.0.700.g56cf767bdb-goog

