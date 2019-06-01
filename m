Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C8EC04AB6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A301127048
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559347248;
	bh=4BNWIjdigKxKDogULYqYoz0tNzxPsCrWNp7S7A4jrRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KUiv6b7snUp4Psg8MDluKuB9cXjtqm9K8JNlUrq+txqf/nOGwHKgi3UYvuOfPgx8f
	 3zjxglZPP8gmu8XHqKAUkqt4cbW/Ha8N+3EY0/8AJ+YO0/bCyxdGJnsfP5BmfZCkg/
	 86Ac5/GOn1SZZ2t3yqjrPW8mynxj5Lk2ovga0G84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfFAAAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 20:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfFAAAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 20:00:47 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A9F27044;
        Sat,  1 Jun 2019 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559347247;
        bh=4BNWIjdigKxKDogULYqYoz0tNzxPsCrWNp7S7A4jrRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i5SKVxIKwWz9x+xpHiX88TxAWiNaAXjJwtUcL5B9qRjmOPOaSo5fKCYr32jO3uJKu
         vjrVaS23xnmTy6YsjQ2s6sd2W7wi8Jze6nYHOgEZYloPkPYcO0sOXrM6auM8c24NGB
         0WnkltjQJxUK6yvEUl41l/c1kR1zx27ga/mxrSSQ=
Date:   Fri, 31 May 2019 17:00:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Albert Vaca Cintora <albertvaka@gmail.com>
Cc:     rdunlap@infradead.org, mingo@kernel.org, jack@suse.cz,
        ebiederm@xmission.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, mbrugger@suse.com
Subject: Re: [PATCH v3 2/3] kernel/ucounts: expose count of inotify watches
 in use
Message-Id: <20190531170046.ac2b52d8c4923fdeedf943cc@linux-foundation.org>
In-Reply-To: <20190531195016.4430-2-albertvaka@gmail.com>
References: <20190531195016.4430-1-albertvaka@gmail.com>
        <20190531195016.4430-2-albertvaka@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019 21:50:15 +0200 Albert Vaca Cintora <albertvaka@gmail.com> wrote:

> Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
> The handler for this entry is a custom function that ends up calling
> proc_dointvec. Said sysctl table already contains 'max_inotify_watches'
> and it gets mounted under /proc/sys/user/.
> 
> Inotify watches are a finite resource, in a similar way to available file
> descriptors. The motivation for this patch is to be able to set up
> monitoring and alerting before an application starts failing because
> it runs out of inotify watches.
> 
> ...
>
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -118,6 +118,26 @@ static void put_ucounts(struct ucounts *ucounts)
>  	kfree(ucounts);
>  }
>  
> +#ifdef CONFIG_INOTIFY_USER
> +int proc_read_inotify_watches(struct ctl_table *table, int write,
> +		     void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct ucounts *ucounts;
> +	struct ctl_table fake_table;

hmm.

> +	int count = -1;
> +
> +	ucounts = get_ucounts(current_user_ns(), current_euid());
> +	if (ucounts != NULL) {
> +		count = atomic_read(&ucounts->ucount[UCOUNT_INOTIFY_WATCHES]);
> +		put_ucounts(ucounts);
> +	}
> +
> +	fake_table.data = &count;
> +	fake_table.maxlen = sizeof(count);
> +	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);

proc_dointvec
->do_proc_dointvec
  ->__do_proc_dointvec
    ->proc_first_pos_non_zero_ignore
      ->warn_sysctl_write
        ->pr_warn_once(..., table->procname)

and I think ->procname is uninitialized.

That's from a cursory check.  Perhaps other uninitialized members of
fake_table are accessed, dunno.

we could do

	{
		struct ctl_table fake_table = {
			.data = &count,
			.maxlen = sizeof(count),
		};

		return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
	}

or whatever.  That will cause the pr_warn_once to print "(null)" but
that's OK I guess.

Are there other places in the kernel which do this temp ctl_table
trick?  If so, what do they do?  If not, what is special about this
code?


