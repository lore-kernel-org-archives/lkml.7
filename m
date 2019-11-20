Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4295C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7932422445
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574258740;
	bh=5KTr67YP0D49i683PBjz5C/VcWminZ5Se+TkPk5SnJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sBT55cvvAZU3ZPFl58YD8FL9fua7LW2RcdaDKznUJg6jpfv7XkrPADnOmdbefOTZy
	 g2SnvLuhnMM0raovyQ9ghkVdtqVPjKxjSA2Njawa/KUewJ7JeJu0tSxacNgXKCV/pq
	 Iym+t6X6ZRAW//uHZpLRcAYMwxWfJOd0Jw9Nh2x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfKTOFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:05:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39629 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbfKTOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:05:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so28300729wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=atKc4wFg2avE5ihR53QhLHb9twQIjMQuT8kQFJO4FJc=;
        b=kR6ot/WzuNefLYyL0/50ZFL1iM+uo0C8kHbCZZG2M0B833bjpCPT51Kmp74FLqNViJ
         AL8ofzPvWAUkwnTnVTgw0SWiv/v8irAEbs4HDhUxUmMnpOAPVcoDzd+G50Cj5UDgIU8L
         t9LNgqAzQuWdLTyaIVRtZ7tpnbsQUcFtDZs5304ZDkgOXhacfImOosRy7rYOYmtXkc08
         v3UL4/Wa1sXzvIp82qaFYuQ1ptXr1EHmANqkQMdWiiOAzCemdhUOEAxypKDx/IGihApz
         3dBIDAheybZYRdtUULIFzwOicOiKIS5OOHqpgT3saklzvT2xsYQxcvsmljFhdLQkMIDn
         sQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=atKc4wFg2avE5ihR53QhLHb9twQIjMQuT8kQFJO4FJc=;
        b=RCnVHYUHb/s2eV4MTkUmQ4CV8FjIF0rAvdDux0r3O6WoTm9UoI41Ws50XxVxVE2Wtz
         ObJC0YcIicmMwYGygtuwDYl+mYkDLGyGZjuJnJH0k/PMF8wfUUsOBTb5kYHcuj065Msq
         WpR2bW+Z2QAzmVGZ+OE7Go05FgfN9Gqdu9efrm8bvuLObSD3UOy9HhiAsqBIja5AclLg
         dCxMlrqOjhttpCZmqeK6yllPQ30oFAngamL7lMy3gSqpSZ+n/wGB3/szFlY+GDaQbHwo
         AJzchJkW5og1L3UcOPvye3Gx7jMNW7eabR+hiIm6DVceHHnIVgND7IbLaf/l6dPYKhnM
         WONw==
X-Gm-Message-State: APjAAAXeNZG+HU9t23in3Wk0TF4Q/NgzqZ3iTi8s41FczxWITm3N5U6A
        TlljGWnKU5S4HfVHpp9TQuY=
X-Google-Smtp-Source: APXvYqzKFQ3NDhXrH/Wj+yQ9Ulkexf8CdqcJ9zZ9jFjNrkCosDDpY4faR/PUT6alO4DcF2zEy5T+5Q==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr3708406wrs.329.1574258735195;
        Wed, 20 Nov 2019 06:05:35 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g4sm30102476wru.75.2019.11.20.06.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:05:34 -0800 (PST)
Date:   Wed, 20 Nov 2019 15:05:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120140532.GA12695@gmail.com>
References: <20191120103613.63563-1-jannh@google.com>
 <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com>
 <20191120112408.GC2634@zn.tnic>
 <CAG48ez26RGztX7O9Ej5rbz2in0KBAEnj1ic5C-8ie7=hzc+d=w@mail.gmail.com>
 <20191120131627.GA54414@gmail.com>
 <CAG48ez0KscmTLf2_-tYPuoAxRjJtzUO8kmAPQ_SZTP1zvqvTtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0KscmTLf2_-tYPuoAxRjJtzUO8kmAPQ_SZTP1zvqvTtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jann Horn <jannh@google.com> wrote:

> On Wed, Nov 20, 2019 at 2:16 PM Ingo Molnar <mingo@kernel.org> wrote:
> > * Jann Horn <jannh@google.com> wrote:
> >
> > > On Wed, Nov 20, 2019 at 12:24 PM Borislav Petkov <bp@alien8.de> wrote:
> > > > On Wed, Nov 20, 2019 at 12:18:59PM +0100, Ingo Molnar wrote:
> > > > > How was this maximum string length of '90' derived? In what way will
> > > > > that have to change if someone changes the message?
> > > >
> > > > That was me counting the string length in a dirty patch in a previous
> > > > thread. We probably should say why we decided for a certain length and
> > > > maybe have a define for it.
> > >
> > > Do you think something like this would be better?
> > >
> > > char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
> >
> > I'd much prefer this for, because it's a big honking warning for people
> > to not just assume things but double check the limits.
> 
> Sorry, I can't parse the start of this sentence. I _think_ you're
> saying you want me to make the change to "char desc[sizeof(GPFSTR) +
> 50 + 2*sizeof(unsigned long) + 1]"?

Yeah, correct. There was an extra 'for' in my first sentence:

> > I'd much prefer this, because it's a big honking warning for people
> > to not just assume things but double check the limits.

Thanks,

	Ingo
