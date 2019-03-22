Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DCCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DE4218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghsf2j6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfCVG73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:59:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40935 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCVG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:59:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so842230pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 23:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zqN19qZBaTe3CuY9FccbjsllBZM7Go+ZjRPzne2VADw=;
        b=ghsf2j6F5Yim4GCwsQNVMUhmEgY3sfNHqNoxPb/1yhy7CyvevA/hrbmpeRmsMdOSQW
         eDnKCbZ6VAUdkR4/PAvENYUDwu3O/xCPe9k64x0fcov3aASgO6VIuVSxs+5t8aaLeN/M
         tVmtZdtk7nyCotgfo4iAXUj0yLE48rWmje0JZm9SFd2+KW3tenepS3jtBnCqtEtQ9OBa
         g6GEReB0w1oLhAPJT96sWOkdxDPCoYbsxJg3h2+25JlOeMt7bxlFt2RFYQgMN/nbRoLt
         uQsVBAA+W+sca+a+mjbq5pnAa26Z5A244lO0VJUX7eZfhJuCBl3qX+82/8W6CIsOLmkr
         0g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zqN19qZBaTe3CuY9FccbjsllBZM7Go+ZjRPzne2VADw=;
        b=qJrZxwVDCtKtmQlkaFnh8NUkIKzx3AD3Fb5vLSOsEWWlhAjW76DMpNTjFawGSPwepJ
         INsXVgQh/yby+m4TixsfFHpqv1lSPyBoxaSXC41OdSYe6DazYvGRDEflkl6KBgvGQofx
         5YgnfRqjl89cyXGElx7+4nwOJng9qZoymEXbEUNdITgEOZ9mWx7xF+TmILxmGJAhWkl9
         6pRIIX9clnPkAOWnQkoc31v9bL/4Zt3fbdGv1d5GQ/O45baiExZ9aUzd0eBL0aCTJBhX
         PQJpziIAFskrC+yBQq8+iTdrytC02Jucjg0H6HNB6nqurH6Oo+qWh702Za3gex8daqDQ
         uwUg==
X-Gm-Message-State: APjAAAUitDEJuothbPHN1I+QhXnDsSq0GM2VSwhehXZ2TGiRNHpxIS33
        TuzGVlLHdNuoip8t+EJ9jeQ=
X-Google-Smtp-Source: APXvYqyLhdQHHstmI+MhJJS8O72fAUuoS3nUzH/fNoSSf34z9qpy6i9qK/9NXVKq64bhIdmx3Gs4gQ==
X-Received: by 2002:a17:902:2963:: with SMTP id g90mr7991538plb.182.1553237968942;
        Thu, 21 Mar 2019 23:59:28 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id o14sm8437837pgn.65.2019.03.21.23.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 23:59:28 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2] tracing: initialize variable in create_dyn_event()
Date:   Thu, 21 Mar 2019 23:58:20 -0700
Message-Id: <1553237900-8555-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Fix compile warning in create_dyn_event(): 'ret' may be used uninitialized
in this function [-Wuninitialized].

Fixes: 5448d44c3855 ("tracing: Add unified dynamic event framework")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes since v1:
  - initialize to -ENODEV instead of 0, as suggested by Steve

 kernel/trace/trace_dynevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index dd1f43588d70..fa100ed3b4de 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -74,7 +74,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 static int create_dyn_event(int argc, char **argv)
 {
 	struct dyn_event_operations *ops;
-	int ret;
+	int ret = -ENODEV;
 
 	if (argv[0][0] == '-' || argv[0][0] == '!')
 		return dyn_event_release(argc, argv, NULL);
-- 
Frank Rowand <frank.rowand@sony.com>

