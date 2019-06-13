Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E7DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABA02173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eAWun/ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfFMXmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:42:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38715 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfFMXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:42:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so212870pfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vet+Dn10p+j7iocPSsG03g8vaMFWiMo90o3B9LDdj5Q=;
        b=eAWun/ksKNSaoQ10+uBkjZGfqtLoiG8yBGDTdZO258ZzYavaoOZuXXwFSkzwuBHRB7
         lAW5Qhzyq2gfCkWzO/C/0t28K4pk2shtn8t++uigTtM6pqGQTxJDZTEppJLVYFcPZiZ+
         ET5Mbl5aw+JT4vfiumCEtNewl5negiJ8/hElc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vet+Dn10p+j7iocPSsG03g8vaMFWiMo90o3B9LDdj5Q=;
        b=pKSxcJlh147/F0OMzFBaq9yh8hDB4zwT/koYOCskXaa4fqebMbIgkJtSOzf32hp6n6
         pUholVajV/CPC/xPmo/1xw0KW47huGdDUxiooi8etUK982sy0JbU3hP76jGzV+qN2h6a
         X3ZaRSbdNxu4gGb468KoLghAIbxBC9qD57nj8rEeXqjWteBnCDHdK37q3/JtWLKCMfjz
         RoAAfumBmUfFARnA2vv8Me0n9QcWA/StTeMHQclmoKVXq1c9q8fc4BL/knRxgmALnqFW
         oFKzhlFEcKRRYsYTI296gyLC/iZl/0ZwAd/9Oemo32Aqcj0gbvCK0A572FXfDMSD1Hyb
         yY1w==
X-Gm-Message-State: APjAAAXtQR69neWCUyg5kDproXDU2+wa73C8cNzgRh4tvhat436QG/6r
        huQ2Hcu/ybbD/0Fb+vghSReUxw==
X-Google-Smtp-Source: APXvYqzcYCogaB1dx3Z18YZOdlzBvYKRQdVrqLFdJgs65C5FTDSv0SULwuUx8O/K6Sy3YmVLTPDmpA==
X-Received: by 2002:a17:90a:8a8e:: with SMTP id x14mr7827548pjn.103.1560469329449;
        Thu, 13 Jun 2019 16:42:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p7sm781088pfp.131.2019.06.13.16.42.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 16:42:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        Douglas Anderson <dianders@chromium.org>,
        Franky Lin <franky.lin@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Ondrej Jirman <megous@megous.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 1/5] Revert "brcmfmac: disable command decode in sdio_aos"
Date:   Thu, 13 Jun 2019 16:41:49 -0700
Message-Id: <20190613234153.59309-2-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613234153.59309-1-dianders@chromium.org>
References: <20190613234153.59309-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 29f6589140a10ece8c1d73f58043ea5b3473ab3e.

After that patch landed I find that my kernel log on
rk3288-veyron-minnie and rk3288-veyron-speedy is filled with:
brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110

This seems to happen every time the Broadcom WiFi transitions out of
sleep mode.  Reverting the commit fixes the problem for me, so that's
what this patch does.

Note that, in general, the justification in the original commit seemed
a little weak.  It looked like someone was testing on a SD card
controller that would sometimes die if there were CRC errors on the
bus.  This used to happen back in early days of dw_mmc (the controller
on my boards), but we fixed it.  Disabling a feature on all boards
just because one SD card controller is broken seems bad.

Fixes: 29f6589140a1 ("brcmfmac: disable command decode in sdio_aos")
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Double Lo <double.lo@cypress.com>
Cc: Madhan Mohan R <madhanmohan.r@cypress.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
As far as I know this patch can land anytime.

Changes in v4: None
Changes in v3: None
Changes in v2:
- A full revert, not just a partial one (Arend).  ...with explicit Cc.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 4e15ea57d4f5..4a750838d8cd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3364,11 +3364,7 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
-	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
-	    bus->ci->chip == CY_CC_4373_CHIP_ID ||
-	    bus->ci->chip == BRCM_CC_4339_CHIP_ID ||
-	    bus->ci->chip == BRCM_CC_4345_CHIP_ID ||
-	    bus->ci->chip == BRCM_CC_4354_CHIP_ID)
+	if (bus->ci->chip == CY_CC_43012_CHIP_ID)
 		return true;
 	else
 		return false;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

