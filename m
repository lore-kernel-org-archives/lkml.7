Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6018C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6FA20684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="iWhjT4BT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLRPsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:48:30 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50394 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfLRPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:48:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47dKDF1GzMz9vYy2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uEFjGA3ibnSQ for <linux-kernel@vger.kernel.org>;
        Wed, 18 Dec 2019 09:48:29 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47dKDF0BPYz9vYxq
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:48:29 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id z7so1547207ywd.21
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24iL5/uUkW8WBrQ+DwpF6Dwk7XjHT1zZjAzHIUDTH/4=;
        b=iWhjT4BTr9LLloEH90ZsH1TvIWOH57cw1MQgcHeDYwOIDfS2k/tzc3ep0QbbE1E1/0
         a3PXogSZAAdSAYBtNaacCxr8oPsRDVX+7p89iaFIspNqEjFU01luRm2avI+bUsbf7pLB
         J56L1XiP+cBb4qlGzneNwYGeEZzMf+HMwzFyi7L2CWEivK6Gwj4BFQ4zBCLEh21Mp5al
         vQzZhSPGrvFmZOEMIyuNUrLoziYSjQkHZDONVva7a++X+SwD4hLw08bg/Euyl05egjHd
         OCHNKwDx4YXZFTyzOlftoV5C9+zmCh1YY/5g6EVOimzmScpjd+hmeezAjXmOXZfZhjnn
         SsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=24iL5/uUkW8WBrQ+DwpF6Dwk7XjHT1zZjAzHIUDTH/4=;
        b=IKZ7N3cLy/7z+hDA2ewcas0+0PeBWDI3mQwzYSngv10sxfzxwJQXuJx3FnGaAazofU
         cqUZuuL1ZrOdgo+syvvlc7dSOcly4sB12WlCuE9I2chLs20/h7f2ohaSmvTIOpc7a8BB
         /bcHUWvF1OBVf48UxNFUj72p5W1ylauRzI6vzAkTya0bccsuhFeB8qsiRIgQ+H610WM5
         WjBlI36Emlp7vwM+Vzs4hMUwKRrq1ybt5qd718G4zoGjNGDkm6ekHLKtRXmBC8YrWIms
         QNP6vm8KyFCGUf6hgwrgRB+mHwXGlZ/Ph3uKXykzrNqJytQcSlmrk4In63gszEsytnld
         5Ndw==
X-Gm-Message-State: APjAAAW2bh8h1Os2lJpyVmqlnJdHyQP9ZiNLPknA7d72dzXfM3FexWFI
        Z5ZYd1ZagaL+3yKW2nIV2lizCH0Q9LZXqzHplflTho9jKPWQ7qT37cyms/GJhrWah2zU35A2m1A
        dsD9gx1aThwhm9T8Gz1Jh4hEqYumX
X-Received: by 2002:a25:df15:: with SMTP id w21mr2537598ybg.7.1576684108468;
        Wed, 18 Dec 2019 07:48:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUs2lA5D65kMHLl6/mRZQTuLTuD4Ghfd2R8mcUBxkI5G82Qt7wVJf30S63EhVsq0vzQPq5Yw==
X-Received: by 2002:a25:df15:: with SMTP id w21mr2537588ybg.7.1576684108258;
        Wed, 18 Dec 2019 07:48:28 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id j4sm1050738ywd.103.2019.12.18.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:48:27 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm/ppi: remove impossible assertion in tpm_eval_dsm
Date:   Wed, 18 Dec 2019 09:48:25 -0600
Message-Id: <20191218154825.11634-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
However, if ppi_handle is NULL, the kernel crashes. The patch
removes the unnecessary check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: replaced the recovery code to completely eliminate the check,
as suggested by Jason Gunthorpe.
---
 drivers/char/tpm/tpm_ppi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index b2dab941cb7f..603f7806f9af 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -42,7 +42,6 @@ static inline union acpi_object *
 tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
 	     union acpi_object *argv4, u64 rev)
 {
-	BUG_ON(!ppi_handle);
 	return acpi_evaluate_dsm_typed(ppi_handle, &tpm_ppi_guid,
 				       rev, func, argv4, type);
 }
-- 
2.20.1

