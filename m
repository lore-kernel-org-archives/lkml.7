Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6646EC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2502070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fI3KWfUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfJHODF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:03:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38797 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfJHODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:03:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so25463885qta.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yu0gGfTVj6sLwuOZPBdVlnhLNBQDCSlVL3WPA0HTvRc=;
        b=fI3KWfUgybEH0X9WfK+cmL48vOC+A3u7+OOS4JKP+ZyQWgNJUfYAdzSaRJnLkGluAM
         Z4qLWcnpnDBIaZuG2QExa5fkFkMYHKODMQ7gfaA0TwxzWYTPzlBoqC/8O3ORu6wG3imQ
         gKv6wMgBmy+RjcCsxQvR0HlxxpBLVVaFkPbd2PVHUhNe5SQh2/H5D64NYHFFOY3nsIdM
         xbUy3bTc2cr1LcP6jz9/RDLphFG4uFFb5Z6NTojX0O7Cy6ETjIoDQusTxGRjxCBFbe0J
         Z4yvXq7N+9QZwpP5AGu0CWnhP96CpGn70vMX8woTv22I7qT610+iIe8V2cREjcik7F9x
         RHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yu0gGfTVj6sLwuOZPBdVlnhLNBQDCSlVL3WPA0HTvRc=;
        b=RLbSL74y1Nvl7vvodMZ4RpL5X08Vaq7raCdBXE9anW8MTZnydn5jadnrhD6+t9F5hQ
         Cp1N7rB5wcrONo/ljRzqa9yGFAkf207njLnYLwxAcOWxk2P6KMYpaaD0+VUt3B/mRAhK
         Kzd0sbfocXGWCx7tRTviSER+byQSg+3JtB5V1LeO0AEu4d2mXMPk0OTASCsysFrWuM2h
         eMmbtVkKsU05FLOC40ls+bKtbhsMpIsY6ahUOIkxjh6dw2KMqMTxOKicLk6bViab5zj1
         EYMy6z8+ef4QTJOed2oKpagbIcXZF9JVQKzJZ4Rs/A5QedVonL4aJ59lZRSDu8PrLhqL
         5iNA==
X-Gm-Message-State: APjAAAUcyfHSnP3s2Y4xrTcsbKqLkSjjmCvB0R8QtgDenip+jC0TWEJg
        PS66Y5l8CwJSbhxk9iLoEQDVNQ==
X-Google-Smtp-Source: APXvYqy8ww2Yo3SnAoYjTX3C5cNs32XspQ9GhDMXqUJWdSHhwmUUeHoCPalkVzD6VxjA5hkuiNJRUA==
X-Received: by 2002:ac8:1bcb:: with SMTP id m11mr36449221qtk.122.1570543384257;
        Tue, 08 Oct 2019 07:03:04 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n4sm8634358qkc.61.2019.10.08.07.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 07:03:03 -0700 (PDT)
Message-ID: <1570543381.5576.301.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 08 Oct 2019 10:03:01 -0400
In-Reply-To: <20191008134256.5ti6rjkvadn5b5q4@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
         <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
         <1570460350.5576.290.camel@lca.pw> <20191007151237.GP2381@dhcp22.suse.cz>
         <1570462407.5576.292.camel@lca.pw>
         <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
         <20191008091349.6195830d@gandalf.local.home>
         <1570541032.5576.297.camel@lca.pw>
         <20191008134256.5ti6rjkvadn5b5q4@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 15:42 +0200, Petr Mladek wrote:
> On Tue 2019-10-08 09:23:52, Qian Cai wrote:
> > On Tue, 2019-10-08 at 09:13 -0400, Steven Rostedt wrote:
> > > On Tue, 8 Oct 2019 10:15:10 +0200
> > > Petr Mladek <pmladek@suse.com> wrote:
> > > 
> > > > There are basically three possibilities:
> > > > 
> > > > 1. Do crazy exercises with locks all around the kernel to
> > > >    avoid the deadlocks. It is usually not worth it. And
> > > >    it is a "whack a mole" approach.
> > > > 
> > > > 2. Use printk_deferred() in problematic code paths. It is
> > > >    a "whack a mole" approach as well. And we would end up
> > > >    with printk_deferred() used almost everywhere.
> > > > 
> > > > 3. Always deffer the console handling in printk(). This would
> > > >    help also to avoid soft lockups. Several people pushed
> > > >    against this last few years because it might reduce
> > > >    the chance to see the message in case of system crash.
> > > > 
> > > > As I said, there has finally been agreement to always do
> > > > the offload few weeks ago. John Ogness is working on it.
> > > > So we might have the systematic solution for these deadlocks
> > > > rather sooner than later.
> > > 
> > > Another solution is to add the printk_deferred() in these places that
> > > cause lockdep splats, and when John's work is done, it would be easy to
> > > grep for them and remove them as they would no longer be needed.
> > > 
> > > This way we don't play whack-a-mole forever (only until we have a
> > > proper solution) and everyone is happy that we no longer have these
> > > false positive or I-don't-care lockdep splats which hide real lockdep
> > > splats because lockdep shuts off as soon as it discovers its first
> > > splat.
> > 
> > I feel like that is what I trying to do, but there seems a lot of resistances
> > with that approach where pragmatism met with perfectionism.
> 
> No, the resistance was against complicated code changes (games with
> locks) and against removing useful messages. Such changes might cause
> more harm than good.

I don't think there is "removing useful messages" in this patch. That one
printk() in __offline_isolated_pages() basically as Michal mentioned it is that
useful, but could be converted to printk_deferred() if anyone objected.

It is more complicated to convert dump_page() to use printk_deferred().

> 
> I am not -mm maintainer so I could not guarantee that a patch
> using printk_deferred() will get accepted. But it will have much
> bigger chance than the original patch.
> 
> Anyway, printk_deferred() is a lost war. It is temporary solution
> for one particular scenario. But as you said, there might be many
> others. The long term solution is the printk rework.
> 
> Best Regards,
> Petr
