Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CDE206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYoKvq8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfLLOuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:50:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57482 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728861AbfLLOuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576162248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7XQ0BIDQs1rSkgFn546VmoxkIOFu9sf2QvSDRqt2+UU=;
        b=YYoKvq8kqS9GyAl/RC0tY86oCqPTA9qS1AUjYy1A93xfTqcLc/tjiTNTNPeqiZThjpweN1
        cGd8iS3DRuB9eNqMpE6LrZO+oNeEq0qlQ0QvnpTBBEjjvxLDt/rIpIrd8DP5zLZIFesjIB
        hA8Stn1JeSErympxuX0uRK4hmMD4o7k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-CioVZae2Or-KhoNGILrX-A-1; Thu, 12 Dec 2019 09:50:46 -0500
X-MC-Unique: CioVZae2Or-KhoNGILrX-A-1
Received: by mail-qt1-f198.google.com with SMTP id g22so1516230qtr.23
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 06:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XQ0BIDQs1rSkgFn546VmoxkIOFu9sf2QvSDRqt2+UU=;
        b=lqlXQEMZBWXKF7SL1p86Vb9L5AiDdmQSg5W7y87RaqkC3xQbzlETIu3mXqGAq52LaH
         0eTZxTr6D4EJokxfxIk3G40WFMtsdwNCdLsGqJCjIxJHFqgDEQVvso0K84lmSSeo6hvS
         CbQrDlq5wkQxk+G6ZQN1b2QMfgFV+1tRAjEdNLsyuXmxIZcG/fWX6ycOEsq4LUXPiLND
         n2DpSiNIFysQUF4ShdclhgKgTfZkH2qErKKl6Zx1vZatWOJIIiANH38KP4vlmtUdK61X
         8W+bMpNs15jKsaZVI+6V5V020yG7/LsLCTVH/5Mdq34Ni/9BM1FluklHUpljKGtOYKTp
         O3zQ==
X-Gm-Message-State: APjAAAUZgJhjBC1V1X1S100iP3BhJxSykQ5/Ljy5YA16bCNqurwENtfT
        bteutnptOqq85DaerjJAdLWALTvwrLkQnaNfK51bKsTMWD3HRpYc0jK6kKyfyd5tsS6lHIhyAJ+
        OSRSA553oR17O7arlH3jzhnCp
X-Received: by 2002:ac8:7417:: with SMTP id p23mr7598797qtq.313.1576162246357;
        Thu, 12 Dec 2019 06:50:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOQuw5KzIzEEpY1tkirep65v+/e3rmTOxoGFv8KpZEJqgnBlMHg1taBK8FFNx2bZg0I/q0jg==
X-Received: by 2002:ac8:7417:: with SMTP id p23mr7598772qtq.313.1576162246140;
        Thu, 12 Dec 2019 06:50:46 -0800 (PST)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id 201sm1823298qkf.10.2019.12.12.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 06:50:45 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: Don't reject unknown parameters
Date:   Thu, 12 Dec 2019 09:50:42 -0500
Message-Id: <20191212145042.12694-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new mount API currently rejects unknown parameters if the
filesystem doesn't have doesn't take any arguments. This is
unfortunately a regression from the old API which silently
ignores extra arguments. This is easly seen with the squashfs
conversion (5a2be1288b51 ("vfs: Convert squashfs to use the new
mount API")) which now fails to mount with extra options. Just
get rid of the error.

Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock
creation/configuration context")
Link: https://lore.kernel.org/lkml/20191130181548.GA28459@gentoo-tp.home/
Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1781863
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 fs/fs_context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..7ec20b1f8a53 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -160,8 +160,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 	}
 
-	return invalf(fc, "%s: Unknown parameter '%s'",
-		      fc->fs_type->name, param->key);
+	return 0;
 }
 EXPORT_SYMBOL(vfs_parse_fs_param);
 
-- 
2.21.0

