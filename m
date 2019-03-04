Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99000C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBE4206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LglIhCV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfCDSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:47:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36209 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfCDSrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:47:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so3701445pgr.3;
        Mon, 04 Mar 2019 10:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0zv5Aviw3gCUYkW1jZEsaZvHrGOTu+ThRxqvIs9s/JU=;
        b=LglIhCV0pNrKe/EMI26cweuVxWI+c/zXwTJb6X0+8wb9d/UTBuuju2kIntJZRwtN8D
         F2CHrWUfnohaPNQCkWyBkT6OzuWu8aMK9KQ7F/iMhuE2GDllFgc2AVCO5z8zYGhWS3Zq
         afiLR1nsiXXaidJwj1KdK2o0nGosDijO5P+AQ1r5Rj8kOIiB5MGIf/1H22Ime6RHsllR
         UpvF9gnKxjAKmgvgikQYSAip+gM7PmRPxGsohaJadYmPwZJwsBGjdibwi6OiHl84fuE8
         ZdklfrK17jhJB7d5UC0/gCWRoWJRHOrn58pfsUTUi4s9YNTfx4z0suhzfxkpFnLa3FQS
         e7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0zv5Aviw3gCUYkW1jZEsaZvHrGOTu+ThRxqvIs9s/JU=;
        b=XAJ5SPQM+Z+8LH4V26YBHryOnun00PyanufrR909hcILWmalmYsA5TSt6I99rm0Guz
         a1V5RcLyiYMM5iKxFeDKCBfyNVb4EV+225UouaGEs1VupzL+wgfAfX55v34y4pZQV/5/
         o0zIg+EC3+Vky4qwrqYiGwrDx9XZ1/FXlb9zz3mtbbFVysILZtr67P9jWwm+C+pdO+el
         bHHHX0xXv/zBGrLOFqv7Isp2D+apiPSZNsCOZ2yIdaFXfk3v7+2vg2C+5QrHxQTshBbX
         vSAwHWNpuBk3DgnurwAYkjvZRr9o6sGpMmLEY4h1RoPiVQeNgmGVl2spSE97pCNQysSf
         JGAA==
X-Gm-Message-State: APjAAAXL+CDMqPB/R0s9Vsqgb1+fvQt1BrbPMaf6wwYbVADecCx9tmzk
        0cDjK334zg7b7JM9P3PMLU4=
X-Google-Smtp-Source: AHgI3IZ8kdBnQJpIXPdfEbZMJKX18niiMZJcg32dK3PK3+poR0FkGQtYPksGeClGbDzz34jWNBsQrw==
X-Received: by 2002:a62:6383:: with SMTP id x125mr20977464pfb.239.1551725219715;
        Mon, 04 Mar 2019 10:46:59 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.146])
        by smtp.gmail.com with ESMTPSA id d6sm10532090pfg.47.2019.03.04.10.46.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 10:46:58 -0800 (PST)
Date:   Tue, 5 Mar 2019 00:21:27 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] selftest/x86/mpx-dig.c: Remove duplicate header
Message-ID: <20190304185127.GA6951@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/testing/selftests/x86/mpx-dig.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/x86/mpx-dig.c b/tools/testing/selftests/x86/mpx-dig.c
index c13607e..880fbf6 100644
--- a/tools/testing/selftests/x86/mpx-dig.c
+++ b/tools/testing/selftests/x86/mpx-dig.c
@@ -8,9 +8,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
-- 
1.9.1

