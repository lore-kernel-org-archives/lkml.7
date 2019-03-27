Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA291C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5E5213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="Z0FO/ZyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbfC0Bsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:48:38 -0400
Received: from chill.innovation.ch ([216.218.245.220]:48382 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbfC0BsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:48:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id EBBA5640145;
        Tue, 26 Mar 2019 18:48:19 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AywgedmsdLDb; Tue, 26 Mar 2019 18:48:15 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 5948D64012F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553651295;
        bh=TKAwUeoQjXGxeCTzx/5U5pnah0OGN0utD5zaICWlxRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0FO/ZyEoomVEiA7vHZUiliooyTcClYNQcEqnnAWq/vZEx6rKQjqElTLfFBZcvwbr
         Ibk7x7uSiNBoZLzu1C+cjX0QYMrniMqR3GFj1zNmN5psn2Pgy7AGKDR2e5bH/02Jv0
         7DG+0Bkxbekew623iLSfNR0xubdv6yoTaLpAbBgyhNCIg7BlG77CVM3z6WExBzb+ZV
         FEq1swr2shdQKk7fBRqpGBCyEa23JzggzGv7mLyl5ruNfyuHBKsxVBJw+MZC4zWi1e
         E/Y549nlQqTwjPcKdY33uttOxEuzeLYONVzqYzABkYgDtl3mFt7iG6Cj3L2Z4Iukcs
         exznPqkO3ErpA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH v3 1/4] drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
Date:   Tue, 26 Mar 2019 18:48:04 -0700
Message-Id: <20190327014807.7472-2-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327014807.7472-1-ronald@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
INPUT. However, this causes problems with other drivers, in particular
an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
future commit):

  drivers/clk/Kconfig:9:error: recursive dependency detected!
  drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
  drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
  drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
  drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
  drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
  drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
  drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
  drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK

According to the docs, select should only be used for non-visible
symbols. Furthermore almost all other references to INPUT throughout the
kernel config are depends, not selects. Hence this change.

CC: Inki Dae <inki.dae@samsung.com>
CC: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 2fee47b0d50b..eabedc83f25c 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
 config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
+	depends on INPUT
 	select DRM_KMS_HELPER
 	imply EXTCON
-	select INPUT
 	select RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
-- 
2.20.1

