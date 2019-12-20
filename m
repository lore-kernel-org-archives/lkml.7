Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6500C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D25220866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VZQQNJhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLTTKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:10:01 -0500
Received: from mout.web.de ([212.227.17.12]:52641 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfLTTKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576868980;
        bh=8mNUtczznW3ZSayhvMTQE2gzza06gaIgPWinSy/QvMQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VZQQNJhdgJCitWAZBLWj7VvxMt8RDsquXwNLKMBkXa2VmgxU5XKT5j4rl+uyKdIkw
         XSbnasL10l1dZucnpWsqhywSTFJYU55bRtgt0rLm+SyJOU/wphoiEOIWY2Q6E5BNDb
         3TY+IsaNf8ngIGyOk2ozMHygq7h02ym45wHW+AJI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([67.254.165.9]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpO93-1i3Wef03dN-00fBzV; Fri, 20
 Dec 2019 20:09:40 +0100
From:   Malte Skarupke <malteskarupke@web.de>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm,
        malteskarupke@web.de
Subject: [PATCH] futex: Support smaller futexes of one byte or two byte size.
Date:   Fri, 20 Dec 2019 14:08:59 -0500
Message-Id: <20191220190901.23465-1-malteskarupke@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204235238.10764-1-malteskarupke@web.de>
References: <20191204235238.10764-1-malteskarupke@web.de>
X-Provags-ID: V03:K1:RHkd5v7v2+t6iIvfFNn80NML3HdKhLzlGqr9evs+VT9o3H5HzHK
 +vmf63Zq1FSLDfQja8ih/0nFhSj8y+SlRh7ZeDTbeUIi+wXtNGcuHOV6Erc/oNgF46VQanY
 AqnX89wm9gVB+YkaO2Pwdfou9So5dXzAmRLQG56p0NDEJ4yAP+U1/Ho64TVi0vdXdKVYYzE
 LGoJYMZK8Pp2q9UxnOajg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KLYn4/4HruY=:mDKlq2ZqNkV3F+tPGJRLDO
 ApNpENGrjw3jSH62NhGnYItCD04ldlQntMDY2lhIA0KnW+4XuzVA40zCtp/bFabJKMJY6SIGd
 eSNtdebSfoARzVPOzjuMwTW1MCWKjjwvczlMrZ4x5ACWPg8vkEEZLxiulJkL4cuXjS+GYBfE9
 4yxLLoLL8cjQi/uYpmznekvwkj9+JrpBLJ7b8c27MaECaRLa5nL8h7Db4hVrwhVV69YlV8ym/
 WQ3Pnqsb7MgNzvV98rkWSwJd44r6UOrh9mSt/P/Mrw7kyWgIz1uT1cxCGDXgjLUvQfL6GDgDo
 RIcvsiJ4w0MmrpOfw76aO8DDcd3Bd9Pzjz7t2ZTWR0G/u9h6A6QtP6mqpj8+XgcR7wEp86kam
 GlnIR2ft1N1reIsydxHn8G6kFnfH3E6BtLcZIsqqw2TlQ3n5VvuGiw7vrieoKUM7zTM/15vUC
 irSmJhO1bj/A8OKmN45MxSOSJowiVu6TPO3ry30fExX2VYnRAURZtoSBPfKp2Ad6z7JMDBSKM
 9mlSOO1IrYCxhm3+9faGhPVMQHDJ4m0nldrIctE4P25s6FZqB5Pasqu3sGoXvgU22XFW/urnt
 eqH65QbQtC35UWdSvs92Dbb+ZC/MJpzB7j656/0j9knxXfnC129BiFe1TMrTC4H/Qmy3TEcv0
 8+KAez+TVFOHLsLZFokbNIlPP6XeJ0BKaY+mOkNSucPODat5DqGJCUFzDEqtFfvJK4S3u/FV0
 6Vv+vdS0tJ3h1rS5pfCEOYvd1KR6xVZmmk3Q7Db/AfZsbVWrhYIp+tvnDhvCakQgoKkbvx5K3
 gdNyzMsxR8UlG3y3Za7lNfeUwBoPgjmkeWFhczbevEAa20vxJ2/VHUUBmwR/oPL6MMAoUze+q
 +druE7lU0+sbp4FfozQLD6/Y+h5pbEfwkR0z7oDhigu/ZqenULvR3BS9mKTFypA7XwIJor7en
 82CuRTlOhovSiEBMOt+TqMtz9UN7hZUNPC2pHnQBoSvs9P3UwfWmqwXHSjwIyWE/tWmEdmIh5
 pvgQAur4JnjbEI87bwKM7pEa27S9IyDCA7Ptg230RqjgKzVgsJ4BIu2ie/pZ94/utguxID5su
 GH464SeEBfYYWQydXAtRzaQ9oxhGSeiQRvCJLqHqYLB5RWvc7Kbpn4/2BLWbdvCqzkdEsFGV5
 Z1hX20Lp9CO6Wq68QuyeJJQMa6aYiejQ1UOVN2H0ZerjQVRy8o5j1JKzyYGU/W1Dtv8mXEn7v
 Vh2ym5if5mrfhyndrwmFWxDIZmeVwH8WCp/qu4AEC7gYe8lZm/GhAIRWVwm0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

here are two patches for sized futexes. Option 1 is the same behavior as my
first patch, just with the fixes suggested above. Option 2 requires a size
flag for WAKE and REQUEUE.

The reason for sending two changelists is that after thinking about it for a
while, and after implementing both options, I realized that I do care which
option we pick. I still prefer option 1. I would also be OK with going with
option 2, but let me try one final time to convince you with three reasons:

1. The consistent API conversation. There were two reasons voiced for this:
a) In a private email Thomas Gleixner voiced that just having two different
   calls, WAIT and WAKE, where one takes the size and the other does not,
   would be inconsistent. I would like to think about this in terms of another
   popular API where one takes a size and the other does not: malloc() and
   free(). Over the years many allocator implementers would have hoped that
   free() also takes a size because it can save a few instructions, and the
   user usually knows what they are freeing and could pass in the size. But
   what if there was a version of free() that doesn't need the size, but it
   still takes a size argument and only uses it to verify that the correct
   size was passed in: If you pass an incorrect size it errors out and doesn't
   actually free the memory. Would that be a better interface?

   Because that's essentially what I'm implementing here: WAKE doesn't need
   the size, and the only thing it uses the size for is to verify that it is
   correct, and if it's not, WAKE errors out and doesn't actually wake. I
   don't think that that makes it a better API.

b) On this mailing list Peter Zijlstra voiced that my implementation does not
   implement the MONITOR/MWAIT pattern. This wasn't a problem when there was
   only one size of futex, but it is once you can have overlapping futexes of
   different sizes. I can see that it might be nice to implement this pattern,
   but I chose to not do it mainly because mutexes and condition variables
   don't actually need it. They just need the same semantics we had before,
   except for smaller types. There is no need to handle overlapping futexes,
   so I propose a different mental model: Comparisons+hashtable lookup. Under
   that mental model only an exact match on the address between WAIT and WAKE
   will do anything, because otherwise you won't find anything in the
   hashtable. And under that mental model the size only applies to the
   comparison. That's what I implemented and what I prefer. Option 1 is a more
   internally consistent implementation in that mental model.

