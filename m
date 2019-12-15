Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5C8C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C0224679
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="K/4WYQMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLOR6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:58:49 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43292 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLOR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 12:58:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47bXFz6bn1z9vKdx
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 17:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yFnDaOMB1Qa7 for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 11:58:47 -0600 (CST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47bXFz5QBWz9vKdq
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:58:47 -0600 (CST)
Received: by mail-yb1-f200.google.com with SMTP id y127so4709429yba.19
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jU+IZfsrbWu2RYKQORP75VmblWiOY4wZRLGbP+XVlQc=;
        b=K/4WYQMbmQ1wpcHdnuZeoJwrgi1TuSRJxWawgTjssgCRnX8GiJ6iRyBlTqADg15eX0
         48CwOuD9aEvwjfg8cpARkHqUADVenh2nclXVmA42nA7VHZzjtIYXgH9HSmT/K6mwQ5yQ
         Wr0g2dZd6zj3FKFJbhcx+2DdrGBIXJX/+dXGuQeJRI4LOMPFLg28QeYB3tWJQ3jOybg1
         bflpmQLNnlFFZ28wh0+p8QKU7/9g/9yfFDVabGzh3EU8hXJf0FE4RA8kCoIzSbJqvpET
         vm5r2Xq/Uy50ZVhZ5Q3JTiCITOQZlM33gZGhu0U20c0lz6QudM6oqhn52R2C/x6hppJu
         YsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jU+IZfsrbWu2RYKQORP75VmblWiOY4wZRLGbP+XVlQc=;
        b=GiEAFIFgukbSh9BE1sHjTKwVhD9zo8Bs/8bFNlULbtFnDgMsczeEgjnQSzsjNVSQ0Q
         HOMLWIOblUqIiFQwYiPJE3F2qUQseF9vcl9ctv6M8OJUMPF5AE0rFButgE635TKwTheu
         gOGIihS6WBLxn6KhmAROF8K+anQ5DXshyklG1gWWAp8AGeVQCD3mwrfORCJocq/F6j+p
         9XIytamABK23OnCBjac51//FIB/NS8vQgYkFE4qknlefwVvKVtcXB65X2B96qev33J06
         Pt96LPD2lXpab9/hxD2SJZl7Rl3SDf5q+d1DSqpp8ltYRpDJ6yQYbH8NenwfhwgmMBsP
         tE8g==
X-Gm-Message-State: APjAAAVY3uIIhqc/BlH96e4cAbz12fChH0MlrPxA4Lp0Rq2OaTi1eu8m
        1DAzQVceShOVelBbvvlLrv1YFCAdq8KVV+LBG+Yay1A3504NyOel9CjzTmRnBYrdyt/bsf/0Uw2
        JwmRNd77mGag0qkJGvOIv8q6KGpfr
X-Received: by 2002:a25:c884:: with SMTP id y126mr18656399ybf.406.1576432727234;
        Sun, 15 Dec 2019 09:58:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLm13Xu0mUMgPfV76cA+1JEcVfLMMY9sBlXwtZ/dJhI+on6PQRm9vQAfnecJEurrKb9n20AQ==
X-Received: by 2002:a25:c884:: with SMTP id y126mr18656390ybf.406.1576432727025;
        Sun, 15 Dec 2019 09:58:47 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id l39sm7400528ywk.36.2019.12.15.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 09:58:46 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hdlcdrv: replace assertion with recovery code
Date:   Sun, 15 Dec 2019 11:58:41 -0600
Message-Id: <20191215175842.30767-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hdlcdrv_register, failure to register the driver causes a crash.
However, by returning the error to the caller in case ops is NULL
can avoid the crash. The patch fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/hamradio/hdlcdrv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.c
index df495b5595f5..38e5d1e54800 100644
--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -687,7 +687,8 @@ struct net_device *hdlcdrv_register(const struct hdlcdrv_ops *ops,
 	struct hdlcdrv_state *s;
 	int err;
 
-	BUG_ON(ops == NULL);
+	if (!ops)
+		return ERR_PTR(-EINVAL);
 
 	if (privsize < sizeof(struct hdlcdrv_state))
 		privsize = sizeof(struct hdlcdrv_state);
-- 
2.20.1

