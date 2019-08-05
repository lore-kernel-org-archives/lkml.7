Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D723C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17A6208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l+h4VMUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfHEUW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:22:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37182 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:22:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so21476188otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4p+ejtDYT9ge85k+G90sVNKMG8+LmSB6C2IJ/PLy4I=;
        b=l+h4VMUo3HjID47W2jQk5jW9sPtqVFRxVM0eVvhidytUEfW/WLQgztIPz3WGnuQHyu
         QgVChLUhWGvhgkSfprgWC6Veu+s04PqIGbT8Mbp7mRZB+60D57tyubYamccIXh/AwO61
         1DidJorr8Z/tsKIExP6XJ+Z7aCPePLzAsKMD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4p+ejtDYT9ge85k+G90sVNKMG8+LmSB6C2IJ/PLy4I=;
        b=uJ2WWeQES5TT34W6dNbWxxtYCaSciNlrdsIsdQ3aLPXEZ+xmsZ8Zp2TrJDm4bn4Vzq
         A0/hhfzLVNoigpET7IkHHaGaJ6b1xzPw9AvZR+6Rg22pQwxqQOAkKFgxUm1gPH01G5vx
         KZa7Jn7yN8jVuwjQe+Vp5l9wKC5chp0JYHyUPBY75+X2OzpGjjQAiCZ3/t1wJnxsjLWZ
         QJBsD0t8ao9lXb5v7RiA3PbQyZzSQRTTFz6hplyFKJtgSNkDRlQr6B3fkRbWP/y5cb/G
         Zu2XUe72vZja1EyQGcQuvrdkWAQSZ6v6mnmCcLk6KhJg4qMFkbzyr4oortwkiplVtHkP
         jbzw==
X-Gm-Message-State: APjAAAX/vGBsB67mp4BsnpIQIUHw4y5dmL5Q/l7F+ilKCt+lmsKgn7i/
        DdByw+f6fAI5khw2+9hr+o+cYw==
X-Google-Smtp-Source: APXvYqxBlJLyquBOJB2pubzHYt11W9nSs+nHGqVd4ZXawAO/UKtEAAJImS0CRZF+PsVj02t135twqw==
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr2582950ioh.70.1565036546411;
        Mon, 05 Aug 2019 13:22:26 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id s15sm66042564ioe.88.2019.08.05.13.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 13:22:25 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        djkurtz@chromium.org, dtor@google.com, sjg@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH] platform/chrome: wilco_ec: Add batt_ppid_info command to telemetry driver
Date:   Mon,  5 Aug 2019 14:22:14 -0600
Message-Id: <20190805202214.3408-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GET_BATT_PPID_INFO=0x8A command to the allowlist of accepted
telemetry commands. In addition, since this new command requires
verifying the contents of some of the arguments, I also restructure
the request to use a union of the argument structs. Also, zero out the
request buffer before each request, and change "whitelist" to
"allowlist".

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/telemetry.c | 64 +++++++++++++-------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index 94cdc166c840..b9d03c33d8dc 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -9,7 +9,7 @@
  * the OS sends a command to the EC via a write() to a char device,
  * and can read the response with a read(). The write() request is
  * verified by the driver to ensure that it is performing only one
- * of the whitelisted commands, and that no extraneous data is
+ * of the allowlisted commands, and that no extraneous data is
  * being transmitted to the EC. The response is passed directly
  * back to the reader with no modification.
  *
@@ -59,21 +59,10 @@ static DEFINE_IDA(telem_ida);
 #define WILCO_EC_TELEM_GET_TEMP_INFO		0x95
 #define WILCO_EC_TELEM_GET_TEMP_READ		0x2C
 #define WILCO_EC_TELEM_GET_BATT_EXT_INFO	0x07
+#define WILCO_EC_TELEM_GET_BATT_PPID_INFO	0x8A
 
 #define TELEM_ARGS_SIZE_MAX	30
 
