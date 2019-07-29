Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410FBC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134E42067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KcZYhm+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbfG2Vr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:47:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40845 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388817AbfG2VrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:47:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so28674554pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uq42J3+sfNTAn1sxO6d5JaONzJuM98rsM2Gw1kk8DQg=;
        b=KcZYhm+rwxzgHL1tF3lL+XQqx6+EcftEzufUHAqyLFenSg4dMPl0j4FQ7YR755+1OX
         Sn0M6Ha3pYfja6duLcrLfQi/xNi6xXn1USbj9nZflgO6vhTAqHKn0UOoqAzqalCg33fN
         uClNvDqQjEYTxMfAAkGRiwBEu93j/BmdGNLRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uq42J3+sfNTAn1sxO6d5JaONzJuM98rsM2Gw1kk8DQg=;
        b=Th82JPvlBoosjqHUEgTHB5oHMCXnQ4I9MTZmNepFX+Tsu5vDPjZ84intdDVyFd4Wax
         0mRGg9hTMajqWCscIp7GECc28+1T5/ucWHpDI8EagZUU9PuW+7pOWqvy+QlPmtWMCu9A
         VZ6KDTtxIu61JZHLJh24Awe6pyildYTUxbzWfefE1JZGMML7B96O9wu8vjLjg63o/NgL
         hxkzrLxrTT23BHZ6MwajyYnS8eU5b/A3QyAgSWDlXR2qNJGrT6lxT/QRUEaIJrxSF4o1
         nqOMEIqgxtUF1EXjGXm54a5vAC2U74ewV+94JOOGSTR/UYVXsFfuwmN++JwWVnfCTtoD
         x+vA==
X-Gm-Message-State: APjAAAUHFrev6xVQIUy/EiY0KO1ZbB5/6FXM+x+tfTbxx4ZEJXheiT/E
        XLqIaWC1N6bs21pm1jF6QND04A==
X-Google-Smtp-Source: APXvYqzgWpzXq3OSNbQIOK4AzTMYmewqjPJ4Uj/C4lGC3kLgNOyQaaiABUx3yDzqQJiViQ3filY0fA==
X-Received: by 2002:a65:4786:: with SMTP id e6mr103642877pgs.448.1564436843930;
        Mon, 29 Jul 2019 14:47:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l124sm62748095pgl.54.2019.07.29.14.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 14:47:23 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:47:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v2] libata: zpodd: Fix small read overflow in
 zpodd_get_mech_type()
Message-ID: <201907291442.B9953EBED@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrin reported a KASAN issue:

  BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
  Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
  ...
  The buggy address belongs to the variable:                 
    cdb.48319+0x0/0x40                                        

Much like commit 18c9a99bce2a ("libata: zpodd: small read overflow in
eject_tray()"), this fixes a cdb[] buffer length, this time in
zpodd_get_mech_type():

We read from the cdb[] buffer in ata_exec_internal_sg(). It has to be
ATAPI_CDB_LEN (16) bytes long, but this buffer is only 12 bytes.

Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Fixes: afe759511808c ("libata: identify and init ZPODD devices")
Link: https://lore.kernel.org/lkml/201907181423.E808958@keescook/
Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: added reported/tested-by and direct to Jens
---
 drivers/ata/libata-zpodd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 173e6f2dd9af..eefda51f97d3 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -56,7 +56,7 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 	unsigned int ret;
 	struct rm_feature_desc *desc;
 	struct ata_taskfile tf;
-	static const char cdb[] = {  GPCMD_GET_CONFIGURATION,
+	static const char cdb[ATAPI_CDB_LEN] = {  GPCMD_GET_CONFIGURATION,
 			2,      /* only 1 feature descriptor requested */
 			0, 3,   /* 3, removable medium feature */
 			0, 0, 0,/* reserved */
-- 
2.17.1


-- 
Kees Cook
