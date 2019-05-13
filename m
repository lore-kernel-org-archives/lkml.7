Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123BEC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89EA2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfEMLdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:33:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54078 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbfEMLdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:33:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so13454788wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXonh0Cb0dxgFIhZGmnGLJLJ19PHXe+EhVuhVcJmlIQ=;
        b=GDvnrvznA2q0O1S0tIsoUG8KnDWncvcHk0Og3wG+k0qSaXBv8Qu7iGJEvqCOPD8fcG
         9K0jxiEBvj8fqUzdHfl7fbSssUQLC9XjNGXmFBtPOUagj7TR8tl1kxD79KVcWJXpzcRu
         vTiA5KJ5t+ntDUdGznCSJFERkrsNmdvzGHhhC9JjPsyJvfTJ9GGtYSXmZ6Bd4AgvnqeC
         vUUtDfrs+v8voD9IbNTcnQX1pWB1y5McTTfkMbqWDKSsTObqT8kFp3mKiJV44tQLoBdY
         7T89cHzg5IrjA2nI1o5eY+CACXXea0Mzn7u5otMGih2Zb2UzibUEG/XTlw6E7VVy1nbs
         doxQ==
X-Gm-Message-State: APjAAAWNyIbLNwOCJF/6mCB6+XMg0njhkRud17aQmLSosQPKZfKazpM9
        y3PQU5k9bzbC5NBWnEqGfuGAMA==
X-Google-Smtp-Source: APXvYqz2dQvSKTRhbYgpf8EaPeGyBogsabl2KJS/nxo3WNhTWQ3dR2zEafUguNyew7X63XOkuKYT7w==
X-Received: by 2002:a1c:3cc2:: with SMTP id j185mr15630534wma.26.1557747196861;
        Mon, 13 May 2019 04:33:16 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i17sm13493947wrr.46.2019.05.13.04.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 04:33:15 -0700 (PDT)
Date:   Mon, 13 May 2019 13:33:15 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190513113314.lddxv4kv5ajjldae@butterfly.localdomain>
References: <20190510072125.18059-1-oleksandr@redhat.com>
 <36a71f93-5a32-b154-b01d-2a420bca2679@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a71f93-5a32-b154-b01d-2a420bca2679@virtuozzo.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, May 13, 2019 at 01:38:43PM +0300, Kirill Tkhai wrote:
> On 10.05.2019 10:21, Oleksandr Natalenko wrote:
> > By default, KSM works only on memory that is marked by madvise(). And the
> > only way to get around that is to either:
> > 
> >   * use LD_PRELOAD; or
> >   * patch the kernel with something like UKSM or PKSM.
> >
> > Instead, lets implement a so-called "always" mode, which allows marking
> > VMAs as mergeable on do_anonymous_page() call automatically.
> >
> > The submission introduces a new sysctl knob as well as kernel cmdline option
> > to control which mode to use. The default mode is to maintain old
> > (madvise-based) behaviour.
> >
> > Due to security concerns, this submission also introduces VM_UNMERGEABLE
> > vmaflag for apps to explicitly opt out of automerging. Because of adding
> > a new vmaflag, the whole work is available for 64-bit architectures only.
> >> This patchset is based on earlier Timofey's submission [1], but it doesn't
> > use dedicated kthread to walk through the list of tasks/VMAs.
> > 
> > For my laptop it saves up to 300 MiB of RAM for usual workflow (browser,
> > terminal, player, chats etc). Timofey's submission also mentions
> > containerised workload that benefits from automerging too.
> 
> This all approach looks complicated for me, and I'm not sure the shown profit
> for desktop is big enough to introduce contradictory vma flags, boot option
> and advance page fault handler. Also, 32/64bit defines do not look good for
> me. I had tried something like this on my laptop some time ago, and
> the result was bad even in absolute (not in memory percentage) meaning.
> Isn't LD_PRELOAD trick enough to desktop? Your workload is same all the time,
> so you may statically insert correct preload to /etc/profile and replace
> your mmap forever.
>
> Speaking about containers, something like this may have a sense, I think.
> The probability of that several containers have the same pages are higher,
> than that desktop applications have the same pages; also LD_PRELOAD for
> containers is not applicable. 

Yes, I get your point. But the intention is to avoid another hacky trick
(LD_PRELOAD), thus *something* should *preferably* be done on the
kernel level instead.

> But 1)this could be made for trusted containers only (are there similar
> issues with KSM like with hardware side-channel attacks?!);

Regarding side-channel attacks, yes, I think so. Were those openssl guys
who complained about it?..

> 2) the most
> shared data for containers in my experience is file cache, which is not
> supported by KSM.
> 
> There are good results by the link [1], but it's difficult to analyze
> them without knowledge about what happens inside them there.
> 
> Some of tests have "VM" prefix. What the reason the hypervisor don't mark
> their VMAs as mergeable? Can't this be fixed in hypervisor? What is the
> generic reason that VMAs are not marked in all the tests?

Timofey, could you please address this?

Also, just for the sake of another piece of stats here:

$ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
526

> In case of there is a fundamental problem of calling madvise, can't we
> just implement an easier workaround like a new write-only file:
> 
> #echo $task > /sys/kernel/mm/ksm/force_madvise
> 
> which will mark all anon VMAs as mergeable for a passed task's mm?
> 
> A small userspace daemon may write mergeable tasks there from time to time.
> 
> Then we won't need to introduce additional vm flags and to change
> anon pagefault handler, and the changes will be small and only
> related to mm/ksm.c, and good enough for both 32 and 64 bit machines.

Yup, looks appealing. Two concerns, though:

1) we are falling back to scanning through the list of tasks (I guess
this is what we wanted to avoid, although this time it happens in the
userspace);

2) what kinds of opt-out we should maintain? Like, what if force_madvise
is called, but the task doesn't want some VMAs to be merged? This will
required new flag anyway, it seems. And should there be another
write-only file to unmerge everything forcibly for specific task?

Thanks.

P.S. Cc'ing Pavel properly this time.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
