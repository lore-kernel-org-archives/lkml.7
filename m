Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFD1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6020661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="y9p1pYFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfCFLMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:12:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33628 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfCFLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:12:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id c55so10010545edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 03:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLBy4rUf+vwVDyhcvFboGzgSFexgJ/70lYXQZKoXH4k=;
        b=y9p1pYFhwEaq3LqfnJdglnV1zJAJ4xGkgGq5wzbEgT1+UkuRR6t4d5J3WPn8HqGMSY
         LKi0iJ3wlMM8qvq6tbSqQjkM8liBb9EraZim9KPvz6z1MyOTksQdZl6LRNY3XWlDB0Nu
         ss3KYheIT+W7gPiW4ARMo8a+V75DTmziu24wb9EquUd/XPUwZYo0MN8tlGObQsmqzK/S
         qhDhJAuR+zIZuJJ8VnJjBuN99Uyl3UYfmfuNIVYAq8uj+VSA90b55HN3m7l8EEzb8R3Q
         YDAScUlPWi8ZsYWtJBubDhE9YaeOTRspZT66yRyN/enuoFsaI2xkrhyTDtE1sODjDAOy
         RWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLBy4rUf+vwVDyhcvFboGzgSFexgJ/70lYXQZKoXH4k=;
        b=ksOEk/dlF3X+0AYJDSk32jckisafGo1fVtLlwJGHCW05w0jAKFY6PcrWSf25Mdf3GD
         pJrhJC2OwYe7c3P3CCHEGwrZPBxyfulwiYUmVvdmg9/dbzBaObXIMreLVu2EUMv7jTK6
         xQQJ+FN/314hYI4nHbY41mOid82RLnEUEkfX9l5r+j1ymhfrAInQDWrojshauU4ve0Sn
         HXr9Zs0K5719QQh8kQhi2+NiTMSuhSOfy0GRS5R25jzG0A6Bo/efixYzBoK/00DwdRzq
         +5nDqVcw9rwbf0S0ebJv5NQXN+QZ6i2vdbVRe3kwg4FoM8lA+wy/dDUuV4+T2/wsYlO3
         Fn2Q==
X-Gm-Message-State: APjAAAWy47jhLRWsSoPtTVek5QGyno28aUL4aSRNsmM0uUZTjaJEvIRP
        445afkR4gZ5JH45qVGvo0i+K5g==
X-Google-Smtp-Source: APXvYqwxJtV24srsDX56efa9N1UEgqc1JG9cFSnmXyVxIL2iePPXuuVUOXdmtG/8E3Ku/SVZz0q+8A==
X-Received: by 2002:a50:a2a6:: with SMTP id 35mr22337546edm.227.1551870754602;
        Wed, 06 Mar 2019 03:12:34 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 03:12:34 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 6/7] counter: ftm-quaddec: Documentation: Add specific counter sysfs documentation
Date:   Wed,  6 Mar 2019 12:12:07 +0100
Message-Id: <20190306111208.7454-7-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the specific prescaler entry.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes v2
 - Add doc for prescaler entry
---
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
new file mode 100644
index 000000000000..2da629d6d485
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
@@ -0,0 +1,16 @@
+What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/prescaler
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the prescaler value associated with Count Y.
+		On the FlexTimer, the counter clock source passes through a
+		prescaler that is a 7-bit counter. This acts like a clock
+		divider.
-- 
2.19.1

