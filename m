Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9F9C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232172063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9TVrYhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437204AbfFLIdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405196AbfFLIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so9203967pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSrUr04JKpLIpOwomhEOW56Uag0Ke/jp4vOdSmNT5bQ=;
        b=f9TVrYhBQ/zkEya2XKd2pjH3MjRqUwg7uD3yMnCmOsA7SHlmsUUON085Zmv/NPLNHB
         ONWQ3QSC2uMyH7UsZGTRCRHlqTVF1CSx++o9uDs3kiCrf14y72Lg1lKnmyLLmJDE9Ris
         mBa+LCFmyzbI0QOZfyDFirHmMnF2AKkLh1419cV85Be7g09IvkwBl/xQd6XP1i4LR8FA
         vXxp/J0Yk+/sVtbG9iTKaq2rwPcSJpu8/PKGohMf3VpNjQ4TuAACF7uCD3+K/qaq9bDU
         tx65e9M5g2yv8SMo6w24Ih+eIh25mQqqIUiY9IZbT6hrAhqfXbY1FzJSgGULwptRT+sf
         R/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSrUr04JKpLIpOwomhEOW56Uag0Ke/jp4vOdSmNT5bQ=;
        b=j9P/ZN4pXiPEyM3FlRk3oEgZ0pQ5CQNBHDZpcEMBxzqCI7h18powdQFBy0uzaRWSqd
         bC/P3ZyVLD7AhlDBcVGH/PJZbVDROU5XyTWfLiny3KAPqypsFO/ODmJGEMzY6TuI9K8c
         yQAu5Fj/PUFtfFH98uhfN7T/r2Sc66yeqWhv3acCZQYEJbgcraMow6CQ78nrjplY9jQy
         ZR7OcGNVekVfrC9XvQ3e3zZRuy3EfgVHS/Q2HQwOiU5sq1g0tET8PjUPD+Gc5HM/RQcn
         PHsEEEnxeO61p1Yk/8u2O4sJXyMIC8WEc8/f9V+BBMOweZgkzOYdYsj+kkd6inbLClgq
         7P4Q==
X-Gm-Message-State: APjAAAWgvEecUB51DtSYxkD9HxMzKY5eM5HPe4YDZDdejrCTOjEj6+aq
        16CVAeNetrlNx33jJwz1sl0=
X-Google-Smtp-Source: APXvYqzT5VWa0aU04CQjd4fZk88OgtGA8DIKZsZZPPIUSO8gik3ubA2W6EhNUG7OikMEye7/Q6NSDQ==
X-Received: by 2002:a63:570c:: with SMTP id l12mr24528172pgb.252.1560328383919;
        Wed, 12 Jun 2019 01:33:03 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:03 -0700 (PDT)
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
Subject: [PATCH v5 00/15] tc358767 driver improvements
Date:   Wed, 12 Jun 2019 01:32:37 -0700
Message-Id: <20190612083252.15321-1-andrew.smirnov@gmail.com>
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
  drm/bridge: tc358767: Add support for address-only I2C transfers
  drm/bridge: tc358767: Introduce tc_set_syspllparam()
  drm/bridge: tc358767: Introduce tc_pllupdate()
  drm/bridge: tc358767: Simplify tc_aux_wait_busy()
  drm/bridge: tc358767: Drop unnecessary 8 byte buffer
  drm/bridge: tc358767: Replace magic number in tc_main_link_enable()

 drivers/gpu/drm/bridge/tc358767.c | 648 +++++++++++++++++-------------
 1 file changed, 372 insertions(+), 276 deletions(-)

-- 
2.21.0

