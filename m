Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F22C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 09:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227EC2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 09:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQfpS9tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfEKJtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 05:49:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41813 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfEKJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 05:49:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id f12so1951978plt.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JoxPpyQyOu22hWp5htaLgYiM2luFFOZuNTOaxrJUw8k=;
        b=CQfpS9tmF4EiQPwD2Cb5zP3Oexv/pRbqqI5uEYdXhJyeFZ7cbf8Q+VakC6kJMu7qpF
         gSyLkcyMFt7u9pauMfdp4xBE9XsQQuYGbaYEOGHmKRKCKFjqO5grhDch8APUv5uKIvln
         tM0jm78HUaxtLsDgHazegGnz5LA/8vd79+62ARsCKv+1m1P5I378KNbiS4P41JQwX/C7
         B6nFc9e8f8pWTRR4l6MHPEPYPJPAWVx3RaRjgkQpma7e9Toptn5wvOAFVry0BLn1DW9S
         ouhlIqXXMLxGsIP7+3MEw6tKyhULNWXYhgNA8UVTi8lxN+Z9642pS6MkdaYGivegspy1
         8jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JoxPpyQyOu22hWp5htaLgYiM2luFFOZuNTOaxrJUw8k=;
        b=mswuqp9NZHFf4xBaL/ufferKXdF0yeNiORcQd6dCDeDEb8zUq2C78OZ++ja49yEF0n
         sZnq2Dx4zvTij8+vFo9K7WqDV3T5JZvELkSKi579bhlejbo3rCBoXpTO3TKgi+hYsW3B
         gRZ7MIZpTmnYE7rCSosmBF1cDHxR0Owgj0CxApK6e3Dcoa4sewdlY7vwRWlSWP/JhbGS
         SaMEaWzIUZ9ZYiHopHyUkW+heQqemSjkt0Fj/WzaowquFXHabM3PUMTomfutPIvpM/8w
         s92GI911iNdEpBurMKW5QR6KkdqEewLhSKpKqn1bLBL/pDbh/CuOl63SDBJgVkFNJLgc
         Kyhg==
X-Gm-Message-State: APjAAAVUHXyvI3JSOBLuNEYEYVoOjpkwXJaX8URg1/8e9pMHUm/vg//t
        v3r30mg2NKW3nvPXNBnKxXk=
X-Google-Smtp-Source: APXvYqzwwCNsanCV8KxJQhlX9V4r6+KCC05de1HjaVoG1/vLbXbN8dEe+WBDp9WhRF6Wen3zflmIiQ==
X-Received: by 2002:a17:902:7895:: with SMTP id q21mr18070928pll.73.1557568146254;
        Sat, 11 May 2019 02:49:06 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id k64sm27220158pfc.97.2019.05.11.02.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 02:49:05 -0700 (PDT)
Date:   Sat, 11 May 2019 15:18:59 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Collier <osdevtc@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Chris Opperman <eklikeroomys@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [Patch v2] drivers: staging : wlan-ng : collect return status
 without variable
Message-ID: <20190511094859.GA21232@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As caller rdev_set_default_key  not particular about -EFAULT.
We can preserve the return value of prism2_domibset_uint32.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
Changes in v2:
  - remove  masking of original return value with EFAULT
---
 drivers/staging/wlan-ng/cfg80211.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 5dad5ac..4018fc5 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -231,12 +231,9 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct wlandevice *wlandev = dev->ml_priv;
 
-	if (prism2_domibset_uint32(wlandev,
-				   DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
-				   key_index))
-		return -EFAULT;
-	else
-		return 0;
+	return prism2_domibset_uint32(wlandev,
+				      DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+				      key_index);
 }
 
 static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
-- 
2.7.4

