Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF8AC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0530621556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l++elnCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfLLTgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:36:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbfLLTgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:36:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so1367205pfx.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxvIIL/M4xNHXhfiPPzelu8fzsGIsbwuQDaIfVtVXFc=;
        b=l++elnCnFpjdWyOmeDMISmI3G2om45f3yRFU/HXxxRki9QynkfxcIBVk1v1NcC//I4
         TAvusqtp0YcKAoAYjOrjuxWpqmDfbs16PmlvjjQwIW+/MhqscEwk/2TpoSFGGIIPi8lz
         OwPTnq7eUPT+NQLs2eSPR/rbsA4E1S403wwG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxvIIL/M4xNHXhfiPPzelu8fzsGIsbwuQDaIfVtVXFc=;
        b=ohEUlQ/BtSa+RuEIcy+DfX5gdd4FPFktQvNPO6I9ZHchFJwt/i96U+YepWHHwZhdBa
         ludyXzeqMHW9uaFZdQsqkbn1VB/Ga+doZwzMpyEDsBZRH0fsuAZQBWHjYrU54vjV5o7v
         o2TzhKZnA8hGli3bp3pxDNlNHRvUzUIHdXZxUD5XaHeJ3C9LOJG8qGONGgbjP53049VR
         PsUMwbwMh8OhCwBwwpYo7cu7EQvObaLYyNQCOUxXLrrs9xgrD5bqFM9B58XyoNWLruRf
         KMSPnv1QTsqpLexrsdRt+EyMFCSuiH2gIb/7DawkYmhkA5korXPr5CcuspN48uABkr1v
         NKRQ==
X-Gm-Message-State: APjAAAVdw6hRfd74YTmjNvKB7LulmWztXOzERjBC7qGlvsiTzpDO3Nm/
        w3jqpCP/KwOwLvKsdOH5GS36zA==
X-Google-Smtp-Source: APXvYqwRLZFrp8ZGCKn5bYAs/X8CMfTRPrFWB7+1WR9Jf7FXzw6D14fesD//auj8r9OqxTRluOF+yQ==
X-Received: by 2002:a63:1a19:: with SMTP id a25mr3467111pga.447.1576179381825;
        Thu, 12 Dec 2019 11:36:21 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m34sm7568302pgb.26.2019.12.12.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:36:21 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        mka@chromium.org, Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 5/7] arm64: dts: qcom: sc7180: Avoid "memory" for cmd-db reserved-memory node
Date:   Thu, 12 Dec 2019 11:35:41 -0800
Message-Id: <20191212113540.5.I4e41d4d872368e2e056db2ec8442ec18d3f7ef08@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191212193544.80640-1-dianders@chromium.org>
References: <20191212193544.80640-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using "memory" we trigger we trigger the "schemas/memory.yaml"
rules when we run "dtbs_check" which then complains that we don't have
a "device_type" of "memory".

Looking at the "reserved-memory.txt" bindings, subnodes shouldn't just
be the word "memory".  Presumably using just "cmd-db" should be OK for
a node name.

Fixes: e0abc5eb526e ("arm64: dts: qcom: sc7180: Add cmd_db reserved area")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index d114feade8e7..9766867abc88 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -61,7 +61,7 @@ reserved_memory: reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		aop_cmd_db_mem: memory@80820000 {
+		aop_cmd_db_mem: cmd-db@80820000 {
 			reg = <0x0 0x80820000 0x0 0x20000>;
 			compatible = "qcom,cmd-db";
 			no-map;
-- 
2.24.1.735.g03f4e72817-goog

