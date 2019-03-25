Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716EE20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erwGFrez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfCYKdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:33:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45781 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbfCYKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:33:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so5247275pfi.12;
        Mon, 25 Mar 2019 03:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Olh6FGvB5iAKqIVmq/9M4GY/Pmghh0Ho/NAjNxudRBo=;
        b=erwGFrez9dfEhb0ta3Ew24ImORva5+K59kcX93MK6NYBZyALHhvCTbUpopea1H6dj4
         w6lMfpVVAmSJ4tUrjD6Bp4jceYF8BOi4tNGKuvCG1JuD2Atpn/a1hu2bAUueFcHNuaq2
         HcqRYiNwV//JrT1mSCCWnClIpjx0Qy/cN7aZGdoxH1Am2xP2FoemNSnfy5UQwgCF8qu3
         yqoJiHViVxCPxXvmaz+bkyEKafXyhrcRo77fJpYQVRMsQQtQG4OzLX9jcLy1K8zumnUB
         AtB91f4zGKt7rB7QxZaMTTqztDQQU6OJLsfsfYyzF2ys9NYIRZGmYCnJnJBdaTf7hm8i
         aN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Olh6FGvB5iAKqIVmq/9M4GY/Pmghh0Ho/NAjNxudRBo=;
        b=rG+DZ/Pv20cLE4D1mxon4esWF7OXRE0xZaYQXeJkQZEOm4gDZTLV005q8PiPD3+5/D
         4MFKUw8pqxiqP4a6XLblvtLO4lo+80mKANBYo581PHrvGg97nsoA2ous1GaLSo1TGf86
         jRdVTFcPQrnheHnHmaPuN1QobaMNOY4qJSYDBOyHJQh+psmbH7biCjla00dbn5uZxF8b
         l8bF6adlzh8q2JuGkKPHsfV+8JBjJ7xjdGILWaCacj0W+rNUiDAe+Y1Ea0BcFxtkZLdJ
         bI21KelT7fS9TrIa7/2IlvoD75Qhf73jbi8YD2u9md3V2PAJyK/Vf8BBJnvXVHTAaemC
         EiGg==
X-Gm-Message-State: APjAAAVfoeALt/Y2GjBXyf9Ii8ZoTVWXFWtOkoNk//O0JG1lQav6Er4K
        l7SCfexUbrdFn6/yPN0PAbmo8l8W
X-Google-Smtp-Source: APXvYqxdq6I9Or7EqCqWlAPuDB/aj6ePj5PruJ87dyN1mrLqAYEfVPje5mbPccdZWB8DGfQsTZLRjA==
X-Received: by 2002:a17:902:70cc:: with SMTP id l12mr5963347plt.10.1553510010099;
        Mon, 25 Mar 2019 03:33:30 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id 1sm19221470pfi.99.2019.03.25.03.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 03:33:29 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation); Mon, 25 Mar 2019 21:03:22 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: rtc: Correct location of rtctest.c
Date:   Mon, 25 Mar 2019 21:03:22 +1030
Message-Id: <20190325103322.2578-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The useful little rtctest program moved location a while back.

Fixes: a12ab9e125f1 ("selftests: move RTC tests to rtc subfolder")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/rtc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rtc.txt b/Documentation/rtc.txt
index a129acf38537..688c95b11919 100644
--- a/Documentation/rtc.txt
+++ b/Documentation/rtc.txt
@@ -136,5 +136,5 @@ a high functionality RTC is integrated into the SOC.  That system might read
 the system clock from the discrete RTC, but use the integrated one for all
 other tasks, because of its greater functionality.
 
-Check out tools/testing/selftests/timers/rtctest.c for an example usage of the
+Check out tools/testing/selftests/rtc/rtctest.c for an example usage of the
 ioctl interface.
-- 
2.20.1

