Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F51BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD24243C4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VI7KxZOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFCSiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:38:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34172 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfFCSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:37:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so2313986pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdJuH7k++BGfpS8zEifYD9KLgjj0LNkMfJlMApOTv3A=;
        b=VI7KxZOr4/miSRAbIaeuYOJWoiCEXYABO8BpdtXK45HVy3s3YAOXH2NJeOgkyrBE/Y
         M99xiWkHi2jRBQUPUeYqrK2eK3FG6YAzAK2+y6UTn4rp+zImAeXBrz5q/Kjrd7fCFoYp
         NqT8KOH/N14j84ZVOE54ukekZw45tWyTAZ44U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdJuH7k++BGfpS8zEifYD9KLgjj0LNkMfJlMApOTv3A=;
        b=BfSHIGQB4tXDhn9+sIRIlZlCsnlaC0taegYyBWU1lXfuC+Cj5SjHi3y8fiMot9k0GY
         2cc2IdD0j7HOjI6ErvAzM5/PW7xz60xjfUqX1fPmana7w+IyEaA5rN9bniHnGkLUz3NM
         UnQpMjayd9sN//gFnQ2COg+MlCPDBsep5JHfF8gEETdgFcxYVrIWjMY8tEXkUSrv2qck
         +Ebp/ZziCz3P48aIZ0pehbPuT5VY4k4K4l5JMObAZaCO5ksxxxnhdRJsbxIcYZwpkOHk
         bXwmLuYnCpWyIhDqlgwxZKEsxef73i2/Dh0GU+arJiiKezsSlDPcwehkrKAl8UPbmglJ
         JTLQ==
X-Gm-Message-State: APjAAAU+drv3+dBKBBp0enW8DlLQFAUXtjYhpL7RUm6FLB3lNl+r2xLR
        2fUkTW1kmTPg87mUxSDezZ5mWA==
X-Google-Smtp-Source: APXvYqxCAKpMJCDgPT0zPf8L4uQ/LWU+VMtO7VfMvXmyv9L+9e+E97URHi0HoDSQYuK+nyvUaZeP3A==
X-Received: by 2002:a17:90a:26a9:: with SMTP id m38mr31800995pje.93.1559587077838;
        Mon, 03 Jun 2019 11:37:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id t2sm14808969pfh.166.2019.06.03.11.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:37:57 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 1/3] Revert "brcmfmac: disable command decode in sdio_aos"
Date:   Mon,  3 Jun 2019 11:37:38 -0700
Message-Id: <20190603183740.239031-2-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183740.239031-1-dianders@chromium.org>
References: <20190603183740.239031-1-dianders@chromium.org>
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
2.22.0.rc1.311.g5d7573a151-goog

