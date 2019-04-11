Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C285C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4346620850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aw/y4BML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDKUUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:20:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45257 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:20:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so3918188plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z1/+beueiWsmz6a7TBUTMwuhhscPHS19VKrRN/IMS0U=;
        b=aw/y4BMLUJFg3fdAfFIw5zmt9yb1JolbZxeS57967jUjrq6SBOsZuzyeiMwrH1e0KA
         kwkh1BVeP0HsE4+9oqeETXp2/wPEzy6NT2tlDkRE90hAuJXvdjfhXuB41eBvszc5ncux
         AWNMjzmWXi0Lu9eF/aSYP8eV7KdKU2B5ozZDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z1/+beueiWsmz6a7TBUTMwuhhscPHS19VKrRN/IMS0U=;
        b=bThYVuhdXTIOgj2WvPsa3vz8db8RiyJSxWND1jKK3tPyuSvzzkEEj/B2BFKIhYh5ry
         Dr4GGoUbQyQlM0onMBHnVLG/gzriSdZ6Bo9xVuzwlPAYPiJH8VPED01a4/r7ttK1FJAK
         gVG0+wTLZZs3SVZ2LmHnYEhL9Wr/6RkxkdtgDZ2B5qOYQoZTmCBVVJ7cxtN63t6BBL9H
         Wio9zPvUsM0NIShP01EZq+F9EIsYWFnYYndGfcVeAz+KOWiG6glzd4GKOUi5V+WdqCnr
         pNjtPqdEaS+BZIyvMotLANzpqK7RQRBYvyBNRaMZaVi4noFAzntFPJG0KNqf93wJD58m
         VqJA==
X-Gm-Message-State: APjAAAVcxWEHX+9/NubePqjGkC6qzwNIhsHJa2fDC5i1uQbEzeNLV+Ao
        gPRGccKJPVErMEybPrdKxQWlXTXwUBM=
X-Google-Smtp-Source: APXvYqxjWchE9gFSHfJBJr+G0pVGKRsGHbzDqmZAQ/h52Lz9C0eN+nVgCFrW1swsmqT+qsM0H0vfgQ==
X-Received: by 2002:a17:902:1621:: with SMTP id g30mr21026345plg.168.1555014008316;
        Thu, 11 Apr 2019 13:20:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j67sm69927804pfc.72.2019.04.11.13.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 13:20:07 -0700 (PDT)
Date:   Thu, 11 Apr 2019 16:20:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net,
        rostedt@goodmis.org, dancol@google.com, jannh@google.com,
        surenb@google.com, torvalds@linux-foundation.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Nadav Amit <namit@vmware.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190411202006.GA130334@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190411200059.GA75190@google.com>
 <DA36DE02-73C2-4C9E-9761-27B3EBC6FED2@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA36DE02-73C2-4C9E-9761-27B3EBC6FED2@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:02:32PM +0200, Christian Brauner wrote:
> On April 11, 2019 10:00:59 PM GMT+02:00, Joel Fernandes <joel@joelfernandes.org> wrote:
> >On Thu, Apr 11, 2019 at 01:50:42PM -0400, Joel Fernandes (Google)
> >wrote:
> >> pidfd are /proc/pid directory file descriptors referring to a task
> >group
> >> leader. Android low memory killer (LMK) needs pidfd polling support
> >to
> >> replace code that currently checks for existence of /proc/pid for
> >> knowing a process that is signalled to be killed has died, which is
> >both
> >> racy and slow. The pidfd poll approach is race-free, and also allows
> >the
> >> LMK to do other things (such as by polling on other fds) while
> >awaiting
> >> the process being killed to die.
> >
> >It appears to me that the "pidfd" now will be an anon inode fd, and not
> >based
> >on /proc/, based on discussions with Linus. So I'll rework the patches
> >accordingly. However that is relatively independent of this patch so
> >this
> >version can also be reviewed before I send out the reworked version.
> 
> Thank you very much, Joel.
> I'm off this week and traveling but I'll try to give it a look asap.
> 
> Christian

Sounds great to me, thanks a lot Christian.

 - Joel

