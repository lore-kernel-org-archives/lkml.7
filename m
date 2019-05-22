Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A73C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E090B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scYBgQFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfEVQBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:01:47 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:37602 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:01:46 -0400
Received: by mail-ua1-f54.google.com with SMTP id t18so1056785uar.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSdosCg7CAf5I4ACWla5jsLhMewb72YTSpe4zJkcCao=;
        b=scYBgQFym9ROAnpR66sReozWPRXNqJVUFlss1Ng44ycb9HpxOlw8L7UQ1Va7t73uvb
         DFN4rwIbWJsovtJ2lO1jCcCjsv/llpFZh7teYPx3c/Yc+JplddZXqxpVfZbwzI5Xn/LU
         9roGRSVSkxgW4wDuxlB1LMucxNvX0+5VadelX4+ew/Ov8rX4CgCIijza9KX9Fco3/Nm2
         8SL7c5IzGLvFUIvWKZDylrdng3FZ1T4GjMPVuy0qw+C2IfwG28lOU6P6EUI6IMf2Wcqr
         rEI5XiismRDtzA7X6wixbeBYQUnhz83yCAmnWShusLcB2rHnAQpp3dkFTdpQFJWPHfmz
         Odiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSdosCg7CAf5I4ACWla5jsLhMewb72YTSpe4zJkcCao=;
        b=OuXzWPWJT/c8X7Av8gkZbpNkUXlI3TC94Xvnk2NbCZjkoyEfQ9n5WeDEvZly8Ci+Ow
         6U2cnO7IancdQYLimQBpp8SI/Yy2tDwlrNGXKqYeUjaDbFJ0Dm2cPziyuivSj8g3LHCR
         s0puTo5nJd+2VWuAREx4+1Xt/6a/Q4EXMWsVvCs0K6oe82HPrATyGW7J0rZcPUgTp3DB
         zOmM2OCK07Y6zcL9qu80uRaq5p7OZlHmMJdl3IhtStDyc6s/GVXapM2aQpOnUmmeuCDT
         NWrG2T2kx7GpbC4HPo3Nk13hkau/YZwqzCKfAVf8ryTWt5ySyWwHJ1JVdJ9I+PcvA4wC
         9lVw==
X-Gm-Message-State: APjAAAUCrw7Na++leZSYbpSSieSWL7teB+FKWqI9VAIHamjaZKB2nNif
        XC4k+snoxW+tW6gSWnKqf2sgYXwl2lv3cGSm9cMtpg==
X-Google-Smtp-Source: APXvYqxi2BZoiCj8jAFjAAZIHHrwShReaS6FEKzT0Pw5Kh4Zsg7Q1dxxKPve5INSlH18g3XyBmOg6fU4xTfpOx2B+bU=
X-Received: by 2002:ab0:1051:: with SMTP id g17mr10254083uab.41.1558540905237;
 Wed, 22 May 2019 09:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190521110552.GG219653@google.com> <20190521113029.76iopljdicymghvq@brauner.io>
 <20190521113911.2rypoh7uniuri2bj@brauner.io> <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
 <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
 <20190522145216.jkimuudoxi6pder2@brauner.io> <CAKOZueu837QGDAGat-tdA9J1qtKaeuQ5rg0tDyEjyvd_hjVc6g@mail.gmail.com>
 <20190522154823.hu77qbjho5weado5@brauner.io> <CAKOZuev97fTvmXhEkjb7_RfDvjki4UoPw+QnVOsSAg0RB8RyMQ@mail.gmail.com>
 <20190522160108.l5i7t4lkfy3tyx3z@brauner.io>
In-Reply-To: <20190522160108.l5i7t4lkfy3tyx3z@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 22 May 2019 09:01:33 -0700
Message-ID: <CAKOZuevR2WTbeFdvpx8K9jJj0Sc=wpNJKr24ePWsvE_WS5wgNw@mail.gmail.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Christian Brauner <christian@brauner.io>
Cc:     Minchan Kim <minchan@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 9:01 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Wed, May 22, 2019 at 08:57:47AM -0700, Daniel Colascione wrote:
> > On Wed, May 22, 2019 at 8:48 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Wed, May 22, 2019 at 08:17:23AM -0700, Daniel Colascione wrote:
> > > > On Wed, May 22, 2019 at 7:52 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > I'm not going to go into yet another long argument. I prefer pidfd_*.
> > > >
> > > > Ok. We're each allowed our opinion.
> > > >
> > > > > It's tied to the api, transparent for userspace, and disambiguates it
> > > > > from process_vm_{read,write}v that both take a pid_t.
> > > >
> > > > Speaking of process_vm_readv and process_vm_writev: both have a
> > > > currently-unused flags argument. Both should grow a flag that tells
> > > > them to interpret the pid argument as a pidfd. Or do you support
> > > > adding pidfd_vm_readv and pidfd_vm_writev system calls? If not, why
> > > > should process_madvise be called pidfd_madvise while process_vm_readv
> > > > isn't called pidfd_vm_readv?
> > >
> > > Actually, you should then do the same with process_madvise() and give it
> > > a flag for that too if that's not too crazy.
> >
> > I don't know what you mean. My gut feeling is that for the sake of
> > consistency, process_madvise, process_vm_readv, and process_vm_writev
> > should all accept a first argument interpreted as either a numeric PID
> > or a pidfd depending on a flag --- ideally the same flag. Is that what
> > you have in mind?
>
> Yes. For the sake of consistency they should probably all default to
> interpret as pid and if say PROCESS_{VM_}PIDFD is passed as flag
> interpret as pidfd.

Sounds good to me!
