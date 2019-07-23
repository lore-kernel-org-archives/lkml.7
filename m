Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165FC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0CE20578
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5ctZVOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbfGWGOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:14:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35261 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbfGWGOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:14:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so12554365pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jB85xxBwApqxzP5t70awnp6QUVo8jjK/SH2bjct3MZE=;
        b=G5ctZVOyf1e2+mEbnsRNWd8L4HRAYyjqt9+LW4CUAh8H5q1QIFrn68m3DxIA1i/Ola
         XOm1L6f/TFr3BLsK/WRE9ka7TxXewhH3vqqKhEt5lrHGCaTxB+i9oKHNY2JalB7+nQZz
         W4FrpBrZ76Ci8SwLkhQ+H61D9Hi8YB9BsEFLjYpj7n9p6zZe19Pmitda/4B/N8NCCRrc
         XBtt1T/Gq4Bg0Kk/8GWDxdLw8w98y/jeZhrqcToiBoVkXh0DBpddlpEOMlqsU64KdWzF
         WxedSaGzqwXztSOwKn2w+K8gz7NFPiTwtsBnotow/RWB/EPeQtW681nVz/fFoikGlctk
         gXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jB85xxBwApqxzP5t70awnp6QUVo8jjK/SH2bjct3MZE=;
        b=E8hjcaS2qJzkJ1YKjLWphplXeyyE603IDdda8PcAB9eydKookm7W+sf9ToPtaqkRfn
         0k0pVQWuwyjZQvJWgkJSyhZfQsHnIC47akKtSaFi8w0AJkmZT25sojJcew5R8U5a5YIg
         EanmRRlJsG7093V701xU1B6lvKCoS/s9gwvrBKt/wYVq/c/flO4pXmHSv531Mf182YmU
         UnNxGSubi2MBsl1zudDlbKt9m6zrn5/ck2TBjTFUpIYJASfQNkkh0+wVRWyLOmdb7TWX
         TWFSC628R9uxd8vCoRVqrR+hvHrmCrz6qh6V5cqk+Scz1sk4+Wc22VAUsVfYsSwv1eCG
         qLJg==
X-Gm-Message-State: APjAAAU8Np1UN9pJi0tm4iXVfdfot347aDnzdlwHuzCSZ0PPJrirInC5
        MiNXWFVy++3s0RXxQvDrDIAfUA==
X-Google-Smtp-Source: APXvYqwU0A/TlI3oMcWf9epZVKEkNmKmLXf4L5BQu4ya3hv/M2F2HVj14WlyVn1mUnpdkXuC3LZuZQ==
X-Received: by 2002:a62:6344:: with SMTP id x65mr4282837pfb.111.1563862480370;
        Mon, 22 Jul 2019 23:14:40 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id q1sm49359764pfg.84.2019.07.22.23.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/10] arch_topology: Use CPUFREQ_CREATE_POLICY instead of CPUFREQ_NOTIFY
Date:   Tue, 23 Jul 2019 11:44:06 +0530
Message-Id: <3afc5046ba9435d229a004c17b005197488006d4.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUFREQ_NOTIFY is going to get removed soon, lets use
CPUFREQ_CREATE_POLICY instead of that here. CPUFREQ_CREATE_POLICY is
called only once (which is exactly what we want here) for each cpufreq
policy when it is first created.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 63c1e76739f1..8cab1f5a8e0c 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -174,7 +174,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	if (!raw_capacity)
 		return 0;
 
-	if (val != CPUFREQ_NOTIFY)
+	if (val != CPUFREQ_CREATE_POLICY)
 		return 0;
 
 	pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
-- 
2.21.0.rc0.269.g1a574e7a288b

