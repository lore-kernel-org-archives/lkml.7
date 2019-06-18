Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314C1C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F372147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVwfTRAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfFRQQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:16:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35049 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbfFRQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:16:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so9749818lfg.2;
        Tue, 18 Jun 2019 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6bCoUgdAjlieVdbURwPlYalmssR6MihNiC0B3+iRako=;
        b=PVwfTRABktYrQbA1EEWkz8UDWUkcYXqwJga1n/jSb+4/WAf3CKHIRkXaapjBceHLDX
         WHW8JUggG3JkzoxjU/xg1TnACf4SQRFgTUzhtM1n/YkGcuCrGQhKlwRIMjNoFphkiI4+
         X8bizwvX99TJbRXQ6CTOs2b1NwUmp8PJRbLYae7KtOM7+nfnumzKlJBgazOw2SAG7AeP
         vv05qVHZeFiWy8abRcsTu/tPYiFqcn4pXdvj1Xc4ERSgAmZqw3I1qE4ZLI7rvpjDkZaq
         DS2OewG6fRMNrP/LosGNRXQf0QYyQrG4/mnQnIdsaVMwkbVYfpuIGU4eGBalQIBHkP1O
         3z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bCoUgdAjlieVdbURwPlYalmssR6MihNiC0B3+iRako=;
        b=ncF5nK1EJQWra8lo7mC1eSYEOa1t1xjmD5Oo5IC+wx+oaPxA1iJY+Chd74EhUXNlTT
         pulkpZJcc8S01pX9o4IVu/fpZMMA/qmkfKyvGwfj5nf4KeQcz6wv0lflbR9ZKNEhBCl+
         GUM3+dWAJFcWD3xTmv6cGhaY2gs8tWF0LVEmrnzpKmbZAt7BMYTa8qHmaJhyMwbqHeWE
         jh+L/W5aXKyX1dTJsOzv5DOwZbsNU88CRBTwnSEk927TEHTFrD/Hw807rzTuaLSMGx+R
         037ciwAPdQ9j57Wm7BPiq4WOjTfAlpZ0tRWFoVApcXe3WWX81OAK5EFhJruYsFNVh1Px
         8Qqg==
X-Gm-Message-State: APjAAAUPb1g8x8XL5nrb6f9wXpYljS9AYqj2yYtY0xBQRG/IEYsOo7o/
        L7InAfyn3xA84cSM5ue1jA8=
X-Google-Smtp-Source: APXvYqxdrOPiY8cM1U1jT9ylZcRc2fxV0JtT47I+Bw9ekNdiHVK2JQhCwg+fUJP7N9HF5oa+S4eUkQ==
X-Received: by 2002:a19:488e:: with SMTP id v136mr57485272lfa.192.1560874590847;
        Tue, 18 Jun 2019 09:16:30 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id v15sm2273295lfd.53.2019.06.18.09.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:16:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: tegra: Enable Tegra VDE driver in tegra_defconfig
Date:   Tue, 18 Jun 2019 19:14:53 +0300
Message-Id: <20190618161458.20499-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618161458.20499-1-digetx@gmail.com>
References: <20190618161458.20499-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The video decoder driver was tested by time and works absolutely fine.
The reason why it is in staging is because it doesn't provide common V4L
interface yet, this shouldn't stop driver enabling in the defconfig since
our userspace (libvdpau-tegra) provides combined acceleration of decoding
and displaying without use of V4L.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8f5c6a5b444c..a27592d3b1fa 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -250,6 +250,8 @@ CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
+CONFIG_STAGING_MEDIA=y
+CONFIG_TEGRA_VDE=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
-- 
2.22.0

