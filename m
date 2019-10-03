Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B48C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E36222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570061619;
	bh=6hltzyRT3OubG5wFKK8LJd0jyatsmp0ace1N5N5YixA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RIqmRmYpNvdmbUAmjuy9eZtmUJaVH4auxA19ZS6g8WChnjRtMT7BzERizF/6hON9C
	 hmRMJ5D3L3irzF+AE0BkZmRaTJf1ZrjtA5BSrQPrikjFty1r+0ZXfKRCLu64aXrMu7
	 gpzWIUc4QvEEkg5lY/Gab1pYpNgpRAIYlLQZwrg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfJCANi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfJCANi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:13:38 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91717222BE;
        Thu,  3 Oct 2019 00:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570061617;
        bh=6hltzyRT3OubG5wFKK8LJd0jyatsmp0ace1N5N5YixA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uD6/FKhUqtDzlmHluCqmNn82TlKMYSMeoZZ1ks7eLfNn2p6+TUzquYUn/bJJEyBHP
         vEoOC0oVjIdkgg/PXDJvCf79MB0H3a3071W51stbDTAKLcd4YuWYQIKhV7VRZ7dg9E
         2hFoDOCW59+OG9d4otYotz/vEX50mbCPaKitj9pw=
Date:   Wed, 2 Oct 2019 17:13:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1] kernel.h: Split out mathematical helpers
Message-Id: <20191002171337.7cf1f48fde153382d7245fc5@linux-foundation.org>
In-Reply-To: <20190910105105.7714-1-andriy.shevchenko@linux.intel.com>
References: <20190910105105.7714-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 13:51:05 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out mathematical
> helpers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  fs/nfs/callback_proc.c        |   1 +
>  include/linux/bitops.h        |   3 +-
>  include/linux/dcache.h        |   1 +
>  include/linux/iommu-helper.h  |   1 +
>  include/linux/kernel.h        | 143 --------------------------------
>  include/linux/math.h          | 149 ++++++++++++++++++++++++++++++++++
>  include/linux/rcu_node_tree.h |   2 +

I'm not really understanding how this works, apart from "dumb luck".

Random example: mm/percpu.c needs roundup(), so how does it include the
new math.h?

....... ./arch/x86/include/asm/uprobes.h
........ ./include/linux/notifier.h
......... ./include/linux/mutex.h
......... ./include/linux/srcu.h
.......... ./include/linux/workqueue.h
........... ./include/linux/timer.h
............ ./include/linux/ktime.h
............. ./include/linux/time.h
.............. ./include/linux/time32.h
............... ./include/linux/timex.h
................ ./include/uapi/linux/timex.h
................. ./include/linux/time.h
................ ./include/uapi/linux/param.h
................. ./arch/x86/include/generated/uapi/asm/param.h
.................. ./include/asm-generic/param.h
................... ./include/uapi/asm-generic/param.h
................ ./arch/x86/include/asm/timex.h
................. ./arch/x86/include/asm/tsc.h
............. ./include/linux/jiffies.h
.............. ./arch/x86/include/generated/uapi/asm/param.h
.............. ./include/generated/timeconst.h
............. ./include/linux/timekeeping.h
............. ./include/linux/timekeeping32.h
............ ./include/linux/debugobjects.h
.......... ./include/linux/rcu_segcblist.h
.......... ./include/linux/srcutree.h
........... ./include/linux/rcu_node_tree.h
............ ./include/linux/math.h

oh, like that.

It seems rather unreliable.  Perhaps a "#include <linux/math.h>" was
intended in kernel.h?

