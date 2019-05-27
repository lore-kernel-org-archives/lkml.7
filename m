Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB66BC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998F72070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558944383;
	bh=ECDp1Q1tYrIl2vqj/PbGQ12yLsqWrMNavq7uYECbZUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iW+zCRdLuYC7xHNRUTK+1VUcqOYGrTmtKXAurJbxWb+KNK75o/hyYARaZLQDIsDcA
	 ZdOZObB21O2bX/wWJ8R5KMF3rClXJiAf92Hyc4tdejLKIGvbe+Fs9pePzwrK7H9Rso
	 iHd5U6o5mJ97QLCQ771GBT3iV2qi7vl32bKaxgZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfE0IGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:06:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39279 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfE0IGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:06:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so6734097plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5rdJRMBeOB+xgTMZzJ1Pck6b2K6E2/69q0AHxR6+/s=;
        b=cvbLWTuIj7hifCDv34fIGfri4oZBxJy6aL2CNzKe9tHh3AdUqxPlw9JHMr/RmmAbCm
         LiNyDtBh3sTAw8Opw8Dx5pYuC0tS/9slXVrl7zo3Tp/pJ2eFCWw6asLPAZ2OVULhhbSl
         FxeJGvfma2snz5OPNYj625BHHYDG202pR+iBZAj8q0PRJFWHjkraE7F8JXYvd0t5ttCX
         lyi8aeH1gfmE6CwrURLqC4wfadIzFOxtuOBNSE4SZM3w1eVisSh6SJ0Ykh8V09rKDMRh
         8/wPskQB72rTjGRB+Qg59EyvF5PaL7rJcQeSW5LssbD+RkJY/7fXej16ibogoXQPi/F2
         v2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5rdJRMBeOB+xgTMZzJ1Pck6b2K6E2/69q0AHxR6+/s=;
        b=esR3kdbKnryvrIBqw1Tx/aPJ42TqVtYhd4mmou/d6JCLBNH3tGOA0tDJcvzQ9tOnPQ
         8LMy5d2VWVZY3NJ+7EL+qobcFUD984+ZxQ9nX/bOhMueN4Wxf5CyQBQXO601fMcRQfRH
         ZnKkfczOFZHU0vKCSxcZWbb2+pv5HHiKanZN3ihqgAOHNMY4dF4r859yMJy++ziqPXLR
         2OYRvte+cojdNIUBeXTlxkRh7IPdFs/8EfaKX95W/Bie3y9S6srDRIVkTVhvwLJkAorb
         mG6Lmj6DZUeTCtfBHIcFsQfOVzASAU9Tml7Hm8bTjONwAYLEgsbZkAVEIl16p+dIWXEt
         UUNw==
X-Gm-Message-State: APjAAAVEI3upyL/gweHQEGB5HEa7cfA8K3imtZfIIpWXERs6nT/TcRrD
        GsmX4MxbkTiadGy/SZufSJE=
X-Google-Smtp-Source: APXvYqwGWTw0Hz7UkOv1TdhxRBDpDuc+1RV/rzH0FQlL8BvuDueyqIKjhlzyrClYaMah75xYTqt2OQ==
X-Received: by 2002:a17:902:f212:: with SMTP id gn18mr64846228plb.106.1558944381799;
        Mon, 27 May 2019 01:06:21 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id t15sm10712248pjb.6.2019.05.27.01.06.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 01:06:19 -0700 (PDT)
Date:   Mon, 27 May 2019 17:06:14 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190527080614.GD6879@google.com>
References: <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
 <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
 <20190522145216.jkimuudoxi6pder2@brauner.io>
 <CAKOZueu837QGDAGat-tdA9J1qtKaeuQ5rg0tDyEjyvd_hjVc6g@mail.gmail.com>
 <20190522154823.hu77qbjho5weado5@brauner.io>
 <CAKOZuev97fTvmXhEkjb7_RfDvjki4UoPw+QnVOsSAg0RB8RyMQ@mail.gmail.com>
 <20190522160108.l5i7t4lkfy3tyx3z@brauner.io>
 <CAKOZuevR2WTbeFdvpx8K9jJj0Sc=wpNJKr24ePWsvE_WS5wgNw@mail.gmail.com>
 <20190523130717.GA203306@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523130717.GA203306@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:07:17PM +0900, Minchan Kim wrote:
> On Wed, May 22, 2019 at 09:01:33AM -0700, Daniel Colascione wrote:
> > On Wed, May 22, 2019 at 9:01 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Wed, May 22, 2019 at 08:57:47AM -0700, Daniel Colascione wrote:
> > > > On Wed, May 22, 2019 at 8:48 AM Christian Brauner <christian@brauner.io> wrote:
> > > > >
> > > > > On Wed, May 22, 2019 at 08:17:23AM -0700, Daniel Colascione wrote:
> > > > > > On Wed, May 22, 2019 at 7:52 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > I'm not going to go into yet another long argument. I prefer pidfd_*.
> > > > > >
> > > > > > Ok. We're each allowed our opinion.
> > > > > >
> > > > > > > It's tied to the api, transparent for userspace, and disambiguates it
> > > > > > > from process_vm_{read,write}v that both take a pid_t.
> > > > > >
> > > > > > Speaking of process_vm_readv and process_vm_writev: both have a
> > > > > > currently-unused flags argument. Both should grow a flag that tells
> > > > > > them to interpret the pid argument as a pidfd. Or do you support
> > > > > > adding pidfd_vm_readv and pidfd_vm_writev system calls? If not, why
> > > > > > should process_madvise be called pidfd_madvise while process_vm_readv
> > > > > > isn't called pidfd_vm_readv?
> > > > >
> > > > > Actually, you should then do the same with process_madvise() and give it
> > > > > a flag for that too if that's not too crazy.
> > > >
> > > > I don't know what you mean. My gut feeling is that for the sake of
> > > > consistency, process_madvise, process_vm_readv, and process_vm_writev
> > > > should all accept a first argument interpreted as either a numeric PID
> > > > or a pidfd depending on a flag --- ideally the same flag. Is that what
> > > > you have in mind?
> > >
> > > Yes. For the sake of consistency they should probably all default to
> > > interpret as pid and if say PROCESS_{VM_}PIDFD is passed as flag
> > > interpret as pidfd.
> > 
> > Sounds good to me!
> 
> Then, I want to change from pidfd to pid at next revsion and stick to
> process_madvise as naming. Later, you guys could define PROCESS_PIDFD
> flag and change all at once every process_xxx syscall friends.
> 
> If you are faster so that I see PROCESS_PIDFD earlier, I am happy to
> use it.

Hi Folks,

I don't want to consume a new API argument too early so want to say
I will use process_madvise with pidfs argument because I agree with
Daniel that we don't need to export implmentation on the syscall name.

I hope every upcoming new syscall with process has by default pidfs
so people are familiar with pidfd slowly so finallly they forgot pid
in the long run so naturally replace pid with pidfs.
