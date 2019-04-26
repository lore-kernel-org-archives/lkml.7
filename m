Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229C1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E904B206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDZUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:06:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38813 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726377AbfDZUGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:06:25 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3QK6Hwl021783
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 16:06:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3A361420003; Fri, 26 Apr 2019 16:06:17 -0400 (EDT)
Date:   Fri, 26 Apr 2019 16:06:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bharath Veda <linux.bhar@gmail.com>
Cc:     arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/char/random.c: Make add_hwgenerator_randomness
 static
Message-ID: <20190426200617.GF9835@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Bharath Veda <linux.bhar@gmail.com>, arnd@arndb.de,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190426182948.GA10020@bharath12345-Inspiron-5559>
 <CAMwgTV7k=32sSFYp38Ft8M-oXhcEqcOByO=fpUBMeS1_XvzN1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwgTV7k=32sSFYp38Ft8M-oXhcEqcOByO=fpUBMeS1_XvzN1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:52:25AM +0530, Bharath Veda wrote:
> Hi,
> 
> Please ignore this patch. It breaks the build.
> 
> On Fri, Apr 26, 2019 at 11:59 PM Bharath Vedartham <linux.bhar@gmail.com> wrote:
> >
> > Make add_hwgenerator_randomness static as it is only declared on
> > drivers/char/random.c

If one were to run the handy-dandy command "git grep
add_hwgenerator_randomness", one would find:

drivers/char/hw_random/core.c:          add_hwgenerator_randomness((void *)rng_fillbuf, rc,
drivers/char/random.c:void add_hwgenerator_randomness(const char *buffer, size_t count,
drivers/char/random.c:EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
drivers/net/wireless/ath/ath9k/rng.c:           add_hwgenerator_randomness((void *)rng_buf, bytes_read,
include/linux/hw_random.h:extern void add_hwgenerator_randomness(const char *buffer, size_t count, size_t entropy);

So the claim that it is only declared in drivers/char/random.c is not
true.

And of course, build-testing patches before sending them out for
review is a really good idea.

Cheers,

    	 	      	  	 	     	- Ted
