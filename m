Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB0BC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A37218BB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562316557;
	bh=vfS7nPLg6sCrL2B+rt8skra+G0NbSflpV/OTg6/QuYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TKEjpEY0hB4BD7Y2LuRye+OHGfxCZilrbTdenUAqiGAbOzdi/qyP7dbRk492ixfBN
	 q/9367xgrEIOl6TQspKPzN3U2JW5wZoIOrT6KXvjmuKmNHeAqSl9LBSJ1pcasV0JO0
	 6E3eefwIRuusjdB2znbnfqsIci9sJtX3XiqvF6FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfGEItQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:49:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54087 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfGEItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:49:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so7996929wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lc4vFjLeaNpLcmbkEFfbqTJWOFEN/FjHGXndTctO/zI=;
        b=BVjqtNL/NGugxe7A7Bz+NjfTLwK7CGKp4EZlZ4i34oBk8OVulQiD/+kEN3b/XtSQCA
         JtKBFXh6BLGNU2FGRmc4i5IeK/1BAQDwKib/3iBbCbmbx8h/gaC+PHA85txuEdyjeh9y
         824RWH7F8j2+4AT0ZWyq5ulRDMO/uyztxCaA3qi3qu6dxn5ECCOqWzRHkPCWpuHyYz++
         2g+Z2a/IAhaZI7CCj/7p3nNHWgHdfW1Sp4dYu/wLnT4Xph4OKdwDWJPnkevZl2vmobAw
         /9aY9Y3AQoyCg/pOytBTZtxsxAOJbg8bDuthURVioS05VgmcVU2kzIfNxLQXBCDoccuL
         hUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lc4vFjLeaNpLcmbkEFfbqTJWOFEN/FjHGXndTctO/zI=;
        b=gP7pOVPR2ZHvQtNVBaeU/eFFqJskQJoWQmC1qBywdCpn+5Y/ET9bJueGYwaV2qPMHk
         UTuZwWebMANYtoOmh0rhbUuT47Ve0gAjgSxEdv/NfcRm+/VIpzTib5UKhrTawQ8p7V+2
         xkNHgKQwXEFbn1+0YYqXCjD4PZf/5DQ5qXqYq6yrZDjuky0f7F38k8KJwVD4Wq3a5Qao
         /W9kEABRgj7OHOI6Vm/JrP60IqhO2YM1nCMSMGqIIX46hsnEFyj4chBq2YSLme3I9EBo
         OcGO2Pn+EvKMlmVOadE23eD9FPWRhK6zoczv4xNgv45li+TpWwFRvrPzK3kMALoduJPa
         dSeQ==
X-Gm-Message-State: APjAAAWrdR8n8387rOW70wCDmZ1L+eL8VAH2aOd8DNIhW4sg3XYS8Ril
        mbSbRPbNoJ964tJTwXL7tuPG+Wru
X-Google-Smtp-Source: APXvYqz3r6zkDg40vRnke1vGHLJE2LBf0Lcdp9dwZrstzO5snRKoGYTOxmKLXbo8oqjC5Mcn/o+2PQ==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr2427367wmg.48.1562316553295;
        Fri, 05 Jul 2019 01:49:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e7sm7656666wmd.0.2019.07.05.01.49.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 01:49:12 -0700 (PDT)
Date:   Fri, 5 Jul 2019 10:49:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
Message-ID: <20190705084910.GA6592@gmail.com>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de>
 <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de>
 <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de>
 <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Jul 4, 2019, at 6:33 PM, Thomas Gleixner tglx@linutronix.de wrote:
> 
> > On Thu, 4 Jul 2019, Mathieu Desnoyers wrote:
> >> ----- On Jul 4, 2019, at 5:10 PM, Thomas Gleixner tglx@linutronix.de wrote:
> >> >
> >> > num_online_cpus() is racy today vs. CPU hotplug operations as
> >> > long as you don't hold the hotplug lock.
> >> 
> >> Fair point, AFAIU none of the loads performed within num_online_cpus()
> >> seem to rely on atomic nor volatile accesses. So not using a volatile
> >> access to load the cached value should not introduce any regression.
> >> 
> >> I'm concerned that some code may rely on re-fetching of the cached
> >> value between iterations of a loop. The lack of READ_ONCE() would
> >> let the compiler keep a lifted load within a register and never
> >> re-fetch, unless there is a cpu_relax() or a barrier() within the
> >> loop.
> > 
> > If someone really wants to write code which can handle concurrent CPU
> > hotplug operations and rely on that information, then it's probably better
> > to write out:
> > 
> >     ncpus = READ_ONCE(__num_online_cpus);
> > 
> > explicitely along with a big fat comment.
> > 
> > I can't figure out why one wants to do that and how it is supposed to work,
> > but my brain is in shutdown mode already :)
> > 
> > I'd rather write a proper kernel doc comment for num_online_cpus() which
> > explains what the constraints are instead of pretending that the READ_ONCE
> > in the inline has any meaning.
> 
> The other aspect I am concerned about is freedom given to the compiler 
> to perform the store to __num_online_cpus non-atomically, or the load 
> non-atomically due to memory pressure.

What connection does "memory pressure" have to what the compiler does? 

Did you confuse it with "register pressure"?

> Is that something we should be concerned about ?

Once I understand it :)

> I thought we had WRITE_ONCE and READ_ONCE to take care of that kind of 
> situation.

Store and load tearing is one of the minor properties of READ_ONCE() and 
WRITE_ONCE() - the main properties are the ordering guarantees.

Since __num_online_cpus is neither weirdly aligned nor is it written via 
constants I don't see how load/store tearing could occur. Can you outline 
such a scenario?

> The semantic I am looking for here is C11's relaxed atomics.

What does this mean?

Thanks,

	Ingo
