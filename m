Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A92C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C45D20720
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5jME4Kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKWPQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 10:16:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35568 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKWPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 10:16:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id n5so853806wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFed9VqpsJKafs4auYjqVCiB2JZMUoL2P/uWCdp5l5Q=;
        b=s5jME4KlROGZt+v99F8rHGB4q5F574j8yIuMkOLNP3orVMGMgvDhzbh43mm6EWJsrP
         gLnQM/bQ2lxwUP6RhPwXRaIK5x/V+73jG8qTjOOSQmua5yY8ImMouZhjYK4v1hiHGIBy
         i8+4ZmlLayz0DP50sOFtd+GCdFVJh3eoWerV0D77GNUTwxS4hjVHrXM+fSXt/82piM3x
         BH3edRluBQo4LxXahRLiShZz+EItaSeBkbewUDLisRKhjcRVJvVBGy6rOdG/4CGEJxHJ
         PFQyykDM4RliuUz8JePMCw0uYlCGHC+SMxKiJQbY+RoDoBXef4QjkKBQ7VaIv2zFuXRa
         m9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFed9VqpsJKafs4auYjqVCiB2JZMUoL2P/uWCdp5l5Q=;
        b=rf+bsP51sXUsKYPP7r28I0wUv8gDRdW7iTsFPkqRsJ1jIz6o4Iv09Lh9xjv2qWZg7n
         QqHKKs0AIQIyuDsQx0d7/mYfR8jkjfE+9yCa5vTP+ZQnlPcFYrYoh0XAwX3/j0hwvgzl
         K3aGVVaP1ADeU8fuAqGh5NEB7R4mntX+GZm5DL+C7I7K9FGxZQUAKmv0UTcX3+w6kt5D
         1DI1m9sxfWJ5fF2FLlQC4D1sOyS+2MJiTKEIP7qCl7I9Z9Zu6gMPcn95r1KDuRNx8T8v
         2jOqQAExaaNPnXS3U3Kt2FqC6Y9WTja12DMK5JMX0ti7AhrV7T8LOxH9bQ5+ZbJqcugW
         bbVA==
X-Gm-Message-State: APjAAAUDjgzVPhi5GxSBSQvYy5FdVF54VPt2PUIH2OYi2lp/xS/mUHuz
        U+2iK5Yg9Z6FhB5RUsa6LVA=
X-Google-Smtp-Source: APXvYqxej3lQo35o2AcErOq4wsO6GVqMxTmW4YKoxjFD/Rzg4BwQccSqZZSdF/3jycOVQ3dSQGpocg==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr20859986wma.177.1574522208846;
        Sat, 23 Nov 2019 07:16:48 -0800 (PST)
Received: from localhost.localdomain (dslb-092-073-054-228.092.073.pools.vodafone-ip.de. [92.73.54.228])
        by smtp.gmail.com with ESMTPSA id p25sm2126311wma.20.2019.11.23.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 07:16:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: remove return variable from rtw_pwr_unassociated_idle
Date:   Sat, 23 Nov 2019 16:16:35 +0100
Message-Id: <20191123151635.155138-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123151635.155138-1-straube.linux@gmail.com>
References: <20191123151635.155138-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_pwr_unassociated_idle returns boolean values.
Remove the return variable ret and the exit label to simplify the
function a little bit. Return true or false directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 8e99e10c1fd4..c4f58507dbfd 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -201,21 +201,17 @@ int ips_leave(struct adapter *padapter)
 static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	bool ret = false;
 
 	if (time_after_eq(adapter->pwrctrlpriv.ips_deny_time, jiffies))
-		goto exit;
+		return false;
 
 	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE|WIFI_SITE_MONITOR) ||
 	    check_fwstate(pmlmepriv, WIFI_UNDER_LINKING|WIFI_UNDER_WPS) ||
 	    check_fwstate(pmlmepriv, WIFI_AP_STATE) ||
 	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE|WIFI_ADHOC_STATE))
-		goto exit;
-
-	ret = true;
+		return false;
 
-exit:
-	return ret;
+	return true;
 }
 
 void rtw_ps_processor(struct adapter *padapter)
-- 
2.24.0

