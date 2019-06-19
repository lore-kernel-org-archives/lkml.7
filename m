Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A5CC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAA821721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPnskNfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfFSSEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:04:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36502 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:04:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so137740plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7m2ha+L8huO4NXvw7qzQc2/yTmlcVlH17yimZLX3etc=;
        b=PPnskNfL6WbL8OyfE6B38CzstmszpK3SrLVfx/RCjS+WMoIyj1X8okxl71X9Ild6mt
         7eBZSFj5KeB31sCt0EaiELblNrSRPZyLvTX6U0q4xTys5O9gj/U80jLtVNt5DWV3P16O
         YSbliiWOCxDzB6RERLkSVdbZFu3CRb3cTBf0jhWjOeLUs3DB65iFNdOblB7qcA9ysuv+
         yMm779CZXH0XDZlN2tYZjxOevcTDiReRCkh1WuLHOjLsdh/FPXkZ3X8/eeGIqZQ+eXZw
         ARgC8t2ttImuMicO+UxicAyE5bZAkD7wQ4Yh9qk/Hafzm7frvC0ylHVAC4iizxIlBPyI
         eQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7m2ha+L8huO4NXvw7qzQc2/yTmlcVlH17yimZLX3etc=;
        b=Ertm3CdV3FYkVXpW2iydHS1xJbbPFe1kU7WhmdON2sgBAa2/6vuOdSntRCbxAEW6w3
         BmYHzH6d1x6FMnddfWwresazyycv1jLVPv+ve9BchRi0x6OfGHAtFN0aIJGeGgcytB39
         DGeT36UXQo1ksVSACfox+6ukSj/EGk4gelwNpchYSoovQ4/aMtH3ab7Mel7q1Lkf/tYf
         WmleKdoiw3dM+K8L5sUtoIgbQBzGn7QhWvFRTzSA8wXGgJNADOyR3xU7wQM3Gi1s12mI
         VEfEgAoofFOWaAHg+fWSIu0LMhU1gnkLvQI/vm2z59U7HiBf70wYVm2dW0JXCdvQ2u/f
         mMhw==
X-Gm-Message-State: APjAAAXzZpT9K263x05OvaBWd1Ouk5CghUH+IZYntHia9Fug3k6SDvK8
        Uo9Y6d/y0kUZmQ0Z4EXtpQk=
X-Google-Smtp-Source: APXvYqx7cDNbvM/pzCoDzfkLBR073ZfulY8LkDyVorgrIitxs6TSkQhay63vh70Brw6w6BxBNH34Fw==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr75041411plb.269.1560967484220;
        Wed, 19 Jun 2019 11:04:44 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id w187sm21152788pfb.4.2019.06.19.11.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 11:04:43 -0700 (PDT)
Date:   Wed, 19 Jun 2019 23:34:39 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: HalBtc8723b1Ant: fix Using comparison to
 true is error prone
Message-ID: <20190619180439.GA7217@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issue reported by checkpatch

CHECK: Using comparison to true is error prone
CHECK: Using comparison to false is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index eb6e07e..768ad53 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -1421,7 +1421,7 @@ static void halbtc8723b1ant_PsTdma(
 
 
 	if (bTurnOn) {
-		if (pBtLinkInfo->bSlaveRole == true)
+		if (pBtLinkInfo->bSlaveRole)
 			psTdmaByte4Val = psTdmaByte4Val | 0x1;  /* 0x778 = 0x1 at wifi slot (no blocking BT Low-Pri pkts) */
 
 
@@ -2337,9 +2337,9 @@ static void halbtc8723b1ant_ActionWifiConnected(PBTC_COEXIST pBtCoexist)
 					);
 			}
 		} else if (
-			(pCoexSta->bPanExist == false) &&
-			(pCoexSta->bA2dpExist == false) &&
-			(pCoexSta->bHidExist == false)
+			!pCoexSta->bPanExist  &&
+			!pCoexSta->bA2dpExist  &&
+			!pCoexSta->bHidExist
 		)
 			halbtc8723b1ant_PowerSaveState(pBtCoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 		else
-- 
2.7.4

