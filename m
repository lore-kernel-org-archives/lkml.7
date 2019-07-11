Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930CC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3620E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562887372;
	bh=BsS8WXkyVQqLJJoPLix1RfAHy7JDHhNbdGzfxl9kzbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T6SFcNwUt1ek3NgXPH4iJhqCzdCIzLbEddBtnoLZAiffzRwhFdwfGY7DHcWdyM/cs
	 U20mYvOKAQ6lcUJf2wLvh6qUZd9r0Y2z/FUJntLZ6UfUwijLOk+D3s/c1K2Akug2jf
	 Rx2xnGOiilwYtdnAuz6pTWS580mhfF1uHqjsed0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfGKXWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:22:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38627 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKXWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 19:22:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so3643836pgz.5;
        Thu, 11 Jul 2019 16:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=awhhz6qXxE2/Ku1LM8KuoCP6ANstzt97mmMZ+S4Y7RI=;
        b=LNQfPo+dzhyvixyIaCr6b1e3yW/TnirndT7NLWInbbRK/Qc0qDOQfl8TzGWiQMD8rV
         skFVaUDUK7ZX+7yrg8Zd+6vkNAaeIAdxz0al57wO2E5WJTL8Wy8hIBb9wmIgTYdZQsrS
         eIXIK6JF4UNAXjMBnEEl3nOn1vyR2y4lwNAOcUJqsbeH/tLQaO994ke1tt3akQqJHNg4
         QgjHunKmn9Fw8V5uti3XxQC0S7qBPek77Jn8MjCtYkDhtny4TwbRp9SwylojMdGZhOj4
         ZsSviytGW1vqXOBgtlQxUDK3Ikz02SJfKSoMTabciFFUB0TuG/r0JABBR1NNmzn5SLtk
         V1gQ==
X-Gm-Message-State: APjAAAXs0EA2LuKktlRgkqneRneB5lxvuPgs9+aIy8+XzH64yYuf0ZO9
        BtIqPwqI/uP56hkjM6aGOo0=
X-Google-Smtp-Source: APXvYqz73jqoB43YbXWjZZV8qOI5bPj68FFnIkCPO4uk5l+dUFOQW78pG61lTc7oNrGvs9SvGeSV4w==
X-Received: by 2002:a17:90a:a008:: with SMTP id q8mr7799354pjp.114.1562887369477;
        Thu, 11 Jul 2019 16:22:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z68sm6294355pgz.88.2019.07.11.16.22.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:22:48 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8CEC1402A1; Thu, 11 Jul 2019 23:22:47 +0000 (UTC)
Date:   Thu, 11 Jul 2019 23:22:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Daniel Jonsson <danijons@student.chalmers.se>,
        Andrzej Wasowski <wasowski@itu.dk>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
Message-ID: <20190711232247.GH19023@42.do-not-panic.com>
References: <CAB=NE6XEnZ1uH2nidRbn6myvdQJ+vArpTTT6iSJebUmyfdaLcQ@mail.gmail.com>
 <20190627045052.GA7594@lst.de>
 <CAB=NE6Xa525g+3oWROjCyDT3eD0sw-6O+7o97HGX8zORJfYw4w@mail.gmail.com>
 <20190629084257.GA1227@kroah.com>
 <20190702205106.GR19023@42.do-not-panic.com>
 <20190703074048.GH3033@kroah.com>
 <20190703165020.GV19023@42.do-not-panic.com>
 <20190703185758.GB14336@kroah.com>
 <20190703222531.GX19023@42.do-not-panic.com>
 <CAFd5g45nGf-abwtNzSOo8suGyhzTEEQbiq7yNCS8XoO4ezA=UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g45nGf-abwtNzSOo8suGyhzTEEQbiq7yNCS8XoO4ezA=UQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 04:07:27PM -0700, Brendan Higgins wrote:
> On Wed, Jul 3, 2019 at 3:25 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Jul 03, 2019 at 08:57:58PM +0200, Greg Kroah-Hartman wrote:
> >
> > But again, this is a separate problem. The one I am addressing, on
> > behalf of Cristina, is a subspace, dedicated towards *hardware*
> > functionality.
> 
> Hmm...maybe this isn't what I am looking for then. I am interested in
> the problem of figuring out what dependencies I need to select to turn
> on a desired config symbol (which is obviously a separate issue),

It isn't directly. the problem statement is different, and
for that I do recommend checking out the kconfig-sat effort.

It only indirectly relates in that we already know our kconfig
semantics need work, and I do think that the underlying problem
in this thread slowly strives towards addressing kconfig semantics
for modules, associating one main kconfig symbol with one module.

I have no evidence for this though. But since there are users who can
gain from it, I don't see any issues from embracing it.

> and
> I am interested in associating symbols with a config symbol and then
> ensuring that symbol is exercised. Basically, I want a way to make
> sure my tests actually get run without a human looking at them; I feel
> like what you are working on might help with this latter issue, but I
> am not 100% sure. It sounds like it is not your primary goal in any
> case.

Nope, this topic only ralates to yours in the semantics case.

  Luis
