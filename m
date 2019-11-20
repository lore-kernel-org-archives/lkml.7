Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0352C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8519520692
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ozv7hJZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfKTPpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:45:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39236 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbfKTPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:45:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so14000243plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LB0mFTtKkHmo2cL12xdptGbf+C8Nvz2KFyNdinT86Hs=;
        b=Ozv7hJZqH8HGUR9P7JW0bGRieZObuXO21O+rOP+m+JocLXsFbjmIS6wZqm2AAlU+ns
         tO6Ukn+1PEnZi1PyTTv/o79FJhchMEw+I02xkgXAocUiVyy1QPPcXYNGr4oeEZ7eAADS
         /q2CKsqN8t++k8KFeA+U8Ykfs+Yi1UHvZQxH3ad7wUea8s0STHkCYkxxj5+DxgDDMVJ0
         UfC6nlhol5VLPIaphGXQLYuN+3g9u38AgNbOWe16OyZIzBIaDVUe/ZJJU5XW39KBPFSB
         pvzEvWKJcd/yolqJz/n+1tX1QL9gEQQw3GQTLdBnqqoOSUM7ZwfFcHota0z0NYHrmcG4
         +M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LB0mFTtKkHmo2cL12xdptGbf+C8Nvz2KFyNdinT86Hs=;
        b=jrGcl3KgIzU3nTp8UiLSTWGDPaHUA4rPrO0/JdlCmLnDWLny8qYVqHqT5E0wTNv9eY
         QFOiV5VOg9JDKQOYXDc2q7eYs6iU43JhiYbZvXMrlU8+9v/Lh9lj8Ixeqj5PL+MA+TSk
         W2GSDhjgdn0toqNsHZY+d2Z1Xr4JBLiiWIEI7uqRwR3vjQEYqd6TgpHa+wXzHgNMcxUc
         mObKowBp4UbLGTe0Hpv70Fp56h92kaWDjD16GsP52/2ij+KYxVA+h3adi8Itqytc+Asn
         3t46LUAaQa3Pj27GUVyAzdb+8VgVcXI0v59Sm4YgpqODbEnEgxvPJ9CPX3nbPw5pCdEe
         AUAw==
X-Gm-Message-State: APjAAAXNmfXE00+MH6DGyBszYhmLQFVHHvuUiuqI508IR34UDPtoz8fK
        t3Y2DNicoNN07+WzLdUR5gbM45hZEyXzBA==
X-Google-Smtp-Source: APXvYqyB42bSl+V4AlIGVMjAxYwx7VypP3HVgpqXRen6G2VGgOnmLvy7kE8oL/ksozcdL9YR6IvUBA==
X-Received: by 2002:a17:902:7287:: with SMTP id d7mr3666727pll.333.1574264742918;
        Wed, 20 Nov 2019 07:45:42 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id i102sm7833530pje.17.2019.11.20.07.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:42 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 04/11] thermal: devfreq_cooling: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:13 +0530
Message-Id: <7059d82472fe12139fc7a3379c5b9716a23cce5c.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the following warnings with make W=1:

linux.git/drivers/thermal/devfreq_cooling.c:68: warning: Function
parameter or member 'capped_state' not described in
'devfreq_cooling_device'
linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Function
parameter or member 'cdev' not described in 'devfreq_cooling_unregister'
linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Excess
function parameter 'dfc' description in 'devfreq_cooling_unregister'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff..a87d4fa031c8 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -53,6 +53,7 @@ static DEFINE_IDA(devfreq_ida);
  *		'utilization' (which is	'busy_time / 'total_time').
  *		The 'res_util' range is from 100 to (power_table[state] * 100)
  *		for the corresponding 'state'.
+ * @capped_state:	index to cooling state with in dynamic power budget
  */
 struct devfreq_cooling_device {
 	int id;
@@ -587,7 +588,7 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
 /**
  * devfreq_cooling_unregister() - Unregister devfreq cooling device.
- * @dfc: Pointer to devfreq cooling device to unregister.
+ * @cdev: Pointer to devfreq cooling device to unregister.
  */
 void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-- 
2.20.1

