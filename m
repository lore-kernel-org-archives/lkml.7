Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5EEC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA7E2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 01:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfLaBzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 20:55:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55071 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbfLaBzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 20:55:20 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBV1tF26016563
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 20:55:16 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 66770420485; Mon, 30 Dec 2019 20:55:15 -0500 (EST)
Date:   Mon, 30 Dec 2019 20:55:15 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Why is CONFIG_VT forced on?
Message-ID: <20191231015515.GB3669@mit.edu>
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 06:30:15PM -0600, Rob Landley wrote:
> On x86-64 menuconfig, CONFIG_VT is forced on (in drivers->char devices->virtual
> terminal), but the help doesn't mention a "selects", and I didn't spot anything
> obvious in "find . -name 'Kconfig*' | xargs grep -rw VT".

It's forced on because of this:

config VT
       bool "Virtual terminal" if EXPERT
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The above is syntatic sugar for this:

       bool
       prompt "Virtual terminal" if EXPERT

What this means is that the prompt is shown only if CONFIG_EXPERT is
enabled.  If CONFIG_EXPERT is not set, then the default value (which
for CONFIG_VT is "yes") is used, with no way to change it.

Basically, this is because we don't want naive users to build a kernel
which displays nothing on the console; for PC class systems, 99.99% of
the time, you really do want the virtual terminal enabled.

> Congratulations, you've reinvented "come from". I'm mostly familiar with the
> kconfig plumbing from _before_ you made it turing complete: how do I navigate this?

In the case where something was actually selected, it is explained as
such when you search for that config variable.  So for example, if you
run "make menuconfig", and then type '/' to search for a configuration
parameter, and then type "CONFIG_JBD2" and return.  What you will see
is this:

   Symbol: JBD2 [=y]                                                                               │  
   Type  : tristate                                                                                │  
     Defined at fs/jbd2/Kconfig:2                                                                  │  
     Depends on: BLOCK [=y]                                                                        │  
     Selects: CRC32 [=y] && CRYPTO [=y] && CRYPTO_CRC32C [=y]                                      │  
     Selected by [y]:                                                                              │  
     - EXT4_FS [=y] && BLOCK [=y]                                                                  │  
     Selected by [n]:                                                                              │  
     - EXT3_FS [=n] && BLOCK [=y]                                                                  │  
     - OCFS2_FS [=n] && BLOCK [=y] && NET [=y] && SYSFS [=y] && CONFIGFS_FS [=y]     

The values in square brackets tell you what the current value of these
configuration parameters.  So it tells you that CONFIG_JBD2 is yes,
CONFIG_BLOCK is yes, EXT3_FS is no, OCFS2_FS is no, etc.

It also tells you that it is currently selected automatically because
CONFIG_EXT4_FS and CONFIG_BLOCK is enabled.  If CONFIG_EXT3_FS and
CONFIG_BLOCK was yes, that would also cause CONFIG_JBD2 to be
selected.

And since CONFIG_JBD2 is enabled, it will force CONFIG_CRC32,
CONFIG_CRYPTO, and CONFIG_CRC32C to be selected.

It also tells you that you can find the actual definition at
fs/jbd2/Kconfig, at line #2.

> I'm guessing "stick printfs into the menuconfig binary" is the recommended next
> step for investigating this? Or is there a trick I'm missing?

See above.  The menuconfig configuration parameter search feature
tells you all about how a particular CONFIG_XXX, and what dependencies
to be enabled in order for you to be able enable that parameter, and
why it might have been enabled via the select command.

What's not there is an explanation for why a parameter like CONFIG_VT
is enabled.  Right now, /CONFIG_VT will display:

   Symbol: VT [=y]
   Type  : bool
   Prompt: Virtual terminal
     Location:
       -> Device Drivers
         -> Character devices
   (1)     -> Enable TTY (TTY [=y])
     Defined at drivers/tty/Kconfig:13
     Depends on: TTY [=y] && !UML
     Selects: INPUT [=y]  

Now, if you look at line 13 of drivers/tty/Kconfig, you'd see:

config VT
	bool "Virtual terminal" if EXPERT
	depends on !UML
	select INPUT
	default y
	---help---
	  If you say Y here, you will get support for terminal devices with
	  ...

Perhaps it would be nice if the output of /CONFIG_VT included
something like:

   Prompt requires CONFIG_EXPERT [=n], default y

I'm sure the kbuild maintainers would love to consider a patch which
did this.  :-)

Cheers,

					- Ted
