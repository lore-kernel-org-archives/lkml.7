Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0BF227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ha7vPRYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfLLTgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:36:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46863 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfLLTgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:36:18 -0500
Received: by mail-pj1-f67.google.com with SMTP id z21so1486025pjq.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImwQrt4+ASNt2Q7OYNBZqW7Xb6BRtjl1Ax5bFWps8lo=;
        b=Ha7vPRYeArv0gldLsw7B4rPz3IGOCgRfcuSYkydMMFSVm/kTtSg7XorAMBS+159yLe
         WKSkV7MosS+nd56fZ/Ls5AssGx/0zdnA9bzJCjll0b1btVLhxmeA4X7/xLKY7hq0cREt
         Ajf2ZlquR+0X2LBG6E9cZuxGZ7byzhfPuU08o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImwQrt4+ASNt2Q7OYNBZqW7Xb6BRtjl1Ax5bFWps8lo=;
        b=qNRHDnQYuIjSatfM6qJwwic3vvYFqFB34QBvv+zVu2gZ3q4oWDHZkWC/wj17gNc/0w
         0g8XsvTaNKBnaTz0DDnQkJvsWDJIGXxqSi/BJzSUxfiNM/f4crDTHe6a1teveMdjFo+X
         U62+ibtREPmZutOzEO8nzxSlGv8alyrYhiU/KRB6Cpyx/SZ2wTrDW3X3SkZrupbO71eZ
         vnF0w61GNs+pW4xnpIJljhCMoxPx9mumKSwAFWX9gcjblSbhEkdcwHPm3xp1GGB4DBPr
         SIIrBOZhtPpgIQ3rEbP+iVgLGVsr1S22l17m44IpnUdLvH1J+fjJZyMF339XoQ4uYi8j
         5WSA==
X-Gm-Message-State: APjAAAU3qYebFeGQbtUSuMKHX8tcSKICDuetbTA5ZPyhBr9psXulaHYB
        jBzHWqS/DZINDxdFp3VNOQtVuw==
X-Google-Smtp-Source: APXvYqzCdTRZCR79zSJLn5TFO0zIzut61GTDaUp63R7VMg2CJ5BqDpFu9fCu4/15kGZ6WwefQqKNRA==
X-Received: by 2002:a17:90a:ba04:: with SMTP id s4mr11613215pjr.92.1576179377766;
        Thu, 12 Dec 2019 11:36:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m34sm7568302pgb.26.2019.12.12.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:36:17 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        mka@chromium.org, Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/7] arm64: dts: qcom: sc7180: Add SoC name to compatible
Date:   Thu, 12 Dec 2019 11:35:37 -0800
Message-Id: <20191212113540.1.I158061c65974bf0f653ceb79b442b76a1fd64868@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191212193544.80640-1-dianders@chromium.org>
References: <20191212193544.80640-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running `make dtbs_check` yells because qcom.yaml says that we should
have:

- items:
    - enum:
        - qcom,sc7180-idp
    - const: qcom,sc7180

...but we're missing "qcom,sc7180".  Add it.

Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for SC7180 soc")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-idp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index f582c9dcc9aa..388f50ad4fde 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. SC7180 IDP";
-	compatible = "qcom,sc7180-idp";
+	compatible = "qcom,sc7180-idp", "qcom,sc7180";
 
 	aliases {
 		hsuart0 = &uart3;
-- 
2.24.1.735.g03f4e72817-goog

