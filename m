Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B02C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4372086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1wXYKlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfCaWxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:53:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38334 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:53:35 -0400
Received: by mail-it1-f193.google.com with SMTP id f22so12313263ita.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lTauicTMEqMJS78ZlwpBuBYgtWUWU6M0fSz7GOUy13M=;
        b=e1wXYKlIHbHwmS1TJTVmLcggPt6wsBouBabc0U01QkYyw6whwxGxHzo6xOAdqNWArT
         QBEUEmr4HPAKQzIW4WPEMSbXt93znhg85deA4XncNzNtpKwyQVLfq03nDyR7GDQbD0VX
         BW0lXTw8OygNe6jDVSzLYo+WKiC7h3pIy2T6NRiaA+sTDxWhmkUJZvmsqr7LBSgyC4oy
         XnYQXJ+De+94tAnt9kGQI+gERXkGzU+fwe8FuIdn12wbQWZnMkMudF7BQOs99qCy9zqs
         QIc5ASqShs3a2Vk4B8PMZfZhwMln9X9/mCDseAQ89ZP3pfhkXWWtTKX5PmiIkp/mhbVW
         Gfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lTauicTMEqMJS78ZlwpBuBYgtWUWU6M0fSz7GOUy13M=;
        b=XpDjmEkcOEpeCO45Pk4PUgSljsjVsODpWu8Ipp3qrQJ7vp5iBWMsPNMXZLdTZJ93ZG
         UTiFtzIzJ46rdjPwrH08lmFOU01FQGaMEHz7JdMJIGbJ2T6Xq4t67acUi0Pr6mouE86Z
         FH8CG/5LWZuV1ByuikLAbSyM9dq5LC6KHVBDVRJgHaQejADNXe8Gxgtf4PBqaeAPlncK
         1ubSwL4ebaug4HcrduQtfOb0b6gfq/3dwa5Br4TM742F4jEi6i3nLTTjEuIHFijmR50C
         YDoGqf/GT9r1Byd513uZQligeRtqJ+l/c01VfSMyLARTXJr95FN+clhhEJFNeRSi9zJn
         voWw==
X-Gm-Message-State: APjAAAUgptIo5hMGHhsjlfFFVnVzXm4tjJs6Kw5K7w3a/RXhsrMbXXEK
        aK4Fe4njwUSaiLtRrnheWfgj4eejZhd6xw==
X-Google-Smtp-Source: APXvYqwIPWkSQTG26BnMFDKiCmERRtGhPjWmG/bINHfLLZhLqeq8Dyi61cHMAGebvlwZM2HzuYU7UQ==
X-Received: by 2002:a24:205:: with SMTP id 5mr13461645itu.150.1554072814053;
        Sun, 31 Mar 2019 15:53:34 -0700 (PDT)
Received: from titus.pi.local ([66.97.27.10])
        by smtp.gmail.com with ESMTPSA id 136sm4878616itu.35.2019.03.31.15.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 15:53:33 -0700 (PDT)
Date:   Sun, 31 Mar 2019 18:53:36 -0400
From:   Will Cunningham <wjcunningham7@gmail.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: comedi: drivers: pcl818: Fixed a coding style error.
Message-ID: <20190331225336.GA26547@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses.`

Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
---
 drivers/staging/comedi/drivers/pcl818.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/pcl818.c b/drivers/staging/comedi/drivers/pcl818.c
index 0af5315d4357..da5d53a288f7 100644
--- a/drivers/staging/comedi/drivers/pcl818.c
+++ b/drivers/staging/comedi/drivers/pcl818.c
@@ -1012,7 +1012,7 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		pcl818_alloc_dma(dev, it->options[2]);
 
 	/* use 1MHz or 10MHz oscilator */
-	if ((it->options[3] == 0) || (it->options[3] == 10))
+	if (it->options[3] == 0 || it->options[3] == 10)
 		osc_base = I8254_OSC_BASE_10MHZ;
 	else
 		osc_base = I8254_OSC_BASE_1MHZ;
@@ -1026,7 +1026,7 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	devpriv->ns_min = board->ns_min;
 	if (!board->is_818) {
 		/* extended PCL718 to 100kHz DAC */
-		if ((it->options[6] == 1) || (it->options[6] == 100))
+		if (it->options[6] == 1 || it->options[6] == 100)
 			devpriv->ns_min = 10000;
 	}
 
@@ -1067,12 +1067,12 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		s->maxdata	= 0x0fff;
 		s->range_table	= &range_unipolar5;
 		if (board->is_818) {
-			if ((it->options[4] == 1) || (it->options[4] == 10))
+			if (it->options[4] == 1 || it->options[4] == 10)
 				s->range_table = &range_unipolar10;
 			if (it->options[4] == 2)
 				s->range_table = &range_unknown;
 		} else {
-			if ((it->options[5] == 1) || (it->options[5] == 10))
+			if (it->options[5] == 1 || it->options[5] == 10)
 				s->range_table = &range_unipolar10;
 			if (it->options[5] == 2)
 				s->range_table = &range_unknown;
-- 
2.19.2

