Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA331C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105321744
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpBFtPSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfL3E4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 23:56:44 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:36104 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfL3E4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 23:56:41 -0500
Received: by mail-pl1-f176.google.com with SMTP id a6so13442233plm.3;
        Sun, 29 Dec 2019 20:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+dkYv5HLHzNOWTER7d+8BqEGnKLKwfpZv5Uz3xEK7E=;
        b=FpBFtPSR/VFNi54ZWQCOfOtfnCZ7Lq4cThBUGaFGz2aj0o58un9XRTJPqVntyYJQTv
         DBdQD7enbga6HkMWR7NGcpG6tYCjtUI3fYiOXnf2xwWugJtHFT5rYB2rY8zJu015Est8
         2gDgl5HCxD6wnqiQEd1m9aQjpLG+YXdzZUa2+oud00hehI6xDe0o6c7brJZVMoNeIAbz
         +4fuPw3Gzx6AdS4D57e/33IPhrRNIIEwkcVIcV9tenqD6Wl/M8Z/nzlhZeWzz3/qivy3
         5/OkOxulwcckMpkF2py8gpFDp7tD9bqdZrso5i9rr7v1DbQ+0iyv51OEubRhjM4zGiL+
         D1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+dkYv5HLHzNOWTER7d+8BqEGnKLKwfpZv5Uz3xEK7E=;
        b=o9h/bxap1aZtjvabmOYhLWpJn/GmUPelmg+1INSwoCgxPYR91kRZLYUdQW3G3H1dDw
         oTCEwYyu7WnxPsN+xYGXGPov9VtNZhbVGSa6cbZf3sSaOLdzyQebh37ApxVS397wcjIu
         QqX+8zy9xW3GtIE/n9IFRNny1OxKaXqQPEI4ACF27/uVA7Y0NGxSAdfeJ5o1UBDszM6u
         kV/+U5e0GSnUkVkLQ+WxGNhWmzv30xx7TLR5k54etBzgonyamVn2AbcDl5581+OsccO/
         Aa0MahDoTziB3HxG0OI5ASJCUoO+z3pZeLfTP9cxM1XQraeRXz+lciJ0mWfGICsto//s
         MZbg==
X-Gm-Message-State: APjAAAUAlwLA0QszXeIkj5y77HSQwgnbFe/pZ7vds6fTA/d1HNht4enq
        K2LsZTOwdG3CGpwwqgUoUiQ=
X-Google-Smtp-Source: APXvYqy5K+A3JJmlnzqidIX9DfQfH66PTegyY0zEBqREVyRLdeuShuyQDCN0cOLurGYKwjqI8RJ81Q==
X-Received: by 2002:a17:90a:8d84:: with SMTP id d4mr44311044pjo.114.1577681800868;
        Sun, 29 Dec 2019 20:56:40 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id b1sm22373189pjw.4.2019.12.29.20.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 20:56:40 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 7/8] Documentation: nfs: pnfs-scsi-server: convert to ReST
Date:   Mon, 30 Dec 2019 01:56:01 -0300
Message-Id: <1d7bdd6e00d4d0192763ba830900a8f3b1a58d09.1577681164.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577681164.git.dwlsalmeida@gmail.com>
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert pnfs-scsi-server to ReST and move it to admin-guide. Content
remains mostly unchanged.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst                          | 1 +
 .../nfs/pnfs-scsi-server.rst}                                    | 1 +
 2 files changed, 2 insertions(+)
 rename Documentation/{filesystems/nfs/pnfs-scsi-server.txt => admin-guide/nfs/pnfs-scsi-server.rst} (97%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index f3bfd0f5a362..c96e93b61744 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -11,4 +11,5 @@ NFS
     nfsd-admin-interfaces
     nfs-idmapper
     pnfs-block-server
+    pnfs-scsi-server
 
diff --git a/Documentation/filesystems/nfs/pnfs-scsi-server.txt b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
similarity index 97%
rename from Documentation/filesystems/nfs/pnfs-scsi-server.txt
rename to Documentation/admin-guide/nfs/pnfs-scsi-server.rst
index 5bef7268bd9f..d2f6ee558071 100644
--- a/Documentation/filesystems/nfs/pnfs-scsi-server.txt
+++ b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
@@ -1,4 +1,5 @@
 
+==================================
 pNFS SCSI layout server user guide
 ==================================
 
-- 
2.24.1

