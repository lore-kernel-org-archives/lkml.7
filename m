Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52856C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228A220645
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hRT6Lt40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfECXpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:45:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36889 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfECXpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:45:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id z8so3431782pln.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XbIwRnpHasrOr38KG1gDBykd/s7vNBHOqXcN+WuSbls=;
        b=hRT6Lt40DTjB+SAfX7dTiYCmgcS0xVV4LOZGxF1nNO1rE6hTxBbwg0EOCg90s634u1
         RAmh5pNALXGX4G8EPiTonOV0il0j4303l80tCXD0rNbGUOUcwN7zZ9qvSXsYdKqHM6zL
         ME3uD6VSGCzZb29q39EjXHNlWjKzINHiqmMl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XbIwRnpHasrOr38KG1gDBykd/s7vNBHOqXcN+WuSbls=;
        b=Zp+LaKVivXBgjnBnVpW/nLwazWzNYo6FSYx/SvlXOMEwnxHBgE++gFZy/ue+AiE74I
         o+eQ5VvOHhOQYIEGi1/JuMeBmftfYVAMqf30BqbN460ZczMBBAiOPpthsenwKE1fITu/
         dq/RCmuLImlU23lPzacYLwWdIeuvvsxL3C6GxMxoeulBKvRUD51QOK3DHjbMc0UZVjl2
         0+UOl/40ClLxXYukbG0VwNhmdayOZp+SQomwz8WGbYsSO4MNeyl9WyPOTZ7oGpI6pnY1
         5KNDYecuZMmoTubydfSPKseShzkv145DR5Oh34x4Oc7GjEMpRHO37IFixUlkO4L7DGRB
         4iaA==
X-Gm-Message-State: APjAAAVOFaaGfsGk1LNTyZor5qNX8zXvaSNRj+4cD2PqtmKFV5HNJpf4
        /DAynrsvJewIzqjSwbOgiEf9HQ==
X-Google-Smtp-Source: APXvYqywi/Agi0SinrIsRvR8a9BzPcCCDDx1uoFGnmEtsaMSQWa+m9ZHFlINHMkxcDC/VFmBjbEvQA==
X-Received: by 2002:a17:902:6b01:: with SMTP id o1mr14464517plk.318.1556927149935;
        Fri, 03 May 2019 16:45:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f22sm4019071pgv.45.2019.05.03.16.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 16:45:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, amstan@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: Make rk3288-veyron-mickey's emmc work again
Date:   Fri,  3 May 2019 16:45:37 -0700
Message-Id: <20190503234537.230177-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to boot rk3288-veyron-mickey I totally fail to make the
eMMC work.  Specifically my logs (on Chrome OS 4.19):

  mmc_host mmc1: card is non-removable.
  mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
  mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
  mmc1: switch to bus width 8 failed
  mmc1: switch to bus width 4 failed
  mmc1: new high speed MMC card at address 0001
  mmcblk1: mmc1:0001 HAG2e 14.7 GiB
  mmcblk1boot0: mmc1:0001 HAG2e partition 1 4.00 MiB
  mmcblk1boot1: mmc1:0001 HAG2e partition 2 4.00 MiB
  mmcblk1rpmb: mmc1:0001 HAG2e partition 3 4.00 MiB, chardev (243:0)
  mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
  mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
  mmc1: switch to bus width 8 failed
  mmc1: switch to bus width 4 failed
  mmc1: tried to HW reset card, got error -110
  mmcblk1: error -110 requesting status
  mmcblk1: recovery failed!
  print_req_error: I/O error, dev mmcblk1, sector 0
  ...

When I remove the '/delete-property/mmc-hs200-1_8v' then everything is
hunky dory.

That line comes from the original submission of the mickey dts
upstream, so presumably at the time the HS200 was failing and just
enumerating things as a high speed device was fine.  ...or maybe it's
just that some mickey devices work when enumerating at "high speed",
just not mine?

In any case, hs200 seems good now.  Let's turn it on.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-mickey.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index e852594417b5..b13f87792e9f 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -128,10 +128,6 @@
 	};
 };
 
-&emmc {
-	/delete-property/mmc-hs200-1_8v;
-};
-
 &i2c2 {
 	status = "disabled";
 };
-- 
2.21.0.1020.gf2820cf01a-goog

