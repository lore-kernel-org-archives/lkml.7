Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B237FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E48204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bKRxHrWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfDQONO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:13:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35872 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfDQONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:13:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so3825043wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PaFbFt0d9eGXDX6m1UWhtov90KWEce3ZD19fSf2vJJ4=;
        b=bKRxHrWRrwnXEgsMDZ3ikLRkZn2bMwnbtO4WrhawvTWqA/CQJS9rhWJlvD8QJ2/cSA
         nd7XW/W/N6toy4ylRAqcs76U4TbIFT3+dr7ft6EKJYCt89zB2g/PSvf3hPHj8sar9713
         VQAssExbc63Ixx2vrZxP/v9eRgU/maX/s+RjKwXS5K6iWbElGiM4sABvCDwG2Nh2M3TC
         ruxvUOgumtILOr9ANMwQVMD3dZtqPpqUzXFG7dewCQWmyt9OpKWm4uEfjsXUEWOXLJSA
         nr4erQbOU8vG4UADZhxOIWmxdwQRYuXuDklDIxpsDJlsh0ufCOkQqrW3ydbOKc7aYtWO
         7CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PaFbFt0d9eGXDX6m1UWhtov90KWEce3ZD19fSf2vJJ4=;
        b=EqBgSVdVTcfimM5ToZ2M++f5NFhQUnHCsWnNRxNMEcQCNpbcw8K3rCcXmUSU55mQuE
         l2GCUcAmvZCJBdcAbAYj/QVMWSzhuG7n7V5hfu50/AJcYnXPrOYoAXnogz3Po36WR7Kk
         OTJ0jznMSOTTEC3u4R+1DeQmReHNqtqe5Z0RXIhXUB7/5l0e2eyCQTq++scA2WKuZiND
         1h63aILQflx92ODc6nnIKSCAvCCTVNipYMg2SwJcCLPjRamp2RDC/Lgon6dV4YsfwLzj
         beV0cDeAZoGRTAEOodtkUzSm9HYGCuxlYYcsH2Hkp/u614DtvmvAn1e+tENfmU4+wXzy
         mkFg==
X-Gm-Message-State: APjAAAVsCQcyr/6bNzSFwk7SgzJMKELl/5MmensGBQYjMJKRkqMQ9dv+
        Gm+yQpHl+cG9N54imukijb7vXg==
X-Google-Smtp-Source: APXvYqyc0qIrgUl6FNV2C7xhYrs65TT3uNB5y3+5XhRDfYuZpVYJEjmEN/mJ6rSRmN6bgr45O0/qOg==
X-Received: by 2002:a1c:3982:: with SMTP id g124mr30913738wma.25.1555510391643;
        Wed, 17 Apr 2019 07:13:11 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id k9sm81609241wru.55.2019.04.17.07.13.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 07:13:10 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:13:09 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: don't silently convert SI_USER signals to
 non-current pidfd
Message-ID: <20190417141308.mpkkhy3sbw5e5hew@brauner.io>
References: <20190330021232.191205-1-jannh@google.com>
 <20190408131315.GA24111@redhat.com>
 <20190417130336.i55vmf3x6cby2mvi@brauner.io>
 <20190417131602.GE32622@redhat.com>
 <20190417131904.qjkv2xuenhcsz36l@brauner.io>
 <20190417135002.GF32622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417135002.GF32622@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:50:03PM +0200, Oleg Nesterov wrote:
> On 04/17, Christian Brauner wrote:
> >
> > On Wed, Apr 17, 2019 at 03:16:03PM +0200, Oleg Nesterov wrote:
> > > On 04/17, Christian Brauner wrote:
> > > >
> > > > On Mon, Apr 08, 2019 at 03:13:16PM +0200, Oleg Nesterov wrote:
> > > > >
> > > > > but perhaps it should always fail, even if task_pid(current) == pid.
> > > > >
> > > > > sys_rt_sigqueueinfo() allows to send any siginfo to yourself, but this is only needed
> > > > > for checkpoint/restart.
> > > >
> > > > Yes, that's why this was added. I would leave it in exactly because of
> > > > checkpoint/restart.
> > >
> > > I don't understand...
> > >
> > > c/r doesn't need this "feature" in pidfd_send_signal(), so it can be removed.
> > > But,
> >
> > Just out of curiosity: in what sense? They don't need it since they have
> > other ways of doing this
> 
> Yes. The restarting process needs to "restore" the pending signals, including the
> signals with si_code >= 0. It does this using tgsigqueueinfo() and that is why we
> allow this if the signal sent to itself.
> 
> So criu simply doesn't need pidfd_send_signal() to do this. And at the same time,
> 
> > or they *can't* use it for some other reason
> 
> Yes again. pidfd_send_signal() does kill_pid_info(), so it can't be used to restore
> the "per-thread" task->pending signals.

In the future pidfd_send_signal() will gain the flag
PIDFD_SIGNAL_THREAD. Jann and I already have a patch for this but we're
holding off until the need arises.

Christian
