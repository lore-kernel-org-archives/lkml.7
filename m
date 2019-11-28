Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745EBC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49975206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jS4vAou0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfK1FKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 00:10:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35129 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfK1FKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 00:10:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so3811448pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 21:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QO/lP+KDcMBuBF0dCbiBImn3ahE7Jw+zkWapBF57MgQ=;
        b=jS4vAou0Kr4VlWLGW46xQ2mOeWEBO9xSfclqVZzZY6prqeXpGcE4q3l3Xx5PLk79oZ
         yt8FdpGPdNdZ2G8OZY9ofcFQ6RHGR/f2dmna1niRT8P5LRmymIw7yNiS+X9eeNUaSlKM
         2+Gs+JwPGWvX/7EfC2IcTHHOGHpS+4ftgU3cqPhiiDhxJSkfTu79VkQa1UQCn5whtfc+
         WdfrCLD+xeu9oUM2RU6+TnqnRiKNvRf/UlbT/bVixd63o8ou4RXmjFL54TiWbfOqRbP0
         3zICwN84cBLfHoYmUrXv9WU5uVkpPXB1CcpQ3HCpuvkP5D8mwXDwQ75SxOO+wqV2yqcB
         tXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QO/lP+KDcMBuBF0dCbiBImn3ahE7Jw+zkWapBF57MgQ=;
        b=KHQY4Yq+1eB09KXeW7Wy3RbtoWgWJLr3ep9RTT4tUFPwRor214bXEPt7JZmmgRaEeh
         h5Eop0ioT4O2FSulpwxsXRQh/FsN4AjKYhLwmEMMlrIFLviW9ZTTri7OYdzKA9wIkLE/
         gtb1Dn60juJMMbk9nWt91J10uAjjYcO9ezE6hT/F2p8aTpKVttxEMHeFuNhUTPwTd0ut
         tqurAzRF7Dx37PBfMkNuvnO53Kq4SUTMVfImenlLEvx1p0Vj9agsHz5jqYRD4bUB7NX7
         o8fj884Lo4OkCsKQcVJwPBcVhLk2CTiGX9dbagRHKImH3A9cUedQ6gdGU+1qx7k0pswD
         7w3w==
X-Gm-Message-State: APjAAAVEozi6HAKbTmrMAJCkUITqGNLAQLXq9BxM4sBRN1aTpxcBi5ZM
        AeeHD/dYV3lYA9lxnZCNiWcUHAjEo1Q=
X-Google-Smtp-Source: APXvYqxGPRbiVlZZUV1rk9y+AqcuPPIRI6ejj7HTdsPF3VM9U1EQBetfUhFQXHuhzrFwXyT1lX4LXQ==
X-Received: by 2002:a62:1488:: with SMTP id 130mr3242980pfu.238.1574917810740;
        Wed, 27 Nov 2019 21:10:10 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j20sm17799838pff.182.2019.11.27.21.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 21:10:10 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 6/8] usb: dwc3: Rework resets initialization to be more flexible
Date:   Thu, 28 Nov 2019 05:09:59 +0000
Message-Id: <20191128051001.18995-7-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128051001.18995-1-john.stultz@linaro.org>
References: <20191128051001.18995-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 core binding specifies one reset.

However some variants of the hardware may have more. Previously
this was handled by using the dwc3-of-simple glue driver, but
that resulted in a proliferation of bindings for for every
variant, when the only difference was the clocks and resets
lists.

So this patch reworks the reading of the resets to fetch all the
resets specified in the dts together.

This patch was recommended by Rob Herring <robh@kernel.org>
as an alternative to creating multiple bindings for each variant
of hardware.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I4a26492f19e857f3f9f29bcdab81458016f70977
---
v3: Rework dwc3 core rather then adding another dwc-of-simple
    binding.
v6: Re-introduce this patch, on Rob's suggestion
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c6316d4b7593..19504b907476 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1462,7 +1462,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
+	dwc->reset = devm_reset_control_array_get(dev, true, true);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
 
-- 
2.17.1

