Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2429CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D085F218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SHxD631W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfC3Ohc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:37:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36013 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbfC3Ohb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 10:37:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16so4445584edr.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9TAMsOp0seFishuNDw8XV7MHWa9//YVeiffHAlpzhDo=;
        b=SHxD631WWEBHFAk+ot/3ZD2prLcFnGtIKIOmxZd8MNqM0/zyJSkA1b07mlzXbL/FOh
         6TUXpbEu84H3eErUiu0i5h8MzTL0VG/bR75Cc5HdWulZ8cGXUxk0GY8EqxnZs6kBC+Wy
         pqrVrRz6ouukyJVCiSp4ufpr8DGTcQAYBG46kPyhkys/0c4TGl2svUV037Ya00VS6BkY
         kYz+poRk2s3Z3i83sLnV1Ris8WnRCGSB/nbpWSUzXTw7sDd3/NAT+dSvutCNwcfvwhj5
         vlBHfxDCY9v2mmS8psB0doL9yHFtH2S2nMLrfsdqrIRG47vhfu6q3Sy9Dz5xIRwdlzTu
         XAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9TAMsOp0seFishuNDw8XV7MHWa9//YVeiffHAlpzhDo=;
        b=NW3gi8/1BL48Qep5g7RBfU/ka5D5lKeaJ4ADXmf1ZaeP9g3elw0fmLZ8ni0QUMXwd0
         LN73iAdZPZAYa9O20T+6mUJjnTvJ3e/4m9+SsT2N3/zuyUbtuIDYLc+MRjVxk8huGAX7
         U1kLrjrLrlhkRee0WsNC6Z9CKZdc+RJz1Jcw/PJrmtDHil7ai/cvjcNzmchekuLseJo9
         Sp1NJqyM/6YTlLi6Dqve2uRYoYHX4PbhcIA8DoYGZ9a2qNy5XnPBNwqy9mYo04L+rulo
         ydBVmIONEHD/gJMhUQISkRpMJb7yjYG+VviDMAdADOboI74UBW5s/st8FhFNtOXcfzpK
         YDwA==
X-Gm-Message-State: APjAAAWNLjvU/DKvcboXy3of4cuKXjzTkN++0qa+SI57aG96KOUXV7AY
        XcJSiZUgPb5UkJpjNc9sTBHEWA==
X-Google-Smtp-Source: APXvYqyQbMLCO0xSf8gD82J/cyXuwP3/gjQOTOcctmdWtEaax05N/nZiUUV6k8ISe6lalFHXFUt5Kw==
X-Received: by 2002:aa7:c697:: with SMTP id n23mr35613464edq.231.1553956649190;
        Sat, 30 Mar 2019 07:37:29 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id x52sm1536321edb.8.2019.03.30.07.37.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 30 Mar 2019 07:37:28 -0700 (PDT)
Date:   Sat, 30 Mar 2019 15:37:27 +0100
From:   Christian Brauner <christian@brauner.io>
To:     =?utf-8?B?SsO8cmc=?= Billeter <j@bitron.ch>,
        torvalds@linux-foundation.org
Cc:     jannh@google.com, luto@kernel.org, dhowells@redhat.com,
        serge@hallyn.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        khlebnikov@yandex-team.ru, keescook@chromium.org,
        adobriyan@gmail.com, tglx@linutronix.de, mtk.manpages@gmail.com,
        bl0pbl33p@gmail.com, ldv@altlinux.org, akpm@linux-foundation.org,
        oleg@redhat.com, nagarathnam.muthusamy@oracle.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk, joel@joelfernandes.org,
        dancol@google.com
Subject: Re: [PATCH v2 2/5] pid: add pidfd_open()
Message-ID: <20190330143726.6aaxz4sctu3pzpyx@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <20190329155425.26059-3-christian@brauner.io>
 <f0d590b96b7d11ae21a9a06040b8ffa85fa74e2a.camel@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0d590b96b7d11ae21a9a06040b8ffa85fa74e2a.camel@bitron.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:53:57PM +0100, Jürg Billeter wrote:
> On Fri, 2019-03-29 at 16:54 +0100, Christian Brauner wrote:
> > diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
> > index ac49a220cf2a..d6c7c0701997 100644
> > --- a/include/uapi/linux/wait.h
> > +++ b/include/uapi/linux/wait.h
> > @@ -18,5 +18,7 @@
> >  #define P_PID		1
> >  #define P_PGID		2
> >  
> > +/* Get a file descriptor for /proc/<pid> of the corresponding pidfd
> > */
> > +#define PIDFD_GET_PROCFD _IOR('p', 1, int)
> >  
> >  #endif /* _UAPI_LINUX_WAIT_H */
> 
> This is missing an entry in Documentation/ioctl/ioctl-number.txt and is
> actually conflicting with existing entries.

Thanks. Yes, Jann mentioned this too.

> 
> However, I'd actually prefer a syscall to allow strict whitelisting via
> seccomp and avoid the other ioctl disadvantages that Daniel has already
> mentioned.

You can filter ioctls with seccomp.

I have compromised quite a bit now and I think what we have is perfectly
fine. a single clean syscalls pidfd_open() that lets you get pidfds for
threads and thread-group leaders independent of procfs and a clean,
simple fd->fd converstion ioctl() that is a property of the f_ops of the
pidfd to get an fd to /proc/<pid> for metadata access. Btw, this being a
part of the pidfd f_ops seems strikingly elegant to me. Because it
expresses the notion that the metadata is implicitly part of the pidfd
nicely. But I might just be dumb.

I do not see the need to add another syscall that is conditional on
CONFIG_PROC_FS and only does a pidfd to /proc/<pid>-fd conversion.
That's almost the definition of what an ioctl() is most suited for.

I get the opposition to multiplexers but consider if we where to oppose
all of them. Let's leave ioctls out and just look at a few widely used
multiplexer syscalls:

1. seccomp()
   - number of supported commands:   4

2. prctl()
   - number of supported commands:  45

3. keyctl()
   - number of supported commands:  25

4. bpf()
   - number of supported commands:  18

5. proposed fsconfig()
   - number of supported commands:   8

Total Number of required syscalls: 100

That means for bpf() alone Linux would have had to gain *18* additional
single syscalls and for the new mount api only for configuring a mount
context 8 additional syscalls would need to be pulled.
That all hinges on the argument that "syscalls are cheap" and that
running out of syscall numbers is not a real problem because there is a
patchset that lifts this restriction _eventually_. That patchset hasn't
been merged yet and I have not even seen it sent out yet. So we're still
short of syscall numbers. _Even_ if this patchset would have landed,
adding 26 syscalls for two apis seems excessive.
So unless Linus jumps in here (Cced) and says that he's fine that the
pidfd to /proc/<pid>-fd conversion is suited for yet another syscalls
what we have here is perfectly acceptable.
Again, as I've said before I don't see the point in sending piles of
syscalls when it is not really justified and I find none of the
arguments against this implementation we have here right now very
convincing.

Christian
