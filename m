Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C91C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C06D2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDANEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:04:14 -0400
Received: from verein.lst.de ([213.95.11.211]:44167 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfDANEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:04:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id E87F268AFE; Mon,  1 Apr 2019 15:04:01 +0200 (CEST)
Date:   Mon, 1 Apr 2019 15:04:01 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/open: Fix most outstanding security bugs
Message-ID: <20190401130401.GC16764@lst.de>
References: <20190401090113.22946-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401090113.22946-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:01:13AM +0200, Johannes Thumshirn wrote:
> Over the last 20 years, the Linux kernel has accumulated hundreds if not
> thousands of security vulnerabilities.
> 
> One common pattern in most of these security related reports is processes
> called "syzkaller", "trinity" or "syz-executor" opening files and then
> abuse kernel interfaces causing kernel crashes or even worse threats using
> memory overwrites or by exploiting race conditions.
> 
> Hunting down these bugs has become time consuming and very expensive, so
> I've decided to put an end to it.
> 
> If one of the above mentioned processes tries opening a file, return -EPERM
> indicating this process does not have the permission to open files on Linux
> anymore.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/open.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index f1c2f855fd43..3a3b460beccd 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1056,6 +1056,20 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
>  	struct open_flags op;
>  	int fd = build_open_flags(flags, mode, &op);
>  	struct filename *tmp;
> +	char comm[TASK_COMM_LEN];
> +	int i;
> +	static const char * const list[] = {

"list" is a bit ambiguous. You could call it "blacklist" or such.

> +		"syzkaller",
> +		"syz-executor,"
> +		"trinity",
> +		NULL
> +	};
> +
> +	get_task_comm(comm, current);
> +
> +	for (i = 0; i < ARRAY_SIZE(list); i++)
> +		if (!strncmp(comm, list[i], strlen(list[i])))
> +			return -EPERM;
                               ^^^^^^^
should be -ECONNRESET.

Also, I'm missing a sysfs parameter file to add more bad guys dynamically.

>  	if (fd)
>  		return fd;
> -- 
> 2.16.4

But for a start, this is OK.
In any case, as already mentioned, big player Cisco has shown us that this is
definitely the way to go!

Rviewed-by: Torsten Duwe <duwe@lst.de>

