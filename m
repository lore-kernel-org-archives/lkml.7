Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45886C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256912147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbfFSMbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:31:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38243 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbfFSMak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so3212502wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdQVoNmmq/tpICs94VWnUfb4xhH0uHVfAUpoN+yDuN4=;
        b=DnWe2at0dLok+t5fMobLMYlffKBP56+wg6ra7wExpF00ynQ4XYIhPJRmCj5R4qHdBo
         cLwleIAHCxEuBFXXILFSLDR4fN72Fv3GLPt35pMHeE7U6Hr0xXaDRBDeBCVOa4Jj/cWR
         MMry++3Xd3yf3WMTUIuvwch++HBeLPT4napY83srcPD9cX6qnvv4dVvYOfmVo9tdRWnY
         7zo9MDKX8vbSuUFQgYyv2UBovWSFVJIKsoBNklVLMBePOZ6IyMIXEb89GctcHPxlOBKS
         NnJNtTxjpEfLCOelrzqNj9dWgNYSiH4/6Gwews/Ed1tThKQQWoW64+pk9ASs2DZe+QJj
         lhhA==
X-Gm-Message-State: APjAAAVasL69vcSgzYeH/hYjxTs+MM8VPIhjwe1OjRZCtjx0AdbLP9kw
        AWB+uGQ6HpfECi5DXvXvt9IQyA==
X-Google-Smtp-Source: APXvYqzgc/pTXrx3oLCjioNyxDtYbyoBKOJfXCsDmaWxhuRtivEE9x9bE9zw/wRPVqXoUt4DZF9cvQ==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr37772543wrp.188.1560947438884;
        Wed, 19 Jun 2019 05:30:38 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:38 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] mqueue: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:15 +0200
Message-Id: <20190619123019.30032-9-mszeredi@redhat.com>
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
and "nomand" make no sense for the mqueue filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 557aa887996a..1e8567c20d6a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1577,7 +1577,7 @@ static const struct super_operations mqueue_super_ops = {
 
 static const struct fs_context_operations mqueue_fs_context_ops = {
 	.free		= mqueue_fs_context_free,
-	.parse_param	= vfs_parse_sb_flag,
+	.parse_param	= vfs_parse_ro_rw,
 	.get_tree	= mqueue_get_tree,
 };
 
-- 
2.21.0

