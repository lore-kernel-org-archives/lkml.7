Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C087C48BD5
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA7A2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2atDKi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGFSlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:41:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34241 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGFSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 14:41:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so6121890plt.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aOXdMqFM49qwxjBJs+4NYgYXPEPkbakFKpkGoCXkxdo=;
        b=U2atDKi7l+WkVgOuT7m/IPf37h4Jl0gh5TqnHzmPFkySaa8YO2vfBWUP13d//UgwiA
         RvMjxE43EKjznbNx3x0jLZ1/9VBzzAv2pIjvzoFOF/jMO+9F7/Q0R5hwAtK19t3Pvxwa
         LL1fh2WhZUW8zv7CNpd/a3gUjzCyFR08X456FCOVX0JxseuLy49XFvTchJBolX2oTwvr
         XIyda6PyQBh/FxUc76q/HXd7+DtcoYKnrkJ2A+TzKYbJi5pfa91TMZMcRYt884NmGSsj
         kfHNWhja2Yuf5ZOLeUwM55jYCvnCL1zaKpikNyeNyJkjnHu24XZcuO15Modrs6397Sgb
         tsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aOXdMqFM49qwxjBJs+4NYgYXPEPkbakFKpkGoCXkxdo=;
        b=N3HyCkCh63gOkRfqofr8uEUi7YkeVzUXGVCzkgEtGIW9Ynck2jmYhr8XoRAPxPO6P6
         mzC15M7EjIv/+0oAMes2tdGQJ0HogS6cmG5UER/4Hu3603s7Mz4b1cX5FzzbwQ5XgNB6
         SpLW6KDpnAmelRM4uYUR/nHwYpxN2yLdg7CkjAtW9GrbVlzM8RXvHpQmW3kqGV6VXLAt
         ou8D3u+0g+8yrszpiZ3pXUK5ymSWUdSNkZaBB70TnlT1ElGEgWPVUTeJTvE05I9VuF/B
         0Gby5c0v4vsPRDEqSZP6A6WHivfHSJG7BKMBE9z8ZWN387TFEwwqYwDSvQB+5l2umPDQ
         g2FQ==
X-Gm-Message-State: APjAAAUvH7jrrk+5/jWMobwfEz0of+XLH0sjQFY9oWnN5t0f1rx6sXzc
        4aAb3hrRNyg033Wc0Twp8+k=
X-Google-Smtp-Source: APXvYqyAm4RMzl6kuXCJQEzf4ic2tJ8zFHfNjZbL8uy5oDQF7UGWEw7pnM4Ad88uLhIIaQR9cpwgCA==
X-Received: by 2002:a17:902:7087:: with SMTP id z7mr12613285plk.184.1562438476986;
        Sat, 06 Jul 2019 11:41:16 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id v185sm16976966pfb.14.2019.07.06.11.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 11:41:16 -0700 (PDT)
Date:   Sat, 6 Jul 2019 11:41:14 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     shobhitkukreti@gmail.com
Subject: [PATCH] video: radeon.h Fix Shifting signed 32 bit value by 31 bits
 problem
Message-ID: <20190706184111.GA13070@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix RB2D_DC_BUSY and HORZ_AUTO_RATIO_INC defines to use "U" cast to
avoid shifting signed 32 bit values by 31 bit problem. This is not a
problem for gcc built kernel.

However, the header file being a public api, other compilers may not
handle the condition safely resulting in undefined behavior.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 include/video/radeon.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/video/radeon.h b/include/video/radeon.h
index 005eae1..cb0a5f6 100644
--- a/include/video/radeon.h
+++ b/include/video/radeon.h
@@ -531,7 +531,7 @@
 #define RB2D_DC_FLUSH_2D			   (1 << 0)
 #define RB2D_DC_FREE_2D				   (1 << 2)
 #define RB2D_DC_FLUSH_ALL			   (RB2D_DC_FLUSH_2D | RB2D_DC_FREE_2D)
-#define RB2D_DC_BUSY				   (1 << 31)
+#define RB2D_DC_BUSY				   (1U << 31)
 
 /* DSTCACHE_MODE bits constants */
 #define RB2D_DC_AUTOFLUSH_ENABLE                   (1 << 8)
@@ -672,7 +672,7 @@
 #define HORZ_STRETCH_ENABLE			   (1 << 25)
 #define HORZ_AUTO_RATIO				   (1 << 27)
 #define HORZ_FP_LOOP_STRETCH			   (0x7 << 28)
-#define HORZ_AUTO_RATIO_INC			   (1 << 31)
+#define HORZ_AUTO_RATIO_INC			   (1U << 31)
 
 
 /* FP_VERT_STRETCH bit constants */
-- 
2.7.4

