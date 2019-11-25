Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86EDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BCF20862
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zchG2SUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfKYOZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:25:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42212 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfKYOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:25:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so11158530lfl.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lk8SRgnsKjAXBRx1hwjdc4Ni4aIadkTu9BDcS7y9BzI=;
        b=zchG2SUm1v9d74lK7/a2Ov/76astU1osx0T1E+xZK0+7tbypt2wEIrGbCIGTV3fYLl
         Qrr/vm3uT1sQaljCinz5Mgcpia9mxh+xjWu1/o1DaUbLJPz2lsjywcvEzeV9OOcHFFXw
         wwb43RuNNbilDJHZe1txdK+kp9I789BbjlWlIoc5O2kjNcXsCNmVIEjI2pTkl2Zgr16S
         9wFS6rTOIN4Gq8aNErHoCVr8SiXT5GzeZqhbdGAx4PJBZVRLKf4k0ueXsbhHHwtAvpJW
         iSEd9iur/qi7eAw07BQkKObFUYbW5j3hSr4gmF2pWAMnAGDNw/8lUlzSCrMNKGQUFBUX
         +teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lk8SRgnsKjAXBRx1hwjdc4Ni4aIadkTu9BDcS7y9BzI=;
        b=YVjS/O6iyiwe7I/JK2RDkAa4y0dP0EK1cTOP5YEsVfgNsqmgTP/VCFjc+/8BMSnXqu
         GyzjwRiwX8XWqUWG2gEF871ukUS00rOBdWK1+XvRIyv99+ay94pP0SCpS7jj3HV3e5HH
         oe7xAQLDQUyhfAJPKa51ZRvf8PWq7XGhtamhwRc93rTtnVm8BVAZMvnM8bWDW81TooEY
         HqLR/zfCa1A4R0nlvh3IjAl+0CwEaNb0qA0JnCGkHl/rSPVQgDhx7V7SJnPtA5bl8f90
         EIs8niZcgUUc3o0b7UJoIyoR8J371YQUHrmafaMVlPAGw1ZSmqMKujUPTnU3rxzC3u5T
         iXsA==
X-Gm-Message-State: APjAAAVcFzdsHxkQk5shEfpZgtlE3ALpVnUs8D4BrIo3bIJvVNb0I0It
        Oes+dnqdX2MLWrZGTBsev032xZli81QklQ==
X-Google-Smtp-Source: APXvYqyE+jBtA6fW2pog7AMXr9bL2gLyOpR90A0sgyb4hzg762aBGAjB5B+6dLqfNRt+VohCnld2CQ==
X-Received: by 2002:a19:751a:: with SMTP id y26mr21685422lfe.78.1574691935705;
        Mon, 25 Nov 2019 06:25:35 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id 15sm4016640ljq.62.2019.11.25.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:25:35 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        bjorn.andersson@linaro.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] arm64: defconfig: Enable HFPLL
Date:   Mon, 25 Nov 2019 15:25:10 +0100
Message-Id: <20191125142511.681149-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191125142511.681149-1-niklas.cassel@linaro.org>
References: <20191125142511.681149-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

The high frequency pll is required on compatible Qualcomm SoCs to
support the CPU frequency scaling feature.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v1:
-None

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7fa92defb964..e76b42b25dd6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -727,6 +727,7 @@ CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
 CONFIG_SM_GCC_8150=y
+CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.23.0

