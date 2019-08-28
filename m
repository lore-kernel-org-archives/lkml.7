Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0AAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A68206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH1LcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:32:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:55558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfH1LcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:32:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A700AED0;
        Wed, 28 Aug 2019 11:32:17 +0000 (UTC)
Date:   Wed, 28 Aug 2019 13:32:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Enrico@kleine-koenig.org,
        Weigelt@kleine-koenig.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        metux IT consult <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
Message-ID: <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827211244.7210-1-uwe@kleine-koenig.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-08-27 23:12:44, Uwe Kleine-König  wrote:
> Petr Mladek had some concerns:
> > The array is long, created by cpu&paste, the index of each code
> > is not obvious.
> 
> Yeah right, the array is long. This cannot really be changed because we
> have that many error codes. I don't understand your concern about the
> index not being obvious. The array was just a list of (number, string)
> pairs where the position in the array didn't have any semantic.

I missed that the number was stored in the array as well. I somehow
expected that it was array of strings.


> > There are ideas to make the code even more tricky to reduce
> > the size, keep it fast.
> 
> I think Enrico Weigelt's suggestion to use a case is the best
> performance-wise so that's what I picked up. Also I hope that
> performance isn't that important because the need to print an error
> should not be so common that it really hurts in production.

I personally do not like switch/case. It is a lot of code.
I wonder if it even saved some space.

If you want to safe space, I would use u16 to store the numbers.
Or I would use array of strings. There will be only few holes.

You might also consider handling only the most commonly
used codes from errno.h and errno-base.h (1..133). There will
be no holes and the codes are stable.


> > Both, %dE modifier and the output format (ECODE) is non-standard.
> 
> Yeah, obviously right. The problem is that the new modifier does
> something that wasn't implemented before, so it cannot match any
> standard. %pI is only known on Linux either, so I think being
> non-standard is a weak argument.

I am not completely sure that %p modifiers were a good idea.
They came before I started maintaining printk(). They add more
complex algorithms into paths where we could not report problems
easily (printk recursion). Also they are causing problems with
unit testing that might be done in userspace. These non-standard
formats cause that printk() can't be simply substituted by printf().

I am not keen to spread these problems over more formats.
Also %d format is more complicated. It is often used with
already existing modifiers.


> > Upper letters gain a lot of attention. But the error code is
> > only helper information. Also many error codes are misleading because
> > they are used either wrongly or there was no better available.
> 
> This isn't really an argument against the patch I think. Sure, if a
> function returned (say) EIO while ETIMEOUT would be better, my patch
> doesn't improve that detail. Still
>
>         mydev: Failed to initialize blablub: EIO
>
> is more expressive than
> 
>         mydev: Failed to initialize blablub: -5

OK, upper letters probably are not a problem.

But what about EWOULDBLOCK and EDEADLOCK? They have the same
error codes as EAGAIN and EDEADLK. It might cause a lot of confusion.
People might spend a lot of time searching for EAGAIN before they
notice that EWOULDBLOCK was used in the code instead.

Also you still did not answer the question where the idea came from.
Did it just look nice? Anyone asked for it? Who? Why?


> > There is no proof that this approach would be widely acceptable for
> > subsystem maintainers. Some might not like mass and "blind" code
> > changes. Some might not like the output at all.
> 
> I don't intend to mass convert existing code. I would restrict myself to
> updating the documentation and then maybe send a patch per subsystem as an
> example to let maintainers know and judge for themselves if they like it or
> not. And if it doesn't get picked up, we can just remove the feature again next
> year (or so).

It looks like a lot of potentially useless work.


> I dropped the example conversion, I think the idea should be clear now
> even without an explicit example.

Please, do the opposite. Add conversion of few subsystems into the
patchset and add more people into CC. We will see immediately whether
it makes sense to spend time on this.

I personally think that this feature is not worth the code, data,
and bikeshedding.

Best Regards,
Petr
