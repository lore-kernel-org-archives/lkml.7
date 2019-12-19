Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9040222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLSVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:18:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35165 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726967AbfLSVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:18:52 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBJLI3tE030273
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 16:18:05 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5BD31420822; Thu, 19 Dec 2019 16:18:03 -0500 (EST)
Date:   Thu, 19 Dec 2019 16:18:03 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
Message-ID: <20191219211803.GA59959@mit.edu>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com>
 <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu>
 <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
 <20191217155206.GA824812@mit.edu>
 <CACT4Y+Yb8Lt2V3RB+wmOXLJ4T9VT_MjYaH0T5MkVsYo9=7XW7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yb8Lt2V3RB+wmOXLJ4T9VT_MjYaH0T5MkVsYo9=7XW7Q@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 06:43:37PM +0100, Dmitry Vyukov wrote:
> We can easily filter out syscall numbers and top level syscall
> argument values (executing random binary code aside, as we gave up on
> this for now). That's what we use to filter out reboot syscalls and
> FIFREEZE ioctl (fortunately the value does not collide with any other
> ioctl we have _for now_). This is done by scanning the test case and
> fixing it if necessary (all the necessary data is already there).

OK, but a number of the changs made in the patch in question (such as
filtering out FIFREEZE by adding a hacky check in the kernel) was done
because the claim was made that Syzkaller *wanted* to run random
binary code.  If you given up for now, then maybe much or all of this
patch isn't needed?

If we do want to run random byte strings as instructions just to see
what the kernel will do, then some ugliness is going to be required.
The question is really, "where do we stash the ugliness", and who pays
the "ugliness tax", and are the benefits worth the costs?

    	      	    	    		       - Ted

