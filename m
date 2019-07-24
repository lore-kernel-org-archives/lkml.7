Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04359C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D579C21BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfGXMaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:30:12 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:58382 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfGXMaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:30:12 -0400
X-Greylist: delayed 1449 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jul 2019 08:30:11 EDT
Received: from [37.164.191.68] (helo=opteyam2)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1hqG1s-000DGH-PU; Wed, 24 Jul 2019 14:05:57 +0200
Message-ID: <bc1ad99a420dd842ce3a17c2c38a2f94683dc91c.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 24 Jul 2019 14:05:48 +0200
In-Reply-To: <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
References: <cover.1563841972.git.joe@perches.com>
         <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
         <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk>
         <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.164.191.68
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 23 juillet 2019 à 15:41 +0000, David Laight a écrit :
> From: Rasmus Villemoes
> > Sent: 23 July 2019 07:56
> ...
> > > +/**
> > > + * stracpy - Copy a C-string into an array of char
> > > + * @to: Where to copy the string, must be an array of char and
> > > not a pointer
> > > + * @from: String to copy, may be a pointer or const char array
> > > + *
> > > + * Helper for strscpy.
> > > + * Copies a maximum of sizeof(@to) bytes of @from with %NUL
> > > termination.
> > > + *
> > > + * Returns:
> > > + * * The number of characters copied (not including the trailing
> > > %NUL)
> > > + * * -E2BIG if @to is a zero size array.
> > 
> > Well, yes, but more importantly and generally: -E2BIG if the copy
> > including %NUL didn't fit. [The zero size array thing could be made
> > into
> > a build bug for these stra* variants if one thinks that might
> > actually
> > occur in real code.]
> 
> Probably better is to return the size of the destination if the copy
> didn't fit
> (zero if the buffer is zero length).
> This allows code to do repeated:
> 	offset += str*cpy(buf + offset, src, sizeof buf - offset);
> and do a final check for overflow after all the copies.
> 
> The same is true for a snprintf()like function
> 

Beware that snprintf(), per C standard, is supposed to return the
length of the formatted string, regarless of the size of the
destination buffer.

So encouraging developper to write something like code below because
snprintf() in kernel behave in a non-standard way, will likely create
some issues in the near future.

  for(;...;)
    offset += snprintf(buf + offset, size - offset, "......", ....);

(Reminder: the code below is not safe and shouldn't be used)

Regards.

-- 
Yann Droneaud
OPTEYA


