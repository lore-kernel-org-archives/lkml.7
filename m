Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75BFC17441
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 02:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7560E20865
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 02:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRtazlfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfKICmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 21:42:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34010 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfKICmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 21:42:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so6406402pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 18:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3aOUzy6rUzyL+A22ql+voMdR9JLNJalZQcTYr1824w=;
        b=NRtazlfidpLzrbXKDkCOE6NaO6GOLX5Lh6Mm7Pvv32Q3hQv5PMbZLh7Ac92oDhosFR
         /1zBLFNCf7wGnzAQyXp/pqUR/AikPgmQKcIPZVSGbHhAjK+UDMKln89bNSQVS85ACJJE
         ikbdmKqeIuQvukcaxMNkKR9ZU8ZRzZeoxkmvGNv/ubqJNkAPnjUUWwNe91owFiC/OzSO
         hmSQwuKmmDzAekKCN3hKX4nzPlBPlzydDEr9FeFQtpqj+mVR5hOVCaY3fxzLKbfuUaz9
         fFqsVOa1BH65aTRWqQwStHrv5OsMNXXlVRCaJ+Z/+azMJmnFR9VWisr6AX+uJEn57jtN
         Gyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3aOUzy6rUzyL+A22ql+voMdR9JLNJalZQcTYr1824w=;
        b=g3i0tumJuLYO0rdCojm3U8Eh1OpFVuVywbNaZbWV2uOqPBHFfgTMfsBuodTyp7hAm2
         +PLS97If+9IICUVAWcvbepO0PD1T7fhMMn4BPZD6u62wWz7JfQNgtWa1jvE2fBDRUWSL
         bODqx49uyf04ELLE0rD5TnP3h8Vm/t4ztkMozGkVgc2iICCesS3vnAXEOacRZiGI9A0/
         VVkiWtXjtbmw6g+UEqJpvoO/Q7AD+0wxDzxj+1+VTDZ3KpTIfDN6Q4SvnLH2q/6bkeR3
         bVdDFclMwX2NYyM6A3nVVOhxsPbSQe/FtGEriFb0AXnS7Ucf3VVSYHa0K7Znv2iG2DhJ
         MOKw==
X-Gm-Message-State: APjAAAXM9bXU4CJ/kmnZloFY31yPzdsDETan4bvjpnrmZQ0UgioJ/Tbh
        IWgzV1/0OVq3GdTVyQKIkjk/xQ==
X-Google-Smtp-Source: APXvYqxbTMEPmg4n9oNIpZHyLmp21Sp2dvJPnoo+1J59q3v0NVek1OR1AH8jXhKgG7Lx4ATWe0bCeg==
X-Received: by 2002:a63:e249:: with SMTP id y9mr15582281pgj.383.1573267358334;
        Fri, 08 Nov 2019 18:42:38 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u20sm8436966pgo.50.2019.11.08.18.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 18:42:37 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SDM845 display and gpu clocks
Date:   Fri,  8 Nov 2019 18:42:34 -0800
Message-Id: <20191109024234.1757452-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the drivers for the display and gpu clock controllers on Qualcomm
SDM845, needed in order to get these features working. These drivers
provides power-domains and can as such not be compiled as modules.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7fa92defb964..7fd999be3de3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -726,6 +726,8 @@ CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
+CONFIG_SDM_GPUCC_845=y
+CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_GCC_8150=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
-- 
2.23.0

