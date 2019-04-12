Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A957C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579BE2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555098792;
	bh=oKz4a0apd2S5GAl84dWoqNQpk7KVldE0lZD6TrChwWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=azboOKFAg245tnUf0Mt5U32rXjw6ry4HdgFReMY4YwE4dR0+QJ2Qpr7wqeGcYjp8j
	 TPt9YRi5+gBP139m4e27l25Cu/GbNC8EWlbmo2abFQoXseO7N6x8HP8xlY/muhKrts
	 JVgisofCDi34na58bj/AtJEqXCuaZZ2q21F16luE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDLTxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:53:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33892 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfDLTxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:53:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id x14so9413457eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jb4z3jW0thx7PVQQQPpt7VEpOEzDZAQnNlKDZUPhehA=;
        b=LuwePai4gzSSuYBQt64mUP9zVzvMEUq9H4chiENOw5T8oq82IlrpZ5/yIiiFiFbsTB
         4TJQLPoERBt3LTqYzoDo1doyBwZSd009Sz+yRojp5LR6fM3yjJYRtlEVG2uBKuSLmv9Y
         PcE11ZY8hynBUFV8oGsu2Wh+meiZLL1LxZJQ/TxLsifzHb4OYfI6iM8o2NAsLNHYrgJx
         MPJBiheEQBd/NrN+7Ys3L26CSdQr/vwrrcmSCEMzjRb/GR6/Mx3VXqY0KWBWkfXerJOv
         iEcJ9AhyawW1UteT7wVLSAOwMGiqyWYU/nIerLS3Wz9piJ3ma87EsTB4S3hx3yrzaxbz
         fWGw==
X-Gm-Message-State: APjAAAVLvEO5VwIKR+Cd4MVie+8uGQJEKhg7dlkc8cauNj8sN20ihxpY
        fDLbwVCt3q8Hz5cYvVcGRnzI/NBhEO1qIAFzQjg=
X-Google-Smtp-Source: APXvYqwxXuULHr9PL/oKDHqGPLuJ84MqWIlBHFRADnpFtxGE/Vurvnn1U8m3WwKTN+jqpQXZF6Noid8kKEY/xBCN4pk=
X-Received: by 2002:a50:9179:: with SMTP id f54mr36491145eda.207.1555098789573;
 Fri, 12 Apr 2019 12:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190226062012.23746-1-lenb@kernel.org> <20190226185358.GQ2861@worktop.programming.kicks-ass.net>
 <20190307145925.GD19434@e105550-lin.cambridge.arm.com> <alpine.DEB.2.21.1904052033220.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904052033220.1802@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 12 Apr 2019 15:52:58 -0400
Message-ID: <CAJvTdK=DNUmOLb9QBHVxn_EAL33zisH-_ZPo8GfFa++5hrK5zQ@mail.gmail.com>
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I think I prefer 's/threads/cpus/g' on that. Threads makes me think SMT,
> > > and I don't think there's any guarantee the part in question will have
> > > SMT on.
> >
> > I think 'threads' is a bit confusing as well. We seem to be using 'cpu'
> > everywhere for something we can schedule tasks on, including the sysfs
> > /sys/devices/system/cpu/ subdirs for each SMT thread on SMT systems.

I agree with Peter and Morten.
"cpu" is more clear and consistent than "thread" here.
I'll spin the series with that string changed.

> > Another thing that I find confusing is that with this series we a new
> > die id/mask which is totally unrelated to the DIE level in the
> > sched_domain hierarchy. We should rename DIE level to something that
> > reflects what it really is. If we can agree on that ;-)
> >
> > NODE level?

Cache topology and node interconnect topology impact performance, and so
we what we look at, when we decided to run something on this CPU or that one.

That logical topology lives within the physical package and die topology,
but doesn't necessarily match it.  For example, caches can be shared
or split into pieces inside a package or die.  Logical nodes may match
die boundaries, or there may be multiple logical nodes within a single
physical package or die.

We have mechanisms for explicitly enumerating the caches,
and for nodes.  This patch series does not touch those mechanisms.

The reason we need to know about physical packages and die is that
there are other things associated with them.
eg. power and temperature domains, and certain system registers
follow these physical boundaries.  Code that talks to those items
needs to be able to understand these physical boundaries.

I hope that helps.

thanks,
Len Brown, Intel Open Source Technology Center
