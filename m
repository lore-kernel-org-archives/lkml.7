Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DCDC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C0E208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDHJtD4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfFHFFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 01:05:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40220 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFHFE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 01:04:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so1581040pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JHMxvIq1jsW2qWML7iET1ggCLWTMelSL100NyRTudI=;
        b=EDHJtD4g8m8NgywjVghSqy+PL2KBFW+vEhsLk+5399uhepYp6Kcj7W9M5c+hBaLixK
         h0g9ZHCNugDtJttP0mUwBtaOU55XtJ/Ep7K+YYQNJGk8HzR2PcXO5ASWe0RuewbKN0PE
         o2eE00inVhPttmqsymXxsGYTKBOuUjjPzRmp/sny5NEFNgUuSbufcRhMjtwTookZaOrn
         fi5AoxdioRxYHyt8m5XdjZ4N99zqXxCnXhWWrQOK7WxKDLAWZNdd5nuOVDCDFn8LHVEs
         GEQLMXROaepbpCAegsCIEv7p2BmrG3jKvhZjLPukkA9lamgDOYtf2C6vPYEJ3Tfd8i8n
         ZJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7JHMxvIq1jsW2qWML7iET1ggCLWTMelSL100NyRTudI=;
        b=BqEl1r3N5r3MW3eXFRNdTsLtsvhQPWoTkRxsIeuPtJ1hemG3sd5hUYQxd/ID5UGUyB
         z4SKPscVxmiAo8ofTwWvAvEkIrgGTlbfTwkasuh7Qd+8+c5JP04S3Sf82SgWnyCQV31d
         A4opOGQBEQQ5qZz8RX4aEneeOLGYpY1CqqjjFpxKtIViFNHwI71TUqcZ7hsH+ujBtrx5
         fLBhAK+oAY8WsDoMyLtfU9z1mzmzahs91uZBrBG5hOR283A7DCtpWnROz8oUzBKHdWqR
         mqg7rf0/ujo2ghBSQyb9JTV2XfAYss3R5RoKY3I/MA8YB0SAzkSAkctA1wnCPG1Wj+oj
         S2VQ==
X-Gm-Message-State: APjAAAUlmGWqCR4TX5AfOsWwzmuLv1FAMrZ2zfQXis56SHlsgD6Kfi+b
        xFQwRk3qIbRYKF9mLoKlDUDamg==
X-Google-Smtp-Source: APXvYqyAHw1AV05o3p032VHhbyghs7+weXTqVDC+E/50Yqk2YdvccJr8yaM4fMNzlvhMVl17Ezvqqw==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr6065542pls.261.1559970296912;
        Fri, 07 Jun 2019 22:04:56 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b8sm4522482pff.20.2019.06.07.22.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 22:04:56 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO
Date:   Fri,  7 Jun 2019 22:04:50 -0700
Message-Id: <20190608050450.12056-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190608050450.12056-1-bjorn.andersson@linaro.org>
References: <20190608050450.12056-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the UFS device-reset gpio, so that the controller will issue a
reset of the UFS device.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 80189807b4e5..441045847e9f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -467,6 +467,8 @@
 &ufs_mem_hc {
 	status = "okay";
 
+	device-reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
 	vcc-supply = <&vreg_l20a_2p95>;
 	vcc-max-microamp = <600000>;
 };
-- 
2.18.0

