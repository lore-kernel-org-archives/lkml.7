Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E088C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368BC20870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566678152;
	bh=oqN1MQFN/r+CxaJUdcGnGb7RUIBK8bIlRXsvR1VRMu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i//6U56STqMUSdG9Z58KKKw/BDr414b1ZdC4E/ImJBV0UkUjtxoTJKAPtXcjiGVzD
	 csXTy8htUttlDmOTTz/f5HQIJ8mFyRz7YdKwN6NlFOS0RETNESMDfrchqXp+qULLrl
	 QY0+hZkn7fI6nZD36shjRRp8ChVrPKC1zm+srQBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfHXUWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:22:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34998 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfHXUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:22:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so12246722wmg.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 13:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NRUJPUKZz4zn4qnI25OXm+dKFPsYejGDJU7kb8ejEU=;
        b=PshsigJ9h8e/W1EVcxhmkPG58AyfQoYqTa+r4i2sPyX82XDYVuyIpl3wadmDFEsLz/
         idtZFr0By69UX2x7vvTt7ukHN0bLUcaC9Byz3h24wjkNRFPVee2Mazsdh8qpGQSmvAR5
         DBTFYkxBqmPjxazVowZ8seiHJwd5dD/rRSrxaVE2rzcYzaac4PPCom4iK4zLvJ0zlSbw
         N81IdwM6jrYFfgb7nWuc1wXEbVoj5mzyIn/D7qiN563BrHT82S1cxhNOCFGVY47Dtc58
         LoB7hSVDxqj2bjelt358jJ0STIIQexACaNU+DLlbdqegxBFvakwWll3R+D7rQi0HF7cE
         r4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NRUJPUKZz4zn4qnI25OXm+dKFPsYejGDJU7kb8ejEU=;
        b=XED4BXp+nfFlxkFJBEjPy6v74Lts2PxspMeTzmroMy6L9W8ZgzEeZAl5fqXmvWmnx2
         fU7ImLj0oXy4jUNTUKASvnsUJqqLmS8j8F7X+iImIc9vj8272w3AVzCNVjNpIOMIplBJ
         OvmjEZmVD6Rb/s/EhbzNIG+m7IGTnMD7HNWH0EHqlOK7MiAr+65l0Z9SnQtaitKMH2RH
         LvC8eF8GNVKsoxT3IDaqll9ENA8RkTcwVhIXZ5GENh2jE/yhfVr7b1u5R0IfLL0vy+zU
         Z6PNKKROBPEQij8P/gGJPWeFx4hGs4T+yfbo87fa4L/256YWiw3rwOzH7KSqi46qaayi
         uAdg==
X-Gm-Message-State: APjAAAWLYWSXzEhO2Rsbr3g3IXGbJXqMDsBJcK4UF+61S8SNs/1dJmEv
        CVsghBwVR/9MSXcXjSx6LcE=
X-Google-Smtp-Source: APXvYqx20xtyPK+1SR1/nZhJidMz+CG2LP/ynr0zIlbvUxlUtvmmMVt5TjdsX7Ni7/yvTqn0OpKmOg==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr12961648wmi.50.1566678147236;
        Sat, 24 Aug 2019 13:22:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l62sm12941142wml.13.2019.08.24.13.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 13:22:26 -0700 (PDT)
Date:   Sat, 24 Aug 2019 22:22:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190824202224.GA5286@gmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
 <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Aug 24, 2019 at 9:14 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > What I noticed is that while reading regular RAM is reasonably fast even
> > in very large chunks, accesses become very slow once they hit iomem - and
> > delays even longer than the reported 145 seconds become possible if
> > bs=100M is increased to say bs=1000M.
> 
> Ok, that makes sense.
> 
> So for IOMEM, we actually have two independent issues:
> 
>  (a) for normal unmapped IOMEM (ie no device), which is probably the
> case your test triggers anyway, it quite possibly ends up having ISA
> timings (ie around 1us per read)

That makes sense: I measured 17 seconds per 100 MB of data, which is is 
0.16 usecs per byte. The instruction used by 
copy_user_enhanced_fast_string() is REP MOVSB - which supposedly goes as 
high as cacheline size accesses - but perhaps those get broken down for 
physical memory that has no device claiming it?

