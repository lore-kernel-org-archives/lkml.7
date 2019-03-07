Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4FAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DCB206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjiFceot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCGAdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:33:22 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34818 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:33:21 -0500
Received: by mail-vs1-f65.google.com with SMTP id e81so3429050vsd.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEJ5G8jnHVQMy7aNfN+k83bonxkbyl6Qcj8Z0QcUY2I=;
        b=IjiFceotbOUdvh5dCUAxBCGwm2/WNmIbFzPS7TK5q6LWR+1u83Cj3bA72X45511uRM
         ien4KzupB3a9Q2iRIRblscdKhQ5GG1nyLzTKZ/3DVA3dM7AO3EZfI8IuPhWu3S7OH3x2
         Kk3plKijR91I1t2G0AaC4ctugSL62vf+7q/BQ/m28uWeIugOp1yE+9I75ibOvHdAnIVc
         /963sSBbFAomEeotRmKxdVzO7UwHECsRqqjefBw0WSnZorsegTcNW0e1g/fd5MIHMwoV
         BFrY07BCDFtK58LN3VpSJOTIbRY7LAvNMv/Tj3B9qrG3zRsMy85QsY6/uHkOLecvXmWI
         z1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEJ5G8jnHVQMy7aNfN+k83bonxkbyl6Qcj8Z0QcUY2I=;
        b=mXFGgCApDw9q28Ib21DBK3bSuXioXPVmNfP9dIObjiqyDsWo2LnoLHMfwhVdn8qWk+
         O9GZu2OehhVZn4oSQoYCU5NqMZwT9K5EEnxL1eU5JzS0dxRMBBSsm5GfOIuwLANs5kNu
         A2OseGid9wuXrkvBRKgsaWrEGH6SDldndkeymbPMM6wb3yfWzrttJL+E0Afh3PQrAW0W
         Q5dtiMeP6PPw3El1Bagr9IDfT0S+Do09f/Las7E2Fj5sbYCmkjg5EA488+CT6LZsQQxF
         LqiNJZhFJMyKygHESx7T28YANSOPCEsEufjl0H7iK2dFWXjcBVrARgHEqWm2aReS1n2u
         y+fg==
X-Gm-Message-State: APjAAAWBCTSUlwzHd1dPTgXYuIC13u0JMl2o5ZfdFZBsGfC2K4s4hpmA
        7qjcWBebimLli9YCB967gueYcyYJ0CTeiROsgWiyOK405Z8=
X-Google-Smtp-Source: APXvYqy+lKouejdKDrIC70LhwZkgqDo9oFlzuoe7ioBpKbNiMIJWWkkubBs0lqKSMg4dnn6u3H0eGyOxDrtb08PqTgg=
X-Received: by 2002:a67:af05:: with SMTP id v5mr5792194vsl.114.1551918799495;
 Wed, 06 Mar 2019 16:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com> <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com> <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
In-Reply-To: <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 6 Mar 2019 16:33:07 -0800
Message-ID: <CAKOZuesjYZ2EH=BHBAJAFFaTOHjWU7BELJUV3QC9cjXVB2HhUw@mail.gmail.com>
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 4:07 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
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

And what are the supposedly disastrous consequences of this change?
It's basically a souped-up version /proc/config.gz. Tell me more about
the trail of destruction and regret behind /proc/config.gz.

> Experience -- and we have almost 30 years of it -- has shown that hacks
> of this nature become engrained and all of a sudden is "mandatory". At
> the *very least* it needs to comply with the zero-one-infinity rule
> rather than being yet another ad hoc hack.

It already satisfies the zero-one-infinity rule by virtue of not being
a system for encoding an arbitrary number of random kernel header
blobs for some reason in a single kernel.

> More fundamentally, we already have multiple ways to handle objects that
> need to go into the filesystem: they can be installed with (or as)
> modules, they can use the firmware interface, and so on.

*There* *may* *be* *no* *filesystem*. Or the filesystem may be
read-only. The only thing the kernel can really guarantee is its own
existence --- it should be entire in itself. If I'm hacking on an
Android kernel and say "fastboot boot mykernel" without making any
changes to the device's boot filesystem, I should still be able to use
tracing tools that rely on knowing the headers for the kernel with
which the device happened to boot. Any approach that requires
coordinated kernel and filesystem changes to make this usecase work is
inferior to what Joel's proposed.

> Saying "it can be a module" is worse than a copout: even if dynamically
> loaded -- and many setups lock out post-boot module loadings for
> security reasons -- there is nothing to cause it to unload.

Those setups can ship kernel headers as they do today. Or a
tmpfs-based approach may be workable.

> The bottom line is that in the end there is no difference between making
> this an archive of some sort and a module, except that to use the module
> you need privilege that you otherwise may not need. If your argument is
> that someone may not be providing the whole set of items provided by
> "make modules_install", what is there to say that they would include
> your specific module?
>
> Here are some better ways of implementation I can see:
>
> 1. Include an archive in "make modules_install". Most trivial; no kernel
>    changes at all.

No. See above.

> 2. Generalize the initramfs code to be able to create a pre-populated
>    tmpfs at any time, that can be populated from an archive provided by
>    the firmware loading mechanism; like all firmware allows it to either
>    be built in or fetched from the filesystem. This allows it to be
>    built in to the kernel image if that becomes necessary; using tmpfs
>    means that it can be pushed out to swap rather than permanently
>    stored in kernel memory, and this filesystem can be unmounted freeing
>    its memory.

Backing the blob storage with tmpfs is a reasonable tweak to Joel's
existing model. We can mark the header blob discardable and memcpy it
into some tmpfs-backed storage. This way, it can swap, and you can
release the memory with rm(1) as well as unmount. You might as well
expose the facility as a new just-like-tmpfs filesystem that init
scripts can mount anywhere --- once. Making the thing a firmware blob
sounds fine too, although I know less about that subsystem. But
blocking this work as a whole in favor of some yet-to-be-designed
general-purpose initramfs-tmpfs conversion thingamajig really is
perfect-is-the-enemy-of-the-good-ism, and I don't think tmpfs storage
is necessary for the initial version of this work.

> 3. Use a squashfs image instead of an archive.

Why?
