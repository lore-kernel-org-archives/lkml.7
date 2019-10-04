Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17FFC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77330222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfNW7ITA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfJDXKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:10:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43467 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbfJDXKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so3792424plj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ojNP7Td0CUinpeHoy78zg0GiX9Nta1E6KaAC40KDS60=;
        b=gfNW7ITAa74FBrUtA/tqio3QLWUaA0+HAhPpjJzsneOE6vWib61lTv5MYZQiKTkKJy
         Nmgqmwi3Dj3cqzogFQdvYxnb383TGHXYr1YFo5Qq3Mfx/vwbq4IvzKQXGdNPG214qric
         loG9nBCVdq3VhUZuFxSJTzyZrBt8qrTuWtKzS1Go0AHk2tZwN1uiMW2ZdiWnBGVDLubO
         ++6oqGW8DWt3+xlc/Q4GssLzHlPNhWiz7DcsxlSlEINLAlo0exkRqkkvADH9rKXJY1cJ
         IhCLcKX/UAl8tfpe7wPIG2xmqF2+iNbY+PHEARXiPeODucowl0lq8Hiyy88qmp34W+w1
         NFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ojNP7Td0CUinpeHoy78zg0GiX9Nta1E6KaAC40KDS60=;
        b=Z3xCuMqREMy+ESBlDeLBBrtArUyhXPGz+IWtzRVzbKMDUmk0TQjp/ohZAc07N05l4i
         FS5rQCI2AGXUhHtHFe30Ho1/nnaLy7d1CXxMh6XkLp6a5YpwklURfrejEI1XYgfyV7Fl
         TsdFMqwXrE6e4prdkQtbMW2e8mDPT7eeegjnVLIiePGda4MBTmYqt+7PgMZ7GLp8rNle
         LbVEnSduo+OALaeP2wA9UztZLUgYAXsxx+EUcX81BS7egwukDwh2PdJvd7qikZ71oDNd
         qCqoMRkEXeTg2GdvaUMpU/jx1V9ebQZu9rI10ELjFd7629cS55XGJvXaiK130IvTrf4j
         BTcA==
X-Gm-Message-State: APjAAAUeXrMhkZy2cqDYNFbx98pq9RwaXq8T19+91rzgWF/uH8+G2bUa
        bMpkdPDoD/y7DRRrr3CoHlVWiENd
X-Google-Smtp-Source: APXvYqz8zM9iw9dpSO9jg59OOS9I9qJAmNyfpDkatcyFiYbNqb+zGpkUhqItUu5DHFykSB1aCcRBpg==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr18250148plc.41.1570230629470;
        Fri, 04 Oct 2019 16:10:29 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o9sm7406542pfp.67.2019.10.04.16.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:10:28 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 7/7] regulator: max77686: switch to using fwnode_gpiod_get_index
Date:   Fri,  4 Oct 2019 16:10:17 -0700
Message-Id: <20191004231017.130290-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
References: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_get_from_of_node() is being retired in favor of
fwnode_gpiod_get_index(), that behaves similar to gpiod_get_index(),
but can work with arbitrary firmware node. It will also be able to
support secondary software nodes.

Let's switch this driver over.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

 drivers/regulator/max77686-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index c8e579e99316..9089ec608fcc 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -256,8 +256,9 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpiod = gpiod_get_from_of_node(np,
-				"maxim,ena-gpios",
+		config->ena_gpiod = fwnode_gpiod_get_index(
+				of_fwnode_handle(np),
+				"maxim,ena",
 				0,
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 				"max77686-regulator");
-- 
2.23.0.581.g78d2f28ef7-goog

