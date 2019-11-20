Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CECC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606C92230E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IRA6x6QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfKTOVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:21:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37899 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730695AbfKTOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:21:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so8021627wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 06:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ObddRrqFMGmSEw2EuOE2BBu3C/YuvLUkk+LiDHWeNuU=;
        b=IRA6x6QOO90UY1+JzXxGLXmM8N1OnPXD5DJQv14VWlGa20JPqSKAbNbvuckP6B83oV
         pxdFs8A0LKDb+2oRb2eKcNuICd21ibmqWaRfz/0V8qMnM2lxUilxfy+4jq8F0jHoWv6s
         o6OutJtkYoVVM0stjcirp8hiZPnkxswtyDBEKwvt9ZNquo9LFDT5uFLXLG9n5H5nUqvi
         3UnJQeBmubU3lqX0GumI3xuTBrfWsQLI8zjITqmDmVHLSR1y1BB/A89ViQAPtLN7z54H
         N97h8jjoiqr2z5crsBG3ntzEoYHy5HN5J46EV6dMEaOujhLJvURDJa1t+xpoCzdJkKuM
         8YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ObddRrqFMGmSEw2EuOE2BBu3C/YuvLUkk+LiDHWeNuU=;
        b=VxIun2riEtjMSd2k42BDbMBGYM60GogwKBUr3XHlHNvNwZvWs44S8BmlZlQukb7gBF
         06iUWih9w2hi4NNHv04ssqyw7X6O8jVXmQQHhKiRzl/DOpBE8G0gmkzSYmuXjyAvVNCQ
         Bsg6R8efCADO5UeN990E6XWCWCxm9ppE3vmOlhcRrM0jVp+bH59gQycSOFJAPF/xiaDZ
         BnZddDeHUH+PGGLsXbI3M8O3rCznDXylG+AAbT428nJoge2x0MLhcBj3w8slxY7VIGGN
         Uit7YxrxwSZG6h063sFuxI38CulVotB/UzJ6KjwdHDQHvYJMvVLLSuelEfjKyeysTanr
         fdaw==
X-Gm-Message-State: APjAAAXktIaKCYVGyeGxoUs0o+MUtq/fe0eRh7zuFGfQ63IX394lj+2b
        GJxLxo1cA5omBwI6v+5T8o2Vlg==
X-Google-Smtp-Source: APXvYqzbksTnApo2dPhUY4VUaSBVv8OpQXusUSD5NtnZDCEi4eJLp2ya1TSJd9aybf0Itc+YD1b9mw==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr3441814wmb.172.1574259674456;
        Wed, 20 Nov 2019 06:21:14 -0800 (PST)
Received: from khouloud-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a6sm34544352wrh.69.2019.11.20.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:21:13 -0800 (PST)
From:   Khouloud Touil <ktouil@baylibre.com>
To:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linus.walleij@linaro.org,
        Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH 0/4] at24: move write-protect pin handling to nvmem core
Date:   Wed, 20 Nov 2019 15:20:34 +0100
Message-Id: <20191120142038.30746-1-ktouil@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write-protect pin handling looks like a standard property that
could benefit other users if available in the core nvmem framework.

Instead of modifying all the drivers to check this pin, make the
nvmem subsystem check if the write-protect GPIO being passed
through the nvmem_config or defined in the device tree and pull it
low whenever writing to the memory.

This patchset:

- adds support for the write-protect pin split into two parts.
The first patch modifies modifies the relevant binding document,
while the second modifies the nvmem code to pull the write-protect
GPIO low (if present) during write operations.

- removes support for the write-protect pin split into two parts.
The first patch modifies the relevant binding document to remove
the wp-gpio, while the second removes the relevant code in the
at24 driver.


Khouloud Touil (4):
  dt-bindings: nvmem: new optional property write-protect-gpios
  nvmem: add support for the write-protect pin
  dt-bindings: at24: remove the optional property write-protect-gpios
  eeprom: at24: remove the write-protect pin support

 .../devicetree/bindings/eeprom/at24.yaml      |  6 ------
 .../devicetree/bindings/nvmem/nvmem.yaml      |  6 ++++++
 drivers/misc/eeprom/at24.c                    |  9 ---------
 drivers/nvmem/core.c                          | 20 +++++++++++++++++--
 drivers/nvmem/nvmem.h                         |  2 ++
 include/linux/nvmem-provider.h                |  3 +++
 6 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.17.1

