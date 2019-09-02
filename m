Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B1C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C90220820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXnIW/gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfIBNH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:07:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55320 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfIBNH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:07:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so10545026wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rsozEf7LzXTyUNJhzuuHzBFC5HEt2b+uTwoXpDRJPPQ=;
        b=UXnIW/gi4ourEdlpXtCIx1S1FdKJcFcQnM7bu2ySM1BS08gggZ9EP6PkB7Hlmo094A
         R8yfJqlI0EUBa4wwuJYf3VfYqjWP8naYIs7CwbaJ47VhuqSHehwPBBCboj8KU25mTD0w
         R7n9mX51/1VCrBPqnSo9HGSeKlgIWBhN6NUw2Ahm1iSqNp7ussbRoSozB2hb8DPykHmb
         9kKwvikt9bSwwk524bOwBpIeQUfW6XMZgAUjshEWjh+7lm2ndr4j+NAzVBx8KsKxosxT
         mEG8a0HPEW5tEzdsQl29Hew92Zg5HKc1uppQvAjC/A1oG6Ul3JxEjIavbmjEVYF1euxk
         f4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rsozEf7LzXTyUNJhzuuHzBFC5HEt2b+uTwoXpDRJPPQ=;
        b=CBqJvIuExNiyQHamPye6kI7yIuGYrJ4KOBu5hBUhIEay2KpoIrhbO+kPaRfEkq5d0h
         x0Y7TeFjpAGnG+AMqYwGQF5B2UAbsMzR3gcAtlu4IoyW93i1Vc+Avu6qpVPnyYZ1IMjp
         KaVit0m6L5fUJQA0Gsn/NzvswNNqZmlNCbyL78M9p7597UXDpNRMM1QejfDdveme6STa
         xaVE0OFbdO3t5O16O2BM5hfZ/ef3CrRx3RTfJDoKH9mmcdle21sDNHu0mZoW89LdcqCZ
         jyG6FVVBW/CYA1LjYHO39gyKW8gUP8BLYiOZoluxmMPnRHcfxG6xu36HHgOVTF/k8AgC
         HyOg==
X-Gm-Message-State: APjAAAXBHg++ObfI5gXQ460IUR55MmUt4ltIdAbHbsv3BlCwgu74u1hL
        MeI3s3DBgmfAyxo35oemmE63kuZ4GT8z9w==
X-Google-Smtp-Source: APXvYqz/ztCgmeIEp/4+hjdqXQXltGXofSvsJ49jHcYPf0MoF928UaMsVWrnbu+vkyw1bSoRiYE2Jw==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr4172216wmk.63.1567429647185;
        Mon, 02 Sep 2019 06:07:27 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id d28sm12352030wrb.95.2019.09.02.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:07:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, olof@lixom.net, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/3] arm64: defconfig: Enable Qualcomm GENI based I2C controller
Date:   Mon,  2 Sep 2019 14:07:22 +0100
Message-Id: <20190902130724.12030-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on the Lenovo Yoga C630 where this patch enables the
keyboard, touchpad and touchscreen.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index facf19cc275d..0fe943ac53b5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -366,6 +366,7 @@ CONFIG_I2C_IMX_LPI2C=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_PXA=y
+CONFIG_I2C_QCOM_GENI=m
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
 CONFIG_I2C_SH_MOBILE=y
-- 
2.17.1

