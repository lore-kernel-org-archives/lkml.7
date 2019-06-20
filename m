Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622B5C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D0D2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odDqhRBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfFTVKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:10:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40188 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfFTVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:10:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so1889373pla.7;
        Thu, 20 Jun 2019 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nBLqKjSVrBp381m0eswowtTt2XvGMCRYc4oh6uPOArU=;
        b=odDqhRBWBoc3kunhmHJB492EcjJwrhFnyXSUVW3/CoWDvFNgUyRMRIvvo6XsI+hRpC
         F8PK8A4AnBpq6wLd0H7Pjr9ZGlp6xHPWKnQFGO00cnPVFoJ/lyFb9pdg4jra3fGKxQEU
         2X3q20gRCZDdgRqN07nqK1bFVIAlAbplibG1x+sLxagcy10U6sMBk4oNYWqHoncvtpPg
         oERoRdPPpL2cBcuymbSzsj1Fty4chUNuNV230KR63W3ofdO/Ydca1wDvHnklAChhmpXf
         iqogw3hGzMxaVxmddB9nF6KsM+TmyR35hKtNUGKFttAKPS9ESWc5O3JpHXLRf+TeEwRF
         r3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nBLqKjSVrBp381m0eswowtTt2XvGMCRYc4oh6uPOArU=;
        b=pHz08Le6tZRfLPIGDLxMfm8EQngjEYmkFZoBHlLKz6uowVMlBbEE6D8swpjFd+7jtO
         gzDvvpM7UgnGeKO9iE87rN+i7eFmpdjn55NOG+67LOs356wWtloJ9a/pfga89yP044ae
         DfXF1Kl/379ognT72/BcrKgCX0+cAR+V/NCjeXbkfr460W1cHjT1+jcd2d7a+QRI9B+7
         rNFbgCiNx3LPyontYnwJP3LiOtAQm89LVd2gIZetH5AcvMI4LiLgDMqleus33ymU49cl
         FQMSnSY2zkW9zywC5vNGSNQD9100cXCY7BK3qHij0cR7GQ/yMPAvOnhVfYQkE/WM53Pi
         8Z+w==
X-Gm-Message-State: APjAAAU7grOSWOUf6m3DaQIqH0zzwBgGKVAfsj7yf3wFABXAt9CKoogM
        x1JRQKhCA/CLVMc6CM2lOpWQ4fV8xOA=
X-Google-Smtp-Source: APXvYqwQeDcUXcq5wDH39La0AxAdtmC0QX43bHAhnAlNJBq86E2hHf1IRQ7lkIFgYUWZ30soK4xk5A==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr127805856plb.258.1561065018506;
        Thu, 20 Jun 2019 14:10:18 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p1sm386805pff.74.2019.06.20.14.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:10:18 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 6/6] usb: bdc: Update compatible match strings
Date:   Thu, 20 Jun 2019 17:09:51 -0400
Message-Id: <1561064991-16874-7-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "brcm,bdc-v0.16" because it was never used on any system.
Add "brcm,bdc-udc-v3.1" which exists for any STB system with BDC.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 15e28790142d..e2b2628925e6 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -644,6 +644,7 @@ static SIMPLE_DEV_PM_OPS(bdc_pm_ops, bdc_suspend,
 		bdc_resume);
 
 static const struct of_device_id bdc_of_match[] = {
+	{ .compatible = "brcm,bdc-udc-v3.1" },
 	{ .compatible = "brcm,bdc-v0.16" },
 	{ .compatible = "brcm,bdc" },
 	{ /* sentinel */ }
-- 
1.9.0.138.g2de3478

