Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A79C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7047821855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcXR9e7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDFIX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:23:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41744 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:23:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so4316395pgs.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0JZSH3gxqWqpv4GmZ+41350PSg8DU+1yr4qk/Q6CEJc=;
        b=bcXR9e7o4FJMpWeQ2bNetblVogJ3/+9nk03ZAl44O/lqrhg4WOjGcT2fYeeQ9EzJFD
         npfAq1gmWhZP8NB1ESS4z0TISI7WagHqb9JRN0yqseIkgVOgafJraAdjh5AjSN6Zx0eg
         0Tas/mvdWjFcl4DBbEX/Q39HOVJtdxtKDCGoBTVyIaehkA3pyYN4birqFCVpz2IUlI3z
         +yzmxVxJPffD/CzaSXuKr519QRdfowhSXeZ+3H/6bUq16/XUNNgiCE6zsBChvEG6Q8s0
         4egNSL5hD0HvcSWd9tDCZjgSOiHtY705hk7EXark9q7tqH9oJu9RKvNzPByRZw8XSP2z
         S/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0JZSH3gxqWqpv4GmZ+41350PSg8DU+1yr4qk/Q6CEJc=;
        b=kv3pN8CRANo5MYc0zj41yDXOTUBAB2nUMqQHdGGrNNC4Gdkaf2KiWcmPVqkKqU3i/D
         3QzwGm8dnkwPMds8NmJ9MiOrDgwEFanGO1dSw+pZy307rAXGG+Dw2R3Q5IOrh33VQj/Q
         zs6tdxONmvxz1FshvX15KjcQCHwDulKbhQxz5DzKC0xVDfSyUsibd6NJLRhdBSx25MT4
         BRJa6YrqTONURwyI8QF8iOIF411Dy1iaStsvoABO6zcmAZefXAlxX7iwuzDYpPl+C7ss
         JxJ6Pka7MjD9THP8MCzFCUX05pK1XbDbKMe4AWE+wRk25qdRWcpbGFWVH0TpqrHQv+MJ
         1qjg==
X-Gm-Message-State: APjAAAU0srQ7S7sthWcYERBiu/Un6PW5xjGx9ybjyB4FbjYQcrE6pTr2
        /s4ec5Ld0+z/YrzsFgABUqw=
X-Google-Smtp-Source: APXvYqyfh5YiIV0/JspcXwa9+Q+C9okHguxGH5h+NboNsdK4R4zZFzQhion0LuFj56kp3b9iKkpYLA==
X-Received: by 2002:aa7:9219:: with SMTP id 25mr17449850pfo.205.1554539004945;
        Sat, 06 Apr 2019 01:23:24 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id 129sm9841253pgc.24.2019.04.06.01.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 01:23:24 -0700 (PDT)
Date:   Sat, 6 Apr 2019 13:53:19 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] staging: comedi: dt2811: Fix spelling mistake
Message-ID: <20190406082319.GA4231@hari-Inspiron-1545>
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
Changes in v2:
  - Make the Subject more clear by including changed file path.
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

