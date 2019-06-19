Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AAFC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A522147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbfFSMcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:32:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56134 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbfFSMac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so1577032wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mkwu/3OEXZGqXJyUnO5ri3H818oiUy7gpX5xDSptxL0=;
        b=Q27OpdFTv4OWEaErbuPdxhUVWomuu9rBb3nD7NAhywbWerg8Ks8VUea8igQYDmgcQ9
         +b3MbHkZaEJmyfvmJKYpSx9RgLxAsHCV1EC42ie/DdmwdCPM0A8KJZv1o3mV6RslsuQP
         11vPVG0EiwAvhme4hP1YQn5iaEDvia3eDv8Pff+lezd1vjPqYfQtcdTKhTtUwiWPTITX
         PwVJndxxD9Rb7Ws/EOsChDZztzPky/LutonUNPjcEofhAiDV8CR77zrImn/kF78eKsNW
         EJDIaFjPg/bgM94fANBIchpkx09PvcYUtBnF7Gp6Iq2nUqzq8I5fOPcUE5U5+0wfPYnJ
         rBtg==
X-Gm-Message-State: APjAAAX+QRerCva43DCxEJcbd1Q/W+uWp3iQO1LevMH7AHv7pGL7clKR
        s8Xy+D6MC8Wg5YfID2H4YkZ0Mw==
X-Google-Smtp-Source: APXvYqzhG/Ojq+ugu+NGlKLRr7Xa/HPx8OL4GK+QnjWlXZC3Xx84s21vw7gBF3qzuyD/LyRnzB0ihw==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr8459959wmc.77.1560947431788;
        Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] vfs: don't parse "silent" option
Date:   Wed, 19 Jun 2019 14:30:11 +0200
Message-Id: <20190619123019.30032-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this is a standard option as documented in mount(8), it is ignored by
most filesystems.  So reject, unless filesystem explicitly wants to handle
it.

The exception is unconverted filesystems, where it is unknown if the
filesystem handles this or not.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 49636e541293..c26b353aa858 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -51,7 +51,6 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ "nolazytime",	SB_LAZYTIME },
 	{ "nomand",	SB_MANDLOCK },
 	{ "rw",		SB_RDONLY },
-	{ "silent",	SB_SILENT },
 };
 
 /*
@@ -535,6 +534,9 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	if (ret != -ENOPARAM)
 		return ret;
 
+	if (strcmp(param->key, "silent") == 0)
+		fc->sb_flags |= SB_SILENT;
+
 	if (strcmp(param->key, "source") == 0) {
 		if (param->type != fs_value_is_string)
 			return invalf(fc, "VFS: Legacy: Non-string source");
-- 
2.21.0

