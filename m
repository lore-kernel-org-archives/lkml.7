Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E4DC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FBE21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="aTqspW27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGETDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:03:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43419 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGETDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 15:03:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so4666049pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgF4Rnpb4hESMxcWU/Va0fg6VtYy9OWldEpeHvAq+44=;
        b=aTqspW27RUz5y0/8r+A3dLV6CLyEVAHErrvepQ6P3rYaqMuU3kpCt9BAno0xzgAffj
         7PNtB8y38k4yqhx21nHrIp85GPQC/0V2GSRtgn4PftrQd5BWHOEqm0qvnJVdFd/hpbbH
         HjWOvzQQ7mJ6zBN7Z3kSgCB+gA+/kagS1x+bjQsy0Md+UvsjZmj0B88lc4HZu72Tzt5y
         TvhW+jPjOKsUb+TpEuY/3tzxCKc1CtNsXSa6yu3y1fNzta5NdUUr70JMc/TN5aDPMpqz
         9fd/AkEY0x/3As7sH7Sph8MvWN5rNGybq1ri7YPYVAbwR9lK1hSGpoZ/6IFD2qqHb9Gd
         7eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HgF4Rnpb4hESMxcWU/Va0fg6VtYy9OWldEpeHvAq+44=;
        b=Y/7jCACwY2dUgIpWkCqrrVbAlqA4VpHP+2A0lMKHXXzcgwwyvejWidqaxnPE1UVfrn
         luknchXbQiQE3GeJ3ZOaMy/l3q7m6VLbwtt6BSEpz3Y/PVs+6f50J50k6xlDSB0K28Z7
         xl9eDiJ4fxxWZ7hwHVdOlBh6j+ZgEwYnsjG4GWugtwyE+KShQf9wxpXoPAKjHR7GQ/gG
         5Og/Y4WOONIXST2Hd0N9KudFdCyWl4IGMfBNmM6OIe463TrowR9eAS85qwHDwfH11Kef
         7slBdrqpDDxJYucd5YmrvR4Fk0df3ALr1rg/ScTnTw9oSOsyGekDJC444K0MwekjuUmM
         Q+qg==
X-Gm-Message-State: APjAAAVJLoP4lFe/IbIjphIl0eqF4g6Nekwf3CaBNrY/E0DuOEsVKvZb
        nT8E1rgWb5qKqKfQDB38oreevA==
X-Google-Smtp-Source: APXvYqxc4byaNPJ+Ted7/VEOfpKzL31z/JBXPmc2kuVYxpBcSE5PFzLheQd3GQUF2/paiao/FQJZAQ==
X-Received: by 2002:a65:42c6:: with SMTP id l6mr7463567pgp.442.1562353380848;
        Fri, 05 Jul 2019 12:03:00 -0700 (PDT)
Received: from localhost.localdomain ([122.164.127.106])
        by smtp.gmail.com with ESMTPSA id h26sm18165857pfq.64.2019.07.05.12.02.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 12:03:00 -0700 (PDT)
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     oberpar@linux.ibm.com, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] Documentation: dev-tools: Fixed an outdated directory path in gcov.rst
Date:   Sat,  6 Jul 2019 00:32:39 +0530
Message-Id: <20190705190239.8173-1-jeffrin@rajagiritech.edu.in>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed an outdated directory path inside gcov related documentation
which is part of an example that shows the way in which the gcov
command should be used in that context

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 Documentation/dev-tools/gcov.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
index 46aae52a41d0..e3d262d8c7de 100644
--- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -8,7 +8,7 @@ To get coverage data for a specific file, change to the kernel build
 directory and use gcov with the ``-o`` option as follows (requires root)::
 
     # cd /tmp/linux-out
-    # gcov -o /sys/kernel/debug/gcov/tmp/linux-out/kernel spinlock.c
+    # gcov -o /sys/kernel/debug/gcov/tmp/linux-out/kernel/locking spinlock.c
 
 This will create source code files annotated with execution counts
 in the current directory. In addition, graphical gcov front-ends such
-- 
2.20.1

