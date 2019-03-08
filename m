Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36525C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078E220684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/7Rtdnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCHJxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:53:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfCHJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:53:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so13788205pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 01:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KdrA7w857vF/J6Rv4FtIt5Pt5FulCSmKHvW432YnoTs=;
        b=w/7RtdnvtIp1B2l9eOJJ2BoM3qkg1ODchNfxZZKC7qEFhdhvPEvZR23ktrlrylMwiT
         V7qgfqU8vNQiC8BLVnUooVhTkuatt+mOfLWaCnAOQAiYID1wSo7VocVNZ6nsp1vBEIle
         ePC3tGlR2ngeTGtfJ64mZMdUPs8y/rRfWMsLKJpieeV/NHzRAkQSb/9CiCEFMrCYMu03
         Tq/VVR/r1sem5h79GJAWwrd/mrz0ophpy0/IR4S4/eVW5/8q4N3PZjGfvtD47srpGs7N
         uGLz/+qyetlyYqFiNfxOvN2cTtUpklbu0JUXZ5BCdr9dkDg+K+qw4o04VFeguNTYKBfY
         mjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdrA7w857vF/J6Rv4FtIt5Pt5FulCSmKHvW432YnoTs=;
        b=ICK1SfJWSAc5pllhwEKuh1X0tkIyPr0vm3dGgoFKWgqwBMICym8B2W7NtKVkJyvg0J
         SLLSjHEzZ/peAeky8dcg05Pe6iyGuIfe56/m827XEONkpOX5L0KO0xD/5JsUhjNAS5qB
         W9uG3w/J8K025BhNSuXsriZ3lgpGqRr4Aw6hmBvTr7AAhYbW4gVBF1smCOwWwDKnvfiM
         NPRR3Oi7NF980j+2EJrcNMku549dGMmXoQbaZWpUra8cYmU8YDEHtUCvpmXfXO9Twb1H
         eMcaInYizw+22d0rnZQ83x+Pvz/JbVp0JPHNUsJyAoWyqW6R8OgSTht/gYdFlrmZ/Fqr
         h7Pw==
X-Gm-Message-State: APjAAAUJptg7/Uog75zFFtks9joR3Ysqoz4u9M1Qosy2I1QrsTJ93Lll
        2m5wqdGlCJfh33roRUIekzXL1Q==
X-Google-Smtp-Source: APXvYqzOf/zfaabIrJEVCxYCl3UsAuTijQrVa+vYBpmpUcQxjZHI2sfYKFHdRjWaeYx8CVoITGZ/4A==
X-Received: by 2002:a62:ee13:: with SMTP id e19mr17598093pfi.224.1552038802182;
        Fri, 08 Mar 2019 01:53:22 -0800 (PST)
Received: from localhost ([122.171.71.18])
        by smtp.gmail.com with ESMTPSA id n6sm11688768pgh.79.2019.03.08.01.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:53:21 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        sunzhaosheng@hisilicon.com, jean.xupeng@hisilicon.com,
        yuwei3@hisilicon.com, gengyanping@hisilicon.com,
        peter.panshilin@hisilicon.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM / wakeup: Clear timer.function in wakeup_source_remove()
Date:   Fri,  8 Mar 2019 15:23:12 +0530
Message-Id: <40efd56ec468837baabd062f1c0b2fb748a9fc5c.1552038717.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
References: <621452804d6d22f72438614b6687f37282d883f5.1552038717.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wakeup_source_activate() performs a check to see if the wakeup source is
registered or not. It works fine for a newly added wakeup source which
may not have been registered but fails to catch the case where a wakeup
source is unregistered as the timer.function is still valid.

Fix it by setting the timer.function to NULL from
wakeup_source_remove().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/wakeup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 18333962e3da..3699faca24af 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -206,6 +206,13 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	synchronize_srcu(&wakeup_srcu);
 
 	del_timer_sync(&ws->timer);
+
+	/*
+	 * Clear timer.function so that wakeup_source_not_registered() can
+	 * detect an unregistered wakeup source.
+	 */
+	ws->timer.function = NULL;
+
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
 
-- 
2.21.0.rc0.269.g1a574e7a288b

