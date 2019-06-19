Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB01C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CDE21530
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbfFSMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:30:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51666 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbfFSMan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so1589688wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+fZF4p8UXoG115rrzAt76mcBbpeZ8uSJfCJdMqpJmo=;
        b=k5OPG9L4Y7pZQtfrT9eWQObrQllFNVmePIHE0kv0e7qg6QXrUHRf65W3+Aq1+lZpvK
         cI6nIuYyRzSLKm/COBZNQLvU7VgSDzTsbcZLutgm1NWzUy2XcxkMRZCPBfyCxyfeVF7Q
         +toeqHCismITvlze5fDTT398XWZiov+Avdmm+sVTPumFgheJsYr8/YIX4zMMwnhBJzgg
         Ga14aITsWKTk6SpNaM1AGxhIw11u81368HHniOvQmlKjdp9cTOwprEFEOHJfchoGdz5L
         m2NgcybntfQy7vejuc3Nt2KoVlMKMxbmGXAloTw5JKSxElydOS0M5nJJn08Tqrxjv6tF
         HWYw==
X-Gm-Message-State: APjAAAXyQM5/yGwJaSBlX+6Z71pExVeL7cLbpiTTQjJg058+zQynqW5P
        wcJFg5ASBbu+LslHaMStO/8WKg==
X-Google-Smtp-Source: APXvYqxOFvgzAiwoliKXheRHN29zlWhShNiFpi+wWSWUHY8gLlo8vKWqRpXQ0haoqcTS2XPWsi/GyQ==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr8881636wmb.25.1560947441267;
        Wed, 19 Jun 2019 05:30:41 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:39 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] cpuset: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:16 +0200
Message-Id: <20190619123019.30032-10-mszeredi@redhat.com>
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
and "nomand" make no sense for the cpuset filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 025f6c6083a3..f6f6b5b44fc3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -394,7 +394,7 @@ static int cpuset_get_tree(struct fs_context *fc)
 }
 
 static const struct fs_context_operations cpuset_fs_context_ops = {
-	.parse_param	= vfs_parse_sb_flag,
+	.parse_param	= vfs_parse_ro_rw,
 	.get_tree	= cpuset_get_tree,
 };
 
-- 
2.21.0

