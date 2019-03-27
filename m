Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FAAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2461D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712903;
	bh=qh6sBJvXLgu3izPpHs//k8F69YCuhHw+TPnCZXSMTkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzRlOOKZDTtDIwXtEAulkvATALUUI98mCw1d99WoQLtZKDqpx/EmdCpDLO+njqXRH
	 KQ6vThbRpdOHV+KHm3lWP32riQIlOr/ixu+KVPvtzhh3QapQilK7ioU4zgftZ7Ofvd
	 oxY8BwuUsxWFvaBB864kAe0UVQU7zbMoRgmUB9bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390470AbfC0SzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389297AbfC0SQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F6D2087C;
        Wed, 27 Mar 2019 18:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710605;
        bh=qh6sBJvXLgu3izPpHs//k8F69YCuhHw+TPnCZXSMTkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x83hH+H1XFwocgci1TNgKIxfduz/J+ejGokvgeOuipHlb4FLwvKyb10bCoFsHihQ7
         qeYvgvlT3TVmEDVGA8Rr/eNKTO+MsgnkdqcViSocJ12U9L9xy53L9ZZPR0Kob4MjCf
         OHZl+DQmONJamQ3YXY1Vh9m9O/e3lP8lKhLGxpVE=
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
Subject: [PATCH AUTOSEL 4.14 010/123] sysctl: handle overflow for file-max
Date:   Wed, 27 Mar 2019 14:14:34 -0400
Message-Id: <20190327181628.15899-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
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
index a7acb058b776..34a3b8a262a9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -125,6 +125,7 @@ static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
 static unsigned long one_ul = 1;
+static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
@@ -1681,6 +1682,8 @@ static struct ctl_table fs_table[] = {
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