-/**
- * struct wilco_ec_telem_request - Telemetry command and arguments sent to EC.
- * @command: One of WILCO_EC_TELEM_GET_* command codes.
- * @reserved: Must be 0.
- * @args: The first N bytes are one of telem_args_get_* structs, the rest is 0.
- */
-struct wilco_ec_telem_request {
-	u8 command;
-	u8 reserved;
-	u8 args[TELEM_ARGS_SIZE_MAX];
-} __packed;
-
 /*
  * The following telem_args_get_* structs are embedded within the |args| field
  * of wilco_ec_telem_request.
@@ -122,6 +111,32 @@ struct telem_args_get_batt_ext_info {
 	u8 var_args[5];
 } __packed;
 
+struct telem_args_get_batt_ppid_info {
+	u8 always1; /* Should always be 1 */
+} __packed;
+
+/**
+ * struct wilco_ec_telem_request - Telemetry command and arguments sent to EC.
+ * @command: One of WILCO_EC_TELEM_GET_* command codes.
+ * @reserved: Must be 0.
+ * @args: The first N bytes are one of telem_args_get_* structs, the rest is 0.
+ */
+struct wilco_ec_telem_request {
+	u8 command;
+	u8 reserved;
+	union {
+		u8 buf[TELEM_ARGS_SIZE_MAX];
+		struct telem_args_get_log		get_log;
+		struct telem_args_get_version		get_version;
+		struct telem_args_get_fan_info		get_fan_info;
+		struct telem_args_get_diag_info		get_diag_info;
+		struct telem_args_get_temp_info		get_temp_info;
+		struct telem_args_get_temp_read		get_temp_read;
+		struct telem_args_get_batt_ext_info	get_batt_ext_info;
+		struct telem_args_get_batt_ppid_info	get_batt_ppid_info;
+	} args;
+} __packed;
+
 /**
  * check_telem_request() - Ensure that a request from userspace is valid.
  * @rq: Request buffer copied from userspace.
@@ -133,7 +148,7 @@ struct telem_args_get_batt_ext_info {
  * We do not want to allow userspace to send arbitrary telemetry commands to
  * the EC. Therefore we check to ensure that
  * 1. The request follows the format of struct wilco_ec_telem_request.
- * 2. The supplied command code is one of the whitelisted commands.
+ * 2. The supplied command code is one of the allowlisted commands.
  * 3. The request only contains the necessary data for the header and arguments.
  */
 static int check_telem_request(struct wilco_ec_telem_request *rq,
@@ -146,25 +161,31 @@ static int check_telem_request(struct wilco_ec_telem_request *rq,
 
 	switch (rq->command) {
 	case WILCO_EC_TELEM_GET_LOG:
-		max_size += sizeof(struct telem_args_get_log);
+		max_size += sizeof(rq->args.get_log);
 		break;
 	case WILCO_EC_TELEM_GET_VERSION:
-		max_size += sizeof(struct telem_args_get_version);
+		max_size += sizeof(rq->args.get_version);
 		break;
 	case WILCO_EC_TELEM_GET_FAN_INFO:
-		max_size += sizeof(struct telem_args_get_fan_info);
+		max_size += sizeof(rq->args.get_fan_info);
 		break;
 	case WILCO_EC_TELEM_GET_DIAG_INFO:
-		max_size += sizeof(struct telem_args_get_diag_info);
+		max_size += sizeof(rq->args.get_diag_info);
 		break;
 	case WILCO_EC_TELEM_GET_TEMP_INFO:
-		max_size += sizeof(struct telem_args_get_temp_info);
+		max_size += sizeof(rq->args.get_temp_info);
 		break;
 	case WILCO_EC_TELEM_GET_TEMP_READ:
-		max_size += sizeof(struct telem_args_get_temp_read);
+		max_size += sizeof(rq->args.get_temp_read);
 		break;
 	case WILCO_EC_TELEM_GET_BATT_EXT_INFO:
-		max_size += sizeof(struct telem_args_get_batt_ext_info);
+		max_size += sizeof(rq->args.get_batt_ext_info);
+		break;
+	case WILCO_EC_TELEM_GET_BATT_PPID_INFO:
+		if (rq->args.get_batt_ppid_info.always1 != 1)
+			return -EINVAL;
+
+		max_size += sizeof(rq->args.get_batt_ppid_info);
 		break;
 	default:
 		return -EINVAL;
@@ -250,6 +271,7 @@ static ssize_t telem_write(struct file *filp, const char __user *buf,
 
 	if (count > sizeof(sess_data->request))
 		return -EMSGSIZE;
+	memset(&sess_data->request, 0, sizeof(sess_data->request));
 	if (copy_from_user(&sess_data->request, buf, count))
 		return -EFAULT;
 	ret = check_telem_request(&sess_data->request, count);
-- 
2.20.1

