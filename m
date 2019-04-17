Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670C3C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EA620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfDQLy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:54:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732122AbfDQLy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:54:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50684B030;
        Wed, 17 Apr 2019 11:54:25 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v7 09/10] vsprintf: Avoid confusion between invalid address and value
Date:   Wed, 17 Apr 2019 13:53:49 +0200
Message-Id: <20190417115350.20479-10-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
References: <20190417115350.20479-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are able to detect invalid values handled by %p[iI] printk specifier.
The current error message is "invalid address". It might cause confusion
against "(efault)" reported by the generic valid_pointer_address() check.

Let's unify the style and use the more appropriate error code description
"(einval)".

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst | 1 +
 lib/vsprintf.c                            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index b2cac8d76b66..75d2bbe9813f 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -64,6 +64,7 @@ of printing the address itself. In this case, the following error messages
 
 	(null)	 data on plain NULL address
 	(efault) data on invalid address
+	(einval) invalid data on a valid address
 
 Plain Pointers
 --------------
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b989f1e8f35b..4e5666035b74 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1511,7 +1511,7 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
 		case AF_INET6:
 			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
 		default:
-			return string_nocheck(buf, end, "(invalid address)", spec);
+			return string_nocheck(buf, end, "(einval)", spec);
 		}}
 	}
 
-- 
2.16.4

