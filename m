Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B1C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F0F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FIzE/crp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFNGxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:53:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49834 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfFNGxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:53:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190614065305euoutp02c73808c461fe90a8b29e6ef35ea5b750~n-hptJzfh1797717977euoutp02F;
        Fri, 14 Jun 2019 06:53:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190614065305euoutp02c73808c461fe90a8b29e6ef35ea5b750~n-hptJzfh1797717977euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560495185;
        bh=T/897ffO/UeNImnMGoYZqvW9BMN4qL2AJzoKTbQUbMk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FIzE/crp6pNNvCFAFH5syzqWDWs8tSMRNEh5XVPAPklq+C0Ku+no8HjFwpH6vJL7V
         AbjzyM8sRdetPtCdJtAnN82blaL6uPDFLZLSr+dOsfVmVtEhkEbSQ83/eE6r1wDco3
         efiYRjiSYQU/fKhtKMoQYkd55S1YmCLQpXdPzH5I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614065304eucas1p17bdedd73d25a018f3a33a205866274dd~n-hpQTzhD1340313403eucas1p1y;
        Fri, 14 Jun 2019 06:53:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 83.77.04377.054430D5; Fri, 14
        Jun 2019 07:53:04 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614065304eucas1p1ad98abc5c0f5e5e94fa43bed7e7d0e4f~n-hoklhSx0061500615eucas1p1y;
        Fri, 14 Jun 2019 06:53:04 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-50-5d034450069d
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.C6.04146.054430D5; Fri, 14
        Jun 2019 07:53:04 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PT200GBBTSBAO70@eusync1.samsung.com>;
        Fri, 14 Jun 2019 07:53:04 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs
Date:   Fri, 14 Jun 2019 08:52:53 +0200
Message-id: <20190614065253.9622-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7djPc7oBLsyxBod7lCw2zljPajH/ZpJF
        46+97BazZpxmtTh/fgO7xeVdc9gsZpzfx2SxaFkrs8XaI3fZHTg9Tq+/yeixaVUnm8e8k4Ee
        fVtWMXps2f+Z0ePzJrkAtigum5TUnMyy1CJ9uwSujCenD7MUvGOvaP3+i7WB8SpbFyMnh4SA
        icS+HT1ANheHkMAKRonNP29COZ8ZJS43dzJ2MXKAVf3/7w0RX8YoceXhRSYI5z+jxPP5x5lA
        RrEJGEp0ve0CGysikCBxZPN7ZhCbWaCPSeJ+uyaILSzgI3F0014mkKEsAqoSi8+XgYR5BWwk
        Pr1dwgRxkbzE6g0HmEHmSwg0skmcWf8Q6ggXiSUNfhA1MhKdHQeZIGqaGSUenlvLDuH0AF3d
        NIMRospa4vDxi6wQR/BJTNo2nRliEK9ER5sQRImHxIHOl+wgtpBArMRSoPsnMIovYGRYxSie
        Wlqcm55abJSXWq5XnJhbXJqXrpecn7uJERhnp/8d/7KDcdefpEOMAhyMSjy8B6yYYoVYE8uK
        K3MPMUpwMCuJ8M6zZo4V4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUI
        JsvEwSnVwBiwKPAAz0GGBb6/pBI/FTJtZpvF4G7Coivm4124qOFJQfbFsxe2bli/9eXifVX3
        Sww7TD++CbzxvzFFSfx9jsiOV/HfOTdx3lbaEHrqCtf5i9Vae6tuFFpLz9q4X6zeFqjIz/vK
        84pNMmpGpWzpc49e/iWzwXRn5VwBmQkbkmy8XL6WHe0+r8RSnJFoqMVcVJwIALDKyFyvAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFJMWRmVeSWpSXmKPExsVy+t/xy7oBLsyxBhcOsFpsnLGe1WL+zSSL
        xl972S1mzTjNanH+/AZ2i8u75rBZzDi/j8li0bJWZou1R+6yO3B6nF5/k9Fj06pONo95JwM9
        +rasYvTYsv8zo8fnTXIBbFFcNimpOZllqUX6dglcGU9OH2YpeMde0fr9F2sD41W2LkYODgkB
        E4n//727GLk4hASWMEqsWdfA3sXICeQ0Mkk82OYEYrMJGEp0ve1iA7FFBBIklrzdzA7SwCww
        gUliz5nHYAlhAR+Jo5v2MoEMZRFQlVh8vgwkzCtgI/Hp7RImEFtCQF5i9YYDzBMYuRYwMqxi
        FEktLc5Nzy021CtOzC0uzUvXS87P3cQIDJFtx35u3sF4aWPwIUYBDkYlHt4DVkyxQqyJZcWV
        uYcYJTiYlUR451kzxwrxpiRWVqUW5ccXleakFh9ilOZgURLn7RA4GCMkkJ5YkpqdmlqQWgST
        ZeLglGpgtH0Qf8/h0Fe+xw15vpuc84Xsg8qzylcx/GqaotM6/0Kaiv//MM6Sdfkz9nMvP8Ky
        eLWcRVnSDfm435/6D1TfiXumdfSHxxHtU2IyUclbKxbvSc2QFeI+7S32zecy/46Si3O6zys3
        fBSLnvBwjY+CYI3m4pJn+lzxes55KRo/vx+YvKSY/66wEktxRqKhFnNRcSIAsj0Jpw0CAAA=
X-CMS-MailID: 20190614065304eucas1p1ad98abc5c0f5e5e94fa43bed7e7d0e4f
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614065304eucas1p1ad98abc5c0f5e5e94fa43bed7e7d0e4f
References: <CGME20190614065304eucas1p1ad98abc5c0f5e5e94fa43bed7e7d0e4f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Exynos SoCs require to force UTMI width to 8bit, otherwise the
host side of the shared USB2 PHY doesn't work.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif with phy_utmi_width")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
---
v2:
- added collected tags
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 6900eea57526..9ece4affb9d4 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -76,6 +76,7 @@ static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
 	struct dwc2_core_params *p = &hsotg->params;
 
 	p->power_down = 0;
+	p->phy_utmi_width = 8;
 }
 
 static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
-- 
2.17.1

