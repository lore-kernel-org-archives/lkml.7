Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3730C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 05:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E222133D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 05:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuUAr0n8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfFPFQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 01:16:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41514 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfFPFQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 01:16:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so3825793pff.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 22:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+nuBJ9f4dkhbGZ0ut/+UiUe+NLKEceMx/7LyP3DsD7I=;
        b=TuUAr0n8xoqntV8JDFYaOXCTj8WoMRADx5SOFlvQX8eeiUrl0v5LFBLbeT0qQSZKft
         BNTVgHkm/15dKOyKyky4fMDx7LLcQxJgsFJScN6zp/K9CcF3ZuPKFFjGf506ieiRcgy5
         z02tq9L9vf4W1uFDdtJIqoCU6Ym8lhRP2NELJrDXAYbhfqAFiiSOeEXeZvNGFlVan4RR
         rOWM3KNJ+3ItmsiDPm4CMVUu4bYlMcRfJdqhVdQL0Hp/cEDhHLKtDcwMxclW/X5nBiA6
         Twjpa4Uj6lwhND4smeCP85XPz56i6kuUbZelanCYNtfOYZ5CEfiCDyvWXfjazZD1QxQ+
         a4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+nuBJ9f4dkhbGZ0ut/+UiUe+NLKEceMx/7LyP3DsD7I=;
        b=JBa0MyyvEA4lWDWl2jVGtesA6wj95zbP6sX9fN3lZd1BGOSet7vljg9zgcWQQZxzbA
         9JegfyO9HSvesGFMjolBjiiQtaXpZ9DmiEl0LOG9ms+jA8yqv55FbTHvEJrNDvV73D88
         szkIYzANUT9SnG4zI3iiUVjQKS3lHJpbXtTDO3h9LvZCIyKBTBxChg/ZUgM2scS8z7cs
         OeWeA/9iNvHfJ6StTixxKkF6A1zCSEWcen0ia1SUCGisJK0PFJ94/qS4+DTVjxouYWA5
         DoRYMmNMa778DO0OVRHlENGHzYK2IWpP8IbBwFC35EazDZR3M3MSlFqj+tigMts9IaCc
         4Vbg==
X-Gm-Message-State: APjAAAVAvTqWNk5rO5pfKshcxFBRUgJ6rpcuQOaoL9hK8jNcZfh/4VTg
        2AyJVVphML9u7Rp2T8wzzulUuvp8
X-Google-Smtp-Source: APXvYqzaLkgQ1lCpEB3AodJVPvf0hYY8zED3KEEWHv555lmDex7XAGPOcuctnWNIUPj4OSUo3sRvLg==
X-Received: by 2002:aa7:9ab5:: with SMTP id x21mr10583861pfi.139.1560662185746;
        Sat, 15 Jun 2019 22:16:25 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id q7sm8638868pfb.32.2019.06.15.22.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 22:16:24 -0700 (PDT)
Date:   Sun, 16 Jun 2019 10:46:19 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: Make use rtw_zmalloc
Message-ID: <20190616051619.GA15036@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_malloc with memset can be replaced with rtw_zmalloc.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 9bc6856..aa7cc50 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1078,12 +1078,10 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	DBG_871X("pairwise =%d\n", pairwise);
 
 	param_len = sizeof(struct ieee_param) + params->key_len;
-	param = rtw_malloc(param_len);
+	param = rtw_zmalloc(param_len);
 	if (param == NULL)
 		return -1;
 
-	memset(param, 0, param_len);
-
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
 	memset(param->sta_addr, 0xff, ETH_ALEN);
 
-- 
2.7.4

