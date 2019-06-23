Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B29BC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30358208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa3y6g2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfFWRIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:08:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36364 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFWRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:08:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so8108625qkl.3;
        Sun, 23 Jun 2019 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWbpdOWa2VAaOy7TBQJIB0mdhzXn8ThTxSUPFXUXBbQ=;
        b=aa3y6g2Nw8ksIoN8BqN9QmNd31rUi43vg/DgdebaWOvLxryFzyjp20wkY+FQxfxwML
         8aodWMN5XWS9Poyha9pr4ZHSEfjczw1qY/pRAZdsRJyG+jegxkirWaRZCueWXSSEoqzn
         QX1nVCh3Ty8isIYuFQ9fd5e96YWAS2MAEQJumYbQ8KmRepK333AdZc+jUNfncVIuKBYV
         c4kjvW0LE0oePDGl+QWZ2x+RT5SrWJXJ8sZgDaMmthomraShAeXzg0qtp48x9Rrat4UE
         BNBq1oajdv9S1cmNYb+P245CF/j9SkHXOYuGDqKNtorukUkJB7wpRC3zJnNkvAk6whJf
         R+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWbpdOWa2VAaOy7TBQJIB0mdhzXn8ThTxSUPFXUXBbQ=;
        b=NRzK7PvjiIng2fhEqZwroghCOvvUfKK2ZL3gxBRRQmaDcbYz/+OdZHKoPu38SPgBj/
         DXdfnfuH8g/M5T0siDWYmadtbvuf+eXHLTwO6p7lidsPJSuzCdqnzd9uYoZq7XLVsaZj
         1MvDX4wdugE2KX+2bEhfqCQZ7Mt1azkGohzmL3+z0DiSYmg+wL4Lf3g4TzkzSHhMPx+d
         LclzQ+VIClY1rWdYRMj67a8FZfqFnrR1WIQe6ILaEtKW++yg6NHe3ILZfCsO9aFnPELQ
         ou1sMc2bbjDBbB1vKUafS6OppGGsfKaw+QFsIzAsJOo91LdCl+XPmY+Ma5p4kjv/GIQQ
         dciA==
X-Gm-Message-State: APjAAAXAjz3fbRTCPF3p6T6gnKZ1vqTcQvgYfCa3gaAlfGdxwhoHAycd
        QvQ8SOh1LNbDvvo3QlIhfpw=
X-Google-Smtp-Source: APXvYqx+1ec4v3/7UU8yLHx5v2GXXVgIULPg46guW2MEBU9mINdiJSZcHlLwyobTxTl/7kayLNkuNA==
X-Received: by 2002:a05:620a:1425:: with SMTP id k5mr116716857qkj.146.1561309688364;
        Sun, 23 Jun 2019 10:08:08 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id o54sm5790756qtb.63.2019.06.23.10.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 10:08:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ARM: tegra: Enable Tegra VDE driver in tegra_defconfig
Date:   Sun, 23 Jun 2019 20:07:25 +0300
Message-Id: <20190623170730.5095-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623170730.5095-1-digetx@gmail.com>
References: <20190623170730.5095-1-digetx@gmail.com>
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

No changes since v1.

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

