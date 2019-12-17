Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A2C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66D32146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zf8bJkao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfLQGUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:20:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38279 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQGUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:20:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so5079897pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/4+dE6TBvtAZbiMIIRV67E0nc4u23eKs5qpkR7aBsc=;
        b=Zf8bJkaoXvahdNySVN74ycCQmLoxy4e5zh/QEjLuVcb/JCf6/qKAIx/QIxOu2AylUF
         NMV/DOrOPmOeOmY0f/G/FTwuHzSTsno4nQwSkTeTsttDr6a+VEguvb69NOqt354udB5u
         3NVNEK2lBA0XKrW2irpwFs6w6ounikv/qY/RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/4+dE6TBvtAZbiMIIRV67E0nc4u23eKs5qpkR7aBsc=;
        b=K5lUJMCzh/4/0kM5MpxANRe7KDu9Niu7+x+wAO9zmptdi/UPuQ6EPn2SAEcHGcgySs
         YXuMM4+z/HVY6IpgcReFSQjVaj75zdVTUKc/CYi97j+eXqgjKfT7eXgUb7wdxkubnIJk
         8i9AU2XHrwLQX63w+2yagSyBB38Ax9VtQo89m8VCVycG/GdieCnuhT+SlnwNatNuIYWl
         7GKAkNSzecJeLiq+EbA6AycNDfgS/96CQ74R+Sm1A+HXhRBIunOFkjp9tCxLIjcFct1D
         szSPfWEHWZsfL689Y3IgD01IcJYlSAqu0tXZK00uidFf/VMfy/Qc4SaxXm0l1lxzlAx8
         c85A==
X-Gm-Message-State: APjAAAXSmb22zXQuy9YZEy7ELAWA4qLVOaMiO9uLg/5GPL1kgk5asfLy
        h64vLmQUxgLCK+f4DiNHFcc5UA==
X-Google-Smtp-Source: APXvYqyEClKB5KveoH1dz7RJn9lqOw2w9s8Xx0dDnRonMN4XFIC7VrXPxnzpn33/nSEKlc6SZb1QQQ==
X-Received: by 2002:a63:360a:: with SMTP id d10mr22663260pga.366.1576563642808;
        Mon, 16 Dec 2019 22:20:42 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 100sm1682030pjo.17.2019.12.16.22.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 22:20:42 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: dts: qcom: sdm845: Rename gic-its node to msi-controller
Date:   Mon, 16 Dec 2019 22:20:25 -0800
Message-Id: <20191216222021.1.I684f124a05a1c3f0b113c8d06d5f9da5d69b801e@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just like commit ac00546a6780 ("arm64: dts: qcom: sc7180:
Rename gic-its node to msi-controller") but for sdm845.  This fixes
all arm64/qcom device trees that I could find.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 407d26e92fcc..5d3b470f1be5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3203,7 +3203,7 @@ intc: interrupt-controller@17a00000 {
 			      <0 0x17a60000 0 0x100000>;    /* GICR * 8 */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-			gic-its@17a40000 {
+			msi-controller@17a40000 {
 				compatible = "arm,gic-v3-its";
 				msi-controller;
 				#msi-cells = <1>;
-- 
2.24.1.735.g03f4e72817-goog

