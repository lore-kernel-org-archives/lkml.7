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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D10C2D0DC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EC8208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cojg7GXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfL3FFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 00:05:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41372 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfL3FFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:05:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so17438832pgk.8;
        Sun, 29 Dec 2019 21:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqP2eC/S/0O0RhX2WiaVYXHo+vBUqmYrR16Y8AXgU4I=;
        b=cojg7GXDIO0SSd59y/w1fJQVIXWuzd9LkruLF3NswZfHII0HOZeIbAI7O1AqSrV2FN
         oNZB7XabSzGq8Tfl3xB5SPGTDSx6ogKMk/zzmRfG/bwxE5WBteuixDY+C+dyDvbvLGOF
         B1aFjDzO2r5e6PFXFmm25RnbGp6T+GEXZ1vhD6M9MCNtACVcPMihrhlpTTbLMf9Vx80w
         rF2QgL4cge4pe6EeTx2LzwFdUzZqz26+GV3u39OG4q5BdU/kUCeNQHM8qC1KOQhiLg/f
         4ikz/VPIO0F40+8V4gknmQHCf5MNmyCdSMoTscsEw8PyaUf0FWAObw4CN1LYg78z8CAQ
         vDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqP2eC/S/0O0RhX2WiaVYXHo+vBUqmYrR16Y8AXgU4I=;
        b=BGmqWgs790E+7H139wikjxlqmtTLdQCf884oos7/3b8wyarMMGJoOsQD4aeUq0+g+c
         x9zS6KSE9xgNdPBHVdcbmLPXyrZnm1DnLJkSIaJryxcgCBqVZlX4orxuK42xRV+NYNu4
         LX5nvanxjIm/HPDyq3UfGhtpV+exDQI8YZtmLPpHe2zVm0OrdHKnkXlzBlJtPd3J43HX
         q6Iqt0J606lYoCRv27fR6Gabu72Z2Qje24PswdeHxSAwRnNS9zb7GR8ziO21vOToogJv
         tj+wkVuclxIoYXz7wvFlC2vxhBaqLFgOxiYfYZRYv18ZmW9LVVawrCi+GFLHv5dnMvgm
         LkTg==
X-Gm-Message-State: APjAAAWj/B6PirRq3aj0biLzXdeytZVK1WyUyIH27Iwk7BPDJZceqtAC
        N/J9pVCYVAwgSQDnJwixtN0=
X-Google-Smtp-Source: APXvYqzuv+nmaHo8IJ76Zo0dAidv1Lebd4Q8nTsHnMhVdhYFiU/A8UDFO/LUppzxwmTFoM0NK6Fx+A==
X-Received: by 2002:a62:1d52:: with SMTP id d79mr69286987pfd.144.1577682313445;
        Sun, 29 Dec 2019 21:05:13 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id r2sm45054727pgv.16.2019.12.29.21.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 21:05:13 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 5/5] Documentation: nfs: knfsd-stats: convert to ReST
Date:   Mon, 30 Dec 2019 02:04:47 -0300
Message-Id: <f4d72e8ac0b41870e12a6d664666f665aefd3f09.1577681894.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577681894.git.dwlsalmeida@gmail.com>
References: <cover.1577681894.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert knfsd-stats.txt to ReST. Content remains mostly the same.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/filesystems/nfs/index.rst         |  1 +
 .../nfs/{knfsd-stats.txt => knfsd-stats.rst}    | 17 ++++++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)
 rename Documentation/filesystems/nfs/{knfsd-stats.txt => knfsd-stats.rst} (95%)

diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesystems/nfs/index.rst
index a0a678af921b..65805624e39b 100644
--- a/Documentation/filesystems/nfs/index.rst
+++ b/Documentation/filesystems/nfs/index.rst
@@ -10,3 +10,4 @@ NFS
    rpc-cache
    rpc-server-gss
    nfs41-server
+   knfsd-stats
diff --git a/Documentation/filesystems/nfs/knfsd-stats.txt b/Documentation/filesystems/nfs/knfsd-stats.rst
similarity index 95%
rename from Documentation/filesystems/nfs/knfsd-stats.txt
rename to Documentation/filesystems/nfs/knfsd-stats.rst
index 1a5d82180b84..80bcf13550de 100644
--- a/Documentation/filesystems/nfs/knfsd-stats.txt
+++ b/Documentation/filesystems/nfs/knfsd-stats.rst
@@ -1,7 +1,9 @@
-
+============================
 Kernel NFS Server Statistics
 ============================
 
+:Authors: Greg Banks <gnb@sgi.com> - 26 Mar 2009
+
 This document describes the format and semantics of the statistics
 which the kernel NFS server makes available to userspace.  These
 statistics are available in several text form pseudo files, each of
@@ -18,7 +20,7 @@ by parsing routines.  All other lines contain a sequence of fields
 separated by whitespace.
 
 /proc/fs/nfsd/pool_stats
-------------------------
+========================
 
 This file is available in kernels from 2.6.30 onwards, if the
 /proc/fs/nfsd filesystem is mounted (it almost always should be).
@@ -109,15 +111,12 @@ this case), or the transport can be enqueued for later attention
 (sockets-enqueued counts this case), or the packet can be temporarily
 deferred because the transport is currently being used by an nfsd
 thread.  This last case is not very interesting and is not explicitly
-counted, but can be inferred from the other counters thus:
+counted, but can be inferred from the other counters thus::
 
-packets-deferred = packets-arrived - ( sockets-enqueued + threads-woken )
+	packets-deferred = packets-arrived - ( sockets-enqueued + threads-woken )
 
 
 More
-----
-Descriptions of the other statistics file should go here.
-
+====
 
-Greg Banks <gnb@sgi.com>
-26 Mar 2009
+Descriptions of the other statistics file should go here.
-- 
2.24.1

