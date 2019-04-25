Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECE7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF55206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556222829;
	bh=Ote/Cx3cdi3Ja9joBnM85Q7XSG19+PK5Qe9dKbcm1Pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Amn4PPGmsRbRCkCiQN/Ulvte6M1Yg+NaTO9VNmaXyz5Wf9dcbORoLyXaUGn2MbycD
	 vhJDKIFuQTlIGyfUmylez6EHu1tiqFHQysGqn2moxvbM2DmdIUS4hxRlUeJfs7Hnx/
	 HMeAP2CNUbI+L7MoZqbDF9D/cod6YqZcWDcvhusk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfDYUHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:07:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:07:07 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B80622E5;
        Thu, 25 Apr 2019 20:07:06 +0000 (UTC)
Date:   Thu, 25 Apr 2019 13:06:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Albert Vaca Cintora <albertvaka@gmail.com>
Cc:     rdunlap@infradead.org, mingo@kernel.org, jack@suse.cz,
        ebiederm@xmission.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2] kernel/ucounts: expose count of inotify watches in
 use
Message-Id: <20190425130657.ba16b6a3f704cd724f670622@linux-foundation.org>
In-Reply-To: <20190201203959.10050-1-albertvaka@gmail.com>
References: <20190201203959.10050-1-albertvaka@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Feb 2019 21:39:59 +0100 Albert Vaca Cintora <albertvaka@gmail.com> wrote:

> Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
> The handler for this entry is a custom function that ends up calling
> proc_dointvec. Said sysctl table already contains 'max_inotify_watches'
> and it gets mounted under /proc/sys/user/.
> 
> Inotify watches are a finite resource, in a similar way to available file
> descriptors. The motivation for this patch is to be able to set up
> monitoring and alerting before an application starts failing because
> it runs out of inotify watches.

Matthias said "Albert found this problem while working on montitoring
software, so it fixes a real problem out there", so please include full
details of the problem which you encountered so that we are better able
to understand the value of the patch.

>
> ...
>
>  kernel/ucount.c | 29 +++++++++++++++++++++++++++++

Documentation, please.  Documentation/filesystems/inotify.txt and/or
Documentation/filesystems/proc.txt.

Also, max_inotify_instances (at least) also appears to be undocumented,
so it would be good to address this as well while you're in there.

> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index f48d1b6376a4..d8b11e53f098 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -57,6 +57,11 @@ static struct ctl_table_root set_root = {
>  	.permissions = set_permissions,
>  };
>  
> +#ifdef CONFIG_INOTIFY_USER
> +int proc_read_inotify_watches(struct ctl_table *table, int write,
> +		     void __user *buffer, size_t *lenp, loff_t *ppos);
> +#endif

The ifdefs aren't really needed.  And this should be in a header file
if it is indeed to be non-static.

But it should be static, in which case the ifdef will be needed to
prevent a warning.  It's kinda irksome and perhaps it would be better
to move proc_read_inotify_watches() to be ahead of user_table[].


>  static int zero = 0;
>  static int int_max = INT_MAX;
>  #define UCOUNT_ENTRY(name)				\
> @@ -79,6 +84,12 @@ static struct ctl_table user_table[] = {
>  #ifdef CONFIG_INOTIFY_USER
>  	UCOUNT_ENTRY("max_inotify_instances"),
>  	UCOUNT_ENTRY("max_inotify_watches"),
> +	{
> +		.procname	= "current_inotify_watches",
> +		.maxlen		= sizeof(int),
> +		.mode		= 0444,
> +		.proc_handler	= proc_read_inotify_watches,
> +	},
>  #endif
>  	{ }
>  };
> @@ -226,6 +237,24 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
>  	put_ucounts(ucounts);
>  }
>  
> +#ifdef CONFIG_INOTIFY_USER
> +int proc_read_inotify_watches(struct ctl_table *table, int write,
> +		     void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct ucounts *ucounts;
> +	struct ctl_table fake_table;
> +	int count;
> +
> +	ucounts = get_ucounts(current_user_ns(), current_euid());

get_ucounts() can return NULL.  The kernel will crash.

> +	count = atomic_read(&ucounts->ucount[UCOUNT_INOTIFY_WATCHES]);
> +	put_ucounts(ucounts);
> +
> +	fake_table.data = &count;
> +	fake_table.maxlen = sizeof(count);
> +	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
> +}
> +#endif

