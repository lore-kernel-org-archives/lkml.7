Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF39C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC2520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHywwHY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfCFQPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:15:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41781 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCFQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:15:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id k11so7802756pgb.8;
        Wed, 06 Mar 2019 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aIFJoF4nTNyGg8uRt4tNamj2fAAVFJo9pK7EWCxRUjQ=;
        b=OHywwHY5l37k0qvdon/dMd9MutO8cmjaLCq+pNuIGyVv21XoRqsg9rc4Ib2UqGcdCX
         B4ABSWmOp67kXbKP9le5kbiYxdDuEvAHH++/SfcgcsgGedrRCikTafHmG8kAYghD6C5Q
         1ZXOnE9gMDNj9byvdzE00fpWvIc4CFTEYrvr9WsxmoaGvs2qN3DYKbnQYc6lFUbR9l9I
         rV2avmMPs2QeLMk0a3oVbEGA0Z9fKlg2ycCwnvddbZhufE7hcLVrNokfmQvVtOb4vQCB
         b/8o2VCa++1F1+8CMaiLpRJfy3fXm0N2yOAy/GgxPahR0/tM1vixPXoMOfQWpo1AF+CG
         Z1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aIFJoF4nTNyGg8uRt4tNamj2fAAVFJo9pK7EWCxRUjQ=;
        b=c6+dcbhKlDHsVgflaGTxGpR88pgXKx2Kcn9sKI9JWb+12EGzLI0MYWjsVxISemB5QH
         hqEtwQDOlgu2NnVjKJMnMqn39pmZm+bGylYK9dHMztCupwL4h8NsZBNcqAbg1FHiMYLo
         lTc80uSOZ6vpr71gEVaaRaX0gjGwbZCl8JUtbGg1/bQG93GFIJEIwfD8SuweCbrvQF5H
         bEWMSpd9tRgY3CSsygwlrpLwzU48vth5ifWMiO1HRKXBOtw/IVZd4FOyrgGmv00j7ceL
         cFtGrCyn4qGE7RxdyXqMOwARM9ay/r7T6mztlLbstRmihqbfD/P8w6lys++q4zVZjgPL
         r0ZQ==
X-Gm-Message-State: APjAAAVQZs7WwGnQrd9fyZs7v2ij2VxWvHXF4362ggAK6s61cvWo2KKM
        SHCMKFRo7XzkY83jmJ7N8TPrz4PH
X-Google-Smtp-Source: APXvYqxR09hqyHu1ez+p4dtHQL6FX7Kr9laIrAdHAP2U7Yidpdlb9nD+PRkxNxBcuFHu4u9aBLtH+Q==
X-Received: by 2002:a63:4e1a:: with SMTP id c26mr6884580pgb.175.1551888950414;
        Wed, 06 Mar 2019 08:15:50 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.50.195])
        by smtp.gmail.com with ESMTPSA id s6sm3515905pfm.94.2019.03.06.08.15.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Mar 2019 08:15:49 -0800 (PST)
Date:   Wed, 6 Mar 2019 21:50:19 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     bamv2005@gmail.com, shuah@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH v2] selftest/gpio: Remove duplicate header
Message-ID: <20190306162018.GA3187@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Remove duplicate header which are included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Corrected format.

 tools/testing/selftests/gpio/gpio-mockup-chardev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index aaa1e9f..d587c81 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <errno.h>
 #include <string.h>
 #include <fcntl.h>
-- 
1.9.1

