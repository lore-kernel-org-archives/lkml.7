Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEABAC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AFA208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsROZ8XO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfFGEq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34820 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfFGEq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so469959pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WGN3NR4MW1WrYhidVDjbYDvKJj0rx7B3nDJpv9Q+YA=;
        b=qsROZ8XOJbENYyPYXdqw9bNV22BT8EHKoWsX/pyjAYa+sTVHTkXr25YmcOeO+yqF3f
         d6ODsYN5z2v83Yoy5/Yf4RI0RH1bda03HvVd3l+B+pf0mDfer+SXR09LVhPVA2OXCGQr
         qaaZ2E2KfrYzk2ebgA9uUf3cWV1ZBTXgMdwDErKTjLiovBKKVTbxOia69mc9OfzFxd+v
         g5IoDhVzSFUqx6gZ6NwqianM2g4JcqcEbCSDOLRek7tI6l6AFSGLnePIzTWKejJ1+TJB
         X4RoQm69PQ1sz9KsYVXzgz9jzJgVn0OUIXlAOykYBOdfHiVUahFLHrueCj574plpwHQX
         erKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WGN3NR4MW1WrYhidVDjbYDvKJj0rx7B3nDJpv9Q+YA=;
        b=SUpvOYYPfzb9QCgaQh9UkU58s6SrqpG0Z6vdtjBmTGXs9c/B6QTkkZr4D+FtJfSfWO
         ToaVv527luMpWHY3xt8L0agUzraWnyqvXIZwsawN/9fWyVeczu/ittoub7N2q+IKpQEH
         332RGly2BfdDZbvrAJIzS0sDyHWZxTDN9WtEpwTMZdvLodejyyPBZiFSpiEXTT9Z4H6K
         MAXIFCQ/VNrjccPvhJf9+6SRQw/uxT8AJAM4QK0yYZqg0VqZ+xXLsPWZFN++Bc3s2vRa
         lFlkZoJCa7QwZd6GVdHlF7UIOOh9M3axIER8v1FxI669tlYLCNNV/9pwK5PMMn8r8tNf
         87JA==
X-Gm-Message-State: APjAAAVu2JTL4fjBbnRhaBFfQyHDdswepInmKU3zFTJh0S4D+s6HuY/d
        0rTs/wkpdqx4jKN5HQO/VCo=
X-Google-Smtp-Source: APXvYqwU9vZPupXHfV6OqLtCeF44EiP7wQdlEprMWLsFY4ri4V5gLX5//Mdu4gski656XyMb8F7wXw==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr3391153pjb.135.1559882785793;
        Thu, 06 Jun 2019 21:46:25 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:24 -0700 (PDT)
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
Subject: [PATCH v4 00/15] tc358767 driver improvements
Date:   Thu,  6 Jun 2019 21:45:35 -0700
Message-Id: <20190607044550.13361-1-andrew.smirnov@gmail.com>
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
  drm/bridge: tc358767: Introduce tc_pllupdate_pllen()
  drm/bridge: tc358767: Simplify tc_aux_wait_busy()
  drm/bridge: tc358767: Drop unnecessary 8 byte buffer
  drm/bridge: tc358767: Replace magic number in tc_main_link_enable()

 drivers/gpu/drm/bridge/tc358767.c | 648 +++++++++++++++++-------------
 1 file changed, 372 insertions(+), 276 deletions(-)

-- 
2.21.0

