Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC0C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5F121873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfFSMa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:30:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731859AbfFSMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so3187659wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nQV+HbwwVC5JDcFHvgQnxZlAQ2DeroGpuSkk8jd0Tk=;
        b=JY+DN3K+8z6qR5EaaN4BIxFx9ZQ298uAIsuCNuiD6d/NzXy3lbNZPNFYmanSgN2ekv
         WulNdyCfsr6Y7lUELObOYb4G42SpjkWkqzBlDf06+9u6foaxXi3RlNoxYWIMCYBQdgGu
         J+rM63CsY3fsdtxzERsLnUeF9b8HOpFEQ5rWSX3TMEvpjFrGeB+qanMNMxaTGCXlbbT8
         nN7h73l+vQrnd9/7/rJDC+NgxFLOtHDIhNMVd4byuwwKPGOXQhrnFPYpjtzg/uiaDuja
         3jK+jDSYNfobUPLDVWeuPBMcoC8GGRUyGWXT7MD/Bq42/bKplidvvWsaFHzencF3Wt2D
         h5cA==
X-Gm-Message-State: APjAAAUFSLTKhIUXrT0QKdApEUxGyOGGJVaQ0UMvxB4EA3/DHa36evHP
        2HmWTLVnqb3pQi78l7eI3WWfYg==
X-Google-Smtp-Source: APXvYqzHsHTMP8Vjwh/pAfZnm0GsX3Los4ghw0Tsr9S1GdEGtjlvPbrdctjrtSZCkpbDaeO0HjA9Bg==
X-Received: by 2002:a5d:4908:: with SMTP id x8mr18266350wrq.290.1560947442583;
        Wed, 19 Jun 2019 05:30:42 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:42 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] cgroup: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:17 +0200
Message-Id: <20190619123019.30032-11-mszeredi@redhat.com>
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
and "nomand" make no sense for the cgroup filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 kernel/cgroup/cgroup.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index f960e6149311..1f50d59f7f4e 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -929,7 +929,7 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	int ret, opt, i;
 
-	ret = vfs_parse_sb_flag(fc, param);
+	ret = vfs_parse_ro_rw(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 93890285b510..f2e86b3942b3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1836,7 +1836,7 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	struct fs_parse_result result;
 	int ret, opt;
 
-	ret = vfs_parse_sb_flag(fc, param);
+	ret = vfs_parse_ro_rw(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
-- 
2.21.0

