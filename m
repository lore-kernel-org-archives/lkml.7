Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF6BC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D472089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfECNcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:32:11 -0400
Received: from ozlabs.org ([203.11.71.1]:48915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfECNcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:32:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wY2Z5SZTz9sDn;
        Fri,  3 May 2019 23:32:06 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190502122128.GA2670@kroah.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com> <20190415051919.GA31481@infradead.org> <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com> <20190502122128.GA2670@kroah.com>
Date:   Fri, 03 May 2019 23:31:48 +1000
Message-ID: <87ef5fy88r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:
> On Mon, Apr 15, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:
>> On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>> >
>> > Can we please have the page refcount overflow fixes out on the list
>> > for review, even if it is after the fact?
>> 
>> They were actually on a list for review long before the fact, but it
>> was the security mailing list. The issue actually got discussed back
>> in January along with early versions of the patches, but then we
>> dropped the ball because it just wasn't on anybody's radar and it got
>> resurrected late March. Willy wrote a rather bigger patch-series, and
>> review of that is what then resulted in those commits. So they may
>> look recent, but that's just because the original patches got
>> seriously edited down and rewritten.
>> 
>> That said, powerpc and s390 should at least look at maybe adding a
>> check for the page ref in their gup paths too. Powerpc has the special
>> gup_hugepte() case, and s390 has its own version of gup entirely. I
>> was actually hoping the s390 guys would look at using the generic gup
>> code.
>> 
>> I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
>> largely irrelevant, partly since even theoretically this whole issue
>> needs a _lot_ of memory.
>> 
>> Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
>> (page ref overflow)"). You may or may not really care.
>
> I've now queued these patches up for the next round of stable releases,
> as some people seem to care about these.
>
> I didn't see any follow-on patches for s390 or ppc64 hit the tree for
> these changes, am I just missing them and should also queue up a few
> more to handle this issue on those platforms?

No you haven't missed them for powerpc. It's on my list.

cheers
