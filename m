Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35DD20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QmZRJgHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCGBmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:42:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40526 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGBmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:42:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so15347491qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 17:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zRO0Af1Vp3F9G+LPmcgGAwm9LnWl/baYdZb8ACB1Nl0=;
        b=QmZRJgHho43sh9PvXAc2kSH1el31RKoAifIhrW/PXwSnexxuUA64dorlJKIqensR06
         GP/t86A7Qb/d8DZWWMudW9zoFSE/vks/20QrV86NS8yibkvDILua/Od2W0kxj1r+IcjX
         1KgNftT9HN8w6bK/V4Q/6TczStAXGjsSY90IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRO0Af1Vp3F9G+LPmcgGAwm9LnWl/baYdZb8ACB1Nl0=;
        b=PxF0NqmFuYL3pMRr0ykm0mIUVis3pJ356Dtf1gMZO13RQK9RwcCqXhoPl0C2Dtxrlh
         i4+muR7K56zOM2hijZijaF5CwJEfHTht7JG1fQe43pAwZOymOMXNlnS7W220PDKD2iNE
         hi3vcWWVX4ty1fhKmyw3ou5I9FMw5iIfc07Om84og8q2gtyZuyvk992Rodq2wktxtqvv
         GJqlLqquqPE2/hXgZw8Nz4GNJPqBrq5rX161OFNB3c8xsipLIsrWKQaBBa1O7koSalmP
         o658nE2+ZNfwfulsVHUxLCBT26Un7BTTr1M/ArJGZwP58BpOMmAuaUN9V5/98tGR1IGR
         07Hw==
X-Gm-Message-State: APjAAAXp2L+iRNrNXnVsnudTc75WzndTWUllnO/UuIPZSlI9DRQ4vke3
        Rujko4Vl9/5Sbkdu2dGWJO1JhQ==
X-Google-Smtp-Source: APXvYqzqSSi4ux3BLRxAX62qHTzmx4pCKKGa9SzUcsCmGby2UrzqWMfV/vRA0WKvxxe3aBQsHyargA==
X-Received: by 2002:ac8:2a7b:: with SMTP id l56mr8410126qtl.270.1551922973493;
        Wed, 06 Mar 2019 17:42:53 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id x6sm1504697qtr.9.2019.03.06.17.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 17:42:52 -0800 (PST)
Date:   Wed, 6 Mar 2019 20:42:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Daniel Colascione <dancol@google.com>, Pavel Machek <pavel@ucw.cz>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
Message-ID: <20190307014251.GA184167@google.com>
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com>
 <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com>
 <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
 <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 04:07:13PM -0800, H. Peter Anvin wrote:
> On 3/6/19 3:37 PM, Daniel Colascione wrote:
> > 
> > I just don't get the opposition to Joel's work. The rest of the thread
> > already goes into detail about the problems with pure-filesystem
> > solutions, and you and others are just totally ignoring those
> > well-thought-out rationales for the module approach and doing
> > inflooping on "lol just use a tarball". That's not productive.
> > 
> > Look; here's the bottom line: without this work, doing certain kinds
> > of system tracing is a nightmare, and with this patch, it Just Works.
> > You're arguing that various tools should do a better job of keeping
> > the filesystem in sync with the kernel. Maybe you're right. But we
> > don't live in a world where they will, because if this coherence were
> > going to happen, it'd work already. But this work solves the problem:
> > by necessity, anything that changes a kernel image *must* update
> > modules coherently, whether the kernel image and module come from the
> > filesystem, network boot, some kind of SQL database, or carrier
> > pigeon. There's nothing wrong with work that very cheaply makes the
> > kernel self-describing (introspection is elegant) and that takes
> > advantage of *existing* kernel tooling infrastructure to transparently
> > do a new thing.
> > 
> > You don't have to use this patch if you don't want to. Please stop
> > trying to block it.
> > 
> 
> No, that's not how this works. It is far worse to do something the wrong
> way than not doing it at all, when it affects the kernel-user space
> interactions.
> 
> Experience -- and we have almost 30 years of it -- has shown that hacks
> of this nature become engrained and all of a sudden is "mandatory". At
> the *very least* it needs to comply with the zero-one-infinity rule
> rather than being yet another ad hoc hack.
> 
> More fundamentally, we already have multiple ways to handle objects that
> need to go into the filesystem: they can be installed with (or as)
> modules, they can use the firmware interface, and so on.
> 
> Saying "it can be a module" is worse than a copout: even if dynamically
> loaded -- and many setups lock out post-boot module loadings for
> security reasons -- there is nothing to cause it to unload.
> 
> The bottom line is that in the end there is no difference between making
> this an archive of some sort and a module, except that to use the module
> you need privilege that you otherwise may not need. If your argument is
> that someone may not be providing the whole set of items provided by
> "make modules_install", what is there to say that they would include
> your specific module?

They would include the module because we can enforce that certain
config options in the kernel need to be enabled for Android features to work.
People can obviously mess up their kernel config in any number of ways and
misconfigure their kernel such that user space may even fail to boot. So how
is it relevant that people would include the module or not? If they want a
feature to work, their kernel has to enable the feature, right?

About disabling post-boot module loading, we don't do it on Android and
that's really the target system here. Can we not deal with such post-boot
module load disabling issue at a later time if such user really wants this?
If there is a CONFIG option that disables post-boot module loading, then we
can make this feature depend on that CONFIG being disabled.

> Here are some better ways of implementation I can see:
> 
> 1. Include an archive in "make modules_install". Most trivial; no kernel
>    changes at all.

As I said in previous posts, some people want to boot a kernel image without
any update to FS, for debug purposes. In the Android/embedded world,
developers want to build and boot a single binary blob (for debugging). For
such usecases, hacking modules_install would not help.

Once they are done debugging, they can switch the CONFIG option back to
module instead of building it in and consuming memory, so that it is not
loaded into memory until needed.

> 2. Generalize the initramfs code to be able to create a pre-populated
>    tmpfs at any time, that can be populated from an archive provided by
>    the firmware loading mechanism; like all firmware allows it to either
>    be built in or fetched from the filesystem. This allows it to be
>    built in to the kernel image if that becomes necessary; using tmpfs
>    means that it can be pushed out to swap rather than permanently
>    stored in kernel memory, and this filesystem can be unmounted freeing
>    its memory.

I see your points about how building it in can make it permanently lost
memory, but would that really be an issue if it is built-in by a user ONLY
for debugging?

Anyway, I'll try to think more about how I can make it memory that can be
unloaded/removed even if built-in into the kernel.

About making it a firmware built-in, and then populating tmpfs with the
firmware's contents, isn't that pointless if the firmware is built-in into
the kernel, and the memory that the firmware blob itself consumes is
permanently lost? Whether the tmpfs copy is swapped out or not, would not
help save the built-in firmware's memory.

> 3. Use a squashfs image instead of an archive.

This point number 3 sounds like a non-starter because it will make the kernel
build system fail if squashfs-tools is not available. So it is not an option
I think. I also don't see how it would solve the above swapping issue you
mentioned.  Whether it is an archive or squashfs image doesn't matter as much
as where the image lives.

thanks,

 - Joel

