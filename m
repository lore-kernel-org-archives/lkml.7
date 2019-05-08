Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C04C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B4A21655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjDGBM1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfEHKO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:14:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42038 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfEHKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:14:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so9696232pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p0PVRgJN8u0SVmWtfEOhULrDoirbepiDPqsJzyAsDR0=;
        b=GjDGBM1MhOzB7g7oZKvrWlHtLNSULP4C2WSeH4ePuxqbOA7kRw/H/w1qQ75qEp5erT
         VahBMI6gdHHpR9d1ynk7u8Y8xrdg+csGkg8v/4taHTiNKY5DPQtP6396fkBjp94EgfQ3
         vPwCjljv445MS1pJQsLA/s17OKSYszZUHdN0lWlqcvvMiS07c0hD0XprAuRpflQFsm2G
         4ytHLaATPWGdGBC/ZH81tOxHaiOciOR5Br4udxrcoW/5Buqp7koKmODpua/D7Xo/uub+
         WdCxDnjdvdpns17mGjxNv++8oyNtHL6YN0Az+h1+Eb0H9qqE3TU7uldrKbLdaLr+Kiur
         U8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p0PVRgJN8u0SVmWtfEOhULrDoirbepiDPqsJzyAsDR0=;
        b=OjmIGAv80lI6PFN1LALJ5Ptieg2CbB6z59nn4T5hEhKxR8H3C09YuV5YDkCPrbpfO9
         0io/eo5EaqsGcPo/QoUwpCd8+ZXR/K+i0LoYV81h0kw5TFfJvOBoZ/7sOeb5EL0xh2S7
         QZrNIKcNFb48DblvN/HDnQwWP2FIoVKQXPgSKNKtUBZU74KBc9PLTLh0tsm5KNbJyx/O
         I2teYBUxYrd8Javl3x2Ua3TuB1INnrQw7m9Lq7ZSn0rN92j7m80Gj6uAVwATwdKvgRk9
         Gv7r9PE2tu9Dc9WB7EwXePpStgJYFxXyyBZtsFzkRULQ8wx6cwJP86zaaw68u9P90h6X
         STdQ==
X-Gm-Message-State: APjAAAV0cyn9eBVegDphGL5BaARs6bxpmOHVVKV5OX7pOS6JQHfaenDC
        4a4xOwoeJvDG1weRFylFQJK5Og==
X-Google-Smtp-Source: APXvYqz4nnEbNBomHXi+aIf4iA5eKUG8g1Jt89p6jZkv5pkE5sTsVzYb7gyXpbI9Oyl7jU0qQcBsmA==
X-Received: by 2002:a17:902:e28a:: with SMTP id cf10mr5589375plb.77.1557310495213;
        Wed, 08 May 2019 03:14:55 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.140])
        by smtp.gmail.com with ESMTPSA id f15sm19014077pgf.18.2019.05.08.03.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 May 2019 03:14:54 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, daniel.thompson@linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] MAINTAINERS: Add mailing list for the TEE subsystem
Date:   Wed,  8 May 2019 15:44:09 +0530
Message-Id: <1557310449-30450-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mailing list for patch reviews and discussions related to TEE
subsystem.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 920a0a1..c05dff7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11556,11 +11556,13 @@ F:	drivers/scsi/st.h
 
 OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
+L:	tee-dev@lists.linaro.org
 S:	Maintained
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Sumit Garg <sumit.garg@linaro.org>
+L:	tee-dev@lists.linaro.org
 S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
 
@@ -15312,6 +15314,7 @@ F:	include/media/i2c/tw9910.h
 
 TEE SUBSYSTEM
 M:	Jens Wiklander <jens.wiklander@linaro.org>
+L:	tee-dev@lists.linaro.org
 S:	Maintained
 F:	include/linux/tee_drv.h
 F:	include/uapi/linux/tee.h
-- 
2.7.4

