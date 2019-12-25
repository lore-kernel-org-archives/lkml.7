Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99905C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 21:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F11A2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 21:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="qJzF3OYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLYVpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 16:45:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40531 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfLYVph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 16:45:37 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so21880173iop.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3aSJZB0OJVXMfAC66n1zig6Ufda47bAnHowrO052PgA=;
        b=qJzF3OYAhdUoP9SNNoN6oh+i6RoA7XW1rf4IP/TBkNLuslgp4h4WhU95Zibilay4up
         ytryVQNI5KLtzBuEtBQ/NDSuByDRnGftfDrfFhV+7//t3TVVUlII8urB2bw9ECDpSUP6
         KSGBDehQ/zyaVugSkZeLUWJeRn6vzI/+htg1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3aSJZB0OJVXMfAC66n1zig6Ufda47bAnHowrO052PgA=;
        b=Uu03jYmSW7cJnFkQSzvoa1w+IC89Ld87dNU6umJ3UzY/0hYIJBJwbTJYmSAXw+y3ww
         cYK4bHAsZ4+ZeWkLtLNl6KfKLIK04yn1df8/BuqAlkbYthoLKsVIbNv7nHutQunT90b7
         ubWyY9+IZ86DPA/DWlu+yuJ5OtYGgQIzCAE+5GYequQ8kof2y1JyK4ZNuwLtxyK1yCOG
         d4idZ5lx5vYSbfUi6HsZv+zGtcg2NDkEScx8AYRNpnoNsxB8FkBvRJJj9FbssRVNGVSI
         y5kyHkG83ZmaoQvXgrXPxdYbbjI2+KLdqOr/NhjoFa0qo1RW2gA2G839Pvctq/0+tru8
         HZWg==
X-Gm-Message-State: APjAAAVpGCuAum+zOJLUJoIpN7l5R/3HClivDlBlu7MWBT6l7P0ht5gY
        NmQt727C+LwmCF0ABDyAtXAVQ3J/rTM=
X-Google-Smtp-Source: APXvYqzgTY33/ZhQlYoKAndwCerwnRNs5PX00DMTIO5fDcXdLwipac5QX2Q8Oqs7lr4u0GD1JlqY4A==
X-Received: by 2002:a5d:8782:: with SMTP id f2mr20237572ion.53.1577310336482;
        Wed, 25 Dec 2019 13:45:36 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id t23sm11576607ila.75.2019.12.25.13.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 13:45:35 -0800 (PST)
Date:   Wed, 25 Dec 2019 21:45:33 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, christian.brauner@ubuntu.com,
        keescook@chromium.org
Subject: [PATCH] seccomp: Check flags on seccomp_notif is unset
Message-ID: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a small change in enforcement of the uapi for
SECCOMP_IOCTL_NOTIF_RECV ioctl. Specificaly, the datastructure which is
passed (seccomp_notif), has a flags member. Previously that could be
set to a nonsense value, and we would ignore it. This ensures that
no flags are set.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 12d2227e5786..455925557490 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1026,6 +1026,13 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	struct seccomp_notif unotif;
 	ssize_t ret;
 
+	if (copy_from_user(&unotif, buf, sizeof(unotif)))
+		return -EFAULT;
+
+	/* flags is reserved right now, make sure it's unset */
+	if (unotif.flags)
+		return -EINVAL;
+
 	memset(&unotif, 0, sizeof(unotif));
 
 	ret = down_interruptible(&filter->notif->request);
-- 
2.20.1

