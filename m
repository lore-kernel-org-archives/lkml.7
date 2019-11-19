Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBC4C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B3F222ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142339;
	bh=Ue3nlCV9pACY7BcNK5tekycybXDU3j44z/a2CvMlZ5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Son8s6lk0U9vvKh2Ll0gIQ30Ko/CEEbQViY8izbRW5wKHHISTtBs/8P7uCCP3d6Er
	 PGB4XPjo+eDE5dTrtxIeu/h6HUe4ExxoaxpG/9aEQIQJ0/HCXzpeRtxOXSDQvQ/DKA
	 /TgthT+EcTbZ96H5CjTgGO1i2exTvTVmPRO4mm14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfKSFph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbfKSFpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:45:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CEDC222A4;
        Tue, 19 Nov 2019 05:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142335;
        bh=Ue3nlCV9pACY7BcNK5tekycybXDU3j44z/a2CvMlZ5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yW3bByfFpL7GbN+1LIWpgojB9JriZ0KeAmmAnDmKgXX17uLt1lBP8IqZJoPJmb1JZ
         TDmYvnbMTYW3fcuVv6m7vebGxHK4T4Ap7hYraOXm4IoYiF0Ndd2qOO1OVBZEP3gap+
         /RxDNm4FEf1rsShP0nN+d3WL+b6JPp/FCaXvMw4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 039/239] extcon: cht-wc: Return from default case to avoid warnings
Date:   Tue, 19 Nov 2019 06:17:19 +0100
Message-Id: <20191119051305.197885561@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 962341b54b99965ebec5f70c8d39f1c382eea833 ]

When we have first case to fall through it's not enough to put
single comment there to satisfy compiler. Instead of doing that,
return fall back value directly from default case.

This to avoid following warnings:

drivers/extcon/extcon-intel-cht-wc.c: In function ‘cht_wc_extcon_get_charger’:
include/linux/device.h:1420:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/extcon/extcon-intel-cht-wc.c:148:3: note: in expansion of macro ‘dev_warn’
   dev_warn(ext->dev,
   ^~~~~~~~
drivers/extcon/extcon-intel-cht-wc.c:152:2: note: here
  case CHT_WC_USBSRC_TYPE_SDP:
  ^~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-intel-cht-wc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 60baaf6931032..c562d9d69ae39 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -155,7 +155,7 @@ static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
 		dev_warn(ext->dev,
 			"Unhandled charger type %d, defaulting to SDP\n",
 			 ret);
-		/* Fall through, treat as SDP */
+		return EXTCON_CHG_USB_SDP;
 	case CHT_WC_USBSRC_TYPE_SDP:
 	case CHT_WC_USBSRC_TYPE_FLOAT_DP_DN:
 	case CHT_WC_USBSRC_TYPE_OTHER:
-- 
2.20.1



