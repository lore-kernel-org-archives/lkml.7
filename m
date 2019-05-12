Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FE6C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141F52146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bttDhfVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfELKxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 06:53:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40716 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfELKxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:53:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so5240836pgl.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TSGu2ypgclukAqwzWAhyyZz9L1hyT8DNMzdH0VVP+ls=;
        b=bttDhfVz8HY0KhYUQY5A2DXkh37y80EeuswqpRP6YWvx3koosM3DbP/E0b/OW21Vaj
         Be93js5stxMQ/Nyo1X/xb4bz2v4NckyZjuwXSOG1Bxs8Pc7dultuo5P2MrqCXN28hn5G
         DPhJ+tv4un4kjdVKgp6aIop/Dd8lQ3VQNT+lDdi2aUp3qAJZHGl28j5qjDarw32luwrT
         e/FJHzaS5hUSkk8Pp+QXK2iD9sWOmaTRMu0bp6c3epBZQPsmVdxdis09V/CAmxpdx9x2
         gpMuviY3+r3KDICb6P2P8je7RgSXDdZ5Wdhq0CWjD8pVtm3b423N8xaay01eLsnOdc0f
         Y3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TSGu2ypgclukAqwzWAhyyZz9L1hyT8DNMzdH0VVP+ls=;
        b=N/COattEtYtCZrsdE5A9IC5ouKwl/XuOZeGf28p8SgKKa08L75WuN1My8hlv4c1Ohp
         wi24fcc5ThXGhixlRsdo/lZ7cj+55lPm11MgPGpTbf2CIyu9zttCfy4gJTt5qftVyCg0
         YIev17jAqZK91+zadESMtJ/rNRLzBONhMZqcOpi4HSugLtmTU1IeggPXsX4pWgCDm1ET
         CUwJ89HLW3515IDkVjCG+ptSY5V123foyGZaEnSqEmeJNGpu9V8aRsqzNx4gfiRFfnBg
         FYdnBWYZlonfzRGrYN+GH+Eqk86z157CwH8gx2lmyUXMLRV7XmV+AlO4cw7GTwRuG/gl
         T6fA==
X-Gm-Message-State: APjAAAXshNN1mHlsdzQdxUPhJVxeff8UIcr781JWtCRZP5TTLkk34WOH
        Ww5juGUBmjxlsSXo2O2M5bU=
X-Google-Smtp-Source: APXvYqyFPzMI6w9lR5oCkUpK788PEl+uNYLmnANR2jb6caiJyOSTDoP0lGdctxOsO+N/4Wxyy5zdiA==
X-Received: by 2002:aa7:90ce:: with SMTP id k14mr26243087pfk.239.1557658431357;
        Sun, 12 May 2019 03:53:51 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id s19sm13060801pfe.74.2019.05.12.03.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 03:53:50 -0700 (PDT)
Date:   Sun, 12 May 2019 16:23:45 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     dan.carpenter@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Collier <osdevtc@gmail.com>,
        Chris Opperman <eklikeroomys@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drivers: staging : wlan-ng : collect return status
 without variable
Message-ID: <20190512105345.GA4046@hari-Inspiron-1545>
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
----
Changes in v2:
  - remove  masking of original return value with EFAULT
Changes in v3:
  - merge patch v1 and v2 sothat it can be applied on linux-next
---
 drivers/staging/wlan-ng/cfg80211.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 8a862f7..eee1998 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -231,17 +231,9 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct wlandevice *wlandev = dev->ml_priv;
 
-	int err = 0;
-	int result = 0;
-
-	result = prism2_domibset_uint32(wlandev,
-		DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
-		key_index);
-
-	if (result)
-		err = -EFAULT;
-
-	return err;
+	return  prism2_domibset_uint32(wlandev,
+				       DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+				       key_index);
 }
 
 static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
-- 
2.7.4

