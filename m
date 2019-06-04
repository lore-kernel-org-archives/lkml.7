Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BB5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C10E24C67
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trbg0frb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfFDIO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:14:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42549 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfFDIO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:14:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so8639044pgd.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e4QisK5dlRTGLzT7/Rg8a2odjBOSln7PHE3O27n2JN8=;
        b=trbg0frb5Fm6WDCdwfgr0zwTekzKj6RqswMPjQMJ99rO6iHuS2rMNYCBGuDZBGGJSL
         VXvzRWgev366dHO4Ju+XgTk8mr53kJtOrWff7OR0VQAnJN/emszpnUFXpteaSuwy+3RD
         6Qwkhht7EOwDAPmNItBNdWldGbu7b/081rTHGBXxhn6QNbTtdri4hBkShVXhnufArVvu
         iSA9g2TY1ReSSUCGk0krgRSecKARonkhd1Vixw60KDRizzeRGhnvZdMNjC2Kzv9Jwicj
         ujsONmhW4MXoIptsfzomXNoWz5qdGXjZlDUflQJBSlx/unwniaY+PBYp8Xh3aBF1cjOg
         0YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e4QisK5dlRTGLzT7/Rg8a2odjBOSln7PHE3O27n2JN8=;
        b=FOnXyGH1A2DF0nc59v4onJ3bxvK41J8QRvbc8BZcPP28kCP2ZU8GyfhYo1yaTWRp9t
         ayqEXjb74o2qd8Hc0ge07ci2QPLVkYJTAeQA6zycGTiy5SUwStYWg1EX6DqwRZzlvguK
         xUw+a970y5KYMe4Zx8heAh4bPbOErTaq3E0t7K6kx2LDEehGI7QgwnhBV/yR9Hk7sf/4
         70kB3/eKIEFi5c6wpg+IZNnqARVOp6tyYObej5xjv+TfhN9uRPdCiM0fA2KrDAbHWA5f
         HhO5ssK3DYP459QzkcLkkUSvS8iQjaUQr5Tn0DVGxRDCh/A3FES/r04TMAr0iBo5ZqOO
         aT0w==
X-Gm-Message-State: APjAAAXFt9kutMV4d93ixIlW1i9vyfeEd2weEtoBvLcsPJ8Y6DnPkkup
        a+wDZk4ECbEYPKOxWuOEt+LStA==
X-Google-Smtp-Source: APXvYqw4qpyu9spV1elQpgXWUR1JDezR8zWgDrSzwYuh+hIyg/hAg3LaU9yU/tm5hbVZNcFXJ+fT0g==
X-Received: by 2002:a62:d149:: with SMTP id t9mr14481108pfl.173.1559636097966;
        Tue, 04 Jun 2019 01:14:57 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.14.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:14:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
Date:   Tue,  4 Jun 2019 16:14:22 +0800
Message-Id: <84abb6b282b1fbce0c39ebd2b42ca4c18118f863.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some Spreadtrum platforms like SC9860 platform, we should enable another
gate clock '2x_enable' to make the SD host controller work well. Thus add
documentation for this optional clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
index 45c9978..a285c77 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -14,6 +14,7 @@ Required properties:
 - clock-names: Should contain the following:
 	"sdio" - SDIO source clock (required)
 	"enable" - gate clock which used for enabling/disabling the device (required)
+	"2x_enable" - gate clock controlling the device for some special platforms (optional)
 
 Optional properties:
 - assigned-clocks: the same with "sdio" clock
-- 
1.7.9.5

