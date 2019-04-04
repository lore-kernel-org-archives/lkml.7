Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F7AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650FB20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371566;
	bh=o8So2GKags6l09Z5mEgzt+O1Ezp9KpjLHYkyr4rOxRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UOhmwHJpLkswLAXaAy+8BrVxX+bdfB5ZgPwqZE9b0AKuUmi+FyI9/1bilVhm6rwij
	 fq2WvW3QvQfkNLoFqxJyTqLAommuTuty1TE15DmLD/ttL8kUhkOzuXTQZMjy2Y8P7b
	 zD1DYvlyUgp+4wq6tUJHyNhU5tFCe6S6tKhkb+C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfDDJwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfDDIyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:54:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0870C2171F;
        Thu,  4 Apr 2019 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368039;
        bh=o8So2GKags6l09Z5mEgzt+O1Ezp9KpjLHYkyr4rOxRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMX6OaB8AFaKTDgCR4FLw+vaj84Anz+0ps5ujJyui8hYph0MCUlc/2csSzfhy2Nnz
         fXDq9aVySkmnYJaIVX0hTB1pJpjrDCyIu8nnmvhEDgxPv4ROTi1Y5d/y/dTK1kwKDI
         mHTKE/BzXp4J79RS2Ngd1dMXoEBstYe9ubuXNMuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 015/121] sysctl: handle overflow for file-max
Date:   Thu,  4 Apr 2019 10:46:43 +0200
Message-Id: <20190404084546.163620305@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



