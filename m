Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1950D20675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj4w2N4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCDSQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:16:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44247 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCDSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:16:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id j3so3635903pgm.11;
        Mon, 04 Mar 2019 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SUSDKce1jHqow8qHOda9+7Nuc5g85cjDAGXQXYdXDf0=;
        b=Lj4w2N4uqIQijZYUDq9xjfB9YSKyRzkP12ztjtLNvJJTBRgFmNlyphuae8k/9T6I6U
         OaTT+hKR7KhjEyzYxrj8tAMCILvcPnX6KREtVe3X1vpq2EJXuOS7qua3opNfVz/9SOYQ
         Fdb5+IpB7eDAwooC0jFablSUXxB+VzJGeuDTBNW+dIrYocmins4vA1dg1y03/07k8qkp
         SjHPn2JYr/vUS2I78Bhy3+HmcwAp92l13WLXtfnIOV3ECaRcthz2j1dUyXUilmEkO3VH
         Pwgss9lt79r8os2DjD/upy3L3WC0jxVyzUHBwja2TtePXpyqCHDn1QE88qZYvWtCwev4
         dHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SUSDKce1jHqow8qHOda9+7Nuc5g85cjDAGXQXYdXDf0=;
        b=ADyus0CSiVih7H/hxBKEOmd+CJRwrhH5uwECYzim2mjbuZLed/MFIWxGIZoK/6iK7+
         EwNo0VQg3n/klTkOjS274LMqHXPtu33nfl1dwCU0unbwvXR76bbI9f0YJdR7x5hGSgB7
         4ZNhVsmS3vvhSTdJgJA/V7dpTqvS7qwCXO+EQEBENBBKg5DX45BSl3IlShJwHUSM8UT3
         12I3/l7wf0vA6hKVJUd1msk0x3jSVO/9qFWvqOq1Lqe7mMZYOd0HT4zVH5maAcXh/NaO
         H7wg4qxqpWI2nEw7eSE2uXKQ9iWjoogeIqN4cZ+txGspwABUILqB2jKHSP1fp3f1lc5K
         eqsQ==
X-Gm-Message-State: AHQUAuaxvUyeVF3OFITlDYqV/OhDHrjHBV3dHO14xMSzHFXSw153c25h
        sxTEoncVSZXgG+3Ok05MG+E=
X-Google-Smtp-Source: AHgI3IZX4ymK9FJasGKMltrQ+QddchGvJskUSqKFrCTNcRQ78sYF1Z16Os/UcBeCYqELqcQuAx2Q0g==
X-Received: by 2002:a62:1bd4:: with SMTP id b203mr20946396pfb.144.1551723383383;
        Mon, 04 Mar 2019 10:16:23 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.146])
        by smtp.gmail.com with ESMTPSA id l7sm26328033pfj.162.2019.03.04.10.16.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 10:16:22 -0800 (PST)
Date:   Mon, 4 Mar 2019 23:50:48 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] selftest/net: Remove duplicate header
Message-ID: <20190304182048.GA6553@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/testing/selftests/net/udpgso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index e279051..b8265ee 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -17,7 +17,6 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
-- 
1.9.1

