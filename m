Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D7AC2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39D52467A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="JLdccgyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfLOSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:23:21 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:34026 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 13:23:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47bXpH4Qjtz9vZ60
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 18:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iLnBNUUIQkFJ for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 12:23:19 -0600 (CST)
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com [209.85.161.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47bXpH3F9Yz9vZ5m
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 12:23:19 -0600 (CST)
Received: by mail-yw1-f71.google.com with SMTP id i70so3995640ywe.23
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llCgKqj4oj+SBI/9u2Qj4pLrOEShlhQ/Pb7xPdsk9S0=;
        b=JLdccgyJMvUFH10z5CGdaUBC2QyJT9+FF/JUVJsEkP++worO7bLakHUfCSF7rK6oFc
         3mjwgpGUuxk6Om/+DeieGP5xm82Rag8ZQpl+AqIRzf9jGf+7/cA0j2Ra4POBDsYw+p8x
         nNxuG1p88kqIErbFUFGJAtQgnsGzEKxLOs/+x9I9KAXMZL905eHOIJHa5q6x6oiXS9BM
         r4wUaA76g6tZQIg8Ont8s1TA6dxmHrhOJ600Y5VwjPGNMI4HKlAb27wJ35B5Y5pgsac3
         9zT5RlEx+zcGz9iDsQwkhAZth+n30Vu7+SN4ww+yigcz4CWjogdFMFr7lCA/LFxCGBrK
         LXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llCgKqj4oj+SBI/9u2Qj4pLrOEShlhQ/Pb7xPdsk9S0=;
        b=qvo7eL+8ouZqD0zIfQqULcrXfix3M0YJrpfdbEyMaFvJQ44sCJCpHMPozFEx7z/1JK
         xdamvYInOVjrovt++meJiKqGm5NfQfcVYAWOEZ4NNCFRnRVhZ1kDptas4MBGrg04e387
         OjO16N5gdfkN1o3aA67ZhK0OXkV3oB0PpdMIBC/Cxjn9k9eSGYqP9730ysM7cJg36WQU
         AXKIRD3zfzMW28zuQPDoj5dDZx9hJdEbJT0c0Hg/+xaZpwtZEkFikbvHZnvuZZZH2iaE
         nkiGkeejb8uBPAChIkMAQMoKpyKBzJIND1uGStUJI5Mjrb90gtdqRhkewR4t0TB6hQa5
         0gwA==
X-Gm-Message-State: APjAAAX8vGAjjBpkuRMpEDDdAjaYIbMJjLl4MsRAMNPcgl8D++fRodyZ
        APjRU4DHXwpY968YcJAyX0JOS326fPH0LknMqjbstI5+YdYdzcXeiRAbAgWeO1QdEz5ejp4ChmG
        rmrJ2W/f2UuXw8RDwDpRsaPO/5HaO
X-Received: by 2002:a81:84c6:: with SMTP id u189mr17064875ywf.439.1576434198949;
        Sun, 15 Dec 2019 10:23:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQGMrX+PEkSD/x5YBWtEuXfdwPOSYkyvf2XkwMhs4RTNPkXIJTpbHfnGzZcSMgz4+G9424rw==
X-Received: by 2002:a81:84c6:: with SMTP id u189mr17064859ywf.439.1576434198671;
        Sun, 15 Dec 2019 10:23:18 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id o84sm962165ywb.92.2019.12.15.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 10:23:18 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/ppi: replace assertion code with recovery in tpm_eval_dsm
Date:   Sun, 15 Dec 2019 12:23:14 -0600
Message-Id: <20191215182314.32208-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
By returning NULL to the callers, instead of crashing, the error
can be better handled.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/char/tpm/tpm_ppi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index b2dab941cb7f..4b6f6a9c0b48 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -42,7 +42,9 @@ static inline union acpi_object *
 tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
 	     union acpi_object *argv4, u64 rev)
 {
-	BUG_ON(!ppi_handle);
+	if (!ppi_handle)
+		return NULL;
+
 	return acpi_evaluate_dsm_typed(ppi_handle, &tpm_ppi_guid,
 				       rev, func, argv4, type);
 }
-- 
2.20.1