>  (b) we use "probe_kernel_read()" to a temporary buffer avoid page
> faults, which uses __copy_from_user_inatomic(). So far so good. But on
> modern x86, because we treat it as just a regular memcpy, we probably
> have ERMS and do "rep movsb".
> 
> So (a) means that each access is slow to begin with, and then (b)
> means that we don't use "copy_from_io()" but a slow byte-by-byte
> access.
> 
> > With Tetsuo's approach the delays are fixed, because the fatal signal is
> > noticed within the 4K chunks of read_mem() immediately:
> 
> Yeah. that's the size of the temp buffer.
> 
> > Note how the first 100MB chunk took 17 seconds, the second chunk was
> > interrupted within ~2 seconds after I sent a SIGKILL.
> 
> It looks closer to 1 second from that trace, but that actually is
> still within the basic noise above: a 4kB buffer being copied one byte
> at a time would take about 4s, but maybe it's not *quite* as bad as
> traditional ISA PIO timings.

Yeah - and note that I phrased it imprecisely: the real in-kernel signal 
interruption delay was probably below 1 msec: in my test the SIGKILL was 
manually triggered, with an about 1 second delay caused by the human 
brain, not by the kernel. ;-)

The in-kernel interruption is almost instantaneous - the 4K max chunking 
is good I think.

> > Except that I think the regular pattern here is not 'break' but 'goto
> > failed' - 'break' would just result in a partial read and 'err' gets
> > ignored.
> 
> That's actually the correct signal handling pattern: either a partial
> read, or -EINTR.
> 
> In the case of SIGKILL, the return value doesn't matter, of course,
> but *if* we were to decide that we can make it interruptible, then it
> would.

Yeah. So while error cases and signals are not equivalent, I also went by 
existing precedent within read_kmem(): the 2 other error cases return an 
error (-ENXIO and -EFAULT), while they could also conceivably return a 
partial read of the previously completed read and only return an error if 
the *first* chunk generates an error without making any progress?

Interruption is arguably *not* an 'error', so preserving partial reads 
sounds like the higher quality solution, nevertheless one could argue 
that particual read *could* be returned by read_kmem() if progress was 
made.

> > I also agree that we should probably allow regular interrupts to
> > interrupt /dev/mem accesses - while the 'dd' process is killable, it's
> > not Ctrl-C-able.
> 
> I'm a bit nervous about it, but there probably aren't all that many
> actual /dev/mem users.
> 
> The main ones I can see are things like "dmidecode" etc.
> 
> > If I change the fatal_signal_pending() to signal_pending() it all behaves
> > much better IMHO - assuming that no utility learned rely on
> > non-interruptibility ...
> 
> So I cloned the dmidecode git tree, and it does "myread()" on the
> /dev/mem file as far as I can tell. And that one correctly hanles
> partial reads.
> 
> It still makes me a bit nervous, but just plain "signal_pending()" is
> not just nicer, it's technically the right thing to do (it's not a
> regular file, so partial reads are permissible, and other files like
> it - eg /dev/zero - already does exactly that).
> 
> I also wonder if we should just not use that crazy
> "probe_kernel_read()" to begin with. The /dev/mem code uses it to
> avoid faults - and that's the intent of it - but it's not meant for
> IO-memory at all.
> 
> But "read()" on /dev/mem does that off "xlate_dev_mem_ptr()", which is
> a bastardized "kernel address or ioremap" thing. It works, but it's
> all kinds of stupid. We'd be a *lot* better off using kmap(), I think.

Hm, I think xlate_dev_mem_ptr() and thus ioremap() would also perform a 
cache aliasing conflict check - which kmap() wouldn't do?

I.e. if for example an iomem area is already mapped by a driver with some 
conflicting cache attribute, xlate_dev_mem_ptr() AFAICS will not 
ioremap_cache() it to cached? IIRC some CPUs would triple fault or 
completely misbehave on certain cache attribute conflicts.

This check in mremap() might also trigger:

        if (is_ram == REGION_MIXED) {
                WARN_ONCE(1, "memremap attempted on mixed range %pa size: %#lx\n",
                                &offset, (unsigned long) size);
                return NULL;
        }

So I'd say xlate_dev_mem_ptr() looks messy, but is possibly a bit more 
robust in this regard?

> So my gut feel is that this is something worth trying to do bigger and
> more fundamental changes to.
> 
> But changing it to use "signal_pending()" at least as a trial looks
> ok. The only user *should* be things like dmidecode that apparently
> already do the right thing.
> 
> And if we changed the bounce buffering to do things at least a 32-bit
> word at a time, that would help latency for IO by a factor of 4.
> 
> And if the signal_pending() is at the end of the copy, then we'd
> guarantee that at least _small_ reads still work the way they did
> before, so people who do things like "lspci()" with direct hardware
> accesses wouldn't be impacted - if they exist.

Yeah.

> So I'd be willing to try that (and then if somebody reports a
> regression we can make it use "fatal_signal_pending()" instead)

Ok, will post a changelogged patch (unless Tetsuo beats me to it?).

Thanks,

	Ingo
