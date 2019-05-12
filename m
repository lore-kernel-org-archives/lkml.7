Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E78FC04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1197D2184E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BM1olpLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfELB0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:26:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54136 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfELBZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:56 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so13819011ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5NnI56YEhBpccDrupNLnoq/PDM7aNqfb+ZvdWdM4KE=;
        b=BM1olpLU6epTYjGJ/w3Y5wrCxFpt9gJr/IhjGEhDAP7XCp5jNnnTGkcrVXxvW7dyNR
         d3cDmCrUJXPEsfDmJbVEdWa1ntXVkJkVH2WLVMGj9gcly/OZy8Rk9NTbsaTKIANzl/KD
         bPjIqHpUfYBk1dgRp30F04dQ81WnGD3Hk81nXawuc6x5BPIAEYC4eJ5RYwjZqC/QCQR/
         m/UyAGAJ6lfr35QFSvB0ZKDuHRY9nKGJ4bQjbYOx2J145l6vJCa5kAmSBBn3cVYD5knq
         HouP0tE9DxJn7Fpc18wO4vvn+0rr52c9XUAFPbCWZDOhG+5DN+TtOFRUmWHfk9YypniD
         GzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5NnI56YEhBpccDrupNLnoq/PDM7aNqfb+ZvdWdM4KE=;
        b=SwnmPfWSgEdL+YRdnrfQ8W1ibwkMRKR4814+vYFx7CLNvOgckQDM2VmSKtOFsrU0Y9
         +KWgZZdFeNXBGdEnTj65SSKDMlnC/zwSkZlS7A3SQkJEgLIhV6gFW+vQ665/oJZqerko
         PcHPzwXBvQ/3Z8sNsshi7LAHr4qktDaMRlj51QAvCwhb+5ETZ2LJwWFfkPMlsaUg+d31
         fct508T8yXfkXs21o+94GjB71b6SVT2iBdO7E/h1jiGDIMm0ReXPYy3aReYT56/yLrdu
         NV12VDDNl0iMTOl2BhSWJA3RtkLT5NzICAFdn5BlYQcvXxZEPcYKPEtDi06B5IvzeaMo
         K/Vw==
X-Gm-Message-State: APjAAAVs3/35rdF+UuKnLdbw7kwjUXl2Q9b3Qw+OkldV33LbNetRApob
        joo23zCzngBGjAQXL1WeYYv7sg==
X-Google-Smtp-Source: APXvYqzUfA2OOPAJGbfEL4rDPAQ0VG+FqjjN9+mgxs1jQCY9O72PSvxRMkShMezOTWbh/ebHT0TL0g==
X-Received: by 2002:a24:c347:: with SMTP id s68mr12557479itg.140.1557624355327;
        Sat, 11 May 2019 18:25:55 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:54 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, catalin.marinas@arm.com,
        will.deacon@arm.com, andy.gross@linaro.org, olof@lixom.net,
        maxime.ripard@bootlin.com, horms+renesas@verge.net.au,
        jagan@amarulasolutions.com, stefan.wahren@i2se.com,
        marc.w.gonzalez@free.fr, enric.balletbo@collabora.com
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 18/18] arm64: defconfig: enable build of IPA code
Date:   Sat, 11 May 2019 20:25:08 -0500
Message-Id: <20190512012508.10608-19-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_IPA to the 64-bit Arm defconfig.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..4f4d803e563d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -268,6 +268,7 @@ CONFIG_SMSC911X=y
 CONFIG_SNI_AVE=y
 CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
+CONFIG_IPA=y
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_AT803X_PHY=m
 CONFIG_MARVELL_PHY=m
-- 
2.20.1

