Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DA9C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D768B2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exdVzCNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfFUBVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:21:41 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33958 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfFUBUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:44 -0400
Received: by mail-qt1-f201.google.com with SMTP id p34so6139643qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fIFhmiOiT1d1AZu2E6BoXeD1gdoYT5pBASREIuKJk5E=;
        b=exdVzCNpyG+TXdyx1zMSMEGHDhm1ELXYDImiocGB1OExqvAiPAOVH++8fzdCIkF3cX
         I1YiXiqr2w28TuEDIdAtd4YiyW+PDnGaeZ3dCuFLFcbkuXJzewsLnKGiBFhcTBE1LOLv
         AK7gdYYpvYGeDpCTs8HA9RCOCWZeh7VVVUwBcLCo0Nj7m6ze/GupP1FtJGynNn0kTRdN
         zopBAyVpQUfdyBQWl/9Vh5zUILpPGH7+aJMp5jNFGmE7dCU6RtRNkE4QFHNTcDNhsEAJ
         k2CRVa100Ba7hesTTMPVHSMcnN9GMc3EZdbG2vTXXYuqgOClRWTcQSJp8ZgNqFsSMSBK
         Wp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fIFhmiOiT1d1AZu2E6BoXeD1gdoYT5pBASREIuKJk5E=;
        b=g0ujNDZxU9jzepz9DL6gDN8PGyvdA67hqybeXxgnb+Kl8S00HNMRl3ShUJac0Nu9kZ
         UTZEoh6Ny2aiRa6kgRHbnpAclIx7HzyaDa8kvVylO8UsDB7xssGyVeW3PR0q5YRjMhSu
         x+bi3+5d3R57x2U0hDEuw/lNmrLRt0QyHVPl4HWcQlGRl4taLNT4QRSZciQIPfE4U0Is
         J/nPX9OrC4J94cGz0AVD1Bu6yZyHiadEOF7ua/bb75rHuehkvQ6o6JQsCTlkeEney0qP
         RdlFCiCHjzUjrCjQ4oAZLDc2fx9PlIZcQcKmfG6q0kmAU19mfTt+slWx+qm80baU3kxy
         Pmaw==
X-Gm-Message-State: APjAAAU/u3ugZXI85ZaBBv7CGFszoxNKEYx3eY3JbIJSrdpv482HiPFU
        E24DkpoJLVh4pwDCpwkFTCsujUabzIsGgOQpM5kIjQ==
X-Google-Smtp-Source: APXvYqw3i5yA5qZQZzU45TUnIenX3cSptG593+0RmQ9grKt1vJcRec3c+XBXkp4U7WgWv7QRcx7z37fRGYjRGvArZyEnuw==
X-Received: by 2002:ac8:38c5:: with SMTP id g5mr117018528qtc.299.1561080043098;
 Thu, 20 Jun 2019 18:20:43 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:33 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 22/30] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data. This is limited to lockdown
confidentiality mode and is still permitted in integrity mode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 fs/proc/kcore.c              | 3 +++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d29d869abec1..b410a16b1960 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/memory.h>
 #include <linux/sched/task.h>
+#include <linux/security.h>
 #include <asm/sections.h>
 #include "internal.h"
 
@@ -545,6 +546,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	if (security_is_locked_down(LOCKDOWN_KCORE))
+		return -EPERM;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 89b7adfae525..6752584729e2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -95,6 +95,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_KCORE,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 215615e67237..80ff4a31d8aa 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -31,6 +31,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

