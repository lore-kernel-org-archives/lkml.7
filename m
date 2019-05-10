Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDAFC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661A820896
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m5DmBmQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfEJWfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:35:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36597 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbfEJWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:35:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so3459806plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTz3ssqMKwXih7kW/rvdj9F00tD72Ht0qosH9fDb+p4=;
        b=m5DmBmQbr31Nx984JHfCz3IviiH3OyT8HQZBJQFM6cOI5aigI4Q1QU5/kNqG58ZnzL
         G5AdfUDbw8rulMd43CuhdLXN4lqpXcrRNV64oa+qXQLvZpg5ZjXFusmd8Nfm3gylgfGZ
         EbNEyzhJHCYjJQgOcYgM0MwXEti/5KGL0K7uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTz3ssqMKwXih7kW/rvdj9F00tD72Ht0qosH9fDb+p4=;
        b=mjAkM8/4y8Ynrm6w5kxt4RsoQ6O+HSzNkp1ktL34CaKrAUDftkZdidsBe3C04CF5eh
         rLwVdlC2Kl6lcbWy+5n7VUAQ0D6NWFUYu+4SWxvKr8XAkihqR0dlCvu2jSN1YCHoj3iE
         bSdcs8sCP+IS0Xg9YeOUR4bTwfCoJVRR/6eyAWpNHAiVs/rdgao+DNmsVounfN40fOjH
         xqA4oAUDZ5Q1LCBMSiiOwPWLaBd2VLenPm8bhss01gKdTtltBsMbV3jcbWsF9GH/qRNX
         ANnsZL5TVIRaJeIHmLEZx0FwF0rvp1RifW1cMd3+a9aH0GwXYkKVxl+IW3XHPY+LcaOB
         J4Rg==
X-Gm-Message-State: APjAAAUzf69NR7qPuJoD0Q/T78iMt7Dyn4H1Xw48KQO343F5tQdCXu/7
        Kn3VKVn8ywMMdUfIRH9SlgJ0FA==
X-Google-Smtp-Source: APXvYqxeP1i6s9XT+hR15W2dLlmU4slR1FOWV1B51dcqbURu9NlJ7G6AyDsoKuooSYOBtHCWskhj2Q==
X-Received: by 2002:a17:902:29e9:: with SMTP id h96mr16039999plb.258.1557527714413;
        Fri, 10 May 2019 15:35:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j6sm7689393pfe.107.2019.05.10.15.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:35:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/chrome: cros_ec_spi: Set ourselves as timing sensitive
Date:   Fri, 10 May 2019 15:34:36 -0700
Message-Id: <20190510223437.84368-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510223437.84368-1-dianders@chromium.org>
References: <20190510223437.84368-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All currently known ECs in the wild are very sensitive to timing.
Specifically the ECs are known to drop a transfer if more than 8 ms
passes from the assertion of the chip select until the transfer
finishes.

Let's use the new feature introduced in the patch ("spi: Allow SPI
devices to specify that they are timing sensitive") to specify this
and increase the success rate of our transfers.

NOTE: if future Chrome OS ECs ever fix themselves to be less sensitive
then we could consider adding a property (or compatible string) to not
set this property.  For now we need it across the board.

With this change we can revert the commit 37a186225a0c
("platform/chrome: cros_ec_spi: Transfer messages at high priority").
...and, in fact, transfers are _even more_ reliable than they were
with that commit since the SPI framework will use a higher priority
(realtime) and we no longer lose our priority when we get shunted over
to the message pumping thread (because we now always get shunted and
the thread is high priority).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/platform/chrome/cros_ec_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 8e9451720e73..757a115502ec 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -703,6 +703,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 
 	spi->bits_per_word = 8;
 	spi->mode = SPI_MODE_0;
+	spi->timing_sensitive = true;
 	err = spi_setup(spi);
 	if (err < 0)
 		return err;
-- 
2.21.0.1020.gf2820cf01a-goog

