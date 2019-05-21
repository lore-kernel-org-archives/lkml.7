Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39180C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05244217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Jqwp5Bh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfEUMEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:04:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45482 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfEUMEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:04:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so8478551pgi.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=fAlHmuMbdO8StoGutrHp7Q7+AaRsIB6i9bHojawbKSQ=;
        b=Jqwp5Bh2k8ImU2IAGBXDj9eAbWh5j0TMCbkio/odjenlXtIpFkWsY/NBHDXQwyb8xB
         nHca3JG+JwQtJwLxx3sLZ3n03Dzmmjc82RoY8tiNFNoj4deTQujBIvcLwRdFCfM3DrHf
         o7/YtqCGyr/wYzwKlCxBUG7WcO473Ti4JprbVIzy309mYsRkacFZ8ZCrrlXxu8Pu9gQs
         FA5PCchneXWWmdst9WPKHbipQgUxN9PXFoN+w7L2mCntaip7U59+4Lpp6sS9I+F2hp5x
         V1tUWuHsrHIo02mZESjyM34QnWoVx9jK/5tbY31m9ggwn1SmLgXOaSRS33Sy2LAF84dk
         Me2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=fAlHmuMbdO8StoGutrHp7Q7+AaRsIB6i9bHojawbKSQ=;
        b=Ur2W8ogXSXclxCS6iDmeINnBBY6YAvXAzXo86VvlmBhD+uV8pf8cdnM4SvfIMZuIhB
         fjnN7eEStKRkzgiASu5eacRKBhPFMAyxmqi+F59FcIia6NQUzdmrDgJyrcJ+TI9x4suZ
         8crljGFE+2qOX5pSEI5L4CkIpXMKO42E4kbj391FR6l/9LXYZ+VULcc8E+xIwszZoIR7
         Zo+CC7byebqI74hlkmqvAA9VgK2WBRNBOd4uf4lcz4QVqWZPP3KfJyyKOm+K0deSlMzs
         VF3WwYNDoUp5W5D7yq/kVnrtsIs08pEJX1SMYs0Uy97YiStq+fovW9QSXPT26DseSG1a
         7KdQ==
X-Gm-Message-State: APjAAAVImkMdk76Lem44+lsPdW+ioFAjZDkmwog4sVnYanTcKnJRjGJc
        s3P3aRAXZn0LY02WzjgKs6M+Iw==
X-Google-Smtp-Source: APXvYqx/G6fkfM7rAhQsB9TFz3mFGfk4yyD9fx+XxerNFGhCM72t2R7k3PLxcE/ZnoOoTWYebwmTZQ==
X-Received: by 2002:a63:8949:: with SMTP id v70mr82230358pgd.196.1558440249114;
        Tue, 21 May 2019 05:04:09 -0700 (PDT)
Received: from [25.170.31.42] ([208.54.39.182])
        by smtp.gmail.com with ESMTPSA id j64sm38526910pfb.126.2019.05.21.05.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 05:04:08 -0700 (PDT)
