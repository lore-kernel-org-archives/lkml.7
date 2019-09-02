Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC984C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AF120820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3ZZoAoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfIBNHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:07:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44080 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfIBNHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:07:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id 30so3019029wrk.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g8Q8qWQfrWkSBZBL0ZC4qSYWSksz/bKYB7eibpEbpjE=;
        b=g3ZZoAoNupIgQJ7LwycZYaI61Y+HZoFJSbt007WbeCls8jor1CkG0XdK8NnFLrxF5J
         r4aSSZjAQFiHEhy4Rb+JiMH5qGvtD4FjCv8Uyenek53GZObk480HmrJb57Pa7Dm6B6J7
         p3i91ZUB+PDaKWazCJl93jRt3XrIifp8yYf3jFvi0EBebWm7+t3BAbP+jeucIIqhSeGf
         jn9mb3QMHHMDZy14U0iMPUKx1O1I+l4r+MMd2rxqHeIVOYmIce6Gn9MaFfl1lQUUZB1I
         YAh03QAu5zHPyC5T/xfc5075QgWS5e8xVji/K6nvK+LXcKcKyT2hw0cOTsv2ndNFSoid
         2FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g8Q8qWQfrWkSBZBL0ZC4qSYWSksz/bKYB7eibpEbpjE=;
        b=HiAm3UE2YkjxgFFprEOfCUYbgaGY2zRvegK5zY+3iVbOa8DXzcIiOPlEYPrLJ54qaC
         drcgbsuSu0pJztyXuC/m6CkCl3rQCAqif4Z8hS6YFa5AlPMjWbU/cnEahXI6WW+feVIP
         UU6XoSfZQqsc32o9i2/gy2bplgTXjKvirQVsOzG9hGo+R1jQpVxjOhp/vGGch7dQu/Nx
         zyp1nQpVacd793S79VPfuOKE3EadHPQlHJpXPoNkKAWLsHBb26awgBjs8OPUEW5Er8Zb
         Pby0pIgnGj/it5CPD9eJwPIp5WdiVswt/dw1fk/CAl8Pn9/rW49NQjVPo1ddRKHs3+4v
         CN4w==
X-Gm-Message-State: APjAAAV4HANfAF7MCZmaPqxxeYtpMvvAV6CeuDQc3SAtuTo2LiImYXRy
        sfiC56C3Af4iDS7K+sB1JKGy4Q==
X-Google-Smtp-Source: APXvYqyVjbfK53qao6AkqFDw56Vfssqbbu6Wzur1UnzFue0+wk/FuBHP3vupfwTKn7EKra2/cgVRow==
X-Received: by 2002:a5d:6043:: with SMTP id j3mr3124284wrt.337.1567429649239;
        Mon, 02 Sep 2019 06:07:29 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id d28sm12352030wrb.95.2019.09.02.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:07:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, olof@lixom.net, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/3] arm64: defconfig: Enable Qualcomm QUSB2 PHY
Date:   Mon,  2 Sep 2019 14:07:24 +0100
Message-Id: <20190902130724.12030-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190902130724.12030-1-lee.jones@linaro.org>
References: <20190902130724.12030-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on the Lenovo Yoga C630 where this patch enables USB.
Without it USB devices are not enumerated.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index af7ca722b519..a94d002182ee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -770,6 +770,7 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_QCOM_QMP=m
+CONFIG_PHY_QCOM_QUSB2=m
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
2.17.1

