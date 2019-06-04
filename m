Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F4524BBB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qorJynVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfFDLUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:20:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36706 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfFDLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:20:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so12352460wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxpNRThISdlm9cH6wVLDT0m23cE+WD+Qwgx9Y+V0kcw=;
        b=qorJynVwLuvik3sbivI5IjQKek7vzUdZCZszNNGbzCEeBlZEduEh2WwFFpZ/9QsRvX
         dJo3sXn9omTqzoQsBnwRHnllGRB6Cpdta98FFXlEUnaSG6o4pHkMTpLoSi3RPlfQho2C
         4WLeCFj8l5xQK3C3wHKfEal2QZBExg/+JgckPRQ5BHqAFRmwOOoJFWd7cGw8UvFvyp5g
         uGO2Glimu1ul6j/1P3D9R0Qa0fmuG2vSRZnUDAoAVVRuDCPyTqBSDYUKUqZ3AGKur7wh
         vZUUU5qmtE7i6K0e/WLrfW9WvlVX4FTuldY7y3IFU8yCEL0LAXzdwoiU9+lBCwnlraB9
         BVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dxpNRThISdlm9cH6wVLDT0m23cE+WD+Qwgx9Y+V0kcw=;
        b=CWuqlefW1PYUx7N0yXnnXhNttIANWBN9HMy4n9cbuRirzW+wJ8GMkuOQ1JeeylyMbM
         6CD+PH3abPZD0Hxs4kRh80ugWqeOxb8MgprTc9zB/5RS0j+bZ//dW2QWvyrSqvMizfas
         JfhAw+cS27Cc31g2tq92a8mD/1vrQuSSXeRqrLWy3WXE0BR9kJi6+4pcQDMmnOVR/UJV
         MmZdNCp97oP+7jeLmJCoPRGQeDVc0bVeCIKv6s6fLxis/dqAYlfvu0vmu92wdTWrOHn6
         yCfiWBMLXBtxc0N/Lgr38e0LVLU2JonbvvbSfFZvTj0mm+jeN2oT0fXEflBVx051VzGz
         y3cQ==
X-Gm-Message-State: APjAAAVP7AuJSyjNw5sNTKxfOEpXCX4FkgFGuKrQS3nS0jPxCfyhIc8a
        KqjBo1g1PlOo2Q9XeOo/EpF82G7w
X-Google-Smtp-Source: APXvYqwNC0MkswzFShHt3yQldVkSXUz1KfIAJTRcaMCLUjOMO/ePNMi5n6kd/8vEPzhgHcOwyWftYQ==
X-Received: by 2002:a5d:4a82:: with SMTP id o2mr3321183wrq.154.1559647234597;
        Tue, 04 Jun 2019 04:20:34 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.213])
        by smtp.gmail.com with ESMTPSA id g5sm20580044wrp.29.2019.06.04.04.20.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:20:33 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     arm@kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Olof Johansson <olof@lixom.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT)
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: add Panfrost driver
Date:   Tue,  4 Jun 2019 13:20:01 +0200
Message-Id: <20190604112003.31813-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the goal of making it easier for CI services such as KernelCI to
run tests for it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6b748f214eae..952dff9d39f2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -656,6 +656,7 @@ CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_MXSFB=m
 CONFIG_DRM_PL111=m
+CONFIG_DRM_PANFROST=m
 CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
 CONFIG_FB_SH_MOBILE_LCDC=y
-- 
2.20.1

