Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7080FC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420FE206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etF6/auc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfKPGoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 01:44:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46176 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfKPGoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 01:44:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so7701600pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 22:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83mOzCZrk2hLeBIavxFW02Ub7zgigDrZgcfo7Rp02xE=;
        b=etF6/auczY/PHyj2EW/5m9MAfa7+4KhKO2DKDAQqUiiJ/HJycDvebsWhFyy7ltErNz
         GPdUetQoCqDTxijT0aZPIe5TPLoBcuI/HcwwSLoQvfsRwKrEcXKyfNi58/nXbyswpqjH
         BprxdonwAHRWF6P4gsThGhzKQh/Py9iApmDHlM3sQN6OXVP0V9y6jMAMLR3TIIUCIAOs
         wiAUpDM/MxLmyKx/CsTNelNQqSJLaS4PsRhsYQm37K7kVfWPrj01BPVG5X/0yGHts/rX
         wRCVlVZ2lrtpKQbhURCDfqzz26gKxLE7PQlrRpXzosM17VsQnO3aK56Z84Nzqk9noZcq
         43eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83mOzCZrk2hLeBIavxFW02Ub7zgigDrZgcfo7Rp02xE=;
        b=lVLj7FZbZnDhySyQJILgT0PG+Y9NTwihfusZEvvIEQgZm4xuOMLlGrgH5ENPlR8mCM
         GqSVq2e1+cfMASzAitLFnTh62u6NEIYTNvXtpV1udpLhiBMntll3QS99bGkKyZsf8R7l
         +eJe81K+BKiSZcC8D6QqV2gNBlIeCZ7faFacoxoC1nCiuWqdFL4/OxPdQZzwC3k86wxK
         Xj4YhXzejh2T+wJLdoWLCKpLoNehu3B8OHBze4djhP0fs6miisJEVGP8v3bCYukXJu8q
         0PzoqpbLHe5HRBT7O3MhIIaYpZEX8Ye646Gj+tcL+NfVka3Pv29j/aRFU7pc3coAVBFy
         J4jg==
X-Gm-Message-State: APjAAAUiZUQdvzaQDTNU27bAyyzb7TG8nezRAFbSQALwb1hRi9JmL8Dy
        sEjbmG4v+k6dqOEQHcA6DPiXLQ==
X-Google-Smtp-Source: APXvYqwkM4lZh6cRGZMVmRD+7muqSOChY7AWDb7zXeO/JwqTvRigHw1HpZUm08pwffapf4Vo4sOuEg==
X-Received: by 2002:a63:5164:: with SMTP id r36mr7664120pgl.143.1573886659746;
        Fri, 15 Nov 2019 22:44:19 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f26sm10985615pgf.22.2019.11.15.22.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 22:44:18 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998-mtp: Add alias for blsp1_uart3
Date:   Fri, 15 Nov 2019 22:44:15 -0800
Message-Id: <20191116064415.159899-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msm_serial driver uses a simple counter to determine which port to
use when no alias is defined, but there's no logic to prevent this from
not colliding with what's defined by the aliases. As a result either
none or all of the active msm_serial instances must be listed as
aliases.

Define blsp1_uart3 as "serial1" to mitigate this problem.

Fixes: 4cffb9f2c700 ("arm64: dts: qcom: msm8998-mtp: Enable bluetooth")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 5f101a20a20a..e08fcb426bbf 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -9,6 +9,7 @@
 / {
 	aliases {
 		serial0 = &blsp2_uart1;
+		serial1 = &blsp1_uart3;
 	};
 
 	chosen {
-- 
2.23.0

