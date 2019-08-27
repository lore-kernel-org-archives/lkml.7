Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB3C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72FC2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdqrFlgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfH0WVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:21:51 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48501 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfH0WVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:21:50 -0400
Received: by mail-pg1-f202.google.com with SMTP id k20so362224pgg.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wPnUIXwCje9aioFwSMDUTow4aP7pSBCci968MTKmxQQ=;
        b=DdqrFlgDVEKBQRVomjmwGlh+g1qgU4hmZKsta/aQ5aRsMW9z4MQJfZot5WL/rvHKT7
         iF5w+r1VrrTBp2XIwotbSYASAMLUhwb40F5Zg89vSzH08qYTkCJGvdDWOchP84tikp9e
         rSJgwWuDa25OB3hj7O8UvPBtF/GRkbhXhf36MipO/bcYKIEA1AqvtPMfgY23nmSSSUGj
         2U8gVr9i397FVT7pmFsp9L8p758k/uD+gh/7gGIlmR+3DNetyIKnVl5kuXerOQyOsnzr
         0YmfG839b3HE4F83Z6ShA4KYsUidQ2COKZMQA+54vkgN/qGZl9bodtCLF9qtELgdBiI1
         hI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wPnUIXwCje9aioFwSMDUTow4aP7pSBCci968MTKmxQQ=;
        b=nJNOIxFVeUd2NsuykXvEiUJsyVKU9vkpVNX3ZSXJgEo0R0AHOg0v0Mb0ZOvRd3ESM1
         I7MrGtprx/dlQum1SlRw2nmrUPOcO9bhBVs+vMkmVaHF4YiuQPnyFYT2d17OHAY/UVDb
         HssNbxUcaZVSRvp9xH8365XF+96uM248yPXKSVr1KMFjxm1EqD88te7IgiXe5P/PsTW+
         V4edwQUmfel0QmtnNp9LnygxXptf6HRQmJqoZYVC7UP73XzTMCsq7fLU3xPPuXxR4adU
         Z4132pp2DqWnXjGV9vm/scCptX70AW3pc45Aj8mv4ZZl/ljc5YMbVwVoVN0NW9TUo1Wk
         haWA==
X-Gm-Message-State: APjAAAV1+W+PGnN1UOVjpl3lUHjYDXadHT/b7ye7czcIxcXurbR0vntS
        zH/wOYsYjs4BTnkDaSwonTaygU8ChXXR
X-Google-Smtp-Source: APXvYqxtskkh8g9jAVNThHQtjXrbaE3Q7xH0UD9TjZRkMlkr+CxfWcD3QxLwidkiGXvaW+Vd2RCLr9hC0nhV
X-Received: by 2002:a63:40a:: with SMTP id 10mr636802pge.317.1566944509926;
 Tue, 27 Aug 2019 15:21:49 -0700 (PDT)
Date:   Tue, 27 Aug 2019 15:21:44 -0700
In-Reply-To: <20190827062309.GA30987@kroah.com>
Message-Id: <20190827222145.32642-1-rajatja@google.com>
Mime-Version: 1.0
References: <20190827062309.GA30987@kroah.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 1/2] PCI/AER: Add PoisonTLPBlocked to Uncorrectable errors
From:   Rajat Jain <rajatja@google.com>
To:     gregkh@linuxfoundation.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The elements in the aer_uncorrectable_error_string[] refer to
the bit names in Uncorrectable Error status Register in the PCIe spec
(Sec 7.8.4.2 in PCIe 4.0)

Add the last error bit in the strings array that was missing.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: same as v2
v2: same as v1

 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47d04fe..68060a290291 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -36,7 +36,7 @@
 #define AER_ERROR_SOURCES_MAX		128
 
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
-#define AER_MAX_TYPEOF_UNCOR_ERRS	26	/* as per PCI_ERR_UNCOR_STATUS*/
+#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
 
 struct aer_err_source {
 	unsigned int status;
@@ -560,6 +560,7 @@ static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
 	"BlockedTLP",			/* Bit Position 23	*/
 	"AtomicOpBlocked",		/* Bit Position 24	*/
 	"TLPBlockedErr",		/* Bit Position 25	*/
+	"PoisonTLPBlocked",		/* Bit Position 26	*/
 };
 
 static const char *aer_agent_string[] = {
-- 
2.23.0.187.g17f5b7556c-goog

