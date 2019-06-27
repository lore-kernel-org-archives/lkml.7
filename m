Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685FC004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96C12075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htCcE9P6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfF0Uox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:44:53 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:39780 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Uox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:44:53 -0400
Received: by mail-pl1-f173.google.com with SMTP id b7so1915165pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/m1U+lqJYg3VKkeMxYY/dgUDheHdcRzphwpkMYg2ec=;
        b=htCcE9P6tU7YLAH84xFrgeN8/gqdt0UqSYCN9MIoMVjxemJx8RytlWuk8ig6sg9cvK
         7Efir32UIyTnB6txtTISWhgvEUZLLoMGNvqvgOnljn2E6CEdCUpOKNihXW0LpAL+20km
         cHv8nyWNudjSEsmvJAPEwCVPwNFsTsQo7nURI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/m1U+lqJYg3VKkeMxYY/dgUDheHdcRzphwpkMYg2ec=;
        b=KEgru6W8+Nx4ynTr8Rd+PaZipp/0sdM9ePFuo4EYvv6z6wadWg+81/KRUAZ6pzjYua
         WKqY8Ax4kxrPAXS0zYC+hSLCuRnRhMguLr4xfXtAu0vyqcstQTa40qJT/KcDEAxfZYhW
         adWLK5w0KGYYF6ZfMChA5ITQ8gr7Ea1tedtsdaqYEqgxzZ8WbAnUtfZt235SCOrgLVJg
         GAXAiOEQl7vHeZNc5Ly+3EnTON1NRMgO4aGJCO+Dct9uIArsfAiMZCYckwk8hNwtjHTe
         qFri6U0atC3jN2Fk5Mo3kUUG4qZuy1V2ecvGxIksQE/d7mbmb93KsSxwjPlAoYupvEhJ
         YoEg==
X-Gm-Message-State: APjAAAXhWlsEIwEovLkJ8ceL2zaZ5kOaYxOMeerYO9XQeVFmzA4q2x06
        TF6WwTEVybQ3PJt+kbCHIOE+MQ==
X-Google-Smtp-Source: APXvYqyezMICBPX4VVgvMvN81c/kUJuYMUFTAaKCZOT/11B9lfr+nQbcXU2t8Jr7E2lJcy1/wnWgpg==
X-Received: by 2002:a17:902:4e25:: with SMTP id f34mr6870553ple.305.1561668292322;
        Thu, 27 Jun 2019 13:44:52 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d1sm37054pgd.50.2019.06.27.13.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Jun 2019 13:44:51 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH v3] platform/chrome: Expose resume result via debugfs
Date:   Thu, 27 Jun 2019 13:44:45 -0700
Message-Id: <20190627204446.52499-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ECs that support it, the EC returns the number of slp_s0
transitions and whether or not there was a timeout in the resume
response. Expose the last resume result to usermode via debugfs so
that usermode can detect and report S0ix timeouts.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v3:
 - Expose the debugfs file on all EC types (Enric)

Changes in v2:
 - Moved from sysfs to debugfs (Enric)
 - Added documentation (Enric)


---
 Documentation/ABI/testing/debugfs-cros-ec | 22 ++++++++++++++++++++++
 drivers/mfd/cros_ec.c                     |  6 +++++-
 drivers/platform/chrome/cros_ec_debugfs.c |  5 +++++
 include/linux/mfd/cros_ec.h               |  1 +
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
index 573a82d23c89..1fe0add99a2a 100644
--- a/Documentation/ABI/testing/debugfs-cros-ec
+++ b/Documentation/ABI/testing/debugfs-cros-ec
@@ -32,3 +32,25 @@ Description:
 		is used for synchronizing the AP host time with the EC
 		log. An error is returned if the command is not supported
 		by the EC or there is a communication problem.
+
+What:		/sys/kernel/debug/<cros-ec-device>/last_resume_result
+Date:		June 2019
+KernelVersion:	5.3
+Description:
+		Some ECs have a feature where they will track transitions to
+		the (Intel) processor's SLP_S0 line, in order to detect cases
+		where a system failed to go into S0ix. When the system resumes,
+		an EC with this feature will return a summary of SLP_S0
+		transitions that occurred. The last_resume_result file returns
+		the most recent response from the AP's resume message to the EC.
+
+		The bottom 31 bits contain a count of the number of SLP_S0
+		transitions that occurred since the suspend message was
+		received. Bit 31 is set if the EC attempted to wake the
+		system due to a timeout when watching for SLP_S0 transitions.
+		Callers can use this to detect a wake from the EC due to
+		S0ix timeouts. The result will be zero if no suspend
+		transitions have been attempted, or the EC does not support
+		this feature.
+
+		Output will be in the format: "0x%08x\n".
diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 5d5c41ac3845..2a9ac5213893 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -102,12 +102,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 
 	/* For now, report failure to transition to S0ix with a warning. */
 	if (ret >= 0 && ec_dev->host_sleep_v1 &&
-	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
+	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
+		ec_dev->last_resume_result =
+			buf.u.resp1.resume_response.sleep_transitions;
+
 		WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
 			  EC_HOST_RESUME_SLEEP_TIMEOUT,
 			  "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
 			  buf.u.resp1.resume_response.sleep_transitions &
 			  EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
+	}
 
 	return ret;
 }
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 7ee060743844..967c78abfdd3 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -447,6 +447,11 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
 			    &cros_ec_uptime_fops);
 
+	debugfs_create_x32("last_resume_result",
+			   0444,
+			   debug_info->dir,
+			   &ec->ec_dev->last_resume_result);
+
 	ec->debug_info = debug_info;
 
 	dev_set_drvdata(&pd->dev, ec);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 5ddca44be06d..45aba26db964 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -155,6 +155,7 @@ struct cros_ec_device {
 	struct ec_response_get_next_event_v1 event_data;
 	int event_size;
 	u32 host_event_wake_mask;
+	u32 last_resume_result;
 };
 
 /**
-- 
2.20.1

