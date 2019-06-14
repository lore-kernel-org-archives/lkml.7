Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF30C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500BB2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESWZ4uf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfFNKpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:45:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45055 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfFNKpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:45:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so1976560wrl.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZO2she5ppWx2Q8JyWUBWFFhbTM0LwZQEDphClt9pDw=;
        b=ESWZ4uf2DPrhUI+Ux6Pq+ahq6nSiNhZTG8jYcSeneUseGmW75Zj5cES9mKbeDCc6p9
         rkH9TUYVfFL8T/oqamNBaMdVxz75eLQzbKBMZsyVDT7wiDKSChDULETjtxBqhwuFndPw
         TZUm26glTE4gMvaJXCT3sjc0RyDuL/6P+RLnKIIgn0BT2T8n4RttoCuuoNLtt1CoROik
         GuMF+wa/HsH+5732vb8HNOIViJR0mR03XSmuet05ieZmyyFHu2BpUG1BuSUiBN1tDmRq
         mwldgK0Wp8YJ7vBeg+ehpeG7x1JwT6Bh82aUhVFtz+iLGSW0YravjoQxptNj1fUDc193
         Ooxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZO2she5ppWx2Q8JyWUBWFFhbTM0LwZQEDphClt9pDw=;
        b=YoMnfW+MICIXJjAH2eTn1rXwezCiFx/RiZAKybYxuNtqL48u3mIecnSoKHwiRG49oM
         vm/xKdt30muXRcEDHVWmiVQZy30Pds1dTQY+8ExfPsnRYdFPo84nqxerX5xYpfzLRhAD
         a4cT7Jy43qoxftopD2Yal5ZD1fAjOw00cTIHD1viiUyy9IiVQcueDcbGMka8nmxaUeam
         NvV6IHRySlezLvBBIMPoKq2AVTdEYMH+oz68REf6tUDjQ7F47OQab5tstFKbsr36G/7Z
         KnT6eyX11g7sor7OC9NwivDbILSTQdHTEcB0WjtOrar/Fs3kJwmOsYQnJ043d0hOLZV3
         SivQ==
X-Gm-Message-State: APjAAAXC19qAiWs7K7LSprWZDadmeNgR8V2IUv1VIsCRgw9lYo42P18H
        EkflPttPL0rqYR01+A0OQ7I=
X-Google-Smtp-Source: APXvYqzdB/X7weMKQijAxhOggcNp+q++NTTj+4iEV8DKP91I/m3WEyO8E6DpxM49YTDL0DdPfjL5Mw==
X-Received: by 2002:adf:c5c1:: with SMTP id v1mr45897548wrg.129.1560509114552;
        Fri, 14 Jun 2019 03:45:14 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id d10sm3746676wrp.74.2019.06.14.03.45.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 03:45:14 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clocksource: Add suspend clocksource sysfs attribute
Date:   Fri, 14 Jun 2019 12:45:10 +0200
Message-Id: <20190614104510.19360-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614104510.19360-1-thierry.reding@gmail.com>
References: <20190614104510.19360-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Allow the currently selected suspend clocksource to be inspected via
sysfs. The suspend clocksource can also be set using this attribute,
which can be useful for debugging.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/time/clocksource.c | 53 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 467b36d2f9f8..d963bcecbc96 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -489,7 +489,8 @@ static void __clocksource_suspend_select(struct clocksource *cs)
 	}
 
 	/* Pick the best rating. */
-	if (!suspend_clocksource || cs->rating > suspend_clocksource->rating)
+	if (!suspend_clocksource || cs->rating > suspend_clocksource->rating ||
+	    (suspend_clocksource->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) == 0)
 		suspend_clocksource = cs;
 }
 
@@ -1172,10 +1173,60 @@ static ssize_t available_clocksource_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(available_clocksource);
 
+static ssize_t suspend_clocksource_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct clocksource *clksrc = suspend_clocksource;
+	ssize_t count = 0;
+
+	if (clksrc)
+		count += snprintf(buf, PAGE_SIZE, "%s\n", clksrc->name);
+
+	return count;
+}
+
+static ssize_t suspend_clocksource_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct clocksource *cs;
+	char name[CS_NAME_LEN];
+	ssize_t ret;
+
+	ret = sysfs_get_uname(buf, name, count);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&clocksource_mutex);
+
+	if (strlen(name) > 0) {
+		cs = clocksource_lookup(name);
+		if (cs) {
+			if (!(cs->flags & CLOCK_SOURCE_SUSPEND_NONSTOP))
+				pr_warn("using non-persistent clocksource %s for suspend\n",
+					cs->name);
+
+			suspend_clocksource = cs;
+		} else {
+			ret = -ENODEV;
+		}
+	} else {
+		clocksource_suspend_select(false);
+	}
+
+	mutex_unlock(&clocksource_mutex);
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(suspend_clocksource);
+
 static struct attribute *clocksource_attrs[] = {
 	&dev_attr_current_clocksource.attr,
 	&dev_attr_unbind_clocksource.attr,
 	&dev_attr_available_clocksource.attr,
+	&dev_attr_suspend_clocksource.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(clocksource);
-- 
2.21.0

