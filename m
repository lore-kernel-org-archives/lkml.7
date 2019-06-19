Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD7C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396C721655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfFSMas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:30:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51681 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbfFSMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so1589957wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNbb6ySXfk0LsxFqiydMR/t6l2T9CSD+Rib4fd27MSM=;
        b=e8Ez379cQ/VT/qA+FjKGPBTg9BhE2PuqSC1lbIpTx7XtOb2ZrbP1WZRbKgGeGQIi6L
         QRHqQIlZ/GmBsIPlY9LzURyYagVEuiyMlWXRRFxTnm7UOGfhH3TSYiBMZaPdRbgBdIdK
         wGcsPRmimLRt6sFx/7t/nbRM3WGB7+bu2prZaSnXxUZdJJWZ8ArmWXuI4RPXuX7cBOSq
         aVwJxLOzOF8keYh3stvmZ+pXeZXMw69wHiH8fLmeQS/8SQ1kOg5D9NCr8zvbV/uZAiTm
         pSet/dfW9rOFUJqYQ2hfXDjJZNplp1ixqGt0VyKb4gultAqIQxr2W7XOYkNOczSXm6z+
         aKCg==
X-Gm-Message-State: APjAAAU95wna0/CVTi2e/jMAyhpxnmxWm7yVjxl+37Gc6EWXea29/8fc
        MgifH5Wi/3ZpyJe6A311HzMV+g==
X-Google-Smtp-Source: APXvYqzDtNt23rFHKuVaUEO5oLhVSqmtdo5dNeWIEYEQF22eYOjWI12j/aKbz0NzzlQAmjdhiRPz6Q==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr8627226wmf.127.1560947445793;
        Wed, 19 Jun 2019 05:30:45 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:45 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] resctrl: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:19 +0200
Message-Id: <20190619123019.30032-13-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the resctrl filesystem.  If these options
are supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 83d3c358f95e..16b110d31457 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2053,7 +2053,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	int ret, opt;
 
-	ret = vfs_parse_sb_flag(fc, param);
+	ret = vfs_parse_ro_rw(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
-- 
2.21.0

