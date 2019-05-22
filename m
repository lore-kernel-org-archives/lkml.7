Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B00C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C01B20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Xt/t8fO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfEVQBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:01:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41620 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:01:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so2905863wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fuynlKhllfIeQm52cXMWcD0lUs6CispzZaQZtwuYuAg=;
        b=Xt/t8fO/1a/GpjPYTtXUr5AFRVjDBYkZmO5Ma1d5Z4Y7booTaJs+tYhgg7B1Hhhv5M
         RQg5GVXm9Sk6FUf1hmMBWGrEmSWDPyAivd8s6isQZ0ZrwZk9/3n/ypCKK6lE8tlQmyYf
         yIzxa0rS3JKH84++TLbteyVEjEWHRwAJL/hA//PRCYGdXj6YSGbMXXfzt16FLkUs5wOR
         rUtyGvhrdu4a+ppko+BiMNLr8W7BBuhX+I9ikxYy4JgrPOngOJ20vo3YHVtSKknC+EHZ
         lrK2WsWl+oc+9k7kAcEFYMtBgOcVBhlvDYJ+ggv1EdfN5Wfp4ppRdMe4qZrSXrKiyr1w
         F2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fuynlKhllfIeQm52cXMWcD0lUs6CispzZaQZtwuYuAg=;
        b=pByG4rJKFZrh+wkvd65U52m9agKm6K34PaKW/gHc2hNI7XwLEWkofzSKnoOF1IxPhY
         0VAXcO/usNXku5jJkJ95nfjjYRwFWfrxQrxXjYSH3mNac24IA99PrF9Qep8+lF6ShjRh
         37d98hiq8GWI3t/yuIbl0IpnQPKyu3zFPvz0UnrjEQm3abchSeqHVXR8gxPEPai6x8O7
         3ygcM37kX5b4E+dLt3RIm07B1SLTOTP6KN9GCpXGdcI/mN0Agg6BTK9BsN2zOmh7r7Le
         udY7OTmoc94iS5ISftGf6C1UuSnSW68Q5YfRCB6fdqIMprNDrbeRuGa7ZCicJfuUwwo/
         IM9Q==
X-Gm-Message-State: APjAAAW4cTz1Y0UJKhf1JeIhGptwF6hm6i/AsvJb4jc1uhjt3XRcMpIK
        ZNNkP2ua9UN1XkGVW8fNj9IwJA==
X-Google-Smtp-Source: APXvYqzeqkgWRWxY32f4i08YJhohV1p2HVc+Y20YULwQSETBfkni16XErxYOS6q6dHcenp/CA5kJew==
X-Received: by 2002:a5d:4cd0:: with SMTP id c16mr28980251wrt.20.1558540871772;
        Wed, 22 May 2019 09:01:11 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id y17sm22149428wrp.70.2019.05.22.09.01.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 09:01:11 -0700 (PDT)
Date:   Wed, 22 May 2019 18:01:09 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
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
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190522160108.l5i7t4lkfy3tyx3z@brauner.io>
References: <20190521110552.GG219653@google.com>
 <20190521113029.76iopljdicymghvq@brauner.io>
 <20190521113911.2rypoh7uniuri2bj@brauner.io>
 <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
 <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
 <20190522145216.jkimuudoxi6pder2@brauner.io>
 <CAKOZueu837QGDAGat-tdA9J1qtKaeuQ5rg0tDyEjyvd_hjVc6g@mail.gmail.com>
 <20190522154823.hu77qbjho5weado5@brauner.io>
 <CAKOZuev97fTvmXhEkjb7_RfDvjki4UoPw+QnVOsSAg0RB8RyMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuev97fTvmXhEkjb7_RfDvjki4UoPw+QnVOsSAg0RB8RyMQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 08:57:47AM -0700, Daniel Colascione wrote:
> On Wed, May 22, 2019 at 8:48 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Wed, May 22, 2019 at 08:17:23AM -0700, Daniel Colascione wrote:
> > > On Wed, May 22, 2019 at 7:52 AM Christian Brauner <christian@brauner.io> wrote:
> > > > I'm not going to go into yet another long argument. I prefer pidfd_*.
> > >
> > > Ok. We're each allowed our opinion.
> > >
> > > > It's tied to the api, transparent for userspace, and disambiguates it
> > > > from process_vm_{read,write}v that both take a pid_t.
> > >
> > > Speaking of process_vm_readv and process_vm_writev: both have a
> > > currently-unused flags argument. Both should grow a flag that tells
> > > them to interpret the pid argument as a pidfd. Or do you support
> > > adding pidfd_vm_readv and pidfd_vm_writev system calls? If not, why
> > > should process_madvise be called pidfd_madvise while process_vm_readv
> > > isn't called pidfd_vm_readv?
> >
> > Actually, you should then do the same with process_madvise() and give it
> > a flag for that too if that's not too crazy.
> 
> I don't know what you mean. My gut feeling is that for the sake of
> consistency, process_madvise, process_vm_readv, and process_vm_writev
> should all accept a first argument interpreted as either a numeric PID
> or a pidfd depending on a flag --- ideally the same flag. Is that what
> you have in mind?

Yes. For the sake of consistency they should probably all default to
interpret as pid and if say PROCESS_{VM_}PIDFD is passed as flag
interpret as pidfd.
