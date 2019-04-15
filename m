Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9028C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4022075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQR8yVRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfDOO4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:56:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41478 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfDOOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id t30so13320321lfd.8;
        Mon, 15 Apr 2019 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rx+zmmGbIXgJpBnbNkGTY/ON6s4vt2Iv8cMQUjYpFd4=;
        b=nQR8yVRuiCUtMHfnGH2RLrGTZEtNHyclqLTlR36QiiWfzKqYxyD7xiFEYwwdXpz6O+
         rHg4T3yP3JZaVHyfIBoo1w9RDZagSEQqoYMbbvaK0m2vIn84v9Zoof6fROK43LXaHQdq
         l/CPEF4zt9ep/r9JFqexuZfFm9p3n6ojjfdCs1d6OeSOkrinRUKV5TmrZN8qJva79AvP
         NQUSKeO54LSUkGcdwplfHRCKf8qT4Nts0CPdxmTaAVqnewfDEemU1kzUAIs/KmbIl/B5
         ZReXk15YR9JrvxDSj81dEQ1jwWFpyX55LVMnC4zJejsgx+TC1zvw6/ZukQTvzPp3VTam
         KGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx+zmmGbIXgJpBnbNkGTY/ON6s4vt2Iv8cMQUjYpFd4=;
        b=MSai3Gdea+NboC3dLBb250b6Qm/LII3s6F1VWN+tnMXK0yoToQvq/BS0vIuqsh4DAC
         6GxTUeORHSzGobQz1Li+oJPFoqDEqhd2Gk5OtkTi/VEiPVVQyIEOhUCFT8ZNpFuLYQZH
         MS4g+Pn6y1LMkBpNngv2vIW+3u5+w/vJvL9S9MSyw4Ak1eVaOBjNQL4nuiVF215Sp9T1
         fhC3+SqaCLlvD1w9zQ5swmrdPrDVfGiMjvhdHMxzlpYDjaJsbVK7kXj2Aq8RLPKXGJYP
         L+Mt1Q3bQ8lYUe8INVju6G6w0EA7OVdISDLdOzNIxMpB+eCxT0sdq/oc73CijwKMBSU5
         9M0Q==
X-Gm-Message-State: APjAAAUUV2sfOulpMvcbjayXP5qfR/IFPN5ZG49rYmpdxJJpBqBfvOHj
        DFfRW54uS9+XqkNZRJ/G0Vk=
X-Google-Smtp-Source: APXvYqy7Q/jQlcTJpZnScZQKbX71sMfRoDXTLbCJaw+eaKnwB+o5Bwjbw57xoLOYwyKkfHDI1oFQPA==
X-Received: by 2002:a19:3845:: with SMTP id d5mr6307275lfj.77.1555340155535;
        Mon, 15 Apr 2019 07:55:55 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 18/19] PM / devfreq: tegra: Enable COMPILE_TEST for the driver
Date:   Mon, 15 Apr 2019 17:55:04 +0300
Message-Id: <20190415145505.18397-19-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver's compilation doesn't have any specific dependencies, hence
the COMPILE_TEST option can be supported in Kconfig.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 78c33ddd4eea..bd6652863e7d 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
 
 config ARM_TEGRA_DEVFREQ
 	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
-- 
2.21.0

