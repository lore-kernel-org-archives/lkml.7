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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B39C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC700222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkJ51fST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfJDXK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:10:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43373 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfJDXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so4766395pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jA8Id7H3gvB/5w4U6JX8arL8+ZxiSG8MjiEy+YBa328=;
        b=nkJ51fSTlMtMCtbP0JNdD/fCfLz0SoZPzTOt7uTZ/qr/G1pN+r8PBe0jZERkRKa97a
         8TL4zdjDpos3J1FpkD22Vok1U6bCLkjYYFLzSk/QucnFg0rG85uIyyk5muO80hdxUQSU
         u1N5cSSlOljIlqYzW84TANZzgrKZxrpGXnTiakBpfs3CFZpAhOXeQuKEcbt1Bc610Ay0
         O0rYahtLo6dzcXAklzFskmlIevjUwVrS3pwknB4E/qNl7R3uIrddDrR6q/Q04c/diafX
         aPq5/5iB8xrDuAADWD1cNNjSra4dn/qUTVpxWw3iGMxL5bNUxUKgMssYBY+xlV0nXRQz
         gW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jA8Id7H3gvB/5w4U6JX8arL8+ZxiSG8MjiEy+YBa328=;
        b=j2eO+AxANy2P/64o5ZgSvpy93QhpdSWhZvAx0SZ3PnLhd9UJx16sFJNjEOSolAPoAv
         E2i95HJhkmvnJiWP4MP8lYXotPgtDTCGnwwTlU3nhuWCSY7WIJzZMdHEjE/DqqGcmY7F
         ZsHGJrbdowOUwSY2YtlS+Hzyrk8PqGrUCIZ1UxP0ArH69AFw496/hpHuqV7RjtdPk4gp
         HrU9ik9ux9EM5LUZS5tNCTdFnhmcUfYThR6U/pLl5Pc6zlKSVOOiMSHco9IUdjb8GEpf
         TUGFZsQW0Rb+7/etMl+VqZBXQ6S/+ABwi57c4Y/8Gk4r+7V4s8+ptfiiBLf9UMcKUp10
         C/XQ==
X-Gm-Message-State: APjAAAV/cAnkbxsfGY2i+bXrazBXAoPFReXWZrg2iRiHakB0GvFou2YB
        ZuzFD9EnffEgzkmIW4S8uJ0=
X-Google-Smtp-Source: APXvYqzo5GHBpyCIxQxXTb61QdW1ylX1LxNG552iSo9B2lmx7ukh6R97MiDqZ+fEzw8TUOzODXelyw==
X-Received: by 2002:aa7:9486:: with SMTP id z6mr19772387pfk.118.1570230627268;
        Fri, 04 Oct 2019 16:10:27 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o9sm7406542pfp.67.2019.10.04.16.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:10:26 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 5/7] regulator: da9211: switch to using devm_fwnode_gpiod_get
Date:   Fri,  4 Oct 2019 16:10:15 -0700
Message-Id: <20191004231017.130290-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
References: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_gpiod_get_from_of_node() is being retired in favor of
devm_fwnode_gpiod_get_index(), that behaves similar to
devm_gpiod_get_index(), but can work with arbitrary firmware node. It
will also be able to support secondary software nodes.

Let's switch this driver over.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/regulator/da9211-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index bf80748f1ccc..523dc1b95826 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -283,12 +283,12 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
 
 		pdata->init_data[n] = da9211_matches[i].init_data;
 		pdata->reg_node[n] = da9211_matches[i].of_node;
-		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
-				  da9211_matches[i].of_node,
-				  "enable-gpios",
-				  0,
-				  GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
-				  "da9211-enable");
+		pdata->gpiod_ren[n] = devm_fwnode_gpiod_get(dev,
+					of_fwnode_handle(pdata->reg_node[n]),
+					"enable",
+					GPIOD_OUT_HIGH |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+					"da9211-enable");
 		if (IS_ERR(pdata->gpiod_ren[n]))
 			pdata->gpiod_ren[n] = NULL;
 		n++;
-- 
2.23.0.581.g78d2f28ef7-goog

