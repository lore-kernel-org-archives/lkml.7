Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D415C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C904214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqCViXMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbfDRK2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:28:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39138 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388301AbfDRK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:28:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so1469530ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b4/z3HQphjEsvzH3BgLLETGidZtveaIsWYroUmoxADE=;
        b=dqCViXMVuDoEwPYSCRyR3gFK2YRd4ueBMYYsoKTDZBk8/sNQkdFgQyT1ulkoSxCdGD
         iAhP8JNaZwj2TCmXl4f7ZzxEBDd92pX2a3LfqUSWUStUGvg2OeFOK61rFvWTIAyj626k
         rIrTAHEyRISdxXMPD4TfZNgc9IfKh1Yw6kYNGVf7DZKue9bcPUal+pbuBTdioRI5UYzQ
         g2s6uRAlhuMFHEZy5QD79ISiwzLfRgqYfdl5sPwWyty5j7YnpeEl9aTv2FrzmZav7vqB
         B8UbnnltODguhp/+BwLPZyxW6LL/Kai69tJ4yKtrwHIGTv7TVRk6kdHzYn+nmUzxnAVO
         gZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b4/z3HQphjEsvzH3BgLLETGidZtveaIsWYroUmoxADE=;
        b=adgiZ5HPk2nmsjO5kmJHAIjTe3svCQ/7jOdOSsQJYmvf+BL+UToIDRtwm5vix5qvNY
         z6OVLHZf9eNcYstpS360JvtY30AaNheYVnjyoM2HLvKCGFdPdqpuA+S2H9TDGDmsAYWD
         dqEsk4CVCWlczoX5mNfLx0KpOk1+WKExg2qTo1uJjsdZ72O/3VFYxUWx7sPXhkQyK6fh
         Ie1vE27pm8mSz/X9qy382cgkhqPai4t3NLuiNioUES3oHNxoEgYOj5KBG3e3Opqz4jpm
         2trGiaEl8NkXaVrf9GdWr7++iaz7J+G2RwWjQORLm7rSxQIqIa9NVIiPcAchI3Rva8Qs
         kG+w==
X-Gm-Message-State: APjAAAWmVr9MAzfVqRZ32sAbBaFm2d6PxpjkPJ6NecSIt+NI4d52MH8B
        bCelnf3D2k6WD4TP88zveL7MzQ==
X-Google-Smtp-Source: APXvYqyP2XTwEGKrSJgjpvfp4q5+IvD+SZE8dUmwojxp2fDrWNFrJxnGtyOuJAGcHcPBpX8n/+BePA==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr37663132ljg.93.1555583284116;
        Thu, 18 Apr 2019 03:28:04 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l13sm320409ljj.96.2019.04.18.03.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:28:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] PM / Domains: Don't kfree() the virtual device in the error path
Date:   Thu, 18 Apr 2019 12:27:55 +0200
Message-Id: <20190418102757.1246-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418102757.1246-1-ulf.hansson@linaro.org>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not correct to call kfree(dev) when device_register(dev) has failed.
Fix this by calling put_device(dev) instead.

Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ecac03dcc9b2..7fec69aebf46 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2528,7 +2528,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 
 	ret = device_register(virt_dev);
 	if (ret) {
-		kfree(virt_dev);
+		put_device(virt_dev);
 		return ERR_PTR(ret);
 	}
 
-- 
2.17.1

