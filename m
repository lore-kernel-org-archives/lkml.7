Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F8DC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE195206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMx/P5Rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFEHFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39626 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFEHFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so14293506pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LnB/qPlcBVS1MiWf1Hu4nd4BnRwaadmudJ8+dogX3yE=;
        b=RMx/P5RtZ+Kl66yQ52r1XgqEli3o9Rs7lILVOMVTCEPCdSkIp4K9237cxsJcgu5xQk
         5LcryYeX386IS5I7mdPCRMMYgAu/4+wSur+T5ziRnBZ/GRpsKdA9n5wSEE05CbDJszX7
         daC81Dev6VZ6kAH1/8N1esEpcVQK+45xBaXFYujYwgNWAjRbFOPH8I4PgAPZJ7vk7M+2
         vyxX/UcnL42bBGS2b9xYsfPvajuKIJPbK/ArUp9iLZR9nV6Zl7s/tuVElKfhG2GIod7K
         YMDYSnS/ZClOnXJ6r1wpHJvQfKLVIBtZcuA25Es/hplWU+7RTAq+Vt68I+a4zvXrsplP
         HZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LnB/qPlcBVS1MiWf1Hu4nd4BnRwaadmudJ8+dogX3yE=;
        b=XK/roSqrgkOI2xiKSprmAWU1GQFvPm+En002de5+qlFlFahCnYoNbR56KMnoep2gK1
         y8ua/YDxeY1EAkiXVwvnj1p75kBss1YyG9afAAk/RMPDLtr8FhwVtvzfI6j2d5LIJJze
         aY2jhuICJ6x1t4kTLvsOQlYmV5zNr+CdOgcLBKRblUaJAsVyOxb0/GYKrnnuJv0D7G9B
         WZaenUXgX9u1MevEXPP/deNV6MZPrUWcT5BxCU+awehsbhM4Z633gY+Xp8+mwi/QrBS3
         iCiPtNueUpLpAIybMqGLAHKeuJ7enEeYMrJJeKO1Va49DrrMyh6EmPPX1NczAwgxZamD
         JxRQ==
X-Gm-Message-State: APjAAAVE/YP5eINkMa45Bt/Xl93zGxoO/rYJx/RFSG4CcYaPj393NUb/
        rVF8zlIx4Tpk+EoC4/1dA2g=
X-Google-Smtp-Source: APXvYqxAyrt1q/R4SqiAji7XsTO61D4Lt92UY1lYf8hWESYxYph2ZgQKB++u5GJd3c4+kK09f2fGwA==
X-Received: by 2002:a63:eb0a:: with SMTP id t10mr2202889pgh.99.1559718321838;
        Wed, 05 Jun 2019 00:05:21 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:20 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/15] tc358767 driver improvements
Date:   Wed,  5 Jun 2019 00:04:52 -0700
Message-Id: <20190605070507.11417-1-andrew.smirnov@gmail.com>
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
  drm/bridge: tc358767: Introduce tc_pllupdate_pllen()
  drm/bridge: tc358767: Simplify tc_aux_wait_busy()
  drm/bridge: tc358767: Drop unnecessary 8 byte buffer
  drm/bridge: tc358767: Replace magic number in tc_main_link_enable()

 drivers/gpu/drm/bridge/tc358767.c | 668 ++++++++++++++++++------------
 1 file changed, 392 insertions(+), 276 deletions(-)

-- 
2.21.0

