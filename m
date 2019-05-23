Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74368C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421A120851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558616846;
	bh=52mWiuShVbTZ/oNwM+RtBBQnGTdr8im3ML9tCIRVIwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GY8Gqes6F/g5xgBpI5LelxaXfHCm46Blki7hQ0c3Ulx5iHmnbz7vSAyTb7K2QJrap
	 0gpS6sykSsJkmjqewzgGN7LozfMwSfOIloVJmL5eOSG0iy1edj0/GjInt+9YcFmU4T
	 twyFEE/oyXZ8frqgfGR7S5kPbwbRTK6QDYf2Flsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfEWNHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:07:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38545 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfEWNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:07:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id b76so3222991pfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s9xCy18W59wKBWAvDaH6JYHoJT0+JbJc9ipAphcb2DM=;
        b=ljJU6suYXw3oRrTgoSVmjqUkCXi1M6cW8rzJN3n8+YRKzycDEPVDeKYbXn3/mMprqa
         fC16A8wn7VpuAGkN1uBB3G/k9Mjokt5JkLynZHE2vAkh9w/7owa46EWLrkiYt3tPegfL
         MWqz1Ug9XJL48A1GMq21a5uM9NYw3fplKybZZ6lS7T3TPwpM/5nfKV82w0Nbq8dzdyT2
         8Ahz/g2EZLckDjc587U1x5xNYmSxKRr73V8NLM7cngHFhsq1GU1Hou6Q/5IbjyhY8cEn
         ifwbNanA59oiVsd5rYAoHRmp/C3UqusAPv3tPAbERw00p/1IEjtQIkGw96Wng4n34vo+
         jmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s9xCy18W59wKBWAvDaH6JYHoJT0+JbJc9ipAphcb2DM=;
        b=QXthUZSpZlu3BgvatjbS3Fx23GV/1Us7ujhLdj8OdzzUdzij14DfAtUFT4BZwdn0aw
         TCiFYxPh58RdZagvEgkmk5a9V0p8nRi4g78Ts5NWGDD2CsHJcrbN9oIb8UUEojzH4FHc
         yy5vSY3/vGzEIZVcb+8CRy9L3KG6//l3JCwAhhYkrdYi3Fwa/29+yQwQGoJKptCL39bk
         Bu3j+k9JBsRs7CO6V+7GqL+KehhaPf+D5dSZ6OiHec741265oySKe46NEtHJGPM9Nw4p
         2lxU0ay/Y0K3mmOmhdPXbLOK5pZo6Vws4yMz78+Zky933bpU8qbRYyBoqTshO3GCrYdA
         Qiqw==
X-Gm-Message-State: APjAAAUgEtSwo4DXGw/D5gQb+zTid3NGsHLjGxwEbzsfDBe8433f7xZc
        ToZz89/c4vE/GjL/4JRKA88=
X-Google-Smtp-Source: APXvYqwOrAosXxrN7lYZl1zDX9p1VHy989m4OxZl4V043iIEU+gL/oZsLZGr/sDCZOW1bvXAmmDLhA==
X-Received: by 2002:a17:90a:8e86:: with SMTP id f6mr966074pjo.66.1558616844214;
        Thu, 23 May 2019 06:07:24 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j72sm654518pje.12.2019.05.23.06.07.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 06:07:22 -0700 (PDT)
Date:   Thu, 23 May 2019 22:07:17 +0900
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
Message-ID: <20190523130717.GA203306@google.com>
References: <20190521113911.2rypoh7uniuri2bj@brauner.io>
 <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
 <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
 <20190522145216.jkimuudoxi6pder2@brauner.io>
 <CAKOZueu837QGDAGat-tdA9J1qtKaeuQ5rg0tDyEjyvd_hjVc6g@mail.gmail.com>
 <20190522154823.hu77qbjho5weado5@brauner.io>
 <CAKOZuev97fTvmXhEkjb7_RfDvjki4UoPw+QnVOsSAg0RB8RyMQ@mail.gmail.com>
 <20190522160108.l5i7t4lkfy3tyx3z@brauner.io>
 <CAKOZuevR2WTbeFdvpx8K9jJj0Sc=wpNJKr24ePWsvE_WS5wgNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevR2WTbeFdvpx8K9jJj0Sc=wpNJKr24ePWsvE_WS5wgNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 09:01:33AM -0700, Daniel Colascione wrote:
> On Wed, May 22, 2019 at 9:01 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Wed, May 22, 2019 at 08:57:47AM -0700, Daniel Colascione wrote:
> > > On Wed, May 22, 2019 at 8:48 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On Wed, May 22, 2019 at 08:17:23AM -0700, Daniel Colascione wrote:
> > > > > On Wed, May 22, 2019 at 7:52 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > > I'm not going to go into yet another long argument. I prefer pidfd_*.
> > > > >
> > > > > Ok. We're each allowed our opinion.
> > > > >
> > > > > > It's tied to the api, transparent for userspace, and disambiguates it
> > > > > > from process_vm_{read,write}v that both take a pid_t.
> > > > >
> > > > > Speaking of process_vm_readv and process_vm_writev: both have a
> > > > > currently-unused flags argument. Both should grow a flag that tells
> > > > > them to interpret the pid argument as a pidfd. Or do you support
> > > > > adding pidfd_vm_readv and pidfd_vm_writev system calls? If not, why
> > > > > should process_madvise be called pidfd_madvise while process_vm_readv
> > > > > isn't called pidfd_vm_readv?
> > > >
> > > > Actually, you should then do the same with process_madvise() and give it
> > > > a flag for that too if that's not too crazy.
> > >
> > > I don't know what you mean. My gut feeling is that for the sake of
> > > consistency, process_madvise, process_vm_readv, and process_vm_writev
> > > should all accept a first argument interpreted as either a numeric PID
> > > or a pidfd depending on a flag --- ideally the same flag. Is that what
> > > you have in mind?
> >
> > Yes. For the sake of consistency they should probably all default to
> > interpret as pid and if say PROCESS_{VM_}PIDFD is passed as flag
> > interpret as pidfd.
> 
> Sounds good to me!

Then, I want to change from pidfd to pid at next revsion and stick to
process_madvise as naming. Later, you guys could define PROCESS_PIDFD
flag and change all at once every process_xxx syscall friends.

If you are faster so that I see PROCESS_PIDFD earlier, I am happy to
use it.

Thanks.
