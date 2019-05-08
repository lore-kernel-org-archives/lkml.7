Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1B9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89414216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB5PfQEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfEHUzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:55:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43690 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfEHUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:55:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id z5so96846lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdHQ2fN9PmYyyKfWtvF5eYBZ95JotNTRJaQiGnwT22Q=;
        b=nB5PfQEzy7OJ7F4ijNv3ammizGHtT2f6SwnFsNgo1hS/qK94j1nbkEtPpdRPqm0qoS
         UhyFFgLmrWvr/bjASQYCwNGzqZQ7QfTlc7zTsuI04bmZTEIdCbQN+BtGavqQAE4fRSLc
         qWufHDuuvjb83rN7UiVIkSBCOjaj+ai5oLQm6woOtVlGmEEMTj4Q079HJM7SJckKmYeT
         x6QCwhXEOQ0LC7ZxCB7b+Ng7lHhx0sICanN4YAnSNv3pPS22+/SX94ghijuxtVhQebLi
         3E1oNsy+nMBpizNgSMdXKoxxCdQO/9+b62MkJ+uiBAjylV05a6O44414HXkjN5MOiJh8
         qT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdHQ2fN9PmYyyKfWtvF5eYBZ95JotNTRJaQiGnwT22Q=;
        b=WCR4oMPItpjITIVFEQAV85RT7GMrcxZXBaRuA7bq8nB1jmgEbRHloqRlxoFxRUFgMr
         0OjXoz3YLCCHyg+zHX5h5VX9g3wmmTmRPmwGCzY+tRiGzgLsMyx8HOSd9LaLkH2j7W+i
         61bw4OzmSpOkL/hx/LAXq1P/TfMKSHEj4m3dGVnsCvBWMATX53NurubJqomw08hfQsu2
         mXAngVONgLPjl78ItnFtCALisakMX1ZRPdy9tqdxZ2shPpDGDJER6Y2AOUMwNwKk4jgC
         9nnzIOPbmEg1yepQRJN7BeNT/XyerF7laXsPvIq/ytzPb2bSdJlWwLpWRzOxBf78tAfp
         w3CQ==
X-Gm-Message-State: APjAAAUW6JixknAyfmVHshWAS5Zt6NL+1kXLKELkpAe85aHdBwFZtdwZ
        QTn8xrDiwqs7+vziVopeD9n1wfZ9
X-Google-Smtp-Source: APXvYqxF4bRLmQ0lCdvd24dzL0b5mFPZQZHuqbb41oIPCNbn8ScTXThKxTpVU0p8Ul0YdYCnv6esWg==
X-Received: by 2002:a2e:568b:: with SMTP id k11mr8084177lje.124.1557348942803;
        Wed, 08 May 2019 13:55:42 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id p18sm4833697ljc.54.2019.05.08.13.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 13:55:42 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] drivers/staging/kpc2000: fix build error on xtensa
Date:   Wed,  8 May 2019 13:55:13 -0700
Message-Id: <20190508205513.11312-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kpc2000/kpc_dma/fileops.c includes asm/uaccess.h instead of
linux/uaccess.h, which results in the following build error on xtensa
architecture:

  In file included from
  drivers/staging/kpc2000/kpc_dma/fileops.c:11:
  arch/xtensa/include/asm/uaccess.h:
  In function ‘clear_user’:
  arch/xtensa/include/asm/uaccess.h:40:22:
  error: implicit declaration of function ‘uaccess_kernel’; ...
   #define __kernel_ok (uaccess_kernel())
                        ^~~~~~~~~~~~~~

Include linux/uaccess.h to fix that.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 5741d2b49a7d..0886ad408b0e 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -8,7 +8,7 @@
 #include <linux/errno.h>    /* error codes */
 #include <linux/types.h>    /* size_t */
 #include <linux/cdev.h>
-#include <asm/uaccess.h>    /* copy_*_user */
+#include <linux/uaccess.h>  /* copy_*_user */
 #include <linux/aio.h>      /* aio stuff */
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
-- 
2.11.0

