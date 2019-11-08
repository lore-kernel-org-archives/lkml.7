Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E81C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D8A21D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213098;
	bh=cdrS8Uc5C1CK0pynDXTy5DUwfd0d+1/Gvdh+qg1pCMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pOltH5deWq3gQZSfgIYSNNMU3oUwcUKliVyr4X+1xqpb2N3MxdUQcKgPq08OP04a3
	 r4PPN+QayuxGqwnIadiIT8dT+k5dctEd6Ne71AZ8u6Tsh7/7asLnwaeM1c+5B7LV1B
	 xEfQsHNZ89iWRB2sZu4m7fLYZUHD4WbE0XNOoZ3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfKHLiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:38:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732259AbfKHLiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44EF222C2;
        Fri,  8 Nov 2019 11:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213095;
        bh=cdrS8Uc5C1CK0pynDXTy5DUwfd0d+1/Gvdh+qg1pCMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btpa0CO/OO2MLs76HbKvlePvTWQ7TYe4u9X0RtfC72jII/V1P68CuYi2qFR3llDzf
         IuFuucKdSN29Jbl21LpTJjT0FucRFGwZ5VWsVuC6J6byoEFZZIXIbVWuxwpLwDPTiv
         m3f7QNOSFDvSdysJTwUy9yM8LSJJGkyZipEVVRzQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 020/205] extcon: cht-wc: Return from default case to avoid warnings
Date:   Fri,  8 Nov 2019 06:34:47 -0500
Message-Id: <20191108113752.12502-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 962341b54b99965ebec5f70c8d39f1c382eea833 ]

When we have first case to fall through it's not enough to put
single comment there to satisfy compiler. Instead of doing that,
return fall back value directly from default case.

This to avoid following warnings:

drivers/extcon/extcon-intel-cht-wc.c: In function ‘cht_wc_extcon_get_charger’:
include/linux/device.h:1420:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/extcon/extcon-intel-cht-wc.c:148:3: note: in expansion of macro ‘dev_warn’
   dev_warn(ext->dev,
   ^~~~~~~~
drivers/extcon/extcon-intel-cht-wc.c:152:2: note: here
  case CHT_WC_USBSRC_TYPE_SDP:
  ^~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-intel-cht-wc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 5e1dd27722781..bdb67878179ed 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -156,7 +156,7 @@ static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
 		dev_warn(ext->dev,
 			"Unhandled charger type %d, defaulting to SDP\n",
 			 ret);
-		/* Fall through, treat as SDP */
+		return EXTCON_CHG_USB_SDP;
 	case CHT_WC_USBSRC_TYPE_SDP:
 	case CHT_WC_USBSRC_TYPE_FLOAT_DP_DN:
 	case CHT_WC_USBSRC_TYPE_OTHER:
-- 
2.20.1

