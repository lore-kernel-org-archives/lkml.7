Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A0CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028A520873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="b7/9uQ66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfJHXIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:08:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39933 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfJHXIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:08:31 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so730898ioc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=t3QL86pnLLp7H0YYwH/FdnAoL7Vq3h3qOuyHpBMWRk0=;
        b=b7/9uQ66uupBgYsVJw0ZQPL+EeFq27QaSUNsKPah4m0OvuJROtA65r5jxaJDF6YnlX
         iab1ki5mx3Sz+PRjV2NBtM3e0agwYbL0MUmyzBc+FrmvdBPAMPnrn7DQl2TsOa4ilXBB
         TPlk8zNqG+fZTqi2FBhsRM5PJ+QDfRKHaC7s3/fft/hXNXzQDOuuFjutP5SgSKQErlFi
         lXfOIHBDmRgk54rWLXvHgOQ4ihDsxsCN7V6ytatzlbO6/BbM75VTkSAwd2qMSEv8mEyo
         u8Rs20zqVaO+JNiGR3XyoVsxl3YHYkxOOTD7H7SgKxtQrdfsLWAIntkXUsKP4qOvUtEZ
         L+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=t3QL86pnLLp7H0YYwH/FdnAoL7Vq3h3qOuyHpBMWRk0=;
        b=p9l46BrEE7qXc9ndxGRGqu3G8jZSWUAKf5HeKeNwd+KcWqH0/0Wj3F9YEvsEeWvCjd
         2/wPmtD3ycI5Ts1epOEFK2ebv/XZijsS/dD68eELfxhdgYNJWdo/ysQc7BzgzIBHa3cT
         nGNsjM7CQjJP/aB3BFJb3TfbDrmPT+AKvLmWrVh4D53wNrsRtI5SOMgcr0JBS+LMuGeq
         vP8m8BU3V5E6K+0JHch7GoG60FIdK3kfyQ/PyoPjmOCgFI23oDkRzQK/NjVRw8kgoh3Z
         eIiG5LN0euYqy/FSbaau9fizhCpNU/jRsq4iXsi20uDwEJDq5HePRchedkuF0Xq8jhmx
         K7qw==
X-Gm-Message-State: APjAAAX9m8ZnjimuCy1BGerMRDKyupYbLXp5UWdLkCc8iI92JDfYtb0r
        vJpJzG9C49KP4AQOvSbyj6wnXA==
X-Google-Smtp-Source: APXvYqw9T/3Qa+z2vFNUc/+LzFnPBHh8p1vHwRgtUolzXIAAClxQUyxSFD7Sse4Dm7TGhqZE04GXvA==
X-Received: by 2002:a92:8fc6:: with SMTP id r67mr121939ilk.25.1570576110234;
        Tue, 08 Oct 2019 16:08:30 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id d26sm195329ioc.16.2019.10.08.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:08:29 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:08:27 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     corbet@lwn.net
cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schwab@suse.de, hch@lst.de
Subject: [PATCH] Documentation: admin-guide: add earlycon documentation for
 the sifive serial driver
Message-ID: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Document earlycon usage for the SiFive serial port driver in the same
fashion as for the other serial port IP blocks, since the SiFive
serial port driver supports it.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reported-by: Andreas Schwab <schwab@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7ac2f3ac99f..90becb00221b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1106,6 +1106,12 @@
 			address must be provided, and the serial port must
 			already be setup and configured.
 
+		sifive,<addr>
+			Start an early, polled-mode console on a SiFive
+			serial port at the specified address.  The port must
+			already be setup and configured.  Options are not
+			yet supported.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=sclp
-- 
2.23.0

