Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A6BFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27476218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpQhfFQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405766AbfJPOpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:45:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35327 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfJPOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:45:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so28416628wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KiNYSZak6gY+iTMwji/UIPStYu+CYTFJcAQfNVpy0D8=;
        b=XpQhfFQSx2JsMXp1NZJ6/hru99O+c0K/SNaTQQ8E8SJtgTESjISSO4eyKSruYo68HD
         lKrhohrltz3iEaM19V/XrkV6RJym+M1Pv0FASiy1SCVuPA8UKAEvz0gMz+UqY4icwO3g
         cybZwnszs3xTqt1f6iUYnd52Taz0kWNsKZ2fjBQ+GIdIYL33r8StF7gkClD4hbQHTBzR
         FnioeCWDIbSW3l7YbamCvXZMhr5F79Z/d5MkfYH863BFl7fA/GHcMG+PYkjjzXhilH09
         JcaczH2qddgCqpLGdQpLDP0GLie+OzbNhiSfVmmLvN7mHqQiz7xe2RHRAMrLIYRnLCEH
         YEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KiNYSZak6gY+iTMwji/UIPStYu+CYTFJcAQfNVpy0D8=;
        b=Aby9K7N0gGqHHNIcGbHFkfSWkffnkJptwIQm1aYQMaUFY+5R1jCIZHkjerXYLl3J0j
         OImnN4lL24XimY6K3GTgcRecPO846RnJW5KSF02PMKDu40yMeji22AHMa5iBic1K8Aqp
         +6tk8wtnY/X+/VVatHcmEf+3CSyJRP/vNPAGotpCEVPOz72z+L5FFDhzr4RuIRgesBmv
         InWBq2hMvn1qsX3+jljrsPSO2NPCBRM2WEF4IEAPJLr0bxJfz4DT6Y2fS7L0nljt/nmR
         F+rTSLExEhRYSzEeghGhwoiOZoxd7544dhop/8kaE7DabYGDtLlzkoRMnWoSk9uHziwK
         +MAg==
X-Gm-Message-State: APjAAAV+5Geiubc3spyKCv9ClVq5qlq8qglEgKpGQC9DhFngfvfI5zC8
        GhuqwxbZNPBf5i6aSPcWYXY=
X-Google-Smtp-Source: APXvYqwY8Vzhr5qL3XF3pfXr5wGIgiABjaTbDw7VvZYTHLNEgTuVHi74EFZMXnZL90WLbwztBZT63g==
X-Received: by 2002:adf:fc42:: with SMTP id e2mr3273223wrs.100.1571237143519;
        Wed, 16 Oct 2019 07:45:43 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q3sm22211733wru.33.2019.10.16.07.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:45:42 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/4] parport: daisy: avoid hardcoded name
Date:   Wed, 16 Oct 2019 15:45:37 +0100
Message-Id: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The daisy device name is hardcoded, define it in the header file and
use it in the code.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/probe.c | 2 +-
 include/linux/parport.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
index e035174ba205..4e2bfeb6b4a6 100644
--- a/drivers/parport/probe.c
+++ b/drivers/parport/probe.c
@@ -257,7 +257,7 @@ static ssize_t parport_read_device_id (struct parport *port, char *buffer,
 ssize_t parport_device_id (int devnum, char *buffer, size_t count)
 {
 	ssize_t retval = -ENXIO;
-	struct pardevice *dev = parport_open (devnum, "Device ID probe");
+	struct pardevice *dev = parport_open(devnum, daisy_dev_name);
 	if (!dev)
 		return -ENXIO;
 
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 397607a0c0eb..13932ce8b37b 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -460,6 +460,7 @@ extern size_t parport_ieee1284_epp_read_addr (struct parport *,
 					      void *, size_t, int);
 
 /* IEEE1284.3 functions */
+#define daisy_dev_name "Device ID probe"
 extern int parport_daisy_init (struct parport *port);
 extern void parport_daisy_fini (struct parport *port);
 extern struct pardevice *parport_open (int devnum, const char *name);
-- 
2.11.0

