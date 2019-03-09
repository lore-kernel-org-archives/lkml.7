Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B57C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6953C20866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="M34iWCmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfCIEnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:43:53 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:51652 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCIEnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:43:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id EAAB5B74
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EXqSTk4WoXTJ for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:43:51 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id B834FA39
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:43:51 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id w200so13818432itc.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=58vOdLLRCNUL+gkqvy6G/8NqXcDukitu6vhvUvGr0WI=;
        b=M34iWCmwC/uSUePuFtnjJXSUvoxeyDtGKxE+FRSE0CqIPx2Asp9wpxH1TzdUJZ60fV
         PJRMgbxVN5dwMAV8DBtBG4jG78BYB9ehSfHKB50dE13tUG9fv3n52OlP/fjQGk2P5eDo
         JiDZ41+i6X6OJqkEg1MGlONt7VOe29qpATEIMM+EEHNXtjpke2b+DYJQASOVzcys3Sqt
         zw+O3Q5PtGHUbs6TBYRpWGfnljQY86mfUcJn6bHlFWKh0dcmoFWFG5A/DWBrTVn28IOV
         U4+D8Mv785L9Ezrl+H9Lvz/ePa4TRggvqpLfLXHVQiGnqGQ8/EGP0puyFM7OGMDVf+5D
         mCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=58vOdLLRCNUL+gkqvy6G/8NqXcDukitu6vhvUvGr0WI=;
        b=L9y/aXs8ibODDpWSqc4qaI4sh8hkjBEyDQfBlY0qvVOSQdHeIcK6zBmo8+FmY6YkSd
         A8gbv0hDE6xqao005qHS5hjeLJPoI8DuLrix5FCVLlTps3fGzCORW0Tt7B0rU4WWpuqe
         ntzCHuZGwM5nIAWCUKVWlkNCTnWbkIdFxWbj89zD0ar/fnFUrs16+N2XigYGMjukmd+Y
         Kl/SOwyPVOloVsuTYA7vwf90eUUAaksvQxv2yZVk3V+qkPjYwS+syaF3Czp2bkI14bF4
         t5VAjLj+jWig7TSuKdVQT5nx/Rgbh+R8QMq/kM1XYk0PmOf1YM8nvDiRFw7oUlF4F9KC
         keKA==
X-Gm-Message-State: APjAAAUDZ37oUAalGsV9tH2GzAiI5IMMrhQyzlWEONHckV4m7J1hJrMc
        j4DOEowRCaQ80sWFRIWbGJ/e+3CjF+5NSrGS/1AVG7R/XUtaacXxKBiWA4CCQHqxybW8J1th/Y1
        rP9ZkZYCY8pV1FpQLHuCNCgfhnhxm
X-Received: by 2002:a5e:9611:: with SMTP id a17mr11183069ioq.2.1552106631335;
        Fri, 08 Mar 2019 20:43:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4AxNBQ+Ic6pRBAM/LsLRgmvMcZyMRwA6yuxBXRQLnqikpEEm3UriiMIyA4wmljxd5qwxRMQ==
X-Received: by 2002:a5e:9611:: with SMTP id a17mr11183064ioq.2.1552106631106;
        Fri, 08 Mar 2019 20:43:51 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id i198sm4982974iti.18.2019.03.08.20.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:43:50 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hid: logitech: check the return value of create_singlethread_workqueue
Date:   Fri,  8 Mar 2019 22:43:45 -0600
Message-Id: <20190309044345.7018-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_singlethread_workqueue may fail and return NULL. The fix
checks if it is NULL to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 15ed6177a7a3..efbc39b92aa2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2156,6 +2156,9 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
 
 	/* init the hardware command queue */
 	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	if (!data->wq)
+		return -ENOMEM;
+
 	atomic_set(&data->workqueue_size, 0);
 
 	/* initialize with zero autocenter to get wheel in usable state */
-- 
2.17.1

