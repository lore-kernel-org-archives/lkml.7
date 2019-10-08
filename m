Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E5BC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A48020815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbfJHNNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:13:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbfJHNNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:13:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8060A206BB;
        Tue,  8 Oct 2019 13:13:51 +0000 (UTC)
Date:   Tue, 8 Oct 2019 09:13:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        linux-mm@kvack.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008091349.6195830d@gandalf.local.home>
In-Reply-To: <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
        <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
        <1570460350.5576.290.camel@lca.pw>
        <20191007151237.GP2381@dhcp22.suse.cz>
        <1570462407.5576.292.camel@lca.pw>
        <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 10:15:10 +0200
Petr Mladek <pmladek@suse.com> wrote:

> There are basically three possibilities:
> 
> 1. Do crazy exercises with locks all around the kernel to
>    avoid the deadlocks. It is usually not worth it. And
>    it is a "whack a mole" approach.
> 
> 2. Use printk_deferred() in problematic code paths. It is
>    a "whack a mole" approach as well. And we would end up
>    with printk_deferred() used almost everywhere.
> 
> 3. Always deffer the console handling in printk(). This would
>    help also to avoid soft lockups. Several people pushed
>    against this last few years because it might reduce
>    the chance to see the message in case of system crash.
> 
> As I said, there has finally been agreement to always do
> the offload few weeks ago. John Ogness is working on it.
> So we might have the systematic solution for these deadlocks
> rather sooner than later.

Another solution is to add the printk_deferred() in these places that
cause lockdep splats, and when John's work is done, it would be easy to
grep for them and remove them as they would no longer be needed.

This way we don't play whack-a-mole forever (only until we have a
proper solution) and everyone is happy that we no longer have these
false positive or I-don't-care lockdep splats which hide real lockdep
splats because lockdep shuts off as soon as it discovers its first
splat.

-- Steve
