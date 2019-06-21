Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0A6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6866E2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T5PljLkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFUClV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 22:41:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36303 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 22:41:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so2235725plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6UYnK9gp9yNfxMsM9VqGe2VrudvgBc5ep+Vc0J9WtE=;
        b=T5PljLkTRydUuza9jkLoqt4cm7UrQgMDePYpIBS6elrS00B7Z4HZt8PL1FyiUHSqv/
         D4koYA2I2/y+zQSJKZsEnCrbktetQfhnyZrRug0t3phq31c7snHPbrKBkFKx8wL/Ugmt
         r54F1Ne3/STy/ENLUSdwXoMExxnZ8OKiJ+aB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6UYnK9gp9yNfxMsM9VqGe2VrudvgBc5ep+Vc0J9WtE=;
        b=DyzvaqF+8JiOCS/JlDOUC4pkDGZlVGh8cuZcJGYcyykx9UHO3i7vtN563vyxtDYd/e
         Hynv9KEQu3EqS5lMQVQDuv4CZDjmULZMyEQ4AQbN7rRkMLT+B71XSEaPZQKUl7TvYRJe
         OiyiowGAIbrID1KhpcBg0aHuXJBL+gVW14D9KswcYwPTFkf7XOK07n0QDY55EB8NuwmF
         Kgo249JR03IgrIDmUgD3BuTplG+TkdAPFO9bA1iWW2hWmxSymITAYQFJmmpQhg0I0bkW
         Y9ZuBQap+L2XH93sb4hfcMinC9fOy4wy1mjyNsxlhqtOJHYRv9b1lPsLDxqIR03sWQvC
         Bdzw==
X-Gm-Message-State: APjAAAXOfQ+ztfVMG+Rap5tOXDUgAZcpTrV8qgh/AuhCGgzUMhDxbXEa
        /6A2XfYuTNwSVDXPDajmDHZCHQ==
X-Google-Smtp-Source: APXvYqzsifsrEB1ggaGeA3mdGyJpbcnheW+0O9MlXbOP9yM/VM87uMESboSM87LnaZ1mcFcHFQiM5g==
X-Received: by 2002:a17:902:148:: with SMTP id 66mr120206912plb.143.1561084880070;
        Thu, 20 Jun 2019 19:41:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 133sm804642pfa.92.2019.06.20.19.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 19:41:19 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] Support accelerometers for veyron_minnie
Date:   Thu, 20 Jun 2019 19:41:04 -0700
Message-Id: <20190621024106.158589-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
controls two accelerometers, one in the lid, one in the base.
However, the EC firmware does not follow the new interface that
cros_ec_accel driver use.
Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
Chromebook - to veyron_minnie.
veyron_minnie being ARM based, issue command over the I2C bus to the EC
instead of relying on the shared registers over LPC.

Gwendal Grignou (2):
  iio: cros_ec: Add sign vector in core for backward compatibility
  iio: cros_ec : Extend legacy support to ARM device

Changes in v2:
- Readd empty line to reduce amount of change in patch.
- Remove Keywords used by ChromeOS commit queue.

 drivers/iio/accel/Kconfig                     |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      | 350 ++++--------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 4 files changed, 84 insertions(+), 275 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

