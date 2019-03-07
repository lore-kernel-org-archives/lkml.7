Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E18C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4C42064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCGUmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:42:49 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:42:48 -0500
Received: from [192.168.1.110] ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWzbr-1hYqXt2Dt3-00XOAB; Thu, 07 Mar 2019 21:41:32 +0100
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Daniel Colascione <dancol@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
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
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
 <754146f0-8b57-8644-81c1-528b5ca7dba1@zytor.com>
 <CAKOZuesjYZ2EH=BHBAJAFFaTOHjWU7BELJUV3QC9cjXVB2HhUw@mail.gmail.com>
 <0c46ab5f-8bd6-6916-fc4a-b6f00d456011@metux.net>
 <CAKOZuevksKGAPif_pUYVzFpbuBCxOZ5WzT6ukLCYm4TzyLUTMw@mail.gmail.com>
Organization: metux IT consult
Message-ID: <5ebec282-57b0-6ebe-0876-ce0dd7b0c11c@metux.net>
Date:   Thu, 7 Mar 2019 21:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuevksKGAPif_pUYVzFpbuBCxOZ5WzT6ukLCYm4TzyLUTMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Tp6bF2Z3dkVllxcS/EPAGmjZI07iAoMz9aPBxme7W/HYkOHI3WX
 pGosHHk0Tm2j84CI2QYv/O6BcnJCYesdCHurfhyx5LZO2cX6XNHFKndrAz0IsXmvV8NzUm2
 WuXgMZMnlXbNC1L1timGw1Y29iZbpQ8Q9hs39e95m+nG1zGTwmooZgThqyPP3NF+QVuNwfR
 4caffVP/JlkaMyDb3KSIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/thYJCKsm1M=:uP5+25oqOqanxyHQSC3j+0
 eXpjcJFUpdorTFprbL/0q/O9hC09GYpOrNbHEwY7YW6yhQkL7raAq1IskLSbgukJ9qoF6j1XE
 4jBOs6ycwHbWiuTvpvYE59A4jsn5qoHd3y0INBLzMAYZUdUL2TxF8JiGiZNGi+HenRBkB4puH
 7rruPEVTfd5bWZRAK19DBRCc0/Xeq27A3+LtvL0R/zVLaAZCZMifNEcJcRVgvcgSY9jzp5U92
 tTw2n6WAmwNgbe60cnhqf2KP11iHDrxO5bOMQWqSr04ngwRG8MfSTbfTe3YHnabmfwKkNhdnD
 aUVa2xHWYJPNtls9vc1U6WrOw/b5NYP+7KJegFgrTtSanXLRCwSPapWrOGP0YLR3DXCy6W99v
 EdsBdcyxVW2zYEK8naveqxTZOCed7r9Uj9I2YJECZsvk/a6LBzG4JR+fJ65MIqd7K2DmQgHBF
 xnz4/kai0ycHxdpqlMkUmtvfFVp6WsZN0KJ5V9NtC7WbKkcJDJpbkfQtLtz2+wDP38bzrY0Un
 FAt6lX15WlWfv6kS2pqlSIc0d3jQ3CVsFmq/ukQo0pz9TW0UykE5DdS6yiIp2G7c++i0fNPbq
 YxQxrouzN3DAWayZUPB0t7kXkUBc1oT4zbFLHPhHhNkIo9/Wz7i/i6S+ObVskSvf0G4loXOtj
 jxVO0LW9Pm9x4eiEhiSKKtembz3SQS/IrF1mBV5abM0YSxDuyO5z8pGPsM5M1Be54bqGS/NqQ
 ILwaaEbsqlPHu+ycNegjsA/G8Uqd4N8yI6OcIPQsoSgzqvDYU8WqADEryZo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.19 02:49, Daniel Colascione wrote:

> Entirely FS-less operation is uncommon, granted. :-) I guess I've just
> spent too much time debugging emulators that refuse to mount their> root filesystems. :-)

Fix these emulators ?

> There are legitimate reasons why a device's> filesystems might not be rw-mountable though, and I can imagine a
> world where I want to attach tracing tools *very* early.

Ok, but the filesystem where the modules live is mountable, right ?

> Sure. There's some support for a ramdisk already in fastboot. But just
> including a blob in initrd doesn't *automatically* make it available
> to userspace in any uniform way. With Joel's approach --- which> defines both a propagation mechanism and an access interface --- we

I can define such an interface with a few words:

* the kernel headers lives in a (compressed) squashfs image in the
  module directory for the corresponding kernel version:
      /lib/modules/<version>-<flavour>/headers.img"
* this image shall be mounted at a canonical mountpoint, eg:
      /usr/src/linux-headers-<version>-<flavour>
* the kernel needs to support squashfs (may be module or built-in)

That's it. I don't need to touch a single line of kernel code for that,
just a very simple and small convention.

> have a chance to make very useful tools work transparently everywhere,
> and without additional work across a fragmented and uncoordinated
> ecosystem. 

Why not instead starting to clean up your fragmented and uncoordinated
ecosystem ? :o

> That's not nothing!

It's nothing more that we already have built-in for aeons.

> While I appreciate the purity merits of a file-based approach, insisting 
> on it will lead to a world where it'll be many more years before we can> apply these powerful analysis tools universally.

So, adding a few LOC in Android build machinery for just creating an
archive/squashfs is such a complicated things that takes many years ?

> Human factors are just as important as technical ones,

Human factors like people just not willing to learn the fundamental
basics of the operating they're customizing ?

> ones if you want to actually get anything done, and in this case, a
> consideration of the human factors points toward the kernel as
> coordination point for kernel metadata. 

So, if userland folks are incapable of doing pretty simple things,
put a complex machinery into the kernel ?

> It'd be different if we were
> working in a more-coordinated system NT or FreeBSD, 

Ah, NT. Windows. The platform where everybody rolls his own monstreaus
drivers stacks (eg. several megabytes for trivialities like a CAN
adapter or about a gigabyte for a bunch of adc cards), usually all with
their own private userland api, because the OS vendor just doesn't
manage to provide generic subsystems for common stuff.

The one where applications are usually 10 times bigger and all come
with their own, private installer, just because there's no coordinated
package management and distros.

> but this is Linux,

No, this is *Android* we're talking about.

In GNU/Linux world, the problem you're trying to solve here already
*is* solved since aeons. Entirely in userland.

> where fragmentation starts as soon as you exit ring zero.

Such fragmentation like virtually any device vendor forking it's own
private kernel for each model, doing a huge bunch of pretty crude
hacks and dropping all maintenance as soon as the next model coming
up on the horizon ?

> Practically speaking, the only universal mechanism is to bake something
> into the kernel image or one of its modules.

Aha, and when do we start moving widget toolkits and html renderers
into the kernel ? :o


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
