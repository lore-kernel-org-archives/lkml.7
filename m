Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547A8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A432171F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGZJVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:21:47 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59320 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfGZJVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:21:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 60CBBFB06;
        Fri, 26 Jul 2019 11:21:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FFe4Rvb0O9iZ; Fri, 26 Jul 2019 11:21:43 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2988E46A9E; Fri, 26 Jul 2019 11:21:43 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/panel: jh057n00900: Move dsi init sequence to prepare
Date:   Fri, 26 Jul 2019 11:21:40 +0200
Message-Id: <cover.1564132646.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the panel is wrapped in a panel_bridge it gets prepar()ed before the
upstream DSI bridge which can cause hangs (e.g. with imx-nwl since clocks
are not enabled yet). To avoid this move the panel's first DSI access to
enable() so the upstream bridge can prepare the DSI host controller in
it's pre_enable().

The second patch makes the disable() call symmetric to the above and the third
one just eases debugging.

Guido Günther (3):
  drm/panel: jh057n00900: Move panel DSI init to enable()
  drm/panel: jh057n00900: Move mipi_dsi_dcs_set_display_off to disable()
  drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s

 .../drm/panel/panel-rocktech-jh057n00900.c    | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

-- 
2.20.1

