Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4316CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB6422BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="T9heSwDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfGYPuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:50:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32819 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGYPuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:50:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so45324519qtt.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtvrTY7GxQUsdUWTdAPxoL6H/V/oQ7yIjHbktZQGDCk=;
        b=T9heSwDOqu1siYRpHwNiDCSodaBYxU3vU2eY0qR34TMSyXqxOh06QhZT2zxs0ENoG3
         N2gEx6WK2FzqPKPLYmraD6D1nPL0D+mvBZXmhI/Z1W7DJtg0FOY1DBbs6j59q671QRYo
         MiH7XkWCjdyhjCwclGWzbW6hjFIlux+tTvf1ebcqn/W+CbJBoKrWSGRbQLzUBid8hN9n
         KPlOqqEffYC2LWg+I/NbpkkmXQ1H07kuGZ8B6a+rj7CvKKq6Y92aDWZ9mb3yUzva2uzC
         X+r2oD0aZy/Qugb2GyLDa1OhGdSbaUT7IsQc+l9x6cHvlSTXPPOsg1zlNB2wERjir+6T
         NKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtvrTY7GxQUsdUWTdAPxoL6H/V/oQ7yIjHbktZQGDCk=;
        b=UF3bxLQFrsaNq9u6GT4eytlXJeTWx6Tvk507suspieniRX1aBdwIo2hjzVoAZdZRFq
         ZtvpWKQPHsDCPzFxATwhFoxrrI93bWsQbbBqiPwu6H5+5HruXy5od13ZRN1SrWaiEz0Y
         BXlQ2TTHHhMBirxLUmOjkk4U82BhvAOHZZWZXxuTyDDtarvS9uL2W4a1yVLBgy7ezktm
         FclwdG1Gtf0ApPy3jMyJ1ITGUKB0vuviXQgcrQOQoQoLfzkQ+9FlXKnAOXQFDc7w16qd
         jTZCMKsKBpXbOzVc1l/lVJKzpfVhLkOqqyOZmOzc58+emwhk+9lH8+HpFlM1kT1lQgtc
         tdqQ==
X-Gm-Message-State: APjAAAUZ8Bb9IWclEYDkfK3Lev+cL1txXDA6s8zJoq1ciQdcp1hVv5zj
        ur19SV75VGUOrcnDLCPa9s2MMg==
X-Google-Smtp-Source: APXvYqzjuj7N05pz4uuT4yLODVJZ4OYaCUUWn62Qni2ysyUSpERMDF7EzFjQKc0ShE9ugDe7LLtgMQ==
X-Received: by 2002:ac8:1c42:: with SMTP id j2mr62457987qtk.68.1564069808139;
        Thu, 25 Jul 2019 08:50:08 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g3sm21898563qke.105.2019.07.25.08.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:50:07 -0700 (PDT)
Message-ID: <1564069805.11067.20.camel@lca.pw>
Subject: Re: [PATCH v2] writeback: fix -Wstringop-truncation warnings
From:   Qian Cai <cai@lca.pw>
To:     David Laight <David.Laight@ACULAB.COM>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "tobin@kernel.org" <tobin@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        "jack@suse.cz" <jack@suse.cz>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jul 2019 11:50:05 -0400
In-Reply-To: <4017a4af4b0e4b96a6d7ed66afe18120@AcuMS.aculab.com>
References: <1564065511-13206-1-git-send-email-cai@lca.pw>
         <4017a4af4b0e4b96a6d7ed66afe18120@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 15:04 +0000, David Laight wrote:
> From: Qian Cai
> > Sent: 25 July 2019 15:39
> > 
> > There are many of those warnings.
> > 
> > In file included from ./arch/powerpc/include/asm/paca.h:15,
> >                  from ./arch/powerpc/include/asm/current.h:13,
> >                  from ./include/linux/thread_info.h:21,
> >                  from ./include/asm-generic/preempt.h:5,
> >                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
> >                  from ./include/linux/preempt.h:78,
> >                  from ./include/linux/spinlock.h:51,
> >                  from fs/fs-writeback.c:19:
> > In function 'strncpy',
> >     inlined from 'perf_trace_writeback_page_template' at
> > ./include/trace/events/writeback.h:56:1:
> > ./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified
> > bound 32 equals destination size [-Wstringop-truncation]
> >   return __builtin_strncpy(p, q, size);
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fix it by using the new strscpy_pad() which was introduced in the
> > commit 458a3bf82df4 ("lib/string: Add strscpy_pad() function") and will
> > always be NUL-terminated instead of strncpy(). Also, changes strlcpy()
> > to use strscpy_pad() in this file for consistency.
> > 
> > Fixes: 455b2864686d ("writeback: Initial tracing support")
> > Fixes: 028c2dd184c0 ("writeback: Add tracing to balance_dirty_pages")
> > Fixes: e84d0a4f8e39 ("writeback: trace event writeback_queue_io")
> > Fixes: b48c104d2211 ("writeback: trace event bdi_dirty_ratelimit")
> > Fixes: cc1676d917f3 ("writeback: Move requeueing when I_SYNC set to
> > writeback_sb_inodes()")
> > Fixes: 9fb0a7da0c52 ("writeback: add more tracepoints")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: Use strscpy_pad() to address the possible data leaking concern from
> > Steve [1].
> >     Replace strlcpy() as well for consistency.
> > 
> > [1] https://lore.kernel.org/lkml/20190716170339.1c44719d@gandalf.local.home/
> > 
> >  include/trace/events/writeback.h | 39 +++++++++++++++++++++--------------
> > ----
> >  1 file changed, 21 insertions(+), 18 deletions(-)
> > 
> > diff --git a/include/trace/events/writeback.h
> > b/include/trace/events/writeback.h
> > index aa7f3aeac740..41092d63a8de 100644
> > --- a/include/trace/events/writeback.h
> > +++ b/include/trace/events/writeback.h
> > @@ -66,8 +66,10 @@
> >  	),
> > 
> >  	TP_fast_assign(
> > -		strncpy(__entry->name,
> > -			mapping ? dev_name(inode_to_bdi(mapping->host)-
> > >dev) : "(unknown)", 32);
> > +		strscpy_pad(__entry->name,
> > +			    mapping ?
> > +			    dev_name(inode_to_bdi(mapping->host)->dev) :
> > +			    "(unknown)", 32);
> 
> Shouldn't the 32 be 'sizeof (something)' ??

Maybe could do a sizeof(__entry->name) as it is defined as,

	TP_STRUCT__entry (
		__array(char, name, 32)
		__field(unsigned long, ino)
		__field(pgoff_t, index)

But, that might be a follow-up patch and does not seem belong here.

> 
> Oh, and a horrid line break.

That line is too long needs to break up. Open up to suggestions though.
