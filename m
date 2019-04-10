Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3BEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA9C2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="WPuRVxJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDJWD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:03:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45560 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJWD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:03:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so4654258wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hq3GlPsvwpTCVfi2lanoAJH6xzEgHr4jpS+LbkBKqmI=;
        b=WPuRVxJRivFPjjCdQfmmaS0CrfLqcY/WlDrt1L0JfjgxRQcK0o6r3E+Oy+PgKDZljO
         W28D8vz3zVV9EfEUUvuQV09uJPeV+z6qH2FBWMhoappFrwsMB6ADmDqntwBT7zUBgdvE
         Cvk/4rtW5YG+wi2NlWs6mFlqMc4BE+bwjKWBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hq3GlPsvwpTCVfi2lanoAJH6xzEgHr4jpS+LbkBKqmI=;
        b=rMQTbwAcV/Cwzb/rtaf8oPZe0EW6SpiDSnNqHQhXQbXGcqdr781+ZpCRWX+RxsBp3n
         sF4BzsgB54cmdFZ/en003FsDLBclI5vJGrT3MA6NmqMkfd3HhOzC15YVcBIYHISMJzq8
         dTBpmos+zPTCvU1nAWoWOptqlvlEPPFGTbKWHRoX5s/E+6Xghja1Bo/E0v9q+WRFFuXK
         FWh8MokuBuv6EapK8rc5I7GH1dTkZI2Xc4clYtNRdi5ndIkYks7wQsNvPV9L164t7Cct
         Lu4xiiFTPjUhfQgAW4JcvLifyki6lD6I0N1tM78JpAQTuObOYjtZU5utKA236gRj/300
         bR2w==
X-Gm-Message-State: APjAAAVDg4JvDEd3ffmUYZT5G6VsrH2Tylndk+95tkGq6Zy3jPx7Kd85
        MGe/7kPoXXiB6eMkhBjN30AwRQ==
X-Google-Smtp-Source: APXvYqyaojQNifGlnsMHgerH9+LQehKvanptd8sWxM2iL7AbfRV4PcUY71je/Vchn/egoUgV3hUePA==
X-Received: by 2002:adf:d848:: with SMTP id k8mr29500390wrl.185.1554933837415;
        Wed, 10 Apr 2019 15:03:57 -0700 (PDT)
Received: from localhost.localdomain ([95.149.160.82])
        by smtp.gmail.com with ESMTPSA id c2sm27565107wrr.13.2019.04.10.15.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:03:56 -0700 (PDT)
From:   Louis Taylor <louis@kragniz.eu>
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] afs: use correct format characters
Date:   Wed, 10 Apr 2019 23:03:01 +0100
Message-Id: <20190410220301.2332-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wformat, clang warns:

fs/afs/flock.c:632:29: warning: format specifies type 'short' but the argument has type
      'unsigned char' [-Wformat]
        _leave(" = %d [%hd]", ret, fl->fl_type);
                       ~~~         ^~~~~~~~~~~

fl_type is declared as an unsigned char unconditionally in
include/linux/fs.h, so use the correct format characters.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 fs/afs/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 6a0174258382..be4c3f6a3178 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -629,7 +629,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 
 	ret = 0;
 error:
-	_leave(" = %d [%hd]", ret, fl->fl_type);
+	_leave(" = %d [%hhu]", ret, fl->fl_type);
 	return ret;
 }
 
-- 
2.21.0

