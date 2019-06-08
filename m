Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E3C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322B221537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfFHL47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:56:59 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46474 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfFHL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:56:58 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZZxx-0000Rs-8Y; Sat, 08 Jun 2019 05:56:57 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZZxw-0007PS-AT; Sat, 08 Jun 2019 05:56:57 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andreas Christoforou <andreaschristofo@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <201906072207.ECB65450@keescook>
Date:   Sat, 08 Jun 2019 06:56:44 -0500
In-Reply-To: <201906072207.ECB65450@keescook> (Kees Cook's message of "Fri, 7
        Jun 2019 22:08:23 -0700")
Message-ID: <87h8909toj.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hZZxw-0007PS-AT;;;mid=<87h8909toj.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Nxc2fpk7+N40M/y0EybiNfcrJHqyX2vU=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] ipc/mqueue: Only perform resource calculation if user valid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Andreas Christoforou reported:
>
> UBSAN: Undefined behaviour in ipc/mqueue.c:414:49 signed integer overflow:
> 9 * 2305843009213693951 cannot be represented in type 'long int'
> ...
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x11b/0x1fe lib/dump_stack.c:113
>  ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
>  handle_overflow+0x193/0x218 lib/ubsan.c:190
>  mqueue_evict_inode+0x8e7/0xa10 ipc/mqueue.c:414
>  evict+0x472/0x8c0 fs/inode.c:558
>  iput_final fs/inode.c:1547 [inline]
>  iput+0x51d/0x8c0 fs/inode.c:1573
>  mqueue_get_inode+0x8eb/0x1070 ipc/mqueue.c:320
>  mqueue_create_attr+0x198/0x440 ipc/mqueue.c:459
>  vfs_mkobj+0x39e/0x580 fs/namei.c:2892
>  prepare_open ipc/mqueue.c:731 [inline]
>  do_mq_open+0x6da/0x8e0 ipc/mqueue.c:771
> ...
>
> Which could be triggered by:
>
>         struct mq_attr attr = {
>                 .mq_flags = 0,
>                 .mq_maxmsg = 9,
>                 .mq_msgsize = 0x1fffffffffffffff,
>                 .mq_curmsgs = 0,
>         };
>
>         if (mq_open("/testing", 0x40, 3, &attr) == (mqd_t) -1)
>                 perror("mq_open");
>
> mqueue_get_inode() was correctly rejecting the giant mq_msgsize,
> and preparing to return -EINVAL. During the cleanup, it calls
> mqueue_evict_inode() which performed resource usage tracking math for
> updating "user", before checking if there was a valid "user" at all
> (which would indicate that the calculations would be sane). Instead,
> delay this check to after seeing a valid "user".
>
> The overflow was real, but the results went unused, so while the flaw
> is harmless, it's noisy for kernel fuzzers, so just fix it by moving
> the calculation under the non-NULL "user" where it actually gets used.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Reported-by: Andreas Christoforou <andreaschristofo@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: update commit log based on Al's feedback
> ---
>  ipc/mqueue.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 216cad1ff0d0..65c351564ad0 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -438,7 +438,6 @@ static void mqueue_evict_inode(struct inode *inode)
>  {
>  	struct mqueue_inode_info *info;
>  	struct user_struct *user;
> -	unsigned long mq_bytes, mq_treesize;
>  	struct ipc_namespace *ipc_ns;
>  	struct msg_msg *msg, *nmsg;
>  	LIST_HEAD(tmp_msg);
> @@ -461,16 +460,18 @@ static void mqueue_evict_inode(struct inode *inode)
>  		free_msg(msg);
>  	}
>  
> -	/* Total amount of bytes accounted for the mqueue */
> -	mq_treesize = info->attr.mq_maxmsg * sizeof(struct msg_msg) +
> -		min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
> -		sizeof(struct posix_msg_tree_node);
> -
> -	mq_bytes = mq_treesize + (info->attr.mq_maxmsg *
> -				  info->attr.mq_msgsize);
> -
>  	user = info->user;
>  	if (user) {
> +		unsigned long mq_bytes, mq_treesize;
> +
> +		/* Total amount of bytes accounted for the mqueue */
> +		mq_treesize = info->attr.mq_maxmsg * sizeof(struct msg_msg) +
> +			min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
> +			sizeof(struct posix_msg_tree_node);
> +
> +		mq_bytes = mq_treesize + (info->attr.mq_maxmsg *
> +					  info->attr.mq_msgsize);
> +
>  		spin_lock(&mq_lock);
>  		user->mq_bytes -= mq_bytes;
>  		/*
> -- 
> 2.17.1
