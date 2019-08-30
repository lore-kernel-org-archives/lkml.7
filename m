Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A929C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3899921874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MwE8AnR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfH3AxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:53:25 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.228]:11333 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbfH3AxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:53:25 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id BCE7A364AB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 19:53:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3VAJiTqSN3Qi03VAJi8tiF; Thu, 29 Aug 2019 19:53:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zQhe90SNY9f5AafpNYwkineQK94njNMtAKBDMRbRfZA=; b=MwE8AnR/nsZQGJ+DAc/zeRIj1W
        Q6kalLNRhpjEPgueSdl24hp5f2Z8bzjBCF46oXuclDaxYslBy2/4Vov6VEV86Gmq9gMO0NUhfQM8b
        wRl+bxuxtPYjjfXho0ubrCSJIkysD/8UWxw17zu4d52VaSKPpi3yFX6wz4SU9kkH5htGeNJ0mDWrx
        g49zBA2YHTzRmAywCae1/GJ0rHIpLzw0tCFS6poaHcuQCCo+q8eAYs9H+65DiNFne5QJA7xE0J6dI
        kvELn1+gtHUacKIAyRdDwrVgh+WZO5Uj3WHkrU41WilN1HMUlF2m8oB8whEXsot09SMU97H5xpVki
        eD+Z2RGA==;
Received: from [189.152.216.116] (port=49566 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i3VAH-000W2Y-Rb; Thu, 29 Aug 2019 19:53:22 -0500
Date:   Thu, 29 Aug 2019 19:53:20 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] leds: pwm: Use struct_size() helper
Message-ID: <20190830005320.GA15267@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i3VAH-000W2Y-Rb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:49566
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct led_pwm_priv {
	...
        struct led_pwm_data leds[0];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following function:

static inline size_t sizeof_pwm_leds_priv(int num_leds)
{
       return sizeof(struct led_pwm_priv) +
                     (sizeof(struct led_pwm_data) * num_leds);
}

with:

struct_size(priv, leds, count)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/leds/leds-pwm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index d0e1f2710351..8b6965a563e9 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -65,12 +65,6 @@ static int led_pwm_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
-static inline size_t sizeof_pwm_leds_priv(int num_leds)
-{
-	return sizeof(struct led_pwm_priv) +
-		      (sizeof(struct led_pwm_data) * num_leds);
-}
-
 static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
@@ -174,7 +168,7 @@ static int led_pwm_probe(struct platform_device *pdev)
 	if (!count)
 		return -EINVAL;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof_pwm_leds_priv(count),
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, count),
 			    GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.23.0

