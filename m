Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E7A2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqy8vjp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfB1XOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:14:21 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:52338 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbfB1XMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:31 -0500
Received: by mail-qk1-f201.google.com with SMTP id k21so12225435qkg.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F6zxXD+nTPfsZfQbyiR2ANcc9A38R04iH+muysUyqZY=;
        b=rqy8vjp1yaqAU5BNxNa+MvsSVvcaRzr5lInb84HYbk4bKsE1qZ5Kdhh6iwvWec6VQI
         Np0PGekQ4lc9JNlPa7Kxi8g+sTyR9WDN0BAB8LElq4VRXg9ZSpNOYJGbXDOvllPDroQN
         2j/vGXeZFSbT3AqFzebVnIlnUd30MR+dw+CcWu+lHBkdhWoN9G+2jK/jxwszpTlaMq7b
         ScY+uB4+r5cbc4LO3RDnYKxygYSd7sH/q5w5hlbyufWWwC06HjE/XFwuCWyA4ATNAV7N
         Xz45Z+siZGWFacREImKXDG2LLH2L8raULbzyeoCyNOUfh6xq5Qa6YtY8SD3ll41nWY2V
         FJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F6zxXD+nTPfsZfQbyiR2ANcc9A38R04iH+muysUyqZY=;
        b=NN8Evj6Z6ADC902AtivOuUpGZosY7EwMLKK1NDrK9uoxNW9ih99d7ZwiN/2E+5ocFk
         l0vs+ZEMd/yRY03od+OasTzZaMYwOvXK25A8o53KCg5yTxjGWnTNxPgktOCOsAzqvm/i
         OzA41mNG11dIQ0x3rYqfU3u8eOoWvC+9vwW5tKNEcpoAVqKQOM5ZwNi+ZaOKFtp8J7Yt
         gUQwJgCfsJ7c3vw7dOQ/BtZ/E/NOonGol1XlbMJs6nvHkD2Wt3b8BOx90KsirdsHBKJp
         3EX6Cm2w+DNOX5nsrHVKjusiUoe8iYvsFgOvHUh0YxwPBz5HzYic8DDjOfjv9DG9VXnz
         Y9Bw==
X-Gm-Message-State: APjAAAWTwp4DN+BEIU/SkLtlUmCXAtPZcnByOtG4erfpt9ZYGQxEjIWB
        g+swpsZH6y/+1xhSxg3TfrzLw3uX/EvV/WmlSqbWEA==
X-Google-Smtp-Source: APXvYqzQpfa57TSK8bbnGQUeo2CjRL0Deo0vZcTr3Ki5Q9LwxiBCVwYNCWwOLgKVHp85Cd+X48GXglBT5kx+zg6IcAYxFw==
X-Received: by 2002:ac8:1b68:: with SMTP id p37mr1177129qtk.50.1551395550264;
 Thu, 28 Feb 2019 15:12:30 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:46 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
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

