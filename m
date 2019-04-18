Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C60AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43D920652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SbeZJGAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbfDRN22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:28:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36057 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbfDRN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:28:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so1820919edm.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+8hg6qujl1+vbAOJgXR0XPQwmvHW2iRzPh5yyJeKJ+Q=;
        b=SbeZJGAvr8VTOX6UdLjzWusPyK86MapUgvtDHJIQHUAJUehW0AiF76gM7DS24r8xpV
         nZTHKr1C/4raOjSLGsQVv+EB+ihEhM//KJw2RgcM0mOlY2/iYEOvcDuVFh0QE5MIQSS6
         1zfWAu18Pjore6aDzEK2/HI8CkkHDVQv8Hqq1KEDRVWowD3T/sNerb4kH0Tu5NHkP7m3
         4wTI6OzUOMdorIuuRzUlqvow2MYo8U/0r7PsWdr5YKf+Aw8nJf4F9OvZO2mom/1PE19p
         +haGhTrxhcvthfUGz3Q1O4jzRWNkmfjOU4W0NqFVS/TlQHceWS7buPqpTuXIHdEah7Su
         /qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+8hg6qujl1+vbAOJgXR0XPQwmvHW2iRzPh5yyJeKJ+Q=;
        b=ucAQFlqEJIF1219NhPPiJtGlpk27IwypJjmU4K3yks1vTFflHAxHZFxze21j12SMj/
         LQyRtmhxUHCnPGx3OP0YmCrkg/UcC8H1+9BfjHoWPDWTI/7r1CleSkdj7dK1WN4Ci0aH
         Jv/6+/2IscrNWmov/xU5qt1LPjZVmq4hgXeiwh1FBz7L4xX+/s89pbbuqFK9HHoPiIOm
         HXdvvieDFoSGJBY8BAwIdU817bEksmzpAarvzU+ZpXHM54JdgwbxqjTdaJc9QRrxilfx
         Jh4g8VeUZwj5fS1ct5GCklrZeO5CDSNaJR00wX2XItzqtCfvxOk61xjdQSS6MmAIG/73
         VRPw==
X-Gm-Message-State: APjAAAVOQHWDDluIi7DboeiRBTSnNGyXDvA+pGZk1RAgCeZ9iw8IUBeH
        JZReyrReS7mr2GrbjN7TIqOxsw==
X-Google-Smtp-Source: APXvYqxlIA+Sep3/MiKVe5bHS1iVH5Hi1uV/7VriACbLdQOgGnpA4Pm0sFJMzSDRBDdEvJChJysj3A==
X-Received: by 2002:a17:906:e202:: with SMTP id gf2mr50491722ejb.55.1555594105530;
        Thu, 18 Apr 2019 06:28:25 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id x14sm526350edm.1.2019.04.18.06.28.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Apr 2019 06:28:24 -0700 (PDT)
Date:   Thu, 18 Apr 2019 15:28:23 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH v2 2/5] clone: add CLONE_PIDFD
Message-ID: <20190418132822.untjt7erfvbbiz7a@brauner.io>
References: <20190418101841.4476-1-christian@brauner.io>
 <20190418101841.4476-3-christian@brauner.io>
 <20190418131206.GB13701@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418131206.GB13701@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:12:07PM +0200, Oleg Nesterov wrote:
> On 04/18, Christian Brauner wrote:
> >
> > @@ -1674,13 +1729,14 @@ static __latent_entropy struct task_struct *copy_process(
> >  					unsigned long clone_flags,
> >  					unsigned long stack_start,
> >  					unsigned long stack_size,
> > +					int __user *parent_tidptr,
> >  					int __user *child_tidptr,
> >  					struct pid *pid,
> >  					int trace,
> >  					unsigned long tls,
> >  					int node)
> >  {
> > -	int retval;
> > +	int pidfd = -1, retval;
> 
> it seems that initialization is unneeded, but this is cosmetic.
> 
> I see no technical problems, feel free to add my reviewed-by.

Thank you!

> 
> 
> But let me ask a couple of questions...

Sure!

> 
> 
> Why O_CLOEXEC? I am just curious, I do not really care.

I think that having the file descriptor O_CLOEXEC by default is a good
security measure in general. Most of the time you do not want to pass a
file descriptor through exec() (apart from 0,1,2) and it is usually more
of an issue when you accidently do it then when you accidently don't. So
if users really care about passing a pidfd they should do so by removing
the O_CLOEXEC flag explicitly.
(New file descriptors should probably all default to that but that's just
my opinion.)
Another thing is that for a pidfds it makes even more sense to have them
cloexec by default. You don't want to *unintentionally* leak an fd that
can be used to operate on a process.

> 
> 
> Should we allow CLONE_THREAD | CLONE_PIDFD ?

I think so, yes. I have thought about this. Yes, due to CLONE_FILES |
CLONE_VM you'd necessarily hand the pidfd to the child but threads are
no security boundary in the first place. So if you have a
non-cooperating thread you very much already have a problem. The
situation is not very much different from passing the tid.
Plus, CLONE_PIDFD can make use of the CLONE_UNDETACHED flag in the
future in contrast to all the other flags. So one could potentially (not
saying we have this planned!) add a flag CLONE_PIDFD_KILL_ON_CLOSE (This
is just an improvised bad name rn.) which would cause the child to kill
itself if it does close(pidfd) on its own pidfd and noone else is
holding a reference at which point you'd hand a suicide switch to a new
thread but nothing else.

> 
> 
> Are you sure we will never need to extend this interface? If not, then perhaps it

Well, we can already make use of CLONE_UNDETACHED with CLONE_PIDFD since
we don't just ignore it. :)

> make sense to add something like
> 
> 	if (CLONE_PIDFD) {
> 		unsigned long not_used_yet;
> 		if (get_user(not_used_yet, parent_tidptr) ||
> 		    not_used_yet != 0)
> 			return -EINVAL;

Oh, very interesting point. Yes, I think this is worth it.

> 	}
> 
> this way we can easily add more arguments in future or even turn CLONE_PIDFD into
> CLONE_MORE_ARGS_IN_PARENT_TIDPTR.
> 
> Not that I think this is really good idea, sys_clone2() makes more sense, but still.

No, you're right about leaving this option open. Even if we don't extend
not allowing garbage to be passed is always a good idea.

Christian
