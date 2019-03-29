Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD06C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3974A21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZ+hpd2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfC2IsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:48:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46836 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbfC2IsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:48:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so1498678wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=64Gj8AZf4WhRlwdxGg8gYpmTlFLWTDISbuiVXutzY60=;
        b=bZ+hpd2HLeihVi0tceluPm814OLhZI9DiZmDTLTdqgtCqEfP9W/rPES722d523v+bs
         NCTmQJuzhCJF9lIhvMigGDKKvbeQkr5hxM3nP45+5EoiFr/r+wx1TEUipR1fOe3fm3a4
         iYYzvJQrQPWOTbiZ+Q7CnW6QPIgzArNFPaH/QOifBxiy28RtpXSCjKg30860ulsimt/p
         h7vfqckD+/UQbSJ66okzbh5c0kRgyti8/JIKcuXpPkOQMT0pjo39hp6ler4d50g6nbhr
         kQn5H/H1ebZUz3NEkRi+QUasyQOF2+s94uj2VQZHZkjALPaRtxr/OShJTTK6+qXFERvf
         iAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=64Gj8AZf4WhRlwdxGg8gYpmTlFLWTDISbuiVXutzY60=;
        b=fghv/QSQQKFUTUnXTxY2eQKP5wmOFZQZNDrg8WF8xLaBGdGwa9J3wjdw0TJZZ86Z/Q
         EPm6ecptulglltGexCwD9dd1Z505Vl03Y7B86Ts+2Tz3EW4PFOXHmVENyZvKcbBjoh8F
         YuLW2CV0AZ6+271gQaZOqt4JraYbOD0aB85XBr5UaREn08MXVrBimgXVIP2ZOoFg0XZD
         6+OLjqsnk3KYtHMFxLo3XDlhLSYIbYEcOykgZ0DGc8Atl0XSEmQl5edgs6BDW7UEXC5B
         gVNtaEqJ5J4niPvDLqpOHJw9eAqgMwSZ1O24JxnhisH/pSB6mF2vptSAfToj7i7xRwPs
         4VZg==
X-Gm-Message-State: APjAAAWbHFcUkQpUjpGrdfCdEsRcKBQ/WBmk/4crla0fF+KcXsqb+DkC
        2hhIV08vCWGzJioFBSc3b2CoqAdb1aM=
X-Google-Smtp-Source: APXvYqwIeqllupg+IQfzA48pKPHjKKVUTGXW0uOrefNuxsZYJv+et7HrHS/gNMyOtUQc2HCzWTF0Ag==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr29550242wru.11.1553849286886;
        Fri, 29 Mar 2019 01:48:06 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id x192sm2214806wmf.48.2019.03.29.01.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:48:06 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org, joe@perches.com
Subject: [PATCH v2 1/1] MAINTAINERS: fix typo in file name
Date:   Fri, 29 Mar 2019 14:17:59 +0530
Message-Id: <c89ce5c4e66de489bb089dd60cd8a26949501a59.1553848972.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553848972.git.amit.kucheria@linaro.org>
References: <cover.1553848972.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e31f941cf977 ("MAINTAINERS: update list of qcom drivers") had a
typo in the filename, replace the underscore with dash.

Fixes: e31f941cf977 ("MAINTAINERS: update list of qcom drivers")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..d2c5852a3c8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2007,7 +2007,7 @@ F:	drivers/i2c/busses/i2c-qup.c
 F:	drivers/i2c/busses/i2c-qcom-geni.c
 F:	drivers/mfd/ssbi.c
 F:	drivers/mmc/host/mmci_qcom*
-F:	drivers/mmc/host/sdhci_msm.c
+F:	drivers/mmc/host/sdhci-msm.c
 F:	drivers/pci/controller/dwc/pcie-qcom.c
 F:	drivers/phy/qualcomm/
 F:	drivers/power/*/msm*
-- 
2.17.1

