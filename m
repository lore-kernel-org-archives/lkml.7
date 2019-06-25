Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BFDC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B97B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfFYRFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:05:41 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34074 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfFYRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:05:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id ED25EFB02;
        Tue, 25 Jun 2019 19:05:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ILinwd_cVNSn; Tue, 25 Jun 2019 19:05:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 59B7648E34; Tue, 25 Jun 2019 19:05:19 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: [PATCH 2/4] drm/panel: jh057n0090: Don't use magic constant
Date:   Tue, 25 Jun 2019 19:05:17 +0200
Message-Id: <ec1993368dba4e6ec1c72faa9c7bb25cf8ca95d3.1561482165.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1561482165.git.agx@sigxcpu.org>
References: <cover.1561482165.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0xBF isn't in any ST7703 data sheet so mark it as unknown. This avoids
confusion on whether there is a missing command in that
dsi_generic_write_seq() call.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index 6dcb692c4701..b8a069055fbc 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -33,6 +33,7 @@
 #define ST7703_CMD_SETEXTC	 0xB9
 #define ST7703_CMD_SETMIPI	 0xBA
 #define ST7703_CMD_SETVDC	 0xBC
+#define ST7703_CMD_UNKNOWN0	 0xBF
 #define ST7703_CMD_SETSCR	 0xC0
 #define ST7703_CMD_SETPOWER	 0xC1
 #define ST7703_CMD_SETPANEL	 0xCC
@@ -94,7 +95,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
 	msleep(20);
 
 	dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
-	dsi_generic_write_seq(dsi, 0xBF, 0x02, 0x11, 0x00);
+	dsi_generic_write_seq(dsi, ST7703_CMD_UNKNOWN0, 0x02, 0x11, 0x00);
 	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
 			      0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
 			      0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
-- 
2.20.1

