Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F02C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EE920823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs5C14Tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfFSF1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:27:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44213 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSF1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so6698528plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r96RXcx0qK4dSLyydqVxx5Qg6T7ocvW76D16O15OAj8=;
        b=Hs5C14Tq40it0FE0YaoL9PhrcAKDTvTmlkZ/G/ZiHFHD3E2SAGd9h4BjVYeclCFYea
         PWVUjc49ShDDrapL+B7Sky97yGc/gOcZJkkGj0/bn7NtZ171IXH2L0szgUBUe1dYz9g4
         St9p7tjppOH8R5lSh/32h/d8+UW7sVlVrsP43zDFXCxJ9w0DZAW6yCh6eeWiggM1NWA4
         hqssV8ylp5zMwvNpMkok+lByfDtg4mSKJKSi/wYx7Ic1GjL+73/bdnqzMhQhL31HyG21
         OHpQTFGoquBHS5xAPCmwPzST8JKscW7kp0vy+tqICNc3ZNh0kib6V1ZLAan4gtjg2tKx
         +M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r96RXcx0qK4dSLyydqVxx5Qg6T7ocvW76D16O15OAj8=;
        b=qrdSKSrEGfwRgy98xLFfx/w9NXRNXRoN0P/h++hd8ychs/6N1WK2YR3zQi8jXzBMQa
         qc9hLPvO7pBnDn4b0159pzPLQ1bnhoLTtlhzVfuE9Mk+UZP7Y+1Fooa8j45sWhgRLb1I
         RPuO+g2STxf8Hv24uM8EU0n6+Kk1XJLAzQ4wQV7rM9Z7SCpMxCAYcEvUgbklgi4G+ils
         SjDHKObJ5POib6rr5YvLtJQMLTzZs65RgCKeBoQazcq4TZQRvwoirow4V4r906ubF5Uy
         vdBxFQwKmH4QpW6HRXqNGQ+xSgO9X/wXLYMN7phEfEO62nJy009t0Ugfk3bH4ttD2//P
         LwhA==
X-Gm-Message-State: APjAAAVM+sHW6HIYiziLxRgarQk+vwyuzTUaQ6asdqlEOBBd+DCuQXYU
        fndktU6J315jlRHwA85PW9A=
X-Google-Smtp-Source: APXvYqzendITaoqu8TWhn3geMSiN8kTHOHsa+u+ZzcAkHKGvwtNQ3TxVx3HOPtVjhZksup7nLGRj/A==
X-Received: by 2002:a17:902:8649:: with SMTP id y9mr40104814plt.289.1560922052461;
        Tue, 18 Jun 2019 22:27:32 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:31 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/15] tc358767 driver improvements
Date:   Tue, 18 Jun 2019 22:27:01 -0700
Message-Id: <20190619052716.16831-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains various improvements (at least in my mind) and
fixes that I made to tc358767 while working with the code of the
driver. Hopefuly each patch is self explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v5]:

    - Fixed regression in "drm/bridge: tc358767: Add support for
      address-only I2C transfers" that broke EDID reading

    - Moved said patch to be the last in case it is still causing
      problems and needs to be dropped

Changes since [v4]:

    - tc_pllupdate_pllen() renamed to tc_pllupdate()

    - Collected Reviewed-bys from Andrzej for the rest of the series

Changes since [v3]:

    - Collected Reviewed-bys from Andrzej
    
    - Dropped explicit check for -ETIMEDOUT in "drm/bridge: tc358767:
      Simplify polling in tc_main_link_setup()" for consistency

    - AUX transfer code converted to user regmap_raw_read(),
      regmap_raw_write()

Changes since [v2]:

    - Patchset rebased on top of v4 of Tomi's series that recently
      went in (https://patchwork.freedesktop.org/series/58176/#rev5)
      
    - AUX transfer code converted to user regmap_bulk_read(),
      regmap_bulk_write()

Changes since [v1]:

    - Patchset rebased on top of
      https://patchwork.freedesktop.org/series/58176/
      
    - Patches to remove both tc_write() and tc_read() helpers added

    - Patches to rework AUX transfer code added

    - Both "drm/bridge: tc358767: Simplify polling in
      tc_main_link_setup()" and "drm/bridge: tc358767: Simplify
      polling in tc_link_training()" changed to use tc_poll_timeout()
      instead of regmap_read_poll_timeout()

[v5] lkml.kernel.org/r/20190612083252.15321-1-andrew.smirnov@gmail.com
[v4] lkml.kernel.org/r/20190607044550.13361-1-andrew.smirnov@gmail.com
[v3] lkml.kernel.org/r/20190605070507.11417-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20190322032901.12045-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20190226193609.9862-1-andrew.smirnov@gmail.com

Andrey Smirnov (15):
  drm/bridge: tc358767: Simplify tc_poll_timeout()
  drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
  drm/bridge: tc358767: Simplify polling in tc_link_training()
  drm/bridge: tc358767: Simplify tc_set_video_mode()
  drm/bridge: tc358767: Drop custom tc_write()/tc_read() accessors
  drm/bridge: tc358767: Simplify AUX data read
  drm/bridge: tc358767: Simplify AUX data write
  drm/bridge: tc358767: Increase AUX transfer length limit
  drm/bridge: tc358767: Use reported AUX transfer size
  drm/bridge: tc358767: Introduce tc_set_syspllparam()
  drm/bridge: tc358767: Introduce tc_pllupdate()
  drm/bridge: tc358767: Simplify tc_aux_wait_busy()
  drm/bridge: tc358767: Drop unnecessary 8 byte buffer
  drm/bridge: tc358767: Replace magic number in tc_main_link_enable()
  drm/bridge: tc358767: Add support for address-only I2C transfers

 drivers/gpu/drm/bridge/tc358767.c | 651 +++++++++++++++++-------------
 1 file changed, 376 insertions(+), 275 deletions(-)

-- 
2.21.0

