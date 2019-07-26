Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2562BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DA522ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfGZNOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:14:46 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36322 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfGZNOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:14:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 2CC44FB07;
        Fri, 26 Jul 2019 15:14:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RdK5Fd9fsItN; Fri, 26 Jul 2019 15:14:41 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0AE6046AA1; Fri, 26 Jul 2019 15:14:40 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drm/panel: jh057n00900: Move dsi init sequence to prepare
Date:   Fri, 26 Jul 2019 15:14:35 +0200
Message-Id: <cover.1564146727.git.agx@sigxcpu.org>
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

Changes from v1:
* As per review comments by Sam Ravnborg
  * Ignore failures to disable the backlight in jh057n_disable()
  * Add 'drm/panel: jh057n00900: Use drm_panel_{unprepare,disable} consistently'
* Collected Reviewed-By: Thanks Sam!

To: "Guido Günther" <agx@sigxcpu.org>,Purism Kernel Team <kernel@puri.sm>,Thierry Reding <thierry.reding@gmail.com>,Sam Ravnborg <sam@ravnborg.org>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org


Guido Günther (4):
  drm/panel: jh057n00900: Move panel DSI init to enable()
  drm/panel: jh057n00900: Move mipi_dsi_dcs_set_display_off to disable()
  drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s
  drm/panel: jh057n00900: Use drm_panel_{unprepare,disable} consistently

 .../drm/panel/panel-rocktech-jh057n00900.c    | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

-- 
2.20.1

