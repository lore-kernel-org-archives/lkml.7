Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B339EC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881CB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c9/kS111"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfG3SRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:17:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43941 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbfG3SQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id r22so2876955pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKD21YltjNdX0Gh4aRiK3v6esh13LM/jUbhsmCEcsM8=;
        b=c9/kS111G3SGImYr1U5vCbj0hdX0U7JXwROeG49nc6dkg0afxl5NMuC6U0VYyvNoml
         IQ7k9VCSv8yu7OhA1vsV/1QXI1xTj1+8lh0VVirk0n2tUisVVdmz9ZNIWsz5X55idcjN
         hYzGHEpH+7gqW/uQVu/s2qHD1YFhx1L5qIWS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKD21YltjNdX0Gh4aRiK3v6esh13LM/jUbhsmCEcsM8=;
        b=CKqyr31NsGbvdR/hshrqMUqcTXZ95LbiIle5XG6uSpMPhpjiJxyT/X1laHYAgbQd6g
         xmQZZoLhTCWOYWpiw+mly1WLqjbWN7uZevI3aMgvIlXVT6oFDA+lBA7AknEd7ungGrUD
         GFwXfJmO5wwoZ1+9rpeekLGLFHUJEBhgrWuqjHpsKg6vBR0iCMAOtrAfJUjsL8pHL8j4
         EZfpEU6Porg8YihjvGP6nXjgQPpIl6VCXtvTrBVXc0a0H8iTz9aLhnO2cTZWf7fifmDU
         7h7NIikoSDVRyg0xwLQTBt+M43xxDUTEcqNKxYAeqUwDBGAgDXzN6fArGTafRZvK/n/s
         UV1w==
X-Gm-Message-State: APjAAAVwD+DWl5Hb68pAeJQoXI0LPGkM/IaVTH9Qre/a2eM6cvOfQDrU
        Xgz2RTuyh78ZVJJqW40nMHv6j6UpNC8eSg==
X-Google-Smtp-Source: APXvYqzToMhXlwFnTe0eItZa7Mbn4k5gYXMT9SLGPEuDAtawXB9pVcnXtqUyvvp+gcIgurPoOgRswQ==
X-Received: by 2002:a65:4844:: with SMTP id i4mr111825638pgs.113.1564510602339;
        Tue, 30 Jul 2019 11:16:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Roman Kiryanov <rkir@google.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v6 52/57] platform/x86: intel_pmc_ipc: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:52 -0700
Message-Id: <20190730181557.90391-53-swboyd@chromium.org>
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

 drivers/platform/x86/intel_pmc_ipc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 55037ff258f8..5c1da2bb1435 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -936,10 +936,8 @@ static int ipc_plat_probe(struct platform_device *pdev)
 	spin_lock_init(&ipcdev.gcr_lock);
 
 	ipcdev.irq = platform_get_irq(pdev, 0);
-	if (ipcdev.irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq\n");
+	if (ipcdev.irq < 0)
 		return -EINVAL;
-	}
 
 	ret = ipc_plat_get_res(pdev);
 	if (ret) {
-- 
Sent by a computer through tubes

