Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1138920663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLboHTMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCFX7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:55 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:34714 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfCFX7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:52 -0500
Received: by mail-yw1-f74.google.com with SMTP id y129so20874600ywd.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JJMzCu+QpYD9Z8bckP0m6/xbjWctPMS7pd0b7hNmVSQ=;
        b=tLboHTMMoMV+yRf3rMjN1/hTQNg/8muTL2AwsTexQzcvw3NgdeYfhtTcpiJqFfIUB0
         37eVsZnj2OHgLGKYMUaoTIjBxEyPUDRdn+d4GtnwAuLkNDndOXzUxAneLXi5m0ocs9cY
         8/iiGPiCS4IHrBXgVjfoNrehXn58s6SKrlaQq3Xp0VQD95pUZPnZlBX14hu9F4J4qocJ
         CL8cUZvbqaAj3lvvbYvEjZJowX1ZxeAAF9iJEJmMZs2yLtbDwFrM5iQE+n7t0zy8lPyv
         Abr86iUavjIxK/vFIqmKm4uxNNaO2dosOCi/oMgW+ZL1joZj0fOxNgjte+HsXLqPjvGF
         BpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JJMzCu+QpYD9Z8bckP0m6/xbjWctPMS7pd0b7hNmVSQ=;
        b=bKTJPNjuRj1y5aOfg7i+qK5GA8Zvd24cnd7/ORr59ivJ9MZxuSVbVwB/0M8FW6HlmC
         KqGMngIXnew8NZZEMkV78gJVyRWe63Nw322A4zRMrfU98KXgmhCrUzI0sTwju/LIAK6Y
         iOT0ccddWb9UiNBJSd4/87gebb+B0RY0vGzc/Ax0puE2eceJjW2K0rLA0o9Jxysso0E+
         E4SDlwBJ/m5BXZpwB8cMuy3UX6eA8hC0h7ccr+WbCRzRL6K8E0TvmvwRp5veC8aecChn
         M2ovlQmeCxovNN76+Q0Ozz4TANOS0m5vZRH5DnyR1jaE9Tb4QD9+3/Nz2tXmYe/a/WmP
         H0Bw==
X-Gm-Message-State: APjAAAWzEh/tjYjk8QnVxipxBcXUQGsjOnZ8jLtFHQHUXqKukHNXyGV2
        C1vbfXZiA29/2d/qD3GfKDjF2pdR6uLCUcN8gim+qQ==
X-Google-Smtp-Source: APXvYqytdTMYqNrVlhZkwaY3/u8OMYHj1aQSIB663TPgr1lcKmQ3eCVuz1JuFTVE8od0nbZkPQ9oXCKDc3obGrQfsUF4ew==
X-Received: by 2002:a5b:44e:: with SMTP id s14mr1091714ybp.55.1551916791554;
 Wed, 06 Mar 2019 15:59:51 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:56 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 10/27] uswsusp: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
cc: linux-pm@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/power/user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..0305d513c274 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -52,6 +52,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (kernel_is_locked_down("/dev/snapshot"))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
-- 
2.21.0.352.gf09ad66450-goog

