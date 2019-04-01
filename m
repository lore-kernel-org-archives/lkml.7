Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EFDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FC620880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140307;
	bh=qCmG/Ywjj+TcBBrIdD41dxuMdK871U3kWAAkOW2ZNys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KOYalxmSrvniy6iPc94ADzHl0pxSc10zrEzq735iv3sDG/k+l1WP9rIE8cbwDlTvy
	 m7mGh10ND8P+vfjJmLMGNjfKpFcKPNcxFADCd7zkY8zxKW6r0s8spA9mokfScpUcoE
	 W2qTWF9u4gTN76S1Lw4PYzR25z1NdU+Ml8ptD2uY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbfDARi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387937AbfDARiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:38:24 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1562720896;
        Mon,  1 Apr 2019 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140303;
        bh=qCmG/Ywjj+TcBBrIdD41dxuMdK871U3kWAAkOW2ZNys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bS3gWyoRSJuUWopRV1kju3K+X5e7aAkrDgt9KjOSvef1Fwz6eOkLt9+jiZOZ1EiNt
         ntYF9tr8yn+rB/WikLWQZmpCmG/8seMsKjFbTTvUlCDID7NDigWEef4TMb926Khv+p
         3MmyFjariOUmK6UAPnzV/dgdpKYuLMkPd9/uXUNU=
Date:   Mon, 1 Apr 2019 10:38:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/open: Fix most outstanding security bugs
Message-ID: <20190401173820.GE131675@gmail.com>
References: <20190401090113.22946-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401090113.22946-1-jthumshirn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
>  
>  	if (fd)
>  		return fd;
> -- 
> 2.16.4
> 

I like that this can't be circumvented by changing the process name, because it
dereferences a NULL pointer when it gets to the end of the list.  However, I'm a
bit uneasy with updating just this syscall. I suggest we go farther and just do:

diff --git a/init/main.c b/init/main.c
index 598e278b46f7..24f4422cb3c9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -547,6 +547,8 @@ asmlinkage __visible void __init start_kernel(void)
 	char *command_line;
 	char *after_dashes;
 
+	return;
+
 	set_task_stack_end_magic(&init_task);
 	smp_setup_processor_id();
 	debug_objects_early_init();


Please also make sure to add a Reported-by line for each one of the 475 open
syzbot bug reports, so they get properly closed.  Thanks!

- Eric
