Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF1C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4696F20866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qwUETuKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCIEyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:54:08 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:42350 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfCIEyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:54:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 68F79D3F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fJSEMFZuCHQw for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:54:06 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 3851DCE5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:54:06 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id r21so17330593ioa.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3JMsAjn5exKlEerExLOrVHDarRBcXTjOMDi86JDw2+U=;
        b=qwUETuKDZcJpVArTZNRUR7RtzUtuWhESAeC/SVjN5jngLhqSRyOtseAcd7y66Y+eKi
         C5o478MXZGkVEUW2mD9//BO8XDwnuihewujQl8MYZXMhbvfvqy/bbyTOTB9DwczowoUd
         Uec5IE93ZK8X+O4cIRhlD29+3Z1QH8ppnqDgxzuXLW6d0hNzrDtcPLpq2PUK0rjTXkPb
         9vsXpCoOIC8LOLQcYRrWmWm/jf5hnjz0gQRMfzkw9P0nGTombENY5Q3/z+/PMQcOV5DV
         C5wEDGjDBXj5mFFPf/dqAjqorJvqcmB/PngazNu1322quyNbh2FiID4zktaf/U+ci4ii
         pw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3JMsAjn5exKlEerExLOrVHDarRBcXTjOMDi86JDw2+U=;
        b=mKAeMuMfaXchBhS4xl0kP/XF/S7/KhRAmTgjEowP7Eg/8hoEPLt6df+9miZMQTt+W+
         T5tmScvZu81rCsYjQ0AcTYGH+8NLHFHGRaIKQoYxrUIAN/SXnIVGpjcyxXVRCoQAcbVV
         dhdPU507a+6xQ6OSoaC8veHJz09O4kUODxI+svmFg2vf4WlPD7mFJZ9Gk35g4M23QR+k
         Xn9j2gWPg79aZOYxSbKQVOwBvpu6At/dp95Clsg8UYFktXa7siBZMcT6SSWD3CmIuu5U
         ou6c4/H0MS27JS3RfeHuR/c0i6eBOTnc9AZhr+gyITqCqPZm6782lEHIGv90arGmC5Sa
         VPpA==
X-Gm-Message-State: APjAAAVMihkrhEbY4nKmvLFTO3xSu9Z0YGY/nqkgZ+oqQNeiaOlhWHG1
        kBB96aX5N/JO7yO48PYoO01XU3AHI7ZIDR3Tdh13Z6XCv7OMnfpvt7E79nZeuIih9EuJ6SDjobF
        q58fBZGAFe9KFCfQZOoZjTd8R8kfg
X-Received: by 2002:a6b:ef12:: with SMTP id k18mr4326323ioh.171.1552107245822;
        Fri, 08 Mar 2019 20:54:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqy981E6VHOFnqLjR1hxMuSwXGxvkzEZIe67wYpWJ8FCYIcLhFDQIYTmuWZJ0uxZXqEzYJQvRQ==
X-Received: by 2002:a6b:ef12:: with SMTP id k18mr4326311ioh.171.1552107245568;
        Fri, 08 Mar 2019 20:54:05 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id x84sm4827153ita.32.2019.03.08.20.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:54:04 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: fix a potential NULL pointer dereference
Date:   Fri,  8 Mar 2019 22:53:55 -0600
Message-Id: <20190309045356.8892-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_iio_trigger_alloc may fail and return NULL. The fix returns
ENOMEM when it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/iio/adc/mxs-lradc-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index c627513d9f0f..5384472b6c4d 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -465,6 +465,8 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
 
 	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
 				      iio->id);
+	if (!trig)
+		return -ENOMEM;
 
 	trig->dev.parent = adc->dev;
 	iio_trigger_set_drvdata(trig, iio);
-- 
2.17.1

