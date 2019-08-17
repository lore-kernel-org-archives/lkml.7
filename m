Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F82C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EA12075E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 21:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu0OTliY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfHQVkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 17:40:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44702 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHQVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 17:40:42 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so13287080iop.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lePJrhb5SnzKA5WSaJlz+iYROUPd5EvqinElChCrM0E=;
        b=Fu0OTliYdI8kpEGlcz/UItlI3Gi83l47C0v4BSzP3Lhp/KK+lqXHNuLPUHj/p1bBu1
         eqmVK1Ic87blM5injxL2Atlp5NOt5TzLaYfUqnf8wNRuvU2U48RQNPtoXC2lEYxp6WlT
         ZtofkdAkMckP7maoNnQTSXlV21RczIPwedXKtwkydspxZREQ+DfzGCPuLVOqKHMXfg6P
         5vFCD4wcH7jeF2vQ8U7FwwElmWx6aP8XVTZf+GG00/OORYK4gf04hePjjfaZfCfm0o/Y
         x8YnUC5Hc7vR96bXjLk2p4mZI6kLowJDr/AIcV3Tl7If8ODeq8X65IPbY40LRvvLmf+q
         aO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lePJrhb5SnzKA5WSaJlz+iYROUPd5EvqinElChCrM0E=;
        b=XttRpwK0i2EjOKs6qeqr5TYkIj/jHnG/l4aJGe097mS7zM9RFKfbAtEtgycK2P/m9e
         /sthGyvJ2AlALSt87EbrHInfD5zpOuHPudufMkp2gFrQt0zE+FQmGMy8aIU3Tn1pHi8X
         6Wke9tO8f0z9LiCPZEWfOBtGgFrtxUbwJSyVM1988Xpt64dQwE7LYFr2v6m+g2K1DKxL
         o/Xg6RXfK64nN4m6nAS9sZyWuE/nHLR3IJIHCj4vN3iuTDCA4IjOxCzc/tNQyDznf/wX
         9a3RmixZGBj0gAEE8GU7tueEGDW6OVoxFjEpLVWvBWQgkooT02w5vneCH6dwbQl0ynIe
         de3Q==
X-Gm-Message-State: APjAAAVYlPFrYFD3+NtaQ4cCXPbFVGGqufteFSkKhmb8mVkEvARht4uK
        Pkw8mpFSf46Z19uOadLUMg5qbdS1cDw=
X-Google-Smtp-Source: APXvYqxNG9be4IixeXXuPfzi2AMUOZDG5fNkJycIYg6zLSyXTb+lu/AtjNiX7KzuAvBuyjoYTf2I7w==
X-Received: by 2002:a5d:9ec6:: with SMTP id a6mr4534622ioe.256.1566078041174;
        Sat, 17 Aug 2019 14:40:41 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:7a60:20d::10])
        by smtp.gmail.com with ESMTPSA id f1sm11924679ioh.73.2019.08.17.14.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:40:40 -0700 (PDT)
From:   Donald Yandt <donald.yandt@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Donald Yandt <donald.yandt@gmail.com>
Subject: [PATCH] staging: android: Remove ion device tree bindings from the TODO
Date:   Sat, 17 Aug 2019 17:37:58 -0400
Message-Id: <20190817213758.5868-1-donald.yandt@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the todo for the ion chunk and
carveout device tree bindings.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
---
 drivers/staging/android/TODO | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/android/TODO b/drivers/staging/android/TODO
index fbf015cc6..767dd98fd 100644
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

