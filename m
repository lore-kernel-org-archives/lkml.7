Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF1C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FFA208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zueC8Wpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfDHKRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:17:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43472 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfDHKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:17:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so2509796plp.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvgHnd237oGngw9Iinl1xldDc2z2stqnIQlwZoYfjL8=;
        b=zueC8WpuxIqagO4BEiWCRrfweXmf3rgrtBQl18HqTlVu/XemFE6zb/4jIIpKrpD1YF
         R4KxXtmEu2reSa2S2xvxnJftqsWpntxujRrIzaTwg/rK+0cS/uMD73fJoTyaX33Bnc95
         NN6649v9tlMLFbKPMCYyBZLomVJ5JoUjspECz8q1TckjNcQi3EbQiUm1/pkBLuStQrHA
         RPdRKVHeeEUJQA4z4fle9OML12g3zOhAHDhE2A3d2z1IB5TCrbhqzXKEPFUsKg/fn7mk
         zmaD1YTFPQlYgc3sxuvz0PECvJvMreIx/TfBampSzd1tQs2+MXSvv0IWxs+IukCKBe39
         RCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvgHnd237oGngw9Iinl1xldDc2z2stqnIQlwZoYfjL8=;
        b=cTe5EglSqe9rYfD5Ui5UO1rReU5tNlYMiKQbcXpewMuMAY/sT4yuuzhvgSgid9OBLJ
         NBkU+wQTkie6AzdxvWJknLbbxZIzs26AhB/ic1yb+OYw4rp5/XAdYfhxa1GJUXTiGYew
         XvuLu6UKgNA9BBkLhkYXOVjNV8p+DwC/K/HLFml4wqlHpRoK9Pz7u822r4Dvg6rISCoj
         1kSpwmfTz/8fva/LgulHjb2CLSm6oHnDgesju3yP6VWEYMh9t8IyFxbm9Uhrv1CdMlNH
         PnnE306IY8uG/u/bvz4uYFL5UJXJDjQV2GUaNTV7kYlUKq4ZplyMwuT6CWUC/JqFN/f1
         oQ4A==
X-Gm-Message-State: APjAAAWsTGq14O7AvnKLfe7fmblkiq0+Q8WkWT5RA0JXSQPszhQQxJZB
        1Mhrk14JfUF7TSYJk8Xq2b7PPw==
X-Google-Smtp-Source: APXvYqxsabb57g17JjGkijyv0MPiOezy+yODG2vSbtwqDOIKtkRI18jF+LEtkpLgbamChVoujMlHig==
X-Received: by 2002:a17:902:28a9:: with SMTP id f38mr9577120plb.295.1554718633578;
        Mon, 08 Apr 2019 03:17:13 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id c1sm41202562pfd.114.2019.04.08.03.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 03:17:12 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: maple: Remove redundant code from maple_cpufreq_init()
Date:   Mon,  8 Apr 2019 15:47:06 +0530
Message-Id: <dfb046a881d254f5133e6a1f86a04f49e73c56f9.1554718622.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The success path and error path both look the same, don't duplicate the
code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index a05f1342ec02..a94355723ef8 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -231,10 +231,6 @@ static int __init maple_cpufreq_init(void)
 
 	rc = cpufreq_register_driver(&maple_cpufreq_driver);
 
-	of_node_put(cpunode);
-
-	return rc;
-
 bail_noprops:
 	of_node_put(cpunode);
 
-- 
2.21.0.rc0.269.g1a574e7a288b

