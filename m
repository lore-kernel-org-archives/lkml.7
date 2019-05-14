Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B85C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666E020850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfENUns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:43:48 -0400
Received: from mailoutvs12.siol.net ([185.57.226.203]:59378 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbfENUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:43:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3FA7C521E73;
        Tue, 14 May 2019 22:43:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id H35XG354VjHa; Tue, 14 May 2019 22:43:44 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id ABA0E521E15;
        Tue, 14 May 2019 22:43:44 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id F0885521DDF;
        Tue, 14 May 2019 22:43:43 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/2] drm/sun4i: Fix sun8i HDMI PHY initialization
Date:   Tue, 14 May 2019 22:43:35 +0200
Message-Id: <20190514204337.11068-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I received a report that 4K resolution doesn't work if U-Boot video
driver is disabled. It turns out that HDMI PHY clock driver was
initialized prematurely, before reset line was deasserted and clocks
enabled. U-Boot video driver masked the issue because it set pixel
clock correctly.

In the process of researching the bug, I also found out that few bits
in HDMI PHY registers were not set correctly. While there is no
noticeable change (4K resolution works with both settings), I've
added fix anyway, to be conformant with vendor documentation.

Please check it out.

Best regards,
Jernej

Jernej Skrabec (2):
  drm/sun4i: Fix sun8i HDMI PHY clock initialization
  drm/sun4i: Fix sun8i HDMI PHY configuration for > 148.5 MHz

 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--=20
2.21.0

