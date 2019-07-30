Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DDC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA877206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfQvx2dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfG3MYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:24:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34037 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfG3MYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:24:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so29766205pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ub4kuUSnrD2CiYyKKwaDCU7WlCc+MjZGT8+i8BhCGSM=;
        b=MfQvx2dhjGV4/bSe60l+LebksrED1y3ZIlrOHn7KEst3uYq0lbZGY0vsMCXlHdvqTW
         Ye8auI8LrPtuk1JjxXNnkdo+hZ+99keG4VGsdhwKAsEXIsOsIUECaXlU8hbVHLFk9cLT
         HO8nBnDu0xGtOjVBUUGFJzgjgr3leWNo194UxYVJeI2Y+0v/K+qeQpXyF0PGeONbMN+i
         gW62oUUDBfxqW/m3zRut5eraL0BhFNM47K2DQzNbSup/f6DVATK2umRIZlAbmj5eTK+g
         Ie2+FR2iyP4pVV9kGjOO0QK2a+lbpVtyMzeY+CEhSSw2QwFdLdH8EHmR5UmLIl/CCH4Z
         mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ub4kuUSnrD2CiYyKKwaDCU7WlCc+MjZGT8+i8BhCGSM=;
        b=aTF+n7CYr2THMjRczZEnL1LsoPKrMfEg7MlODum7puYHPqTmTXYhnSf71hOiSmOEKH
         sUUHnlzZ2UHWeKQxej84mkCUSODVHfifJm9PTdpQXF8EZ5nYRTJRBjj2mVIkCEIwgJaI
         Ktt+TjghHHJijiPCn1jR99FZ+tlyRPVW8weAhGVyMnrRHn9i6Lwq96Iv2+IyvcJq4bm2
         Zmvp3kY9RAejEJnMs+w0yTq+6C41E05D/utKvdWNSr+VUymaCkYA7EnLcOVZUYVod1e6
         NhsNzC0e1yZ0XcFwneSiCps3e7TWpwl7spKp1gBz9ryFIrhoSO3fs/TQklwiKdJ4D5N1
         sFlw==
X-Gm-Message-State: APjAAAWTUdaB1gtjh6UC7WQVcI4XITaRkC6/iBwnrtO5gnxHdBO5p8IN
        hZ3qOn+DkWN9JnQJKxcqhaji6g==
X-Google-Smtp-Source: APXvYqy9AOsI/bgpSrYC4bB6dRW/RMjRTTrIQ53nsJNjfy9Y+arPAlgz9XGruaRKwy6MTunT2Iwvvg==
X-Received: by 2002:a63:125c:: with SMTP id 28mr55618644pgs.255.1564489473744;
        Tue, 30 Jul 2019 05:24:33 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id v8sm54895462pgs.82.2019.07.30.05.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 05:24:33 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC v2 1/6] tee: optee: allow kernel pages to register as shm
Date:   Tue, 30 Jul 2019 17:53:35 +0530
Message-Id: <1564489420-677-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel pages are marked as normal type memory only so allow kernel pages
to be registered as shared memory with OP-TEE.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index aa94270..bce45b1 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -553,6 +553,13 @@ static int check_mem_type(unsigned long start, size_t num_pages)
 	struct mm_struct *mm = current->mm;
 	int rc;
 
+	/*
+	 * Allow kernel address to register with OP-TEE as kernel
+	 * pages are configured as normal memory only.
+	 */
+	if (virt_addr_valid(start))
+		return 0;
+
 	down_read(&mm->mmap_sem);
 	rc = __check_mem_type(find_vma(mm, start),
 			      start + num_pages * PAGE_SIZE);
-- 
2.7.4

