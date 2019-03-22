Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C983C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA68A21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nkc/3J5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfCVVzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:55:08 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49488 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCVVzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:55:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 3BD40B11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 21:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PWLfHn3CpwDC for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 16:55:06 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 0A5A6A37
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:55:06 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id p143so2860567iod.19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3u0nxxgYyEUjXGg7NUYYV5jP9VVsDH2PdPlFmPZRDs8=;
        b=nkc/3J5l9lvsH0GEGOeWVE5HW1UWH4O8mE2J2wFE1tby5QacB9w027TiFpUO1+eUIa
         oKZwOsQJ5mhZMhW5C0lMMhlyOS8I9q2Ew4eg7jqURdhgoWSZON/aPb07TFDuiDcRRLPk
         5mYZEzixpAtRX5Dl8e8EmNHBHo9ysXJypecmHS1NABWG6z3Xuq96HduhlcAVsMGzCAvz
         +0Unq0P7t8SpOJX8iMpPGk9GeywjUyKe3smeBsxuyy/aWYTOuWbrbqtZuAG4S5H9mfKY
         viiYRAv4QIPvozUs6A8EuVqJe/xgg3jlJ25xyTdvsP25Wpi8dSW0HfewhtJFBN0Jp33I
         bZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3u0nxxgYyEUjXGg7NUYYV5jP9VVsDH2PdPlFmPZRDs8=;
        b=p4NFm+0j6oYaWA0IEK5SmMdv9yAsuej+i3nwT4WxFwB7U5jLzRaLad61y3fUOP3cjX
         5evpc5DkDc+QHKeXx2D2Bg1KtR5taiiYzMl743deRIrFFcOmxmN4OYMCOzS+GmVgtQGZ
         QC2lkGyZy+adBBIBhw2Oci8HUQdZ9qVSORfLQpbmTDg30tvDwy7H0OFnngICxIB7AASp
         yL6LUYRNezwJTAebJIs99dFDtyiPzredBB5Z8l+nln9XtNSAtLlBZpaKkxa5jyl3fMnv
         djnZmVT5+L/pRSYEMXswGuJLL10sqv0JTKh16fl9dwM+9NMkw2DVbekvC92DKUiDsls6
         pnkA==
X-Gm-Message-State: APjAAAUqws3U61ibSnDbnLcUPVQNEMEZzFasykX1iQbFNzYNAS5/TgFr
        bsb7juRWnxKFn9hRR/KeNO+v4I16dmPI+fgvdEJJ1aqdl6B/UJC3JokutQ5HzrfDisJbtq6Aka8
        F2wjLeQzVmyoxUj7KN3TQk9hKIuCU
X-Received: by 2002:a6b:e705:: with SMTP id b5mr9259535ioh.73.1553291705683;
        Fri, 22 Mar 2019 14:55:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkphDk1FFr0lFJ+r86bvH/4wVkkK7ExCe4IPri+2/UsibcTua2GeoDL3E5ksPVNDPKiOOSiA==
X-Received: by 2002:a6b:e705:: with SMTP id b5mr9259525ioh.73.1553291705503;
        Fri, 22 Mar 2019 14:55:05 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id y16sm3860688ion.64.2019.03.22.14.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 14:55:05 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] firmware: arm_scmi: Fix to replace of_match_device
Date:   Fri, 22 Mar 2019 16:55:03 -0500
Message-Id: <20190322215503.13434-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device can return NULL if no matching device is found.
This patch replaces the function with of_device_get_match_data.
and returns -EINVAL in such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Replace of_match_device with of_device_get_match_data
---
 drivers/firmware/arm_scmi/driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8f952f2f1a29..a44852a1d5bc 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -798,7 +798,9 @@ static int scmi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	desc = of_match_device(scmi_of_match, dev)->data;
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -EINVAL;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
-- 
2.17.1

