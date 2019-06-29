Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994FBC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 04:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657752083B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 04:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKijhPXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfF2ElS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 00:41:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32901 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfF2ElR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 00:41:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so3472524pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 21:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HCWGPbCB1IAUiNh4J5x21IviuwK97PdKw68XVj7uGfY=;
        b=DKijhPXRNffzTBsGmdNmCcBds3ZCZ0GIoB095RpsDGeNTJDDi+BsILzPlxC5158M8n
         dnEJr9ragFhOlalUvp7WImmZbmQGzCzrpn5Ahk0zJF4lSidbmkfud3b+y7SKF/AS8Mh1
         2xrz3558Yuk9yb6ktnaN0u02wSzTCcyGhKk4juqrwlu7YP0RSVF0jcoeD4dgUOW9nncD
         6oAXT/pC/fLcMtCRBaXpZBmoE4CC/BGm+Vyb1xMos7jIiHRyVIceMfErNZzIGALzKuBD
         GlDeOBe9QB6U3zkJVUL2a4NshFo6NW9yqk2BwvidGE8eAWYJoWhCKu1nfnOcobdCPfhA
         JLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCWGPbCB1IAUiNh4J5x21IviuwK97PdKw68XVj7uGfY=;
        b=eGoQ3SEteN6gjTd2aHPTFq3kgcLpifd9SFIJUPwVcC/FF2csXrPKAoRoLnfptTPJmQ
         7UXmsJicSLRf4IsVCZ18x9/Vq0uneZ7kGX3L/uPSCSs+8rzl/Mvj8JVtAdHZ9DFWRBRw
         QYluqO4w4rBZe/0VfSt2dTGyZ/HPy5/dcPfHKsnyHeOCVyO9Ip9nUawSjZ/MS7/TTdaE
         FXNiG1Tg/9ZzFf0lM2wCt5UZWYOEZsHjuMGGTSk91vGkHk7+KwhJRMugZsTX4jZBZldq
         U9yakt9OeeHjaZxoj3cgHgJQTlOgWHHdAfZ6dt3jp8vAEebjEeWc+n8CBgl+Khsf3iM/
         pPQA==
X-Gm-Message-State: APjAAAWS9jtPQwg4vxADKgdUzKxnEev/1EucZ6jnhDu47BykgPEj5JQF
        MtrE/fAdLqYIj5Tta91f2nk=
X-Google-Smtp-Source: APXvYqylEwYPvLI3abceUCuTAZ9WfWTVD6SWh/M68SX1uycAu1C9eLnoeHamV96qhOZJ0akDL5F5wQ==
X-Received: by 2002:a17:90a:384d:: with SMTP id l13mr17709759pjf.86.1561783277098;
        Fri, 28 Jun 2019 21:41:17 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.53.14])
        by smtp.gmail.com with ESMTPSA id 131sm7304530pfx.57.2019.06.28.21.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Jun 2019 21:41:16 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] perf: Remove duplicate headers
Date:   Sat, 29 Jun 2019 10:16:27 +0530
Message-Id: <1561783587-5382-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed duplicate headers which are included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
 tools/perf/util/data.c                 | 1 -
 tools/perf/util/get_current_dir_name.c | 1 -
 tools/perf/util/stat-display.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 6a64f71..509a41e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -8,7 +8,6 @@
 #include <unistd.h>
 #include <string.h>
 #include <asm/bug.h>
-#include <sys/types.h>
 #include <dirent.h>
 
 #include "data.h"
diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
index 267aa60..ebb80cd 100644
--- a/tools/perf/util/get_current_dir_name.c
+++ b/tools/perf/util/get_current_dir_name.c
@@ -5,7 +5,6 @@
 #include "util.h"
 #include <unistd.h>
 #include <stdlib.h>
-#include <stdlib.h>
 
 /* Android's 'bionic' library, for one, doesn't have this */
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6d043c7..7b3a16c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -12,7 +12,6 @@
 #include "string2.h"
 #include "sane_ctype.h"
 #include "cgroup.h"
-#include <math.h>
 #include <api/fs/fs.h>
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
-- 
1.9.1

