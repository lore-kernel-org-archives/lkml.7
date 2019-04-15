Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F07C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0597420883
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dhB9HCr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfDOLmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:42:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37351 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfDOLmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:42:16 -0400
Received: by mail-it1-f194.google.com with SMTP id u65so26053383itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVSPkvt9BqtnPlPL39TJHMRVFb8x0A01KTK+jYGWGsg=;
        b=dhB9HCr6Qpn52S4osyplpy49jFsOV4SLfupn7LDbKBuaQ22jERlQ1O1ZRAbY4JUEgV
         rmnpgaXda4P4j/PHZKlo/Cn6JR7TUX8cFmvx4exoufyeQCnaHDo0OS4BwF6tsX1spHoJ
         Rpn7+7adfs+Gdw0j/2voVJcYDptVGNyUTyb55sGG2V31WbvssxxndzFYLRK/7pHvQr13
         cfhQH+P7gXFgmXy6ylU+VCIDLfJt9qO/U/rjCiYhQ8R16MNHQbw2igtCIS3rCG/rjMzm
         fL7LzQ4U/D4fmkfClgLSXPI890y0T8iheaytBdYl40djQXGX7wNEMq9jfGxMuJBwPSg0
         bGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVSPkvt9BqtnPlPL39TJHMRVFb8x0A01KTK+jYGWGsg=;
        b=ar2goth7mwIIZ87S2zj3j3qvFsynAbNKCpXyMUgIO+JBe5LRwhifXK6ixLXRfVgkBk
         4u5fJHmmDcPl83IVzEtTxjc1JEpJ+aZYOKmx4DcDZ0vuQpwZLcgmzSQ1KRp9TgBH9lcU
         lOLdbxU90ukJDtWGbL1dAYLTFdgUw7oKK/yPCBZ8C9U2ewlzZKF7dMSmCZxaEYdFYM5S
         Ivke3MuFLeAuhgXM2K64ula36aM/KPo826j034XeDe/6KIeS50MccO7glQ0C3w2HdMxp
         re5xEB5niopdedQG/SOP95u6SW4maUPf8ScPfFzSs21qNlfBQQEuXajaAQDFYCnosgtp
         b3eQ==
X-Gm-Message-State: APjAAAUawj018ndC3YkAiVxGjGYium5/xiv73+7j0/Ffo3mjFeEAwEQ2
        ytpITKrKhF6NBe6RFqNdKQg7Ww==
X-Google-Smtp-Source: APXvYqwVkXN4/my6NSbSZOdKn3MDfHHgdq2dzmwdcwfEOKd1CmFH5fSwZveaXy8GAS0XB9g6s9Da7Q==
X-Received: by 2002:a24:2e0a:: with SMTP id i10mr21474472ita.162.1555328535032;
        Mon, 15 Apr 2019 04:42:15 -0700 (PDT)
Received: from brauner.io ([208.54.80.237])
        by smtp.gmail.com with ESMTPSA id v19sm18858196iol.27.2019.04.15.04.42.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Apr 2019 04:42:14 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:42:06 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH 2/4] clone: add CLONE_PIDFD
Message-ID: <20190415114204.ydczeuwmi74wfsuv@brauner.io>
References: <20190414201436.19502-1-christian@brauner.io>
 <20190414201436.19502-3-christian@brauner.io>
 <20190415105209.GA22204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415105209.GA22204@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 12:52:09PM +0200, Oleg Nesterov wrote:
> On 04/14, Christian Brauner wrote:
> >
> > @@ -2260,6 +2363,10 @@ long _do_fork(unsigned long clone_flags,
> >  	}
> >
> >  	put_pid(pid);
> > +
> > +	if (clone_flags & CLONE_PIDFD)
> > +		nr = pidfd;
> > +
> 
> Well, this doesn't look nice ...
> 
> CLONE_PARENT_SETTID doesn't look very usefule, so what if we add
> 
> 	if ((clone_flags & (CLONE_PIDFD|CLONE_PARENT_SETTID)) ==
> 	                   (CLONE_PIDFD|CLONE_PARENT_SETTID))
> 		return ERR_PTR(-EINVAL);
> 
> at the start of copy_process() ?
> 
> Then it can do
> 
> 	if (clone_flags & CLONE_PIDFD) {
> 		retval = pidfd_create(pid, &pidfdf);
> 		if (retval < 0)
> 			goto bad_fork_free_pid;
> 		retval = put_user(retval, parent_tidptr)
> 		if (retval < 0)
> 			goto bad_fork_free_pid;
> 	}

Uhhh Oleg, that is nifty. I have to say I like that a lot. This would
let us return the pid and the pidfd in one go and we can also start
pidfd numbering at 0.
