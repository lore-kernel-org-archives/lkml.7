Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBFBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F6620663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfCGAI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:08:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51137 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfCGAI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:08:26 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.40])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2707HlQ1943640
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 6 Mar 2019 16:07:18 -0800
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Daniel Colascione <dancol@google.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
Date:   Wed, 6 Mar 2019 16:07:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 3:37 PM, Daniel Colascione wrote:
> 
> I just don't get the opposition to Joel's work. The rest of the thread
> already goes into detail about the problems with pure-filesystem
> solutions, and you and others are just totally ignoring those
> well-thought-out rationales for the module approach and doing
> inflooping on "lol just use a tarball". That's not productive.
> 
> Look; here's the bottom line: without this work, doing certain kinds
> of system tracing is a nightmare, and with this patch, it Just Works.
> You're arguing that various tools should do a better job of keeping
> the filesystem in sync with the kernel. Maybe you're right. But we
> don't live in a world where they will, because if this coherence were
> going to happen, it'd work already. But this work solves the problem:
> by necessity, anything that changes a kernel image *must* update
> modules coherently, whether the kernel image and module come from the
> filesystem, network boot, some kind of SQL database, or carrier
> pigeon. There's nothing wrong with work that very cheaply makes the
> kernel self-describing (introspection is elegant) and that takes
> advantage of *existing* kernel tooling infrastructure to transparently
> do a new thing.
> 
> You don't have to use this patch if you don't want to. Please stop
> trying to block it.
> 

No, that's not how this works. It is far worse to do something the wrong
way than not doing it at all, when it affects the kernel-user space
interactions.

Experience -- and we have almost 30 years of it -- has shown that hacks
of this nature become engrained and all of a sudden is "mandatory". At
the *very least* it needs to comply with the zero-one-infinity rule
rather than being yet another ad hoc hack.

More fundamentally, we already have multiple ways to handle objects that
need to go into the filesystem: they can be installed with (or as)
modules, they can use the firmware interface, and so on.

Saying "it can be a module" is worse than a copout: even if dynamically
loaded -- and many setups lock out post-boot module loadings for
security reasons -- there is nothing to cause it to unload.

The bottom line is that in the end there is no difference between making
this an archive of some sort and a module, except that to use the module
you need privilege that you otherwise may not need. If your argument is
that someone may not be providing the whole set of items provided by
"make modules_install", what is there to say that they would include
your specific module?

Here are some better ways of implementation I can see:

1. Include an archive in "make modules_install". Most trivial; no kernel
   changes at all.
2. Generalize the initramfs code to be able to create a pre-populated
   tmpfs at any time, that can be populated from an archive provided by
   the firmware loading mechanism; like all firmware allows it to either
   be built in or fetched from the filesystem. This allows it to be
   built in to the kernel image if that becomes necessary; using tmpfs
   means that it can be pushed out to swap rather than permanently
   stored in kernel memory, and this filesystem can be unmounted freeing
   its memory.
3. Use a squashfs image instead of an archive.

	-hpa
