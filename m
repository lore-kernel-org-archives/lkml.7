Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D32FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26098208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142286;
	bh=BVN4guRbz7t3vPSsHyZRa9cgH9ITtQ3dmc9IWsNpJng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B6ECtLbQ3NO8JHiNyIkIWOQKLbYcjUg9wYBWW3KB6rUP6dN/LGmQxPE2pxcc0Oc+L
	 C2UB/Z6iHBE1xt85K6eNdMXmLp4osWuu+zvVARC5qcdJddDpyGqZbGfBqH27+BaWnT
	 p8V4Dofguyok45wOm1mljoK6YIqyn0srPyQ5Tnss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfKSFop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730868AbfKSFom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:44:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE8922082F;
        Tue, 19 Nov 2019 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142282;
        bh=BVN4guRbz7t3vPSsHyZRa9cgH9ITtQ3dmc9IWsNpJng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InBarMxdIzjCRn+VNfz2jo5Bn6PfYbeBObN92FuQvpiKM6ypeddOUg9walcAONVS2
         sxS++v7kBmdkGSjEoA3LplEbWUMOfmPhLu8J989WOL2wVB0I7N4v9Mtirf21FkIwuw
         9M8HzutUls19J1/02ZFtKL3cpFHbjH22EawtrgT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/239] iio: adc: max9611: explicitly cast gain_selectors
Date:   Tue, 19 Nov 2019 06:17:08 +0100
Message-Id: <20191119051303.105712987@linuxfoundation.org>
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

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit b1ec0802503820ccbc894aadfd2a44da20232f5e ]

After finding a reasonable gain, the function converts the configured
gain to a gain configuration option selector enum max9611_csa_gain.
Make the conversion clearly visible by using an explicit cast. This
also avoids a warning seen with clang:
  drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
      enumeration type 'enum max9611_conf_ids' to different enumeration
      type 'enum max9611_csa_gain' [-Wenum-conversion]
                        *csa_gain = gain_selectors[i];
                                  ~ ^~~~~~~~~~~~~~~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index c61fbf5602718..33be07c78b96f 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -289,7 +289,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
 			return ret;
 
 		if (*adc_raw > 0) {
-			*csa_gain = gain_selectors[i];
+			*csa_gain = (enum max9611_csa_gain)gain_selectors[i];
 			return 0;
 		}
 	}
-- 
2.20.1



