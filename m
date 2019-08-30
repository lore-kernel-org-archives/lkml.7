Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B8C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F4721726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfH3BtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:49:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58874 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727216AbfH3BtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:49:16 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7U1n78t001290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 21:49:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E5BCE42049E; Thu, 29 Aug 2019 21:49:06 -0400 (EDT)
Date:   Thu, 29 Aug 2019 21:49:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 0/7] Rework random blocking
Message-ID: <20190830014906.GD10779@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andy Lutomirski <luto@kernel.org>, Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <cover.1567126741.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567126741.git.luto@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 06:11:35PM -0700, Andy Lutomirski wrote:
> This series also removes the blocking pool and makes /dev/random
> work just like getentropy(..., 0) and makes GRND_RANDOM a no-op.  I
> believe that Linux's blocking pool has outlived its usefulness.
> Linux's CRNG generates output that is good enough to use even for
> key generation.  The blocking pool is not stronger in any material
> way, and keeping it around requires a lot of infrastructure of
> dubious value.

It's too late for the 5.4 cycle for a change of this magnitude, and
I'd just as soon let this wait until *after* the LTS kernel gets cut.
The reason for this is because at the moment, there are some PCI
compliance labs who believe that the "true randomness" of /dev/random
is necessary for PCI compliance and so they mandate the use of
/dev/random over /dev/urandom's "cryptographic randomness" for that
reason.  A lot of things which are thought to be needed for PCI
compliance that are about as useful as eye of newt and toe of frog,
but nothing says that PCI compliance (and enterprise customer
requirements :-) have to make sense.

It may be that what we might need to really support people (or stupid
compliance labs) who have a fetish for "true randomness" to get a
better interface for hardware random number generators than
/dev/hwrng.  Specifically, one which allows for a more sane way of
selecting which hardware random number generator to use if there are
multiple available, and also one where we mix in some CRNG as a
whitening step just case the hardware number generator is busted in
some way.  (And to fix the issue that at the moment, if someone evil
fakes up a USB device with the USB manufacturer and minor device
number for a ChosKey device that generates a insecure sequence, it
will still get blindly trusted by the kernel without any kind of
authentication of said hardware device.)

That probably means we need to come up with a new interface than
/dev/hwrng, or have some way of configuring /dev/random to use a
hardware RNG device for those people who really care about "true
randomness".  The current /dev/hwrng interface and how it is
configured via sysfs is pretty baroque IMO.

	      	  	     	       	  	 - Ted
