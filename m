Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC3021882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QUcTHbo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGCQKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:10:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47023 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:10:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so3437943wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ALFY6vlCWKUDexSPH/TfQp8zi+qgTanTZE8Fm6Ed/4=;
        b=QUcTHbo2yG7+/8Jto5oUX9V5OsBRLn94iCRsmWSPgjbAKsM/uaa+80bAZzRYtBBsTY
         eAAKp4hulU2umSliz0PAd8rp77ozAYWQEc8oHJZbHYpOlO+vqPrJFF9eo9MuZZ958z/n
         farhPaUvSrq/erYvw8radn0wYZGFp87TzCqbpia0c8cB11dC7QnvadnObpu1Uf7eZ6vl
         4w3L9LVQXwltwY/BU5COM2/oLhctBZ7aBh8Uh4Jb7yxvpA6CtLzBjxZAOUF6nvecUmmI
         AHt+XURHksx3anMW1gzzmArv48Q6FFfLTk0IJvY1H1b388ph3yJ3nnvPjVj0In7ohP0O
         h8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ALFY6vlCWKUDexSPH/TfQp8zi+qgTanTZE8Fm6Ed/4=;
        b=omozZbSyfLRZvyVZcGkK2BD24axX2n9eMgwCB6mAz5dfzJyIh+gFgPeXGjB2ih08Et
         Go19GIJLktaJknN1NI94BaNeC0BCP7nwM08nfYyes7XXoxh7ZmZzUSCHqkiXligZJyvm
         p4yC1E8nFZn4aCJ/7GO7NNjDBawdOJYCtpkeQPgUZjhTH9zLwiNAuVO/dOO8uKRkJ1vn
         ZuJUPzlFDyy1y0m2MZDiXjxyF0hgvMLMgrIxhaPAU8dOMW1Aiy1Mpt/UT4fkXAOI+nvW
         guncRyJ4CWvYm1v1eZwKJOyhby7G9EDS5ddLcQnbpbAM+ERhvFXo0xTbbYCNfgFlZTTn
         OpdA==
X-Gm-Message-State: APjAAAWluT3Ug+/8OlqYydclu6FzLtootU8HU75F0ag5jaVg3g5ySVny
        4rXKNT4/iGSeHH3uBtSu89b/OK033NU=
X-Google-Smtp-Source: APXvYqxQFg49Re/DoujGwSC0KOZEduSA13u3jeb7pFIjX+EUTlAeGdXnamfkOfCJ9nR/h17h/PwKtg==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr29762095wre.205.1562170240332;
        Wed, 03 Jul 2019 09:10:40 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t17sm3803572wrs.45.2019.07.03.09.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:10:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] regulator: selector stepping for voltage regulators
Date:   Wed,  3 Jul 2019 18:10:33 +0200
Message-Id: <20190703161035.31808-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Mark, Liam,

I know this won't make it for v5.3, but I thought I'd send it already
for you to take a look. Some time ago we discussed implementing the
voltage stepping in the regulator core. Here's a first go at that.
The first user is the max77650 driver which actually uses it. I think
there are more drivers that could reuse it later if accepted.

Bartosz Golaszewski (2):
  regulator: implement selector stepping
  regulator: max77650: use vsel_step

 drivers/regulator/core.c               | 63 ++++++++++++++++++++++
 drivers/regulator/max77650-regulator.c | 73 ++++----------------------
 include/linux/regulator/driver.h       |  6 +++
 3 files changed, 78 insertions(+), 64 deletions(-)

-- 
2.21.0

