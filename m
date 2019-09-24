Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3872C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FAF2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569354761;
	bh=9Zqwja0a3zjksBuVxiikR342abRYwV5RT4etTofKeME=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=m/6bT6Cx3TCQqc0Wgfd0J5Pf+p1tzL+nN/uukaESae8W7DkHcjD2kHisO7zYVVjfn
	 IbCvqCINYJ/slcdsB3fvbj5TNJWOcuzg2BKQcfoVuMgW18orvA+wXjoqAXKr7UUs+x
	 kViw7zW5xVgH4jsRiajJcUqpc4H1dykMe4AM/QBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633001AbfIXTwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:52:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42525 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfIXTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:52:40 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so7466552iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOnpOcgSk5NX5LvkWHWvLf5kiHdtooLHIMsu7TMjUxI=;
        b=RFzpzm9U/FsxED0LFp9Fp+Mj4jRg7GqvNmOO+9whCApw4/WFURWolT+VRG9v+OWbPc
         l7N3w67EPii/OkFXjP4gTcNruVsJjMcPfxmI6GOsKOSHp1Q4jkLP8yQ4KH6LzWsBIuAM
         XGty4konqFPtGgc8WZCm0YXM2ySxl/Y2U3+UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOnpOcgSk5NX5LvkWHWvLf5kiHdtooLHIMsu7TMjUxI=;
        b=gP4Kgzw7KirvCHLDTumaAJlenZw0AGJ6HqH6XxYtIxj8Y+/adYf+sCjhFsAkW76rOw
         oU82r7cr3KC3guZlP+hs1JMHaAS4HaMbrICCnX2muYEchRPXxgpyr6I/mhbdyqhEM9Ks
         5IOmXhnSTp9gXjuWT2HAAHl2uB6Lc5Y/l2TkPOztLFgSEMubv0/ZvPG0p7YVbVdLDlgz
         w4bqiekzDGfO0uEl7pmXZpZ2igGT0hMFST60qNu4MydkyB4epa7rxzkLMFcgNkGfwsYh
         wH+Z/2jLzfV9aVZkFHwILwiNyZHUWN0dclYP0KwarVlo4i2m5UpFCLhpCVUhE7L87v9U
         Dqpw==
X-Gm-Message-State: APjAAAUGk013kkXnT+gnhHcZ9fHy2AhyA4kF9/n1UZ0Ft0Agzpnuu7Ls
        9fUXoXhsKEVx9NbqCuMmvrComA==
X-Google-Smtp-Source: APXvYqyjabRdDMqnPKETR4eIRTr/iHS+Ld3WozdWwgpQwZPNqMT0cSOe8xrIAyxGOeds8ZPHUKrP8Q==
X-Received: by 2002:a05:6638:1f5:: with SMTP id t21mr571908jaq.119.1569354759536;
        Tue, 24 Sep 2019 12:52:39 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g8sm1949257ioc.0.2019.09.24.12.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:52:39 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     christian@brauner.io, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: pidfd: Fix undefined reference to pthread_create()
Date:   Tue, 24 Sep 2019 13:52:37 -0600
Message-Id: <20190924195237.30519-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build failure:

undefined reference to `pthread_create'
collect2: error: ld returned 1 exit status

Fix CFLAGS to include pthread correctly.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/pidfd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 464c9b76148f..7550f08822a3 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g -I../../../../usr/include/ -lpthread
+CFLAGS += -g -I../../../../usr/include/ -pthread
 
 TEST_GEN_PROGS := pidfd_test pidfd_open_test pidfd_poll_test pidfd_wait
 
-- 
2.20.1

