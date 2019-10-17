Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4772FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D0421D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRYDbzXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438247AbfJQWS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 18:18:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34746 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbfJQWS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:18:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so2534560pfa.1;
        Thu, 17 Oct 2019 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C169RwbVuJRbGp34GilCowuduOX6yRZWq0x40Zztun8=;
        b=PRYDbzXtZ/SI+Iz1Fdv8VRKfhYh4ZHVpkTLQPJas85E17XDmyjw05WJM5WqTVF3OV7
         xb0AYHe3JCgUXM6LIJs5p6dio/JbX5mFLXahRZRbLq8VybPWftUt78kXrMDXuThD38w4
         UczpItN4bYOd3Q4Pm/Vj8NR8zaTyIqyPV+0eHDz9W/Pv9YdBC4N1GdSM6rKjwBDax/+M
         UvFr89PmEhmqQAbT8CmkzcbH05MEKOqBuy5DrHPNz588kU5+3LSDApsk/CU5l9FvPsuj
         0buXhrOLyU01YJa+8TiTmImdaP8rvUqlU+JEI8rQY8/EUVziv00mnzq24vQM0e/ZUPjO
         hC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C169RwbVuJRbGp34GilCowuduOX6yRZWq0x40Zztun8=;
        b=Urx4aNv/+/XoQqqH+egkLCA0O9qqIewzaBmWvla65kcd2jEg9+jk5qxcb1gK4GkymS
         p26diKl3FzcS71c+b9vnQWWhhgVdYff9+6za1wQOkMrXQtbn2kNreFA82xKAKKoVXdcF
         00eTKVkqT42G66WOR1Gx9j2O6SLuN5aXSDDhG7BnMzqa1QJe6uZdCItqYQnlEtZbHnTy
         4FX5mHHYWMXcAj0WSB+hDb0TNYHv5lXgPXuNU7KjoIL1jRXziw3MXrxqVV2DQ9XjDLJY
         nnVtQg/Ga/z9hZc7ivb1fLh1OTO3mO4yv3/k9wTQzOPOl+z7gFyOvn532DGjFk+LU3p5
         qTeQ==
X-Gm-Message-State: APjAAAXc6YIUWjfcDNEYojCmY2Gam6qRFIEEsKM0gtc6lYeuMDFd+Sy7
        KRtz6ZBOZ7JqqAiKCjj60Lc=
X-Google-Smtp-Source: APXvYqxoawBsnwxFpbUrvD8qh7zE5Su3nWTf9ECIFvUO/tdKYDdF9ZiLNySJn6V+TeRpO0csw44STQ==
X-Received: by 2002:a63:b61:: with SMTP id a33mr6765327pgl.247.1571350735122;
        Thu, 17 Oct 2019 15:18:55 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a8sm3441912pff.5.2019.10.17.15.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 15:18:54 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [RFC PATCH 0/4] Enable msm8998 bluetooth
Date:   Thu, 17 Oct 2019 15:18:39 -0700
Message-Id: <20191017221843.8130-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables bluetooth on the msm8998 platforms.  However,
without fixes under discussion [1] and [2], the init process will fail,
leaving bluetooth non-functional.  Perhaps it is best to wait until the
dependencies meet acceptance before taking this series.

[1] - https://lkml.org/lkml/2019/10/17/599
[2] - https://lkml.org/lkml/2019/10/17/975 

Jeffrey Hugo (4):
  arm64: dts: qcom: msm8998: Add blsp1 BAM
  arm64: dts: qcom: msm8998: Add blsp1_uart3
  arm64: dts: qcom: msm8998-mtp: Enable bluetooth
  arm64: dts: qcom: msm8998-clamshell: Enable bluetooth

 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 17 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 14 ++++++++++
 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi    | 13 +++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 27 +++++++++++++++++++
 4 files changed, 71 insertions(+)

-- 
2.17.1

