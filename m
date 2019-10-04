Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604B6222C7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0IyyUTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfJDXKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:10:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38302 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:10:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so4786413pfe.5;
        Fri, 04 Oct 2019 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eo8j3uqHa8jn8KFSODiCETkk/W1oSTnB08fvMqW++d4=;
        b=h0IyyUTnQ5QcSdR8DQIn10/8j5HXiZD6JupYb0uSmNPjTbjRJJfuR03nfEOHuCCf4Y
         s3WVw24Ii6+TnNxqxB5XJCf80CkZX9Ozd243qrakLaJ6r0ORdG3ji7fDus29knONCE/Q
         7NeHAvgli+tQ2U6PUnO4x/B7Rlkj0UFjwX7bZCSpJKBu6JKjIlGa7xB/n5fit30McbtQ
         PKXsJx+nfznLPgvi6BJCR7nPqs5RGxO16y+u91miTOQk8RkFj+RQLVLPnwA0wq8X/AKw
         ea24QZTKDh0Eo1UqNF6YJSLTiJdvwSjT0DugAvDpO1igEUet4ynmBt5Ig98dPBOBwzrY
         QZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eo8j3uqHa8jn8KFSODiCETkk/W1oSTnB08fvMqW++d4=;
        b=nb5tyyW14SdbA110xC90Wg76QfK4lqDPv51YJnLc4y6a2DSZVfm0MFbwHdaRqZKrHK
         GXz9csX/Z9hU+ytxic6AbkJdTZ6kiQFC5Mpzy76G9vBIguKAIZTGzRAYe2fBkn7oFPqW
         TiOgVqBsKfgnNd+fGBJJ9lNQX31Av0sulhW7pjyQK1d62WG7Q+r1iXYTBaQjhD8H8X3O
         UAVEycFtsgIMgu6Hm7axkF04cgXzeexHBiS/7MtAjEOjqgzQdxGNWJolnHMwAHukUWbJ
         clvfcWNMJd/id0wOGKqcO7auCXF9u/NDLu3eOeQw1Rramy0uoaji+l60bMtMAT7uhCEF
         0F4g==
X-Gm-Message-State: APjAAAViRfRaYarypDgi8cb813orRy6JJkuali7lMg73EI3gMPNg8NXJ
        JgQ9mGBX78wNUq67aHl+Miw=
X-Google-Smtp-Source: APXvYqzRHuzdJyfyUJXXCjKxog+kfsHGAbnXUmB4UTRag4/ma1adDO2IaN/P0n3FejFuNOFf+FYF3Q==
X-Received: by 2002:a17:90a:a606:: with SMTP id c6mr19777831pjq.20.1570230621363;
        Fri, 04 Oct 2019 16:10:21 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o9sm7406542pfp.67.2019.10.04.16.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:10:20 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/7] regulator: switch to using [devm_]fwnode_gpiod_get_index
Date:   Fri,  4 Oct 2019 16:10:10 -0700
Message-Id: <20191004231017.130290-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series swiches regulator drivers form using
[devm_]gpiod_get_from_of_node() that is scheduled to be removed in favor
of [devm_]fwnode_gpiod_get_index() that behaves more like standard
[devm_]gpiod_get_index() and will potentially handle secondary software
nodes in cases we need to augment platform firmware.

This depends on the new code that can be found in
ib-fwnode-gpiod-get-index immutable branch of Linus' Walleij tree:

	git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git ib-fwnode-gpiod-get-index

I hope that it would be possible to pull in this immutable branch and
not wait until after 5.5 merge window.

Thanks!

Dmitry Torokhov (7):
  regulator: s5m8767: switch to using devm_fwnode_gpiod_get
  regulator: slg51000: switch to using fwnode_gpiod_get_index
  regulator: tps65090: switch to using devm_fwnode_gpiod_get
  regulator: s2mps11: switch to using devm_fwnode_gpiod_get
  regulator: da9211: switch to using devm_fwnode_gpiod_get
  regulator: tps65132: switch to using devm_fwnode_gpiod_get()
  regulator: max77686: switch to using fwnode_gpiod_get_index

 drivers/regulator/da9211-regulator.c   | 12 ++++++------
 drivers/regulator/max77686-regulator.c |  5 +++--
 drivers/regulator/s2mps11.c            |  7 +++----
 drivers/regulator/s5m8767.c            |  7 +++----
 drivers/regulator/slg51000-regulator.c | 13 +++++--------
 drivers/regulator/tps65090-regulator.c | 26 +++++++++++++++-----------
 drivers/regulator/tps65132-regulator.c | 17 ++++++++++-------
 7 files changed, 45 insertions(+), 42 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

