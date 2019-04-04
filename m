Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30341C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A7E20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM6+ciqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDDBYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:24:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37799 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDBYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:24:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so360629pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wvCZGps9tWughgsWHdoQZdrsOwDItuOv3jE/bnb1ns4=;
        b=HM6+ciqQ8oPF/KKREc+Xb6ND1FU+Q0GvkaKU6eW2A9AUJnKl8I8eaGTLzfSGF3vQlb
         qZA0oCcLRm2gSGfPMBlMdQFq6TmFfb8KpBRTXS5dgBFutoK1Nt/mDrFRRca/VcuHN6Bd
         GY4W/ylAdv67p+fPrSaiY0rbEd7C56Ou1X2cRGoJ2qQVZkWmCF6mUuUQld6d5/lukO96
         Z43elAMVKuEEHu1mKDDinR+e7Atr5STc58g0jcMv8+TwqUp3PdmdM6TDGN5Nlx2E0vUH
         qsvJmpJA47/LP7w6zFgFoLz2dVJ1AoQ4zzfBaS+rabsqnXmFq8E9gvwBpTQG9D2WbyOm
         dqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wvCZGps9tWughgsWHdoQZdrsOwDItuOv3jE/bnb1ns4=;
        b=qv14w/jctw8H3OPQsAP4f30lgatqjHSp6asr6isinJ9KjXT8xUZHJyTsPo8SnYmNre
         PJ3kA+VbFZfSy1uiuEoqaPv5l2w9pYjKvfg4zZZh8jtXCUy7HZynQhXFXR0tPm9lMd+M
         GKJ7n3DcDOhy+g7SrzC3AAkafdbJcMdHR32o6pfzqF1Ris4ql5bEgVIt2wFIlVYcz3kr
         UKnxoF5O8gFW680YbmeYb7EE9rSFq6ud//4mqu+HhhGIgHkzpXICHJKLP2dud+HdX2PN
         G5mLzXyRXFG5ZLIZ27t6OyDALqq1e6PwKyFaFOFogih/MT5EFu7FyuUdvaa//mf5gZu5
         UFVg==
X-Gm-Message-State: APjAAAVYYxd2p15wKz1wTuX6wxvT00hcVbW2+rCqLdYtkGZp7keOxxqi
        +Vi+eKE/FA/OVIhaNDE17F+DM076
X-Google-Smtp-Source: APXvYqz1BB8SU3Wi8w60n9JbAtV/k70eRrPWj4YndUs10rV2v4Oj7D9/ic+d3erGFfQHAl60MWZtmg==
X-Received: by 2002:a63:4620:: with SMTP id t32mr2860223pga.363.1554341050756;
        Wed, 03 Apr 2019 18:24:10 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id 14sm36741295pft.137.2019.04.03.18.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 18:24:10 -0700 (PDT)
Date:   Thu, 4 Apr 2019 06:54:05 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: Fix spelling mistake
Message-ID: <20190404012404.GA2098@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes interupts --> interrupts to fix warning reported by checkpatch
tool

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/comedi/drivers/dt2811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/dt2811.c b/drivers/staging/comedi/drivers/dt2811.c
index 05207a5..8a1f9ef 100644
--- a/drivers/staging/comedi/drivers/dt2811.c
+++ b/drivers/staging/comedi/drivers/dt2811.c
@@ -52,7 +52,7 @@
 #define DT2811_ADCSR_ADBUSY		BIT(5)	/* r      1=A/D busy */
 #define DT2811_ADCSR_CLRERROR		BIT(4)
 #define DT2811_ADCSR_DMAENB		BIT(3)	/* r/w    1=dma ena */
-#define DT2811_ADCSR_INTENB		BIT(2)	/* r/w    1=interupts ena */
+#define DT2811_ADCSR_INTENB		BIT(2)	/* r/w    1=interrupts ena */
 #define DT2811_ADCSR_ADMODE(x)		(((x) & 0x3) << 0)
 
 #define DT2811_ADGCR_REG		0x01	/* r/w  A/D Gain/Channel */
-- 
2.7.4

