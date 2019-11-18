Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79651C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8BA2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dXr2HiDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfKROgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:36:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35157 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKROgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:36:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so9922795plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uaGtjQjkiXQCGGVyN/yvfM6hHUAMfrH/0aSuT3FKPok=;
        b=dXr2HiDHC+WF7WTSzcXRorBdBEEEgGeM1BgutFITl9KcciFzaGe1qDCYMYwb84+f41
         03kMnArtj/j5dOV+EsvJnXimx88ca6TOO+QRUIkZRfOQlxvI5a2UEKatswHBJ3GeCLr7
         8EWherCy1ydgUv617d/4Ug6AQgyuVxapZ3LygvUlJPDfqKJms5udKg89pFfN0s0wKuoK
         /4kFS36KX/dcNP44P4QDJQYRFPMfHq8eUlqr5QWLo2Rjy/b7KSrlH2cp5iW4VK92GJEu
         RA1W18d7EUWFLhpL58Lew3y3zCchT1+KQMhEDMLFKN1B99zxQSIdzKmzHlp741dtC41t
         zwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uaGtjQjkiXQCGGVyN/yvfM6hHUAMfrH/0aSuT3FKPok=;
        b=ltSkQhGgIlO1qSg4Bu1M2fcJADt9C85DkN+ooav649iy7GEPY+3B2fTaaePuhEp1cg
         pRrEOUoDHRGOnd7mdYo7wIfsdBjOjJZ8t+xF/NUYzVGJwqSbpTP+JOxl0bCoN7VT2t8S
         6DuXZTf2vAGzG3kirpJm4k3XruxrTqqqwPZuCbmlNaOBxNdIquYHo0TH8yKGa/oDOyLD
         /Le9E2p6k0gkecJ4HjW+vUo1q5xg69XYSDJeIL5DbYf9lVv79SCSPHevVcsPthynv8yo
         AII1fCBdJtHyE/mT8WgP0l4F4u6Iu7PY0RX0QeaoC/UVer9qEGWEZEJc30oADbNCIifg
         /khw==
X-Gm-Message-State: APjAAAVgz1yAtEynWlIu4HXpF8ZdpZPKQIZrFvKbtSEo4g2P4rNuHwz2
        2VWpKM4+MIKm1Hq/GXiCGhuvaQ==
X-Google-Smtp-Source: APXvYqxZ54D+VZ1BRTP9UpgguFCizP4ZBPpYz1OoT7BDsD1dW5wa3A5/4dEWw3lEyHmvu/gNNUOCMA==
X-Received: by 2002:a17:90a:8d0d:: with SMTP id c13mr39718491pjo.68.1574087806084;
        Mon, 18 Nov 2019 06:36:46 -0800 (PST)
Received: from localhost.localdomain (1-169-21-101.dynamic-ip.hinet.net. [1.169.21.101])
        by smtp.gmail.com with ESMTPSA id x10sm21910996pfn.36.2019.11.18.06.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 06:36:45 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: sf-pdma: replace /** with /* for non-function comment
Date:   Mon, 18 Nov 2019 22:35:52 +0800
Message-Id: <20191118143554.16129-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several comments starting from "/**" but not for function
comment purpose. It causes kernel-doc parsing wrong string. Replace
"/**" with "/*" to fix them.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 2 +-
 drivers/dma/sf-pdma/sf-pdma.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 16fe00553496..e8b9770dcfba 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * SiFive FU540 Platform DMA driver
  * Copyright (C) 2019 SiFive
  *
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 55816c9e0249..aab65a0bdfcc 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * SiFive FU540 Platform DMA driver
  * Copyright (C) 2019 SiFive
  *

base-commit: a7e335deed174a37fc6f84f69caaeff8a08f8ff8
-- 
2.17.1

