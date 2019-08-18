Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B659C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 17:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6E62183E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 17:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIGqsIae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfHRRAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 13:00:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35166 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfHRRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:00:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so5742203pfd.2;
        Sun, 18 Aug 2019 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=InlPSV/Fud4UWUCgto+/j1ZvODODh0X74nMaQ0nLf/c=;
        b=NIGqsIaek0HjL2GgtSXKY5GZVgFt+5jqDUInO3L77J5eaER7ZN8d99MATAtLY2JzPN
         EVU5bVid6REbeVbkJDFb80b1sy38bFj6EO7gXXIHl3taHTXPhgrQh0W9fPEu+B1mtBNz
         zMJ0EwoJx11zqoZSxzoxq+Pi0C49es/Fh02nL1WeL0NolPViJyNKX4/juh8KVqYaKM6F
         TBuyOd/mTqBSWauWhT/9Q3Crf2dCiiidIYe7govFkyI1EQd/XjxiI1owhL/FNRPI7etw
         w2pGv19Ci1X61OH6jsfSUGfjyXZIMbsjiwJUiasimYgezzTN8XxSGHtvEB7mCMBaa479
         kR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=InlPSV/Fud4UWUCgto+/j1ZvODODh0X74nMaQ0nLf/c=;
        b=q/Gb3SZ9y5V+qBTdkd8EOFp0SQTRpJ4hpTfoXZRMu1JwuCu+VhvfVvFrTbp3YiCawb
         Zy64SxDuiL8ogeQawJYG+yPchCp2MDuZ1yOqugv40jus2Aaf1Q00s5X5mzpFluUw4mav
         wxRoqOiqWfLwV0yrGo3dGnBgVBpUsKEM6o665jksK6rR/8xQ942a8lYUroYe0suGyYo2
         opJuT+x9vW7w4Fqk0ifka42UT9qlYDfYwIHIAmz1occFXEqLoGLfhzbItUXY7h4L++uo
         +pQudIeRmF4TH7rGt5L+kA1eKsKLUGUWb5iY/8In14yfN++G8t8xyHvUyN0BrDBIAlVe
         txew==
X-Gm-Message-State: APjAAAWCOHpTuuzQQMbQSBUmJA9C/h3ALyxaORI94GMG3IaZGgvwTgan
        DLwj4y90296TqUtHrSeWELQ=
X-Google-Smtp-Source: APXvYqxm+JpZUrPKi90PzUoRj4CYKmRp6DCp9IDbKaerdS94K13XnVQclSTUErvrl1h7LBtc+yL4LQ==
X-Received: by 2002:a63:b60b:: with SMTP id j11mr5062604pgf.283.1566147601603;
        Sun, 18 Aug 2019 10:00:01 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 10:00:01 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, zyan@redhat.com, sage@redhat.com,
        idryomov@gmail.com, ceph-devel@vger.kernel.org
Subject: [PATCH v8 15/20] fs: ceph: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:12 -0700
Message-Id: <20190818165817.32634-16-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

According to the disscussion in
https://patchwork.kernel.org/patch/8308691/ we agreed to use
unsigned 32 bit timestamps on ceph.
Update the limits accordingly.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: zyan@redhat.com
Cc: sage@redhat.com
Cc: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 4406ec7018bb..2aa052b7bda7 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -907,6 +907,8 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_export_op = &ceph_export_ops;
 
 	s->s_time_gran = 1;
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
 
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
-- 
2.17.1

