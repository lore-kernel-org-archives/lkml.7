Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D87C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4082B222C4
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W7tHdhv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfCXPOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:14:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41809 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfCXPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:14:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1so7262576wrs.8;
        Sun, 24 Mar 2019 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tPPs4cqO/p0eCsszsL77g72f9HhvkgctqQ1mO/ZcfF8=;
        b=W7tHdhv0K3oYuREw9pn1mtJLg8Ya/LFJBpCRVOHU0OTTxdEUfxsKf29c0p4e+rp1zp
         rbJHK2BLm/QV7j8l37sqlf/vwloX7eshyNWH27dqKrhaAexqTIJ1uDOnOGo9zkf0m7wo
         805X1YxUF++0xdUtOLtbMszZYGBdPqYQYoEYLYeVWfLSnpWdLx1L5ORQm4EWHXwpBhKe
         rQMkBYZknlS14PBStt2FzLbUO8YU8DMXNARxufZnzfb4p9nWp0s11aklt4XHuRF8cmxT
         g6mr4787BOFrG8ZCX1bGatRIf9HjJsoPGkp4hyjowsJtjzKGhL/VnXzH7o/+Q6sggj9K
         XKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tPPs4cqO/p0eCsszsL77g72f9HhvkgctqQ1mO/ZcfF8=;
        b=dOf58+gcJ90zUiUtWWFJmcK7K76beXtwu5tG7k6bOOVO6nrVEgn5K0kQOv9kUY80wA
         vOjHaf1zKxB6k1URWWr3AJGpoZC1mqFdTT/0EdDdp32dUDpSf7ZP3O3JTfWT/MxK+L3+
         tP0LVdWpbOIYxBlwOPam8JReXMYbjX3y0g0laQ+rxgB3QvyZRmxs2XJDhHa5V5UlKgMq
         wJ35YV2NThvdi44PwVeLdEBM4K4TjAwDQ6ktVI6vzvELVWeuLr46vIzLbfla9CnRaOSE
         LvFxZ8ryiiZN8BS7HGR+pnVRxUVFVqNz2dUhhyVSPyfzCpex0dWx2sZO5+GH6zO1IiRT
         JD0A==
X-Gm-Message-State: APjAAAUT5KrpA5bIHPO+ZxmQcyOjtB0GoW6xewQ125eDUj/jccL6SzI9
        1MUSWTr1b/JXTkGZlhCO4yE=
X-Google-Smtp-Source: APXvYqyIvJ1yldHZZfQLdrnadIfO3HzyeP+m636eMNcPVgg6y+YXhTA3F1Oe45APmhRFipVpPGM1EQ==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr11834366wrj.8.1553440479699;
        Sun, 24 Mar 2019 08:14:39 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r16sm376889wrx.37.2019.03.24.08.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 08:14:38 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, mjourdan@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] clk: meson8b: add the video decoder clocks
Date:   Sun, 24 Mar 2019 16:14:21 +0100
Message-Id: <20190324151423.19063-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the video decoder clocks for Meson8, Meson8b and Meson8m2.

The clock tree on Meson8 differs from the one one Meson8b and Meson8m2.
Details can be found in patch #2.

There are some checkpatch warnings in patch #2:
  WARNING: please, no space before tabs
I decided to still send the patch because we have the same inconsistency
with all other clk_hw_onecell_data table entries. Please let me know if
I should come up with a follow-up patch to clean them all up.

Testing:
I have not tested this with Maxime's video decoder driver yet.
However, I manually enabled and set various frequencies for the HCODEC
clock and verified that clkmsr reports the correct rate.

Dependencies:
This is meant to be applied on top of my other series from [0]:
  clk: meson8b: add the VPU clock tree

Changes since v1 at [1]:
- collected Neil's and Maxime's Reviewed-by (thank you!)


[0] https://patchwork.kernel.org/cover/10860401/
[1] https://patchwork.kernel.org/cover/10860513/


Martin Blumenstingl (2):
  dt-bindings: clock: meson8b: export the video decoder clocks
  clk: meson: meson8b: add the video decoder clock trees

 drivers/clk/meson/meson8b.c              | 312 +++++++++++++++++++++++
 drivers/clk/meson/meson8b.h              |  17 +-
 include/dt-bindings/clock/meson8b-clkc.h |   4 +
 3 files changed, 332 insertions(+), 1 deletion(-)

-- 
2.21.0

