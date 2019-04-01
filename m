Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1779C2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfDATP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:15:28 -0400
Received: from mailoutvs30.siol.net ([185.57.226.221]:37809 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbfDATP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:15:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 050A852081D;
        Mon,  1 Apr 2019 21:15:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pDCkOTYPU6WW; Mon,  1 Apr 2019 21:15:24 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id AE86752065A;
        Mon,  1 Apr 2019 21:15:24 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 3D36052081D;
        Mon,  1 Apr 2019 21:15:22 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, wens@csie.org,
        narmstrong@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] drm/sun4i: dw-hdmi: Improve CEC support
Date:   Mon,  1 Apr 2019 21:15:11 +0200
Message-Id: <20190401191513.23159-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that additional logic between HDMI CEC controller and
pins on PHY on some Allwinner SoCs prevents proper communication.
It might be possible to fix it, but it's much easier and less error
prone to just directly drive pins using software implementation of
CEC protocol.

Let me know what do you think.

Best regards,
Jernej

Changes from v1:
- renamed is_cec_unusable to disable_cec
- added review-by tag

Jernej Skrabec (2):
  drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC
    driver
  drm/sun4i: dw-hdmi: Bit bang CEC on some SoCs

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |  2 +-
 drivers/gpu/drm/sun4i/Kconfig             | 10 +++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h     | 11 +++
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c    | 83 ++++++++++++++++++++++-
 include/drm/bridge/dw_hdmi.h              |  2 +
 5 files changed, 105 insertions(+), 3 deletions(-)

--=20
2.21.0

