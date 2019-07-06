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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC710C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5D20656
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPNOU8l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGFRlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:41:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41275 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfGFRlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:41:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so2402386pls.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SlFn540nBc9iqKn2rizLIuz2b9MqNZcwMoN2lyFQW88=;
        b=iPNOU8l0aQwmCUThSgbPHO76Gq5JEc2QWPMsRbU+CA8smqlQR5kc2j0AOY+oDf7pij
         H3Yy/rPbngQ8fmQN9pEBqIpX7+utwaPAoKAGPxQjBooqt/HuhQLppfUDAidVekKQnGky
         ai7/+G8dZOq6lMS6+tmvp7DFjlzD2oHWfBQVFYRokfS+rbUJe0e8Zmg30bBLmB3VsB//
         eTUolEoU3VbglrKKNGFKRCUxyHqeKx076QTfzr83XsGbyQmNxH5bgQCMb+X81wJYN+/g
         1jDYkJG8lRyrlTg5DmAwzdIqcZS0lhXOvoc72Jj5jakybv7iN4NLtnv/3A0ixhnED5XA
         uP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SlFn540nBc9iqKn2rizLIuz2b9MqNZcwMoN2lyFQW88=;
        b=V5GpCKeCa30UvuHGgq7Ge/hpe6EcmfCxs+6N1Hqtm6UHQ2027kz+S+KEr+pXlrjhrX
         sKE4bLloklqrMSYhSPtpVPvsojlm13NMJSqtAacgBPNCBAsmArsF6XzPKdIkfi3Irtu7
         waangR6wFrG/ruZ+Z5soo048EeR15atQK1NzCwErzl+PQZNnIPzBPw9yPQw9WOsg0hzv
         otZX0WQfFgu6j2zIairogBt00A7+mf/cdlfaWvEY6gmZ7M27n9/KeM5JndqOMGvFyX3Y
         U4CQXSXrMJ/njOY9cvmxaIJYzd3/Fz7LfFnfJ4VJhfjr9I34nckYEz3+/m0LbS/K4lEU
         X3Bg==
X-Gm-Message-State: APjAAAVZD3CENJP4DSCoBXk6xyayul2XIMNENyfv7U7FbQzs2s1tWvYy
        +RTyWnEmkgkDVNwzbBRt7xfiubwYQkQ=
X-Google-Smtp-Source: APXvYqyOJbknq04MmQC6fbHlqttqPoYezZZyP/WLd6bs6ce6w/pgdfuDRwK3h0RNM2b/w7Yn98OvxQ==
X-Received: by 2002:a17:902:9a82:: with SMTP id w2mr12469572plp.291.1562434866164;
        Sat, 06 Jul 2019 10:41:06 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id g1sm31422049pgg.27.2019.07.06.10.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 10:41:05 -0700 (PDT)
Date:   Sat, 6 Jul 2019 10:41:03 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     shobhitkukreti@gmail.com
Subject: [Linux-kernel-mentees] [PATCH] video: atmel_lcdc: Fix Shifting
 signed 32 bit value by 31 bits problem
Message-ID: <20190706174059.GA14822@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ATMEL_LCDC_MEMOR and ATMEL_LCDC_MEMOR_LITTLE defines to use "U"
cast to avoid shifting signed 32 bit values by 31 bit problem. This
problem. This is not a problem for gcc built kernel.

However, this may be a problem since the header is part of pbulic API
which could be included for builds using compilers which do not handle
this condition safely resulting in undefined behavior

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 include/video/atmel_lcdc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index 43e497c..ac96b4f 100644
--- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -103,9 +103,9 @@ struct atmel_lcdfb_pdata {
 #define	ATMEL_LCDC_CLKMOD	(1 << 15)
 #define		ATMEL_LCDC_CLKMOD_ACTIVEDISPLAY	(0 << 15)
 #define		ATMEL_LCDC_CLKMOD_ALWAYSACTIVE	(1 << 15)
-#define	ATMEL_LCDC_MEMOR	(1 << 31)
+#define	ATMEL_LCDC_MEMOR	(1U << 31)
 #define		ATMEL_LCDC_MEMOR_BIG		(0 << 31)
-#define		ATMEL_LCDC_MEMOR_LITTLE		(1 << 31)
+#define		ATMEL_LCDC_MEMOR_LITTLE		(1U << 31)
 
 #define ATMEL_LCDC_TIM1		0x0808
 #define	ATMEL_LCDC_VFP		(0xffU <<  0)
-- 
2.7.4

