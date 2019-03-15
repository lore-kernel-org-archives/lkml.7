Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4507C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752562077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="b6pga2xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfCOEJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:09:10 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48896 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfCOEJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 00:09:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 599609DB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bfHzaxUAua8Z for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 23:09:08 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 26012955
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:09:08 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id q184so6648339itd.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 21:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O9rMhtX1vR0PT9zKhPtIORvPqqG5lK1vASnyIVyfTAo=;
        b=b6pga2xTA+lKsRg+otrqeO/oE5Xtg2DfuJ+TfxKhq6LeTmYJLCP713zf2lKnLtllnh
         xeks4rF02YdJYpDG9wjhHVk0DSLQpwjuWLiz1AHyxnb5/ZxRoROeu5QvgFgUilG5JFe5
         ojdEleTNocLcrEr03u+luEeAXpn/JY6eWDnm7vnqiCxXKiJK6I8cfz3A9cCyEYODhT7B
         jpVF2YNvyCz95aH58ygPoWDVV/+fELahvp7jn0al8gKfYwJXhwqepbTNQOss88axO5g8
         JnGf1vmXXkIGSwFNqBd79aMemN6k6JVKn3zyh+fkoCuGFS5N+BArNPJ3AUj/5Hry8jyy
         6dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O9rMhtX1vR0PT9zKhPtIORvPqqG5lK1vASnyIVyfTAo=;
        b=g6zPECsLw60YcXCQ7BThnM8hAfdAJfbQjo/TdBqWDJya662cUlO8EhVF2EaPPjm1K8
         sK9fRf33PVDn3Nk29EryMYabfrXmT4BdlkSwqJbtoqg2GNbNE3a7/pI+a3YUxk5kM18s
         mVlZ/XhQZ+apstx0iLst0UCYP9B2rCdAHAEp7j6Z858rF2c6/Pk5ab+0VR0/gnHUd3oe
         Y+9ZQK5Ef4FoNRL1sZ+c1xBxICt/8Ltwaf9LJNyiisO78b8nerLHGPgOMh9DOfvvGA+6
         NP6NC1iYAE/csftP/FSkj6upPWAvD/8fBReYWY7e7RtMZl2gsIobNPYBlw9j+3H4eT6H
         EPKQ==
X-Gm-Message-State: APjAAAXe4Vk15M4hVp94CXEQ+ZU+12AdMBhdEvKHvjozOgB+7DS3hdq1
        mT0SsG8PzNxeSsT+OYw2DEmHW04bmkrzqrb9db7+XhtPcXKGfWKx1hyU6BcIqtXZUZkNK5PPPeJ
        f5VNsGLcjkjN/I23n1ViCrAJmFdlr
X-Received: by 2002:a5e:c019:: with SMTP id u25mr990223iol.104.1552622947782;
        Thu, 14 Mar 2019 21:09:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMUBU57OzjlVlfyf6CG/asc9x8dUapj+TeZEbTNs/0vL1OTPifKfgwnDc3Z8Rr+6qeZEc2QA==
X-Received: by 2002:a5e:c019:: with SMTP id u25mr990210iol.104.1552622947540;
        Thu, 14 Mar 2019 21:09:07 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id z22sm405105ioc.68.2019.03.14.21.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 21:09:06 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: inode: fix a missing check for securityfs_create_file
Date:   Thu, 14 Mar 2019 23:09:01 -0500
Message-Id: <20190315040901.31551-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

securityfs_create_file  may fail. The fix checks its status and
returns EFAULT upstream if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 security/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/inode.c b/security/inode.c
index b7772a9b315e..11d9a6bc2161 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -339,6 +339,11 @@ static int __init securityfs_init(void)
 #ifdef CONFIG_SECURITY
 	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
 						&lsm_ops);
+	if (IS_ERR(lsm_dentry)) {
+		unregister_filesystem(&fs_type);
+		sysfs_remove_mount_point(kernel_kobj, "security");
+		return -EFAULT;
+	}
 #endif
 	return 0;
 }
-- 
2.17.1

