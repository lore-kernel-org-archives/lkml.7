Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07872C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA47A20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acocqf30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfCFQSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:18:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40994 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCFQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:18:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id d25so8985792pfn.8;
        Wed, 06 Mar 2019 08:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Qf1fgWJYahIiJYzezquJ2dcavBZMIViSGrZd4qooBHY=;
        b=Acocqf30Lv2Gm2kX36NAmhA04v2C/v9p0WT7kAltS7nwizpJyL5IlMUNk/8HzePn1o
         Nhdn4+08QhZM+caG2i6LMAR8jVxp5X7pc8pApTg5Ne3P+qMAqtiWA34tuBnnqqmBvwqO
         FFxzFBMzUMgiKGB4lAuvn9Wf5bDwcwW9iopGR5W2z8luKzq9qk6v7cEVd+NjHpHpytJw
         qiuds9jsPLAwSm2t8blUg1aDGZNmpJwnw5qu+M2xeWIbmMulvK9zJ7mbKWlv6SgTw24e
         mHxUeQyJ+tP/SFW8MLeUcXG6ju07df1cWnW+KoAow2rNgqiu7FQDkI+K0da8J/t5v3aG
         GL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Qf1fgWJYahIiJYzezquJ2dcavBZMIViSGrZd4qooBHY=;
        b=NxtY1mOdiPqVXBWw6nX8WQ+myhWIFUJFTE43r1N5v3UyuWGQzjHoQ2qZmR1V2zEcO8
         kyzvlv0m1IgbbFif28tzKeVXeDEFUl0s+bmXm3TNqnuRDjeAh4sBXepwF7yccsr98ecm
         ofDQlquwRoLXxaM/GzkGkA6e3pyHTfIqPFSrAl4gfwaqEH4yyxxF6FvWM0nDlzg5Lp28
         NTI6gavcYudD+TWpEUNhaMT78JoI7A4uTCY6I46zzZ4SOi3+gJWbnmrEyiZvtjlwupp3
         n5juhiRnz3PYiUcBkihFilfVJVjvB8xoT5OXVUa2lp3AfIDYUKdbA/xJGToyvqqkyCF1
         e+9A==
X-Gm-Message-State: APjAAAU7bWJx4vvsmZBeOcno6n9xa4bRxQBXr8E6CRnqhelWVuyK+NgN
        col2VCxhyf8yRSKOHPrEDFM=
X-Google-Smtp-Source: APXvYqzGXuUQtYHcOFEMB82OKwBQXZ1cs52bCDBFu7O1ch8BAvq+n8QzNnIwyxVeTcOicCempPw9qg==
X-Received: by 2002:aa7:90c1:: with SMTP id k1mr7885371pfk.202.1551889103982;
        Wed, 06 Mar 2019 08:18:23 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.50.195])
        by smtp.gmail.com with ESMTPSA id i79sm3522940pfj.28.2019.03.06.08.18.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Mar 2019 08:18:23 -0800 (PST)
Date:   Wed, 6 Mar 2019 21:52:52 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH v2] selftest/timers: Remove duplicate header
Message-ID: <20190306162252.GA3221@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Corrected format.

 tools/testing/selftests/timers/skew_consistency.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 022b711..8066be9 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -32,7 +32,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/wait.h>
 #include "../kselftest.h"
-- 
1.9.1

