Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189D9C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CB4206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN1Mo5Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKQRZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 12:25:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfKQRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 12:25:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so8423300pgm.6;
        Sun, 17 Nov 2019 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fS+44pmIjjlReJvbKvVLf0765f8adwUSGR73BlaFD/U=;
        b=gN1Mo5UmYrqC9LVg7cuxwT9kHbAX4e9U8sAkLsBuYdVSrFUFqw22QS1Z/B8wbneb7d
         dLQfmhuY5Crymhhqhb6vUeTI8BFIw1Wxa0rac8lgf5qTfdytIz3NK5k8BUW/77UIdyi5
         DPoKy5aUe9ugU6Agh65jSohH5pngDGQVlceKbTsf9WC1ppcqJAb3j2epOKqkWoDfcZSN
         DgK3GxfRnjO2JabyVnKwF/L7w60u1hXnm0pRxRRB4BR4UexWd5x80qfJ/bLCmmDrFfRR
         mmHO+S8JGg/SonGAnUVDMsnmzmzzkerj4TYxOZnvll8hoSfrQvC8qZigbXWhiq62zl5D
         JPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fS+44pmIjjlReJvbKvVLf0765f8adwUSGR73BlaFD/U=;
        b=X7eOSBhfld1jsDgnIKRz6heXooPPwICXgBVZB6pNIi2EuNgz+ZujYWhbz4QhC344/v
         zDVOK/uO8rHjOGALtqzI8WL0QgFu2zKSHS+5K1pWFSv7SQayVuEcRRX8Nsvc0Bs+/DTL
         vcLZ2cM39EyMTD/weymWutFRpaIeTtjQxecuDowk44TFQcpzHeFcOwRiU3ukj1YH9SIH
         WqvF4JolQnP5i84bL1+hhJDvWn5fIvsJP4lt3NUadLEy2fTrr5jSLMQH/wzRU+Gm24T7
         MHrEweUyp5k1rxWzW4h00XRF5kb5zxcWlJWy6KbHPvpwN3ncfqMFIbD5zFeRGh4Ji4X+
         izGA==
X-Gm-Message-State: APjAAAVD7KRU6d8lXo3n6aBYZUWal6wgIBYVtBcYEZ9Jh3OlYfoiCYD2
        22HVaCXc1W0pxLy3Kw56QAw=
X-Google-Smtp-Source: APXvYqyzrnexkyZ2/csroq2Iu4YbCPUaAAitUKHbQ2dotMRGlWPLNDiu39qgc2cFVDa9qI92h1npfQ==
X-Received: by 2002:a63:395:: with SMTP id 143mr7407475pgd.93.1574011530823;
        Sun, 17 Nov 2019 09:25:30 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1662:ba74:f9a6:2aa3:8a9a:5581])
        by smtp.googlemail.com with ESMTPSA id x13sm18146302pfc.46.2019.11.17.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 09:25:30 -0800 (PST)
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     corbet@lwn.net
Cc:     raven@themaw.net, akpm@linux-foundation.org,
        jaskaransingh7654321@gmail.com, mchehab+samsung@kernel.org,
        neilb@suse.com, christian@brauner.io, mszeredi@redhat.com,
        ebiggers@google.com, tobin@kernel.org, stefanha@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v2 3/3] docs: filesystems: Add mount map description in Content
Date:   Sun, 17 Nov 2019 22:54:36 +0530
Message-Id: <20191117172436.8831-4-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191117172436.8831-1-jaskaransingh7654321@gmail.com>
References: <20191117172436.8831-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second paragraph of the content section does not properly
describe how mount points are determined by autofs.

Replace the lines detailing how the determination of these mount
points is "ad hoc" by a short description of the mount map syntax
used by autofs.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 Documentation/filesystems/autofs.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/autofs.rst b/Documentation/filesystems/autofs.rst
index 2f704e9c5dc0..c17f6bf0eb5d 100644
--- a/Documentation/filesystems/autofs.rst
+++ b/Documentation/filesystems/autofs.rst
@@ -49,9 +49,10 @@ extra properties as described in the next section.
 Objects can only be created by the automount daemon: symlinks are
 created with a regular `symlink` system call, while directories and
 mount traps are created with `mkdir`.  The determination of whether a
-directory should be a mount trap or not is quite ad hoc, largely for
-historical reasons, and is determined in part by the
-*direct*/*indirect*/*offset* mount options, and the *maxproto* mount option.
+directory should be a mount trap is based on a master map. This master
+map is consulted by autofs to determine which directories are mount
+points. Mount points can be *direct*/*indirect*/*offset*.
+On most systems, the default master map is located at */etc/auto.master*.
 
 If neither the *direct* or *offset* mount options are given (so the
 mount is considered to be *indirect*), then the root directory is
-- 
2.21.0

