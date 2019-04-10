Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3033FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F139220830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXkahYLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfDJJz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:55:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40375 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730265AbfDJJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:55:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so1502554ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IdJSlX082YGa+o2RjrcHVg2ClWPcfT2dSVotJi56VHg=;
        b=LXkahYLKzcDWcov3EhmrnSqF7l0ZXLldbNSWy+3WOKivzEWNVsDEMAc/w1fGAJ0d+S
         jU+gZtakF/P20vRD0HTjJydZ0aodQzLjGq1sxd7k7PMNOCTsAYwSdIMuxElevBFQbOsE
         oelE3y3dezV9zqaCi//YyPIEGhlmkX6pCoER0fRz9WRyqRXOToansJreNKndeL0vud5f
         MtXOSNFAk98IV0gHyxqzBdceik6Fls+cTt+p7vAbsGxieUdDdkJRRuH0YIjLomA8qS9F
         B1UBFGwoqaeC9YQZFqO0vnTdET8iiYBdIq6ceOmemhmAz+LCCRV1JpTdrL+YS8+RjKWS
         Lvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IdJSlX082YGa+o2RjrcHVg2ClWPcfT2dSVotJi56VHg=;
        b=BGGly5QjQV6FYuGufINsCMFj5f7nquiPhSQQCq0FMFwU/tJ4F7/hhPEEy+wOB+mUOu
         NMLZ0jyMWj/OKS5BWkT+9I7txD23A0ZZukRa+Oi9gKwy0UrEkqAdk4qwhDd3lchRnI6i
         BTiQELgobIXFf+12ph94KDi6FofIY9qVbxHTfBQl/Xh2jg8xaQXZYFwWCkU0k1l5pbH3
         rq+ubMZjLeg2q8k2nCXLgidvOK98hzt2CH58YsdC/dRw0ALX77IZ5VJ6nrZ0ikRJgakJ
         GU2pOVJanX5lRDlGoIFtucJjwOaALYP8k1cek0Fsv9bkbcaQmvIRhLP2Rj8PCvjh8+q9
         BlKw==
X-Gm-Message-State: APjAAAXcco00GuUXeoVSWm3Oq2gVK8lJj4EVy0w52oexADS0HFKgrJxo
        V42eULSIBjD64Ognu9hm7XlFig==
X-Google-Smtp-Source: APXvYqwk7081QudqCuERp6RleVPoGeEKggtgjEdb4dksKdX/YeywMTxgd+NhOrUbEYXQ2jg1bnL9HA==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr16508925ljg.136.1554890126771;
        Wed, 10 Apr 2019 02:55:26 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id h3sm113941lfe.87.2019.04.10.02.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 02:55:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / core: Propagate dev->power.wakeup_path when no callbacks
Date:   Wed, 10 Apr 2019 11:55:16 +0200
Message-Id: <20190410095516.6170-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev->power.direct_complete flag may become set in device_prepare() in
case the device don't have any PM callbacks (dev->power.no_pm_callbacks is
set). This leads to a broken behaviour, when there is child having wakeup
enabled and relies on its parent to be used in the wakeup path.

More precisely, when the direct complete path becomes selected for the
child in __device_suspend(), the propagation of the dev->power.wakeup_path
becomes skipped as well.

Let's address this problem, by checking if the device is a part the wakeup
path or has wakeup enabled, then prevent the direct complete path from
being used.

Reported-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

More background:

This problem was reported by Loic Pallardy, offlist, while he was working
on enabling wakeup for a tty serial console driver.

When I looked more closely, I noticed that uart_suspend_port() calls
device_may_wakeup() for the tty child devices, and then also the used serial
driver check its device (parent) for device_may_wakeup(). To me this looks like
workarounds to fix a behaviour that really should be dealt with from the PM
core, no matter of whether the child have PM callbacks assigned or not.

In other words, it seems like the serial driver(s) should be checking the
wakeup_path flag for the parent, solely, instead.

I haven't digested further behaviours for other subsystem, but recently
reviewed a patch for a gpio driver [1], that seems to be suffering from the
similar problems.

Kind regards
Ulf Hansson

[1]
https://lkml.org/lkml/2019/4/4/1283

---
 drivers/base/power/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 41eba82ee7b9..f9cfdeee8288 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1747,6 +1747,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.syscore)
 		goto Complete;
 
+	/* Avoid direct_complete, to let wakeup_path being propagated. */
+	if (device_may_wakeup(dev) || dev->power.wakeup_path)
+		dev->power.direct_complete = false;
+
 	if (dev->power.direct_complete) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
-- 
2.17.1

