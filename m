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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B952C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B1320851
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0EFZvYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHRPVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 11:21:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39038 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRPVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 11:21:06 -0400
Received: by mail-io1-f65.google.com with SMTP id l7so15606181ioj.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7fPfB4NOFjj+0lwTkAH+mRK1JzZdb5Bqg7OlEHxdtA=;
        b=R0EFZvYvIKc5JmdcGmlQ0FqqbB1So/mF4Rcwe8FX/LzTCDRNODTjaQTrlW0yPW/K1U
         k2WHQ81LGx8F5VYGGReoUNFkC/iY7ccsaebFectXl9u1Bd5NY338oQDwMZm8vmFRkMA/
         N+Vq7ArXnhDomHyFG7i7nHxWM4FVN+xtbECWlclV0W4I/ocdCyw+ck0F/JwHBtkoM1/C
         JRoGG0uzVvwuAJw/ahM1DUQRVStblHzktrJAAKRpl33oRUlq3RHSRUgWFy61KA7EGIef
         yeAjYFsCWO+wePkIRi/AVeDN43Lov/qEjGQENisj6y4LAKUOKDw+JDJay8kw8u2kGm16
         KFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7fPfB4NOFjj+0lwTkAH+mRK1JzZdb5Bqg7OlEHxdtA=;
        b=eYSNpj5/AVppDSRhhI8fjEZskqfnIrCMuIFY3jEajfomkvyaIP++Cn09ObQrdws3Yv
         mJITZC7ToG93USc3gOZKC+8S6SNz37aSkjX9vVEMhmfjeEghDoyYWj+yc80sbeotp7lS
         Hd2Lp6WNsZ9CbJe5B2seGgQqV+wxk6XBvTY1ZZ2/k60zGTaCDCyOz+ClRBhtG8zvrhhW
         lZH2yMj9qE7i1vfZ3R15FMDOFbcc8q5PBMtv5vAqc4KWsBhLeDRHGjEarrfB61MtiToc
         ory3ce/5/FtR4j9cOlGwUz5Gfhr1D8p3cgxorVfSl4vJN+SQLy3SqMrEHkH4T05rKaFH
         gcTQ==
X-Gm-Message-State: APjAAAXTjyt9u3jvdVqEIBQwcQfjXRlHbx8iXG31LV5P9Oh2WIihnW4c
        LtG3Ukjyn0nAYtlI5LrGA4c=
X-Google-Smtp-Source: APXvYqzc1d8/aSCCYWyQWiFJB7Ea07frOjKD3EnuRhKWbAM7xuBi2VnCJgfYD5ehDNrof5I9CTIFvQ==
X-Received: by 2002:a5d:8249:: with SMTP id n9mr20876179ioo.14.1566141665127;
        Sun, 18 Aug 2019 08:21:05 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:7a60:20d::10])
        by smtp.gmail.com with ESMTPSA id i9sm9138681ioe.35.2019.08.18.08.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 08:21:04 -0700 (PDT)
From:   Donald Yandt <donald.yandt@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Donald Yandt <donald.yandt@gmail.com>
Subject: [PATCH v2] staging: android: Remove ion device tree bindings from the TODO
Date:   Sun, 18 Aug 2019 11:20:23 -0400
Message-Id: <20190818152023.891-1-donald.yandt@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 23a4388f24f5 ("staging: android: ion: Remove file ion_chunk_heap.c")
and eadbf7a34e44 ("staging: android: ion: Remove file ion_carveout_heap.c")
removed the chunk and carveout heaps from ion but left behind the device
tree bindings for them in the TODO, this patch removes it.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
---
Changes in v2:
- Referenced previous commits and described the commit in greater detail.
---
 drivers/staging/android/TODO | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/android/TODO b/drivers/staging/android/TODO
index fbf015cc6d62..767dd98fd92d 100644
--- a/drivers/staging/android/TODO
+++ b/drivers/staging/android/TODO
@@ -6,8 +6,6 @@ TODO:
 
 
 ion/
- - Add dt-bindings for remaining heaps (chunk and carveout heaps). This would
-   involve putting appropriate bindings in a memory node for Ion to find.
  - Split /dev/ion up into multiple nodes (e.g. /dev/ion/heap0)
  - Better test framework (integration with VGEM was suggested)
 
-- 
2.21.0