2. Precedent. When Windows added support for futexes, they supported different
   sizes of futexes from the beginning. In their API WaitOnAddress() is the
   equivalent to our FUTEX_WAIT, and WakeByAddressSingle() and
   WakeByAddressAll() are the equivalents to our FUTEX_WAKE. In the Windows
   API WaitOnAddress() takes a size, but the WakeByAddress calls do not take a
   size. Obviously there may be reasons to do things differently from how
   Windows does it, but it does show that at least some other programmers came
   to the same conclusions that I did.

3. Odd behavior. I made one change compared to what I wrote earlier in the
   discussion. Earlier I said that calling WAIT with two different sizes on
   the same address should probably not be allowed. The reason for that is
   that it can lead to unexpected behavior. If you do a 8 bit WAIT followed by
   a 16 bit WAIT on the same address, then call 8 bit WAKE on the same address
   twice, the first WAKE call will work and return 1, but the second WAKE call
   will return -EINVAL because of a size mismatch.

   I thought that that's just a bit too weird so I said that I wouldn't allow
   WAITs with different sizes. The reason why I changed my mind on that is
   that I would have to change what WAIT does. Instead of just inserting
   itself into a linked list, it would have to iterate through that linked
   list to check if anybody else already went to sleep with a different size.
   So a O(1) operation would turn into a O(n) operation. Since there can be
   condition variables where many threads sleep on the same futex, this would
   actually be fairly common. So I thought that that would be an unacceptable
   change in behavior. (and a similar change would have to be made to REQUEUE)
   So this does mean that in the version where WAKE verifies the size, you can
   get weird behavior if WAIT was called with two different sizes. (or maybe
   if somebody wasn't consistent with their usage of the flags in REQUEUE) I
   don't think this is a huge concern because I don't expect people to have
   different sized futexes on the same address, but it is a weird API quirk.
   If this does cause bugs, they should also be fairly obvious and easy to
   fix. But they would be bugs that you couldn't have with option 1.

So now that I have tried to convince you one final time, you're free to choose
whichever option that you like. And obviously if you have more feedback for
the code, I would also implement those fixes. Also if you want a patch without
the "option 1" or "option 2" text in the description, I can provide that.

Thanks,

Malte



