Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA91C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F64E207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FrZeEqkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLJPmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:42:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34353 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfLJPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:42:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so20663178wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6NwUJ31Bo5gKSBcxH1IDObD46smc7wVjOw9e/arLHQA=;
        b=FrZeEqkqxNArFnKorxAKtv5XDSo6QeJdoZVA3gbtqAuJdQz5fTj0xOXb8o+1KVUvDk
         VQDURHvy6+QMWLTUkh4QpEprSfPEi3UruZTRfNwb/OwrQ53/mmiZrSJjI7oD3gFrQbbf
         UOBLk7b46xE+6spl4k7pZcsr7UJLXAI2UnMTaGSdNLTtuwEomrQYvz8V+7uQPfyJyfJi
         FavcexNoEe2wxlQXYsUE+wS5/xHgRpcEJU0t8wgLgAV6PxLZBwFIL7fivmzduXIP6srx
         CYcFdJsEk33pgCn9mOEEQOAbEXyiWLO8fVdKCfA7JqhcZuWdB5OCASUjaHeyUQFE5hmr
         7dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6NwUJ31Bo5gKSBcxH1IDObD46smc7wVjOw9e/arLHQA=;
        b=TAD1NaNatKz7FQyDy5XCNf2GOW0gCRkzsSJvJN13v9y/DVTMrbyYbg9GAsIZ6F5r5E
         5GJSEMDNz+OEm8IR/WyMDjezstxeZ6M3Gu6WASfMS0svO+DsOOH0yXSdzy2E1L38dP3L
         DZrHEd8RSBHN8HgdUr86qAtI4Fr/1OyQ0gUovBHOR3vSsLnDk/IxdalE7AGKRlTMQVuo
         rcKOA6HZDNERts5RtbcxMDVFP8xL9j92p2xkzbjeIXGa3y97WkH5EoahCXYQX42D5Zkd
         LAQmEW/v4O6LpP8Kd/7N0KQFNouuKB1Op2BJ8rrzlXx22ApTpyhCNkA0/7s3rvd74WyF
         NDnA==
X-Gm-Message-State: APjAAAVfshV5+mgRwZDgpnjx4qdyrViJpMqYWi7BPdqNozXQNpt4kk3a
        J8wRQ1JX6PwB66K+ATRXP66kGA==
X-Google-Smtp-Source: APXvYqx0+sRZpARe7yyKwoh1VzPjcBcUfnEDPjYDAlfGydTyHMB1TtXdHHswyB1vjks0B67ZVwWqOg==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr916414wrv.364.1575992535224;
        Tue, 10 Dec 2019 07:42:15 -0800 (PST)
Received: from khouloud-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o7sm3469085wmc.41.2019.12.10.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:42:14 -0800 (PST)
From:   Khouloud Touil <ktouil@baylibre.com>
To:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linus.walleij@linaro.org,
        Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH v2 0/4] at24: move write-protect pin handling to nvmem core
Date:   Tue, 10 Dec 2019 16:41:53 +0100
Message-Id: <20191210154157.21930-1-ktouil@baylibre.com>
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

Changes since v1:
-Add an explenation on how the wp-gpios works
-keep reference to the wp-gpios in the at24 binding

Khouloud Touil (4):
  dt-bindings: nvmem: new optional property write-protect-gpios
  nvmem: add support for the write-protect pin
  dt-bindings: at24: remove the optional property write-protect-gpios
  eeprom: at24: remove the write-protect pin support

 .../devicetree/bindings/eeprom/at24.yaml      |  6 +-----
 .../devicetree/bindings/nvmem/nvmem.yaml      |  9 +++++++++
 drivers/misc/eeprom/at24.c                    |  9 ---------
 drivers/nvmem/core.c                          | 19 +++++++++++++++++--
 drivers/nvmem/nvmem.h                         |  2 ++
 include/linux/nvmem-provider.h                |  3 +++
 6 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.17.1

