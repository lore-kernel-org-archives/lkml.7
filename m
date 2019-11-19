Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2453FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED93322362
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftUzIhsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfKSPqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:46:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34535 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfKSPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:46:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id 139so23890036ljf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 07:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKKyPkgTIrUgJLfJdMi3ez4CUNaFpld4hIHRZMCg8t8=;
        b=ftUzIhsgD2KsI+Xzqgh9UNmduNgupRakB+aHfdmjkBk3PNzBCQTJgEuedpdzkJdBzc
         gWv8w4cSzN/HJgXo3UJm3CnBhX9EK6DKqftCJ/MGeJBWR+fy/+T10n7Q9S6BAzA1NL+s
         poasY+D/n4q2kqmwKeNoDnm4IY/Rpjr+iwTYxSi2TjMPfQ+0Cb3WqZQw0LEtByhNG3kG
         u4s8aDh1rQEyYLHAWFQY21DsnpHKJwfXXCYt+7Qfr3fMu8sQttCuz1lS5od1dfeBjiKT
         9uYu6/o6Z5lGCoUhkzEfXZJ6AUaaLbjTS4bR2ks4qbV4d2EQpS5OzqcfDahcllBwpfBz
         KcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKKyPkgTIrUgJLfJdMi3ez4CUNaFpld4hIHRZMCg8t8=;
        b=VUwTXUkMVN6EKFMTGfeFK93uwOUZ0BtAb2KU1kI1a6VlviWVMakyg0liXWzT96IgZg
         F3fJZkYvC2n2w/Q61faoU8hvbn4Kgy7Pczk4ych+FQ1xd7jzLf/Ih4JQgVTHkRRQ+XAo
         Fkf0C4OYb2ZODHSX98H6gcQFB/QfdqmOJUH8ogQ6HqNiOkTemGq2ux3k3uumI1vZkuDT
         +gCiWYQ/4csVSJEZz7eo4XSAUUz60mpgNsnUljl3s+dSnn3agv8nw9s/sf8S21mJ3cje
         DhibZ1o3gT/172I/+CXRytcqsswnr+b/kIwITHx/cS6bK+ozVg9SrXsvbXRS0i7azVMd
         MhgA==
X-Gm-Message-State: APjAAAULF1vY6NJ0TQrOvA6VKOfrRSF14FuQN9PJBnKgV5rp64CapDc1
        Yv3JbhVzk1cThBcyMibvSHrseUdHduwiTQ==
X-Google-Smtp-Source: APXvYqxlG+4qGNAX91shhoryUkY0lCP1hEIsDb7QpnfSi0qgJ/p5zP7rjKHMWeQBYegUbtHUwvI/gA==
X-Received: by 2002:a2e:b0d3:: with SMTP id g19mr4343582ljl.135.1574178405466;
        Tue, 19 Nov 2019 07:46:45 -0800 (PST)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e14sm10128803ljb.75.2019.11.19.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:46:44 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 4/5] arm64: defconfig: enable CONFIG_QCOM_CPR
Date:   Tue, 19 Nov 2019 16:46:19 +0100
Message-Id: <20191119154621.55341-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191119154621.55341-1-niklas.cassel@linaro.org>
References: <20191119154621.55341-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_QCOM_CPR.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e76b42b25dd6..4385033c0a34 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -438,6 +438,7 @@ CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
 CONFIG_POWER_AVS=y
+CONFIG_QCOM_CPR=y
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
-- 
2.23.0

