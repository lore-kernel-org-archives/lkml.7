Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3F7C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3C820673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="yXu869UJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJHOZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:25:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52761 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:25:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so3398473wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=T1EoziBTkltAHMdc4buw9CGaKKcLnkZK2Xg/SL3bAR4=;
        b=yXu869UJT4DZ6ShP3Lq21w+k8SvrbwZ8BBXbEyayU0MvLGlVN3E2x1fFomLnlsmvYZ
         DbfNuFvjNpjti30lwXOENTvIDu4MiRca3YQ2N3r+cql9Kj2PyDju9lqX0OP8pmASzC6d
         OY7DttRSnAnzlQTE+sbf2xRBiizj5VykngpWgDfQ+hqVB7DmbyCkvXuR1zl9aBHvDCuL
         I4vAqaRSq+jigGBskbCgUemaslfTPxO6cVZS13SB++qADsBWF5EETqcj6joc8XpjbF4w
         mccVrmF0uFeTTkh+HJgtHsrDi+bbyz9pdJ3c0muVodEpQYuYq4hFnwbSUaXHLE9N1CUh
         hPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=T1EoziBTkltAHMdc4buw9CGaKKcLnkZK2Xg/SL3bAR4=;
        b=hDeBJFNQffO6S/L1n9/255WpuzY46WDEe1GEEIMpf9dlH8uY+s8Bqk8B9/Q/lOZIQ/
         BX8vGfbMcHdWnd7/Bcp5uBAhJKThhfn+CdS/kRTIYjqlQlUPmhOQJ/ajKNonp4/dTRxd
         7V4J09aSy15NuwPJChVPhYQ5QmtOJbHAoL+l9aedlWQngEYr/fsy3NlyUox8fYVX4Rxk
         1KfaPiP4ULf09otMQ5wBDZJiG0jL0lrIawe8TRZrJUG+3PFhpJ01ryO/96EaiDAAhOmD
         TcD4BYFsNwM8DrUqVHU81lJpo05nCu6PW1uwPUhjTjtwXeKQ2vR8DYJOtK45QFU/4yXH
         QD6w==
X-Gm-Message-State: APjAAAXxNsWjSl8pomDLeNiER0D/5T15Z1D3GpmsqGMAmjMns53FcAfm
        oGhU72gSV3qQIogyiftJuESbd3unPyeiu6LS
X-Google-Smtp-Source: APXvYqyWKsQ9SfdIDOC7smhgfVGN4ZnXDTPhORIUYTwQs0c17NQHzryFDWGsfQjjV5PUvpaqvl9hSQ==
X-Received: by 2002:a1c:1fd3:: with SMTP id f202mr3957965wmf.18.1570544743722;
        Tue, 08 Oct 2019 07:25:43 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d10sm4485803wma.42.2019.10.08.07.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 07:25:42 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Srinivas Goud <srinivas.goud@xilinx.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: xilinx: Fix calibval variable type
Date:   Tue,  8 Oct 2019 16:25:41 +0200
Message-Id: <20765c4c27aa92c75426b82fd2815ebef6471492.1570544738.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Goud <srinivas.goud@xilinx.com>

This patch fixes the warnings reported by static code analysis.
Updated calibval variable type to unsigned type from signed.

Signed-off-by: Srinivas Goud <srinivas.goud@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/rtc/rtc-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 2c762757fb54..da0dbea8def3 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -44,7 +44,7 @@ struct xlnx_rtc_dev {
 	void __iomem		*reg_base;
 	int			alarm_irq;
 	int			sec_irq;
-	int			calibval;
+	unsigned int		calibval;
 };
 
 static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.17.1

