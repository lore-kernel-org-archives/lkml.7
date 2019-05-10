Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE09BC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD712177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgkRML8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfEJLaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:30:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44342 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfEJLaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:30:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id g9so3074532pfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XEEIgwOV9z+zGwCO+bIPdlvdaxukbTtCAZSyRHFIYp8=;
        b=PgkRML8BUjp4OaooFW5wqoDKpWiVOpDtLOaT9rXtfDX8p1w9hjpPGCkM+9pXTvVIgp
         o7f7YVDLeyz64hfKY/psaexOP59hI0BiFvFMOIw2+FXP+oYknF8Q8Q/rvZW/TiXeUp5e
         I8HnJmMf5tOdX7q/eOgpuvSv8SZLC/0B0Y5D9zdw02m4a/5oDIXEdNgwx43oVrNGLvBN
         KLGd7V9L3HpJhooCyV/2SFrPe8x99d4O7EYiZQ9kgatEFMUMy5KdkdZ3tGv5TrU6YmWd
         J0OYDSp7nTw8JLKG7URMq7FSOiAKpsrXRR4LWET0rqQ9d041XFAydmqetRD+/HA/etH2
         aD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XEEIgwOV9z+zGwCO+bIPdlvdaxukbTtCAZSyRHFIYp8=;
        b=oDesMG90dY5rkV62URHlEz0gBDnE3g2xCoT9zXU4nXOKZeWTKBksc2hYmASX7RudHM
         qeG75qeq0q/dEzzBRNllQWszbdKM3MwOENPFhbLdCx8pFf5iBL9Hu7M9QtS9MZkLXbji
         jathnVaHhp0Pcfb4faokU37gntdF1rMRslYrx1dL2Gf9q1uivCBNEpYtx7GRjMVzCUWY
         HdDA1QdzdpFijf8b2T3sLqwsSp9MWqA5arbDzRXOLyk3yuUgefg+vYpiRnRgZlbEp8Rj
         RuqEGZef5iTI7GcReMkAPi9e7+DnmCCc99iX6Z6xsseAAPx/PiQlf/JW9twkuup6zXNt
         Lmhg==
X-Gm-Message-State: APjAAAU/c64/gVNVxGGw6hAnucFN+7B7Klc8paMZEkCW2kgHSLyIbpu9
        5G4ZwfkV8L7rSxrAm4LN3+lbqTeWTOM=
X-Google-Smtp-Source: APXvYqzVNweeOUex4wtCyguEfq/kjTXsfJW1UD0IsFIC5Dc0O82bHCQsrFPy7HWYhM1fFJWBxDlRvQ==
X-Received: by 2002:aa7:8212:: with SMTP id k18mr13005473pfi.50.1557487804833;
        Fri, 10 May 2019 04:30:04 -0700 (PDT)
Received: from localhost ([103.8.150.7])
        by smtp.gmail.com with ESMTPSA id p67sm10677543pfi.123.2019.05.10.04.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 04:30:04 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCHv1 3/8] arm64: dts: qcom: msm8916: Add entry-method property for the idle-states node
Date:   Fri, 10 May 2019 16:59:41 +0530
Message-Id: <030b5d9c6dc2e872466b7132e4fd65c473f9883f.1557486950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idle-states binding documentation[1] mentions that the
'entry-method' property is required on 64-bit platforms and must be set
to "psci".

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0803ca8c02da..ded1052e5693 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -158,6 +158,8 @@
 		};
 
 		idle-states {
+			entry-method="psci";
+
 			CPU_SPC: spc {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x40000002>;
-- 
2.17.1

