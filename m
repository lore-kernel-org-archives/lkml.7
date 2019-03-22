Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C16C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1838A21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSmVXBVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfCVD3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43984 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCVD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so520783pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvwMadT9Guc44W9HPQvKgVqVpo2kPt/43WK6NKQJPxI=;
        b=XSmVXBVsm721phYyKIHxSA8/GjgWDGofBo56UOPWoLYj8ouQX/R7obaKjMYZF7b2cj
         fBHsFW/JTzaiDxC2AS0kJWYMAZD3CYEFAHN2ppqeHnoQYB7tPJlyzpdFoJm/7uPtdoZ/
         Wi/0Ep471+bgOgnQNUc/dfSWBLzUEnfZg7TChYOuBVngzu8WbSsFacvaBhXSYTwiN68A
         ujWHaWOkkdTKka/viC9d+25A+8a1ifVPO8tVLg/oX3JRJmi1XkMd072WxWCm3jwIVqSK
         fsyJXVY9WaHETLGj+UGLlsx6etCWlJ+GfKJNv773LsbC0GR0swKV/R07FXjs1aqwUwzE
         Q57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvwMadT9Guc44W9HPQvKgVqVpo2kPt/43WK6NKQJPxI=;
        b=gmq99ISkESkZ1uMXhQMr4nCL5mYd11ooC1cagwWjsPolGbRFm1zi+eTQh+wkxckN+x
         JboEpkAYj9YeC5d/xjgKB3bVkg7wbNfDAgS2EIi5XLte9PASZ6CYqpBLJa4hWmnLF3QB
         Y8ag7eJ0gyKtfksheRP3kA/bS7/MbOUKL4MoH/vys8kAhtRcgFyEwzJPWhhLTDMoCCaG
         zMWT58uD+6Mz/ggG3qgTA+qwmQvuntFwckPwwMiDkI4UqoSlFniaZwtzhpFSGQsKB9jv
         7v5QXSPWQxJfKjHzomG3DVO5FrsAW5gwR+o7l74pz3UiNpQAebw/YjyToILwGtvGp6iz
         jbpw==
X-Gm-Message-State: APjAAAUe4rUwyyKwSEuKFqHanLU1psn6ZguS6yTG1HseCNn7As1GG54n
        PDnj5aHAr00l2QiKx3NF79I=
X-Google-Smtp-Source: APXvYqxkYMxK6WMA+I3UVbzcmF3jDxVZJ75x86H1lB2pHu68dPUA5RiDH0mbD4PZDbf+24hi23vdbg==
X-Received: by 2002:a63:e14e:: with SMTP id h14mr6593815pgk.184.1553225354086;
        Thu, 21 Mar 2019 20:29:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/15] tc358767 driver improvements
Date:   Thu, 21 Mar 2019 20:28:46 -0700
Message-Id: <20190322032901.12045-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Changes since [v1]:

    - Patchset rebased on top of
      https://patchwork.freedesktop.org/series/58176/
      
    - Patches to remove both tc_write() and tc_read() helpers added

    - Patches to rework AUX transfer code added

    - Both "drm/bridge: tc358767: Simplify polling in
      tc_main_link_setup()" and "drm/bridge: tc358767: Simplify
      polling in tc_link_training()" changed to use tc_poll_timeout()
      instead of regmap_read_poll_timeout()

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

 drivers/gpu/drm/bridge/tc358767.c | 648 ++++++++++++++++--------------
 1 file changed, 349 insertions(+), 299 deletions(-)

-- 
2.20.1

