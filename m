Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A240C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D70C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iltPRF12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfG3SRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:17:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40026 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388148AbfG3SQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so30484908pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+ftxlHygcLTMnV6ovKYGNOcO/becl15s7w7AJh5ieo=;
        b=iltPRF12M4kTR89xqPOF1f8ILEoGf9Uhmw+ZsFJao7VfBq8DZDGzzspUsv5gSSUnbQ
         ZfWQOFp0qryiJFz3QGQRhNLk9NL/WrtFqrAO+ZkqnSVIWHd95KOg/xXuUb2xQrYbKz9K
         QNqmf5or4Tl2FU5FIGqqdhqu9FgWFEtPtZ/8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+ftxlHygcLTMnV6ovKYGNOcO/becl15s7w7AJh5ieo=;
        b=LO7wNRtJ9MYFFLcg8wv/wqXty33yCzFDPUjHMDPfZMdhCccfHN5XAyIvSoNsd3+ACy
         vnh6pWbZf3i5c8O+b5hUvNX/XIYBtpZdPh+lswMe0Mlkd2JQnOel4l8rBPCPi3lCkZ6e
         7O2ZbIl0elqd6/fxr/xDmoBLTYUjgpkk3NH58XN0Gxln/gRvgjOEyOSYzhmQbMbNEHu5
         wKhaSbWyN6D4IWdn/ddIejBH+8Rfr/NKs8yOUKMAHrPnCxGSu9h16QXYw6e/Ji/3ABub
         65XziEVPenXmsNIvl/fdnqj8hWC0PGOkyuS2La866bJuf56Q1fQkiIZVnqdCqs3+R7NC
         kWrA==
X-Gm-Message-State: APjAAAUOqsjDun4EiOQS18hRn5SbH+IzUCj0ckIYOJcSlDzNOsfYIHVy
        IePLhSoBO62Qn52f2KvrUq4R9B5LgeImuA==
X-Google-Smtp-Source: APXvYqxRypCVtQvbF/lW3j9E9/Kxp9ws1ALm7ty5+QabMPmOJLd0mrApno2hJBvadBUilpRGz1i0/A==
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr121483484pjg.116.1564510604198;
        Tue, 30 Jul 2019 11:16:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Roman Kiryanov <rkir@google.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v6 54/57] platform/x86: intel_bxtwc_tmu: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:54 -0700
Message-Id: <20190730181557.90391-55-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Darren Hart (VMware)" <dvhart@infradead.org>
Cc: Roman Kiryanov <rkir@google.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/platform/x86/intel_bxtwc_tmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_bxtwc_tmu.c b/drivers/platform/x86/intel_bxtwc_tmu.c
index 951c105bafc1..7ccf583649e6 100644
--- a/drivers/platform/x86/intel_bxtwc_tmu.c
+++ b/drivers/platform/x86/intel_bxtwc_tmu.c
@@ -60,11 +60,8 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 	wctmu->regmap = pmic->regmap;
 
 	irq = platform_get_irq(pdev, 0);
-
-	if (irq < 0) {
-		dev_err(&pdev->dev, "invalid irq %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	regmap_irq_chip = pmic->irq_chip_data_tmu;
 	virq = regmap_irq_get_virq(regmap_irq_chip, irq);
-- 
Sent by a computer through tubes

