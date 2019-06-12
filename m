Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7313C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D1921743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404748AbfFMRN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:13:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34881 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbfFLWB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 18:01:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so18557612wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 15:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rtjjxJbZCnNJbQ4rRmAh0Ahovsd/DILFvQwc++jpSoQ=;
        b=a2ORLIoZf9N5iqjC2ggsM8Hh1mhSo5nxnJ/DZap0cc/9kBYXO6LDjFn1n+SoxVjOsC
         PV11oWZ2YNZtPTveKxaJ8gh89ChWF049yutZ4Jxxo8Gib1JOvxQn3ohhDOSXgJLGiScX
         ZGRnyphL4n2zKqEc9M3p9+r2MsY0ZCujvKR1EgGkj/zYj6jL44QF9aMKglsZAnaoQoky
         sZqToFv7FnnmRJ2kh+lIf9Oy2TLZYeRuaN8MMw3gWfRWlDa1Fig3fB6LyzpC9FauHrA2
         s26CsgA4GBiUteX8gczWeWafn+7Bg53GrB0jUa0xJ+r/ok9mPiIJF15s368jgexnobZp
         21oA==
X-Gm-Message-State: APjAAAV8a3Kd8PgVySRnifK3fj72RRZBqAhUZELwJQ+h8GNlX5FFoz9i
        aJHRCq92RfEjJyIDvVlVi6RRWA==
X-Google-Smtp-Source: APXvYqwzum8xO+Bu+aMx87Ojw8bGvggqXnzAbO1TIQlOxrSKi01Hd/i8+OaLN8a0LKXtOAy3bBjcow==
X-Received: by 2002:adf:d081:: with SMTP id y1mr11088437wrh.34.1560376884297;
        Wed, 12 Jun 2019 15:01:24 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.dsl.teletu.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id i188sm929448wma.27.2019.06.12.15.01.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 15:01:23 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: [PATCH linux-next] sysctl: fix build error
Date:   Thu, 13 Jun 2019 00:01:20 +0200
Message-Id: <20190612220120.31312-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cefdca0a86be ("userfaultfd/sysctl: add vm.unprivileged_userfaultfd")
reintroduces a reference to 'zero' and 'one'.
Use the SYSCTL_{ZERO,ONE} symbols instead.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 kernel/sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c77174336d16..4dce89d74a40 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1735,8 +1735,8 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &one,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #endif
 	{ }
-- 
2.21.0

