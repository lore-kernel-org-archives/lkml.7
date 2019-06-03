Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C19C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E20525EBC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcxGCM90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfFCX7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:59:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36604 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfFCX7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:59:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so3360470ljj.3;
        Mon, 03 Jun 2019 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luWRPxWhb+G3yPkr3PP9NRgLhfVseUu5B2z5OZUhM3o=;
        b=fcxGCM90rTP+zlwwrCbXMQYeXpSk0p/a/v/YuiQQeL/EIptiApw6f1rXKRV2Pe7c7J
         KSkBtSxx8SUU+dd0NcIUr7wOhv9jynaIIZaW/nR37gf15ilu71UN1INP1WlBKnW0Wb2p
         XTyxoeSyB1JO1oeQWd0pP+e+uz5+pixH0pT+H4TejNwTomvv7qQQ9nVu6HBvsfZ94KXD
         ld5lLg4ZzlZLD3V+HwqR8mTeyFX/UtyZPeNTo7rfPp7DowtxxV6lsLP9yS0tszKlimhh
         uSWfsM+3Pm/c54DssYhN5TD/hrhEunlROB7CDN/ua3nbgyW+mLf0b8yeo5QNojFub79i
         ajqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luWRPxWhb+G3yPkr3PP9NRgLhfVseUu5B2z5OZUhM3o=;
        b=NLkhbZN4GsV5RHDahr5HAZNd8cuK6HuLrZerI9VkNMlSWE4oCKkLjXwx89on4zYZ5p
         HgId4XYKRryxw/J+2RA/KLN5CW6/fqie/QGR9eljR7AggUgHaUB7PXSttbgBuc3YEbeP
         PuI6lrNB0Z94AsM5wZIARAZ0lYbuVt4f3SzHm9D+bEhmCtCTl8gXzhHMrNS/gmHPIaVo
         MEqDcRIV3nVAqcwCAn/bRo5s1+418s+Dlyi5kD4P7qvSDSo0zLkQoi+cilxyHYOmqolH
         K1P8HG59//n0MVudmYy5VzXFGc7slgfEDriaSa33vCVDjVrfDJz9DlT5sxKtOejXJj8A
         +PCQ==
X-Gm-Message-State: APjAAAVA6RMLm3naaLBGgYwfEr/R8IMwkQys93HVdlY68MCeAF7VLXRi
        b+f76NdTqS/kLWMmBMJZzBQ=
X-Google-Smtp-Source: APXvYqyyKCNzugGJtKKvB+yQ60cZpCdi3TZR8D97JmO4VPjZERYGo5FCSPP0Ji5dTd/yvRcUVAx7Qw==
X-Received: by 2002:a2e:5dc4:: with SMTP id v65mr7915041lje.138.1559606390034;
        Mon, 03 Jun 2019 16:59:50 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id n7sm2943151lfi.68.2019.06.03.16.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:59:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] regulator: core Bump MAX_COUPLED to 3
Date:   Tue,  4 Jun 2019 02:59:00 +0300
Message-Id: <20190603235904.19097-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603235904.19097-1-digetx@gmail.com>
References: <20190603235904.19097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA Tegra20 SoC's couple 3 regulators, bump the MAX_COUPLED accordingly
to support that case of coupling.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/regulator/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index dfd8e518b283..5e81020d66ae 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -15,7 +15,7 @@
 #ifndef __LINUX_REGULATOR_DRIVER_H_
 #define __LINUX_REGULATOR_DRIVER_H_
 
-#define MAX_COUPLED		2
+#define MAX_COUPLED		3
 
 #include <linux/device.h>
 #include <linux/notifier.h>
-- 
2.21.0