Date:   Tue, 21 May 2019 14:04:00 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190521114120.GJ219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org> <20190521084158.s5wwjgewexjzrsm6@brauner.io> <20190521110552.GG219653@google.com> <20190521113029.76iopljdicymghvq@brauner.io> <20190521114120.GJ219653@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleksandr@redhat.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <E01B155E-2FB4-4411-8725-3A3D7ADBE1D9@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 21, 2019 1:41:20 PM GMT+02:00, Minchan Kim <minchan@kernel=2Eorg> wr=
ote:
>On Tue, May 21, 2019 at 01:30:32PM +0200, Christian Brauner wrote:
>> On Tue, May 21, 2019 at 08:05:52PM +0900, Minchan Kim wrote:
>> > On Tue, May 21, 2019 at 10:42:00AM +0200, Christian Brauner wrote:
>> > > On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
>> > > > - Background
>> > > >=20
>> > > > The Android terminology used for forking a new process and
>starting an app
>> > > > from scratch is a cold start, while resuming an existing app is
>a hot start=2E
>> > > > While we continually try to improve the performance of cold
>starts, hot
>> > > > starts will always be significantly less power hungry as well
>as faster so
>> > > > we are trying to make hot start more likely than cold start=2E
>> > > >=20
>> > > > To increase hot start, Android userspace manages the order that
>apps should
>> > > > be killed in a process called ActivityManagerService=2E
>ActivityManagerService
>> > > > tracks every Android app or service that the user could be
>interacting with
>> > > > at any time and translates that into a ranked list for lmkd(low
>memory
>> > > > killer daemon)=2E They are likely to be killed by lmkd if the
>system has to
>> > > > reclaim memory=2E In that sense they are similar to entries in
>any other cache=2E
>> > > > Those apps are kept alive for opportunistic performance
>improvements but
>> > > > those performance improvements will vary based on the memory
>requirements of
>> > > > individual workloads=2E
>> > > >=20
>> > > > - Problem
>> > > >=20
>> > > > Naturally, cached apps were dominant consumers of memory on the
>system=2E
>> > > > However, they were not significant consumers of swap even
>though they are
>> > > > good candidate for swap=2E Under investigation, swapping out only
>begins
>> > > > once the low zone watermark is hit and kswapd wakes up, but the
>overall
>> > > > allocation rate in the system might trip lmkd thresholds and
>cause a cached
>> > > > process to be killed(we measured performance swapping out vs=2E
>zapping the
>> > > > memory by killing a process=2E Unsurprisingly, zapping is 10x
>times faster
>> > > > even though we use zram which is much faster than real storage)
>so kill
>> > > > from lmkd will often satisfy the high zone watermark, resulting
>in very
>> > > > few pages actually being moved to swap=2E
>> > > >=20
>> > > > - Approach
>> > > >=20
>> > > > The approach we chose was to use a new interface to allow
>userspace to
>> > > > proactively reclaim entire processes by leveraging platform
>information=2E
>> > > > This allowed us to bypass the inaccuracy of the kernel=E2=80=99s =
LRUs
>for pages
>> > > > that are known to be cold from userspace and to avoid races
>with lmkd
>> > > > by reclaiming apps as soon as they entered the cached state=2E
>Additionally,
>> > > > it could provide many chances for platform to use much
>information to
>> > > > optimize memory efficiency=2E
>> > > >=20
>> > > > IMHO we should spell it out that this patchset complements
>MADV_WONTNEED
>> > > > and MADV_FREE by adding non-destructive ways to gain some free
>memory
>> > > > space=2E MADV_COLD is similar to MADV_WONTNEED in a way that it
>hints the
>> > > > kernel that memory region is not currently needed and should be
>reclaimed
>> > > > immediately; MADV_COOL is similar to MADV_FREE in a way that it
>hints the
>> > > > kernel that memory region is not currently needed and should be
>reclaimed
>> > > > when memory pressure rises=2E
>> > > >=20
>> > > > To achieve the goal, the patchset introduce two new options for
>madvise=2E
>> > > > One is MADV_COOL which will deactive activated pages and the
>other is
>> > > > MADV_COLD which will reclaim private pages instantly=2E These new
>options
>> > > > complement MADV_DONTNEED and MADV_FREE by adding
>non-destructive ways to
>> > > > gain some free memory space=2E MADV_COLD is similar to
>MADV_DONTNEED in a way
>> > > > that it hints the kernel that memory region is not currently
>needed and
>> > > > should be reclaimed immediately; MADV_COOL is similar to
>MADV_FREE in a way
>> > > > that it hints the kernel that memory region is not currently
>needed and
>> > > > should be reclaimed when memory pressure rises=2E
>> > > >=20
>> > > > This approach is similar in spirit to madvise(MADV_WONTNEED),
>but the
>> > > > information required to make the reclaim decision is not known
>to the app=2E
>> > > > Instead, it is known to a centralized userspace daemon, and
>that daemon
>> > > > must be able to initiate reclaim on its own without any app
>involvement=2E
>> > > > To solve the concern, this patch introduces new syscall -
>> > > >=20
>> > > > 	struct pr_madvise_param {
>> > > > 		int size;
>> > > > 		const struct iovec *vec;
>> > > > 	}
>> > > >=20
>> > > > 	int process_madvise(int pidfd, ssize_t nr_elem, int *behavior,
>> > > > 				struct pr_madvise_param *restuls,
>> > > > 				struct pr_madvise_param *ranges,
>> > > > 				unsigned long flags);
>> > > >=20
>> > > > The syscall get pidfd to give hints to external process and
>provides
>> > > > pair of result/ranges vector arguments so that it could give
>several
>> > > > hints to each address range all at once=2E
>> > > >=20
>> > > > I guess others have different ideas about the naming of syscall
>and options
>> > > > so feel free to suggest better naming=2E
>> > >=20
>> > > Yes, all new syscalls making use of pidfds should be named
>> > > pidfd_<action>=2E So please make this pidfd_madvise=2E
>> >=20
>> > I don't have any particular preference but just wondering why pidfd
>is
>> > so special to have it as prefix of system call name=2E
>>=20
>> It's a whole new API to address processes=2E We already have
>> clone(CLONE_PIDFD) and pidfd_send_signal() as you have seen since you
>> exported pidfd_to_pid()=2E And we're going to have pidfd_open()=2E Your
>> syscall works only with pidfds so it's tied to this api as well so it
>> should follow the naming scheme=2E This also makes life easier for
>> userspace and is consistent=2E
>
>Okay=2E I will change the API name at next revision=2E
>Thanks=2E

Thanks!
Fwiw, there's been a similar patch by Oleksandr for pidfd_madvise I stumbl=
ed upon a few days back:
https://gitlab=2Ecom/post-factum/pf-kernel/commit/0595f874a53fa898739ac315=
ddf208554d9dc897

He wanted to be cc'ed but I forgot=2E

Christian

