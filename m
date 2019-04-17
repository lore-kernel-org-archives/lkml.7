Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A653EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0C42173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WRQzIrUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfDQNDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:03:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35794 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQNDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:03:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so3548491wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cejhRTfWhhlFH6fanfQsVN7dbGnTDgRUCk8MGU3ZSYo=;
        b=WRQzIrUYwNw1/iNH34bfBmOBn+jf/W9if2TBGaCc7qQSnyomzEajvUd/pVjJe4ARJk
         sGKdwRKkSyayNANAxn30nQ1nh5+8ZR3VF6gvFgE9PfMFyiH48DE8RI8DRimXnG7RWy1J
         31e9o//JhD+/nr719dX13Ybu3Od0QmVj0CoK6SMHuD3dHr0Q4dzoQL63fKvcirXGINcO
         fq+MOXI/E8b7fZNP/tVuUwV8DdAhGWSZoLuzKu1LHu5v4gTh1Fx8lUXh2Ub/m16DlL7d
         zN1u7ALNgP2REw8oXu29iDeTVJFGHQlvBTHkfDKGMJ123KIECVNuRRQ5H8fUwFyqZxH6
         RoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cejhRTfWhhlFH6fanfQsVN7dbGnTDgRUCk8MGU3ZSYo=;
        b=EkFEKhkl/Q5WqsLKVWzdiF72Vetff4ZYxt+Di9PyKBDNqFMYe0C/2wmjurBaSy7OY7
         kxI2uGWWnEDtpbkxw9i5ltr2raftx5BFogotKVmLKSBmC25cCFRExqWdAoR4w0GE9cPF
         mftzGjF3nXWTDzHMVESSWULzt5MQejr4rvD/QosVJ5ux0K5N7DS+gC9SDL8Wce56M8fH
         8p0x7v7TuGwk8T47cis586M7Ulw6+TtJpIwOBB9N5OqfGa15aHtywHbKMOPPuDR0RPTJ
         QQmm1yicimBnr750XYj7sPZBCQ2YS2T0mupt6rAj8j7m6E4zdQ+dfALpZFQpaQG4mgzU
         W6oA==
X-Gm-Message-State: APjAAAVqrCRC38enFGQ8dH0YgC4zKNEx4C1fXbHMMpswZY8n77cWK2N4
        eUP+fFbqbMpGdTP0OjO7zInUnw==
X-Google-Smtp-Source: APXvYqzupwLA/R31cjqq1W3HOP0r1EP8Dbe6PetLMdsurtKWlEIEfUDQaIyq9nTqCXHKq6xhFWvaKg==
X-Received: by 2002:a1c:9991:: with SMTP id b139mr29680031wme.53.1555506219137;
        Wed, 17 Apr 2019 06:03:39 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id w16sm79760431wrt.84.2019.04.17.06.03.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 06:03:38 -0700 (PDT)
Date:   Wed, 17 Apr 2019 15:03:37 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: don't silently convert SI_USER signals to
 non-current pidfd
Message-ID: <20190417130336.i55vmf3x6cby2mvi@brauner.io>
References: <20190330021232.191205-1-jannh@google.com>
 <20190408131315.GA24111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190408131315.GA24111@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 03:13:16PM +0200, Oleg Nesterov wrote:
> On 03/30, Jann Horn wrote:
> >
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3605,16 +3605,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >  		if (unlikely(sig != kinfo.si_signo))
> >  			goto err;
> >
> > +		/* Only allow sending arbitrary signals to yourself. */
> > +		ret = -EPERM;
> >  		if ((task_pid(current) != pid) &&
> > -		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
> > -			/* Only allow sending arbitrary signals to yourself. */
> > -			ret = -EPERM;
> > -			if (kinfo.si_code != SI_USER)
> > -				goto err;
> > -
> > -			/* Turn this into a regular kill signal. */
> > -			prepare_kill_siginfo(sig, &kinfo);
> > -		}
> > +		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> > +			goto err;
> 
> ACK.
> 

Sorry Oleg. I missed that message somehow.
> 
> but perhaps it should always fail, even if task_pid(current) == pid.
> 
> sys_rt_sigqueueinfo() allows to send any siginfo to yourself, but this is only needed
> for checkpoint/restart.

Yes, that's why this was added. I would leave it in exactly because of
checkpoint/restart. I have sympathies for "this [...] project by various
mad Russians" [1] and it doesn't really hurt us. :)

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=099469502f62fbe0d7e4f0b83a2f22538367f734

Christian
