Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AECFC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EC0214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jllI4sbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfJKXsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 19:48:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41662 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfJKXsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:48:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so6954409pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 16:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmsaWR6UIYQFsskmsBUdb3fnHuvmiQm3ZQiAWL6V5Qc=;
        b=jllI4sbRj/cCNWxGttqdKesUD1HiYXaKIvs794DXXkc+PoCdkcM6erto6iQpJ2rVud
         8x8uYDcnaphLecfMmemcLRSW39ZOAsiY1fpX57AgoFA76OdqMj/YC0hmd4h+OiH4iynt
         jy7YCSb1g1byOhT7+4nEcBeBc9rVr9YUKFpTFGTtrTxVmTOlwQDIvcSmMdvAyNLBEniY
         zsaFaa8R6uL7KmJQMdTWGJv6LsPDDGctdIyqL7lENT9fX9FmOIFJyFBpld8huwIfhQDb
         LqKAHiLoKH5XlxH+7NG4g7NzAeUnTviUWArEsPTKSF7qeUbLlSAEJWfBAp78UEmB30Ps
         8Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmsaWR6UIYQFsskmsBUdb3fnHuvmiQm3ZQiAWL6V5Qc=;
        b=sVlap4Ehu/lfm0CjuIsuYafJ03hvhwlTDLfG1TM1jII1NvoSeY2WPQOlIjU2vv3SWN
         sLgiJyPasUUOM3ViTjVYuELJEMVV93NpR+l+DzPjqmw2Q8whAC4OuYfdLHvn3FvitgkD
         vjM4tPmmB1myf77wj6GDKRP4jcERyJ8HBqdAAAvpas4mnxrW4K8yaZD5C13hODteDo33
         TI6vO8t0D5gDQ5ThU5U6mOkZ6VDFPC/DnpDTb3eDibzGMFzxOv4g2ESyLDhDpJsqPX7G
         4WDhvVJEsbEGY2PD7xM8ceOpOATorkahlqEMedufLr+7F0X2ySgPosEBWsbJdqU2lQQy
         iQPA==
X-Gm-Message-State: APjAAAUEv4qnHPuoS21D3OxaKIPNa/U9XNjfmczqFJT30krtjp165fDT
        QwLFL7GicHR+WXqwRh1A6GO0Ag==
X-Google-Smtp-Source: APXvYqzQQMfZB/vfwkNtGeT6aWfRdgIU/ygvDWyu2BePS2QK+kJUi1HassUgKqK1qK042mIzuwELyg==
X-Received: by 2002:a17:90a:d793:: with SMTP id z19mr20089752pju.140.1570837711757;
        Fri, 11 Oct 2019 16:48:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m102sm8477015pje.5.2019.10.11.16.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:48:31 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm socinfo driver
Date:   Fri, 11 Oct 2019 16:48:28 -0700
Message-Id: <20191011234828.374419-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm socinfo driver provides SoC information to userspace using
the standard soc interface as well as a number of debugfs entries.

Enable this to allow certain user space tools to acquire this
information, as well as getting developers access to the information in
debugfs that is useful when reporting bugs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 45e55dfe1ee4..a5953b0b382d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -744,6 +744,7 @@ CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
+CONFIG_QCOM_SOCINFO=m
 CONFIG_ARCH_R8A774A1=y
 CONFIG_ARCH_R8A774C0=y
 CONFIG_ARCH_R8A7795=y
-- 
2.23.0

