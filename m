Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE42218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710249;
	bh=EEaZFz9zlsIZ7fAQBlx070X5SA2PFqLMkh+kUaNIyuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/x1sW1JsutedWhAUF5zj8wvYD6DK7/OnzNWj22+j83xDUvLAurecwwV/y2HUeW1n
	 CLf8GuSm9B9rUoN+6IwmxrW0yXZ1ZqvDd2xcauoK6qkLQLHVnkJDFojqlJMNOO9pQk
	 034HdoIpqN+HL5O5SZl5Unl8Sy52AaaeyrjkRA+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfC0SKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfC0SKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E554321738;
        Wed, 27 Mar 2019 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710244;
        bh=EEaZFz9zlsIZ7fAQBlx070X5SA2PFqLMkh+kUaNIyuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJp9cWUcd5KDcnKDOZ8D88RW0X9edBtzAre4v1k6xZx4QmD3VMQbq+CEzIjKK9kPc
         WuH+H2UJDC6rjRyoKr4x8k6ahIPu6NuMDdOEFf1zl3ZpCQdpB11bbqrEtBJcw1CNiT
         fd56Nhrf8Nu7Md3n8hBi8tPy2mgDFvc9Hvh05K4s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 012/192] sysctl: handle overflow for file-max
Date:   Wed, 27 Mar 2019 14:07:24 -0400
Message-Id: <20190327181025.13507-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian@brauner.io>

[ Upstream commit 32a5ad9c22852e6bd9e74bdec5934ef9d1480bc5 ]

Currently, when writing

  echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0.  That quickly
crashes the system.

This commit sets the max and min value for file-max.  The max value is
set to long int.  Any higher value cannot currently be used as the
percpu counters are long ints and not unsigned integers.

Note that the file-max value is ultimately parsed via
__do_proc_doulongvec_minmax().  This function does not report error when
min or max are exceeded.  Which means if a value largen that long int is
written userspace will not receive an error instead the old value will be
kept.  There is an argument to be made that this should be changed and
__do_proc_doulongvec_minmax() should return an error when a dedicated min
or max value are exceeded.  However this has the potential to break
userspace so let's defer this to an RFC patch.

Link: http://lkml.kernel.org/r/20190107222700.15954-3-christian@brauner.io
Signed-off-by: Christian Brauner <christian@brauner.io>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Waiman Long <longman@redhat.com>
[christian@brauner.io: v4]
  Link: http://lkml.kernel.org/r/20190210203943.8227-3-christian@brauner.io
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3b86acd5de4e..9e22660153ff 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -126,6 +126,7 @@ static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long one_ul = 1;
+static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
@@ -1695,6 +1696,8 @@ static struct ctl_table fs_table[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &long_max,
 	},
 	{
 		.procname	= "nr_open",
-- 
2.19.1

