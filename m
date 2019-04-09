Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4147B20830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDIJux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:50:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58698 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfDIJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:50:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 55CAF80839; Tue,  9 Apr 2019 11:50:41 +0200 (CEST)
Date:   Tue, 9 Apr 2019 11:50:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vadim Pasternak <vadimp@mellanox.com>, jacek.anaszewski@gmail.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        idosch@mellanox.com, Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v1 bitops] bitops: Fix UBSAN undefined behavior warning
 for rotation right
Message-ID: <20190409095041.GA32344@atrey.karlin.mff.cuni.cz>
References: <20190407125325.24440-1-vadimp@mellanox.com>
 <20190408155217.3f723554ae7fbcb34eeacb30@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408155217.3f723554ae7fbcb34eeacb30@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (resend, cc Andrey)
> 
> On Sun,  7 Apr 2019 12:53:25 +0000 Vadim Pasternak <vadimp@mellanox.com> wrote:
> 
> > The warning is caused by call to rorXX(), if the second parameters of
> > this function "shift" is zero. In such case UBSAN reports the warning
> > for the next expression: (word << (XX - shift), where XX is
> > 64, 32, 16, 8 for respectively ror64, ror32, ror16, ror8.
> > Fix adds validation of this parameter - in case it's equal zero, no
> > need to rotate, just original "word" is to be returned to caller.
> > 
> > The UBSAN undefined behavior warning has been reported for call to
> > ror32():
> > [   11.426543] UBSAN: Undefined behaviour in ./include/linux/bitops.h:93:33
> > [   11.434045] shift exponent 32 is too large for 32-bit type 'unsigned int'
> 
> hm, do we care?
> 
> > ...
> >
> 
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -70,6 +70,9 @@ static inline __u64 rol64(__u64 word, unsigned int shift)
> >   */
> >  static inline __u64 ror64(__u64 word, unsigned int shift)
> >  {
> > +	if (!shift)
> > +		return word;
> > +
> >  	return (word >> shift) | (word << (64 - shift));
> >  }
> 
> Is there any known architecture or compiler for which UL<<64 doesn't
> reliably produce zero?  Is there any prospect that this will become a
> problem in the future?

Compiler is free to assume that shift !=0 after running ror64()... and
use that fact in optimalizations. so... if it is not problem today it
may easily become problem tommorow.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
