Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF6C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8182183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="J7gchnRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfDTMfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:35:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39501 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:35:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id k45so6334791edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lfS4jHQHDZpV/nXsHbcDnf57yfYUP32gdciwif1OGGI=;
        b=J7gchnRQD/fUtkqWGlccOk74KJNsIQOx48hIxszBYnesbNZHkVH0YTeppDOtGWfWSi
         fI/aA8zB3u8WgIjObQDmW3ukULvUTYL0ogvV9TDETVrXzc8q4xPNSpqEoXOj/FIx/dNM
         0F+OwzDNkcilQiICD4QteNiMTXTKfekzQXmLqqVgCqqx/yrkkJmL41p2Kcjz4YU0KocL
         0E+UPlFFB/tP8cQx58COuSTdTyw5Ae4OOaoSdz1w4DxlKhv/1aJvJkhMbeckO0b5CHXQ
         3l7oDP2GMGuK9+0sUnxjXJxbkRqRHkvoErHqg7GsE1JEbpFptR00tCsu5ePQZmwsPdJX
         gjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lfS4jHQHDZpV/nXsHbcDnf57yfYUP32gdciwif1OGGI=;
        b=Z7kRbheUyOcOxhZFnOZHfziyGRkgdAROBCEOuQfypHuNz4Rxd+5ZH56f60JcNYW/Dc
         U0CShft1AGrlSm2/7MK7uzLBmMQNzPRgNKHmzPzSYPtd0foCGmoZjcBRKr7u6e6ddNad
         /7eVPRPGonzwD6RUYL2LGIRMdBBwkgc8R2aVk1fW/Y7RXN0zNzJNnn1psMjLn0zJt0PV
         rC8sLB2SxPSC7ez3X7Xg5XTn1mW9WcvtYDe9ErD+whbiwsj1TmRU8LBUx2UvvNBqSgpB
         eOIwaQtLHcXlGuQAFtbGKAjUFkeSSyKEtMANh495n1Pe7zH3Ysh0+lSQXM8Ztmcj0K+/
         iVCQ==
X-Gm-Message-State: APjAAAVTPt8ZXKwKCr8Y4sFBjCAk5nWlqYmjgMY//2GCMBlL8L2o2twq
        7T0jfaC+FHd+E5VkCST6bepGXg==
X-Google-Smtp-Source: APXvYqyyrtC1nJRCk3xC0Q5ImPiI6D+SOjremXeJ9tic2+JtroW6/DiWbdX1kU2+EyySp/1lbN2uXg==
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr4392645ejv.256.1555763707826;
        Sat, 20 Apr 2019 05:35:07 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id i9sm2128976edk.56.2019.04.20.05.35.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 20 Apr 2019 05:35:07 -0700 (PDT)
Date:   Sat, 20 Apr 2019 14:35:05 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190420123504.gohscgeahp45hjd3@brauner.io>
References: <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <20190419212002.GB44851@google.com>
 <CAHrFyr6qqj-q9nSVuNhFL5WOcuQstAFvaDu2544OpeMe6jawQw@mail.gmail.com>
 <20190420115125.GC17468@redhat.com>
 <20190420122614.GD17468@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190420122614.GD17468@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 02:26:15PM +0200, Oleg Nesterov wrote:
> On 04/20, Oleg Nesterov wrote:
> >
> > Note that we need
> > thread_group_empty() only for the case when the task is traced,
> 
> Damn, sorry for noise... of course this is not true, I tried to say that
> notification won't come otherwise. Nevermind, lets discuss this when we
> have a patch. I already got lost in this thread and I have no idea what

Agreed. The polling work is not targeted for the 5.2 merge window
anyway so there's no need to rush this.

> are you all talking about ;)

Nothing patch-worthy comes without a solid portion of controversy and
confusion at first. ;)

Christian
