Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABADC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DBD21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NXKztfCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbfDRJge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:36:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35184 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388044AbfDRJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:36:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id y67so1261180ede.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RUWum+Va8Z//jAipbx3o13SVsAv8KB7rFp2TRt5t/Rk=;
        b=NXKztfCOd+fSDtYoQU4LaNKH1DHMz1g4gjQzMKGYNYydsfBFvXQprtejqnEnHHWozb
         CMd6gjnvuks+QCuYwswWjoB8aeGsWR7ekrDUwHSMTcTqNqzVSIjttJl0Gtb1uppfwTd7
         NoD3NECnl5rnr7LfU7KQaJtHcgMTZ10pARYGjwzBG/aIQeMSdV0kXNM3XDSXMaZH8t33
         8gXk+YFniNWR8t7pvumroZPUXzbmEI29fNoLVwSuA5eYmk+7M0AmG2q893mvYR/Gjsa2
         HtkGEJZBHGTkwirfAPS73hY5BF0pDHeokRR/spU902DbN7/w6xZyqsd8uj5B6R+cu/xB
         E/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUWum+Va8Z//jAipbx3o13SVsAv8KB7rFp2TRt5t/Rk=;
        b=NpucbfmmHQzWUsW3IMtJjs0n4eWhq+bCumRBJGrkLK5dukfm6uNdZQJKa35omfihto
         XCewrpGWWr+JPS/nL/NPX/XWO/QHWKHcpPDAtbw/Bfk1lM3kO2YqW+fRhk520ZUPmgxU
         Ez1WtS/G0RZcwlgR+7ucbNd0osUzxzTS2VeVxlyXmpXcGBAi2rG0cNMO4qW0bgPQ7pl7
         LYCknnCiLBu2N5CTlO2NiW98r6xFsfyk4msq/EVS2GHA5/cg6B4YhZHYD5MYD17RIhwd
         8rvza9NTDIIUVG5ljJDp490mSKIv+kzTb6e9kHbJVWMfA8hVFN+P/NROvhmLslXNzBxY
         EzaA==
X-Gm-Message-State: APjAAAWLYJLwLv9pvKQUZgfeX/iyTW38PvvJmTTG7GrZBHQuU30J+dUB
        6IRcQ8Y+ndvXN4vTrKzcJ7S3Vg==
X-Google-Smtp-Source: APXvYqwPPEGctDAmToWSMGLAevSWwbrCqU+Xxdc7DcxOzpI59beah5B5o6Mt4CKANjYas/+0ICbc0g==
X-Received: by 2002:a50:f5a2:: with SMTP id u31mr24357976edm.166.1555580192182;
        Thu, 18 Apr 2019 02:36:32 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id j18sm379039edj.92.2019.04.18.02.36.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Apr 2019 02:36:31 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:36:30 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH v1 2/4] clone: add CLONE_PIDFD
Message-ID: <20190418093629.6fshxhambc2zzjdk@brauner.io>
References: <20190416170233.10208-1-christian@brauner.io>
 <20190416170233.10208-3-christian@brauner.io>
 <20190417142253.GH32622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417142253.GH32622@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:22:54PM +0200, Oleg Nesterov wrote:
> On 04/16, Christian Brauner wrote:
> >
> > +	if (clone_flags & CLONE_PIDFD) {
> > +		retval = pidfd_create(pid, &pidfdf);
> > +		if (retval < 0)
> > +			goto bad_fork_free_pid;
> > +		pidfd = retval;
> > +	}
> 
> ...
> 
> > +	if (clone_flags & CLONE_PIDFD) {
> > +		fd_install(pidfd, pidfdf);
> > +		put_user(pidfd, parent_tidptr);
> 
> put_user() can fail, I don't think this error should be silently ignored,
> this can lead to the hard-to-trigger/debug problems.
> 
> Why can't we do put_user-with-check along with pidfd_create() above?

I've moved put_user() right were pidfd_create() is called but I think
then it makes sense to change pidfd_create() to also do the fd_install()
such that the following sequence creates the pidfd, installs it, and
calls put_user() and calls ksys_close() on error. Any objections Oleg?

+       if (clone_flags & CLONE_PIDFD) {
+               retval = pidfd_create(pid);
+               if (retval < 0)
+                       goto bad_fork_free_pid;
+
+               pidfd = retval;
+               retval = put_user(pidfd, parent_tidptr);
+               if (retval)
+                       goto bad_fork_put_pidfd;
+       }

Christian
