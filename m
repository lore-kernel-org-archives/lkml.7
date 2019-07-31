Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A811206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="avbVjvMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfGaKfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:35:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42269 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfGaKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:35:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so31618188pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xp/W8ZTYuEqer12ai3NiDJg4PMDw8fKy9ZdPilJWoCU=;
        b=avbVjvMuJowWAvhzBE0eK2ZNV5N05z76jBJNXrAViCbe4s8BE8tl3E/0EsaOzluxy0
         z6583/YHJSoBt15HT+6lebxkKLxW+oftiyWPeYfyykJy7zbamWrqhdNn/YzzxV5JUqtS
         e2SIxZZX4kh1VcfOmf76FX+6CL4ewE/rwvDa55Ln9Mi4EbuMiQjWL8jnpLYnFWwYrOBg
         QB3yMarTBJ0StFM2x8NoeT1gIDWE/qNrqJtdUjqRV70n0zdrUOpeC+Kg/I8+bnirb/kV
         xBmepOYD7+pUoFfZ0odeQ+kOuBkbqmmA7G5Ukrr/+hovZnMsCYP0nQbRu87JfBHiaWkE
         fHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xp/W8ZTYuEqer12ai3NiDJg4PMDw8fKy9ZdPilJWoCU=;
        b=P5FC5/PhB4Rcwm4ACR3k7BWuXPa0vdnnO1FI0uFdEN6jZ+DJsFE3hBKgk1l6USQM2c
         OsiDorrp4O2VIJddUZT5peil7IpQ72owuuqb20NCqh+sw513B74iqZaC2DEzX2hSYbkC
         fmG7UQYMISE4aYe9QHDOZ6lf/qkOHeT/a/LJBWHWmkp2QK+jTQXbu8g9xWsK2CmAf/Nu
         UGE3TmJpfsc9n2CGkDUuVNikjKsHNIMWPc54LjciGL+ks0hQSFqxyNOo7mt7cYwLV4VE
         /O9er5D6Qq2wRahzpz0cmqDPHsb0+xnlKhqrSsqMm7VpNCoQnmptcVMRPOTooxS0gE5A
         0OhA==
X-Gm-Message-State: APjAAAWVIwJmPZp6xcqp34ICUm+zvTfOFmvh8qJ9cfDLa1HsmPYZw3Lv
        gO+gSIVIQ8ZPkL8NuhQpfN6HXA==
X-Google-Smtp-Source: APXvYqzjgNCBS9Xc6r1qaCIRpbgFCY8FEOUGV0ioNj007dahDNshESK0G3DDioV3YzxY2BA9jd53DQ==
X-Received: by 2002:a17:90a:d14b:: with SMTP id t11mr2249852pjw.79.1564569329177;
        Wed, 31 Jul 2019 03:35:29 -0700 (PDT)
Received: from localhost.localdomain (220-133-8-232.HINET-IP.hinet.net. [220.133.8.232])
        by smtp.gmail.com with ESMTPSA id h26sm71056516pfq.64.2019.07.31.03.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:35:28 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     gregkh@linuxfoundation.org, himadri18.07@gmail.com,
        madhumithabiw@gmail.com, colin.king@canonical.com,
        payal.s.kshirsagar.98@gmail.com, benniciemanuel78@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: indicate disconnection when disconnecting
Date:   Wed, 31 Jul 2019 18:35:17 +0800
Message-Id: <20190731103517.66903-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RTL8723BS only connects successfully at the very first
time, then it always fails attempting to switch to another AP. No
authentication/association observed from the air capture for each
attempt due to the cfg80211 believes the device is still connected.

Fix this by forcing to indicate the disconnection events during
disconnection so the cfg80211_connect can connect to a different
AP without problem.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index db553f2e4c0b..f76a498f015f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2024,8 +2024,6 @@ static int cfg80211_rtw_leave_ibss(struct wiphy *wiphy, struct net_device *ndev)
 
 	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
 
-	padapter->mlmepriv.not_indic_disco = true;
-
 	old_type = rtw_wdev->iftype;
 
 	rtw_set_to_roam(padapter, 0);
@@ -2047,8 +2045,6 @@ static int cfg80211_rtw_leave_ibss(struct wiphy *wiphy, struct net_device *ndev)
 	}
 
 leave_ibss:
-	padapter->mlmepriv.not_indic_disco = false;
-
 	return 0;
 }
 
@@ -2246,8 +2242,6 @@ static int cfg80211_rtw_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 
 	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
 
-	padapter->mlmepriv.not_indic_disco = true;
-
 	rtw_set_to_roam(padapter, 0);
 
 	rtw_scan_abort(padapter);
@@ -2261,8 +2255,6 @@ static int cfg80211_rtw_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 	rtw_free_assoc_resources(padapter, 1);
 	rtw_pwr_wakeup(padapter);
 
-	padapter->mlmepriv.not_indic_disco = false;
-
 	DBG_871X(FUNC_NDEV_FMT" return 0\n", FUNC_NDEV_ARG(ndev));
 	return 0;
 }
-- 
2.20.1

