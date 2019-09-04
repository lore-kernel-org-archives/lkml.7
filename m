Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DDEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6625420674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar7mAQHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfIDVGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:06:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36369 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIDVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:06:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so182335qtf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaZIRIb7eWDZUmuFUvyLJZmPVK7Rr9RueiAiw2bvhuY=;
        b=Ar7mAQHarWzTpLuNkoxVGscFW2h5Z1XgkkQgf6T1ze27edjg8vNPRaiXl1tvdFHGKF
         VFBnKOgaShRFEX3uP/UUK9PyE0le4/R7wUeL6ysQUCuB13lQs370sLLc/jK5UdVF8HWw
         1oGzQvU6kYV5c9VbZqCNTb0aqrJNzOeTn/HjjI0+J1Jw2oTIkyzncubeh3Qjj5cM/EEp
         A/iB3BZjPGM5dyBJqmkXedT96aXWQB6l5iWExy8yCss7TRtMMLQVbTsVPsF4QbdIQ5d7
         qYiokp++onnRb9W1XQtbmbH1F9xAvDk+yT8N0Z038LrHIlEXMXqGXsgrloX5qhVdrsFo
         vwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaZIRIb7eWDZUmuFUvyLJZmPVK7Rr9RueiAiw2bvhuY=;
        b=SBmf0HSXIRTUYiEdatNLp34touDCg637aLxTO+z4iErSflx6ktbFVYNV0TrIllq5JG
         k+2WTPOdYHrn6yplcExQPaYSVmWec/XSqHB7q0X3i7YCKV1koGB3zSAwxnjdiXUkMj29
         5W4XMZQHbB7ekH05A1EHY/Y7tUXUmPbssNbz1MUWp4CkK4CQIwa/xqxNgA6cD1+DkfNS
         V5kuUIjWlvZxGb7yecSAgOl3NEpM4NlbhyWr8IAiUepE1SYnpBSj3+iCcCnmveGCraLp
         qKg8+2DKEDcnzMC28W/V/RQehb/FNPbYRp40LuVWcDpjqAqkYRNyKifIErcRkSjwKY02
         VoBw==
X-Gm-Message-State: APjAAAVcH+sAXpyausfdtHeFKmL13CcDuxLpjNWw5/xBMRYICkTNFyfy
        X6kh4+RH9tIUmvuRDWjxnNg=
X-Google-Smtp-Source: APXvYqwVoEzX6KSezOYOFf+WK2aIAr87DU49pQjAfxp0pf9UKtZOQWsSmSLyU+3HlWu+KMfP6vmIUQ==
X-Received: by 2002:ac8:92d:: with SMTP id t42mr105126qth.206.1567631184313;
        Wed, 04 Sep 2019 14:06:24 -0700 (PDT)
Received: from 24a3ceb039de.ic.unicamp.br (wifi-177-220-85-167.wifi.ic.unicamp.br. [177.220.85.167])
        by smtp.gmail.com with ESMTPSA id o127sm86871qkd.104.2019.09.04.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:06:23 -0700 (PDT)
From:   Pedro Chinen <ph.u.chinen@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: greybus: loopback_test: remove multiple blank lines
Date:   Wed,  4 Sep 2019 21:05:47 +0000
Message-Id: <20190904210547.5288-1-ph.u.chinen@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkpath warnings in multiple lines:
CHECK: Please don't use multiple blank lines

Signed-off-by: Pedro Chinen <ph.u.chinen@gmail.com>
---
 drivers/staging/greybus/tools/loopback_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index ba6f905f26fa..1e78c148d7cb 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -779,7 +779,6 @@ static void prepare_devices(struct loopback_test *t)
 		if (t->stop_all || device_enabled(t, i))
 			write_sysfs_val(t->devices[i].sysfs_entry, "type", 0);
 
-
 	for (i = 0; i < t->device_count; i++) {
 		if (!device_enabled(t, i))
 			continue;
@@ -850,7 +849,6 @@ void loopback_run(struct loopback_test *t)
 	if (ret)
 		goto err;
 
-
 	get_results(t);
 
 	log_results(t);
@@ -882,7 +880,6 @@ static int sanity_check(struct loopback_test *t)
 
 	}
 
-
 	return 0;
 }
 
-- 
2.20.1

