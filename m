Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B1CC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3839320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDHWJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:09:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38704 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfDHWJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:09:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so951823wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 15:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/H+BPiceixq2PxCNPJzqXmyv8QW6SP78HvIow6e2qA=;
        b=q7L9N9Y7MQAbmoZ0cDTboG1Jym3oFksb09KnbDYxfHq0okyElWs6UCuEp2OwtubEFJ
         uXpqYN6ArEKVTFh6pvbAQNfzgmdtYkxm+h6BziwKCkhgb4ERhTLpte7If2tqVTHz+g7P
         37WMBHUg7HtV6tWw5JjflfDaL/ywbYtW3ItguxuXlZDGuH/J3sBGIji89scj8wNOzKbL
         o8cg0lUNrfWoK/Q+L1ZwwSa7KFDcbqvtgMXV8I92p+sFkS8MBu8Wm6vZYUmL0Jo0/wJg
         z66kcDohgBRw0sosRdX8r6XugZrhE9xzUj9ayAt7Uav7O/QyKTR6P/iU2FV+9R+wgmlQ
         yjsQ==
X-Gm-Message-State: APjAAAV/dKxQCI+oBmJdDXPWn98y7Yx82W6oWFIeKLFSKHZf02UqAOD6
        Rjd8zOd8LecI9pEM3rCqUWpB4KRq/Ec=
X-Google-Smtp-Source: APXvYqwJ98n6gwITz41dx7J6xIQQgi9/KFVIMJx8KHbSI7QtyPd10+wYv6bDtjqd/CnNHRlKWz+Hvg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr20080229wma.129.1554761379278;
        Mon, 08 Apr 2019 15:09:39 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id h2sm49894204wro.11.2019.04.08.15.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 15:09:38 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 1/2] proc/sysctl: add shared variables for range check
Date:   Tue,  9 Apr 2019 00:09:24 +0200
Message-Id: <20190408220925.13077-2-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408220925.13077-1-mcroce@redhat.com>
References: <20190408220925.13077-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the sysctl code the proc_dointvec_minmax() function is often used to
validate the user supplied value between an allowed range. This function
uses the extra1 and extra2 members from struct ctl_table as minimum and
maximum allowed value.

On sysctl handler declaration, in every source file there are some readonly
variables containing just an integer which address is assigned to the
extra1 and extra2 members, so the sysctl range is enforced.

The special values 0, 1 and INT_MAX are very often used as range boundary,
leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
different source files:

    $ git grep -E '\.extra[12].*&(zero|one|int_max)' |wc -l
    261

This patch adds three variables for the most commonly used values, so they
can be referenced instead of creating a local one for every object file.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 fs/proc/proc_sysctl.c  | 5 +++++
 include/linux/sysctl.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d65390727541..e7a96169fced 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -21,6 +21,11 @@ static const struct inode_operations proc_sys_inode_operations;
 static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
+/* shared constants to be used in various sysctls */
+const int sysctl_zero = 0;
+const int sysctl_one = 1;
+const int sysctl_int_max = INT_MAX;
+
 /* Support for permanently empty directories */
 
 struct ctl_table sysctl_mount_point[] = {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b769ecfcc3bd..f3b191799747 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -37,6 +37,10 @@ struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
 
+extern const int sysctl_zero;
+extern const int sysctl_one;
+extern const int sysctl_int_max;
+
 typedef int proc_handler (struct ctl_table *ctl, int write,
 			  void __user *buffer, size_t *lenp, loff_t *ppos);
 
-- 
2.21.0

