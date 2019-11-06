Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33780C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E640C214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuATidBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfKFGDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:03:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41461 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbfKFGDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:03:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id l3so16377468pgr.8;
        Tue, 05 Nov 2019 22:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/6ILvar/Vc1NMB4f7GrkmfjN1HObi4yraIRhPcFGto=;
        b=BuATidBjIts5hHmDKKZlujEP41wcqVP7Yk5A6SBb/teaPz7lWYAWq7vnCRk1LcWiXE
         YjkhzUwRVWbDxPdLyCYJGkmGcBkaT3joD0mY71d5nMoXyDsuZf+axhR23/pUX9HB7tYC
         ccVmjKURstvC5U+pQqN49oH4avpatxMn8cpZ26bbTfMlfd/Z1LwTYQD2YsvjS3IlgXye
         d10ADmqdU+G2ckLyYY7P8KpRz5b/U/vMkTg8I4PEk51+knjsAVEqGzrEtrfGoQ67UQHU
         T/EKR9FVNAHHOzSAY9IYC1ZOXTAkPpCUS2KOu4T/mc0ichdJdwL3mCAFwFdeeZWM+0vQ
         z5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5/6ILvar/Vc1NMB4f7GrkmfjN1HObi4yraIRhPcFGto=;
        b=b+PynbWxEojGRwVsr0+3F82LG50wCLb+Ef/v97hk/9cSRx6OdWuO3Eo1iBhPlM5h2g
         Y9OKJXcMMo4SHVyQ7f7ia0NRWDyaiBvqodNBPaSukZ2mpIP+ZRa/JSZhY8pIeQrR+Pax
         Q8zBgVG4ypgup2DiBi1TRlknNTgT6PFDfE5+ISG6M54s3vvrnC4zg6+/5hqKicz17E/f
         z7zXaVLIBO4lGn2+mZjJA3Li5zCdmn05SyY5CAHBfysb+ty08gAP7bRCZ5d508JIKiND
         7V1YxJarlDak6ipvBI3lnpljVO2TeqjTCK0E8Dnj7IFooU+ggw5wPqgRxQ2xOPKHkKi8
         5BaA==
X-Gm-Message-State: APjAAAXI27GtHHqhfRUu7iR98Zo2jj2QG/echQr3JlFlsqlAXOFXeJvh
        jZgqCMsRYPeEl6VR/9DKySg=
X-Google-Smtp-Source: APXvYqweLDs9cKw9j14668DFH5DKEGGVEUDKedXgP0s4rb+8rjWCTXxUP+g39XP/Qw3NEakH6Wvdlg==
X-Received: by 2002:aa7:8197:: with SMTP id g23mr1161202pfi.247.1573020209675;
        Tue, 05 Nov 2019 22:03:29 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id u65sm23177676pfb.35.2019.11.05.22.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 22:03:29 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 4/4] dt-bindings: fttmr010: Add ast2600 compatible
Date:   Wed,  6 Nov 2019 16:33:01 +1030
Message-Id: <20191106060301.17408-5-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191106060301.17408-1-joel@jms.id.au>
References: <20191106060301.17408-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ast2600 contains a fttmr010 derivative.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
index 195792270414..3cb2f4c98d64 100644
--- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
+++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
@@ -11,6 +11,7 @@ Required properties:
   "moxa,moxart-timer", "faraday,fttmr010"
   "aspeed,ast2400-timer"
   "aspeed,ast2500-timer"
+  "aspeed,ast2600-timer"
 
 - reg : Should contain registers location and length
 - interrupts : Should contain the three timer interrupts usually with
-- 
2.24.0.rc1

