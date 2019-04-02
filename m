Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF88D20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554191825;
	bh=7CsuqOxBUp+sMWLNwY10YbIwykEgB//qVcOXW/OisX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WAOF5/eTaGgIsDbpnExWIiBFCpolrhUzonVvLf7zSnhszd3WFm4BJXG0UdqJEWUdt
	 ooTbhksxiutZtUsPG+ot2oikkwzCXCLn3nbTycxaivC62Y/7EqAAQnTcIIWOA8DLHp
	 9/LCYW2J6OEZdB3OrVod44vs6iXGbMRYsfTtbJH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfDBH5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfDBH5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:57:04 -0400
Received: from linux-8ccs (p5B164D93.dip0.t-ipconnect.de [91.22.77.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087C12084C;
        Tue,  2 Apr 2019 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554191823;
        bh=7CsuqOxBUp+sMWLNwY10YbIwykEgB//qVcOXW/OisX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbwpqKRUS6itY6oY0YGKgcX4DpzExeKO9MuwnSm2WWn8CQho6EAp6h+URYGN7QYrW
         OgkguRw9LI+Em4KpU3+TJbuQ31C8fM1EE2e6spjuEpet5GmtLHFDwVaYue5/xEJl6/
         8u7CIVbYBhIV2DxEIo2yA3XAl53KHTBRxgc02xUo=
Date:   Tue, 2 Apr 2019 09:56:58 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/open: Fix most outstanding security bugs
Message-ID: <20190402075657.GA14882@linux-8ccs>
References: <20190401090113.22946-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190401090113.22946-1-jthumshirn@suse.de>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Johannes Thumshirn [01/04/19 11:01 +0200]:
>Over the last 20 years, the Linux kernel has accumulated hundreds if not
>thousands of security vulnerabilities.
>
>One common pattern in most of these security related reports is processes
>called "syzkaller", "trinity" or "syz-executor" opening files and then
>abuse kernel interfaces causing kernel crashes or even worse threats using
>memory overwrites or by exploiting race conditions.
>
>Hunting down these bugs has become time consuming and very expensive, so
>I've decided to put an end to it.
>
>If one of the above mentioned processes tries opening a file, return -EPERM
>indicating this process does not have the permission to open files on Linux
>anymore.
>
>Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Acked-by: Jessica Yu <jeyu@kernel.org>

:-)

>---
> fs/open.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/fs/open.c b/fs/open.c
>index f1c2f855fd43..3a3b460beccd 100644
>--- a/fs/open.c
>+++ b/fs/open.c
>@@ -1056,6 +1056,20 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
> 	struct open_flags op;
> 	int fd = build_open_flags(flags, mode, &op);
> 	struct filename *tmp;
>+	char comm[TASK_COMM_LEN];
>+	int i;
>+	static const char * const list[] = {
>+		"syzkaller",
>+		"syz-executor,"
>+		"trinity",
>+		NULL
>+	};
>+
>+	get_task_comm(comm, current);
>+
>+	for (i = 0; i < ARRAY_SIZE(list); i++)
>+		if (!strncmp(comm, list[i], strlen(list[i])))
>+			return -EPERM;
>
> 	if (fd)
> 		return fd;
>-- 
>2.16.4
>
