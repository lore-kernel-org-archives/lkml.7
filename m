Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D667C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5B821773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="JGoE6Xbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfEUO2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:28:02 -0400
Received: from mail2.skidata.com ([91.230.2.91]:32652 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfEUO2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:28:01 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 10:28:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1558448903; x=1589984903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tZprcqh9LXoNlxO8gu2/EPEJEdKFxz91AfnZIELZi24=;
  b=JGoE6XbuYBoVl0P6cwUeUVyz5qAnahyEDot1GFFYag6twOIni4MrlZVV
   VLtwoQR3gZZA1XII77FnhRGJc29iMvv3zG3wUEtFTDCXxFLGaltSxnRkf
   9AyYPQkr7TzJcjTBCg5VFIqfBQ/lXUBewfRlTtp4gOWPiV/sjpaeN1ims
   4A7g+4U3qh4zTAeY5vbqWUvBoqGt8vB4wjltm9Zw0LSkh2zKACMaOgoKL
   gJrbWlP06/DGV1aFFXUSN1Rf7Ke7FzE83XZRox2e/LTMjvKyehUK7zBdB
   mFABFeesdxvtBYyocteObWHstG114D5OUaea9IF0t/K8QmihftQfPVDrz
   Q==;
IronPort-SDR: R9oJvERd0WsFqarg5Vu7T2H4biQbG7n/GQ2SjYFPrZgZiM+UnwDlsvITezDtGFRkpWH5YYwm42
 4C5HdUYQcmtpiFDkQeHKjSbBAnnTl3S2czdi+0AJnxUMgfvn91cFGfkgbVw3K8iy+Yjyd0kgka
 RSA2GgjO+H3FIiJcSbZWbA0a9FXQYW4KvxRpHcZ5S0S4fQGvqp/R8o6Yj45z0LFMYtngq0GJjt
 02neaZoH0kDPZe1asN/q5H/922IOUINggRacKHjqYrMIr8vWuvk8jMbGeoglubhzJYxyxcqaui
 i58=
X-IronPort-AV: E=Sophos;i="5.60,495,1549926000"; 
   d="scan'208";a="2150343"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 0/3] rtc: s35390a: uie_unsupported and minor fixes
Date:   Tue, 21 May 2019 16:20:21 +0200
Message-ID: <20190521142024.25894-1-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the s35390a does only support per-minute based alarms we have to
set the uie_unsupported flag. Otherwise it delays for 10sec and 
fails afterwards with modern hwclock versions.

Furthermore some other minor changes are made.

All patches were tested on an i.MX6 platform.

Richard Leitner (3):
  rtc: s35390a: clarify INT2 pin output modes
  rtc: s35390a: set uie_unsupported
  rtc: s35390a: introduce struct device in probe

 drivers/rtc/rtc-s35390a.c | 43 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

-- 
2.20.1

