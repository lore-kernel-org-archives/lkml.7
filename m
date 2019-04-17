Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E33C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338DD2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555471065;
	bh=EtNp+iz+vav9GE/rtTbs5jMyOX+/DllITj1zGt1ilPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LvnXgfFqqTmLsSrzUSx8Q/pMPNtRwnehKa0keHvqeOz7LJfAkViLRNq7LgqdFzp07
	 /ZshMxSyMYNCP5zAWGyO9qyWFOtDt+JPJ5tI1w6F82nOzwq7OFE2T1kKHGA64wQGCy
	 2RZzXbbpZMSCjcFKN1qWn8dtPFjuK7D8fIqovcQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfDQDRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:17:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfDQDRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:17:43 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6056CA70;
        Wed, 17 Apr 2019 03:17:42 +0000 (UTC)
Date:   Tue, 16 Apr 2019 20:17:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] proc/sysctl: add shared variables for range check
Message-Id: <20190416201741.19395c715a1cb0f2130e795a@linux-foundation.org>
In-Reply-To: <20190417005943.17448-1-mcroce@redhat.com>
References: <20190417005943.17448-1-mcroce@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 02:59:43 +0200 Matteo Croce <mcroce@redhat.com> wrote:

> In the sysctl code the proc_dointvec_minmax() function is often used to
> validate the user supplied value between an allowed range. This function
> uses the extra1 and extra2 members from struct ctl_table as minimum and
> maximum allowed value.
> 
> On sysctl handler declaration, in every source file there are some readonly
> variables containing just an integer which address is assigned to the
> extra1 and extra2 members, so the sysctl range is enforced.
> 
> The special values 0, 1 and INT_MAX are very often used as range boundary,
> leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
> different source files:
> 
>     $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
>     245
> 
> This patch adds three const variables for the most commonly used values,
> and use them instead of creating a local one for every object file.
> 

Nice.  A few thoughts:

> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -220,15 +220,13 @@ appldata_timer_handler(struct ctl_table *ctl, int write,
>  			   void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int timer_active = appldata_timer_active;
> -	int zero = 0;
> -	int one = 1;
>  	int rc;
>  	struct ctl_table ctl_entry = {
>  		.procname	= ctl->procname,
>  		.data		= &timer_active,
>  		.maxlen		= sizeof(int),
> -		.extra1		= &zero,
> -		.extra2		= &one,
> +		.extra1		= (void *)&sysctl_zero,
> +		.extra2		= (void *)&sysctl_one,

The casts are ugly, and by casting away constness they introduce the
risk that some errant could could change the value of 0, 1 and INT_MAX!
Maybe - perhaps trying to do that would cause a segv but still,
they're ugly.

A proper fix would require changing extra1 and extra2 to const void *. 
Perhaps that would be unfeasibly extensive?

> ...
>
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -21,6 +21,11 @@ static const struct inode_operations proc_sys_inode_operations;
>  static const struct file_operations proc_sys_dir_file_operations;
>  static const struct inode_operations proc_sys_dir_operations;
>  
> +/* shared constants to be used in various sysctls */
> +const int sysctl_zero = 0;
> +const int sysctl_one = 1;
> +const int sysctl_int_max = INT_MAX;

Don't these require EXPORT_SYMBOL()?


