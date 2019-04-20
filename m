Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556ECC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E7E20833
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QpK1Wuo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfDTTEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:04:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48406 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbfDTTEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:04:49 -0400
Received: from zn.tnic (p200300EC2F112E00E1C548496DF7C17A.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:e1c5:4849:6df7:c17a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE5071EC014A;
        Sat, 20 Apr 2019 21:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555787086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ShvJsdhScM7s7cbfAJAGtm4jgWtD1rQ7Rc7XC1MIgWo=;
        b=QpK1Wuo2uTC3kJRxsiJu5fojgPmk+cnYUnGh22mvEtMlYq31b7TJgVF2ANm2c4euIBYI9q
        YLSYPjpNI5S7kaqIxc15OM7IPVNgbsPSghvI7cjcyJlS2cnlSb1jyHDDL5egH4jER1yGbz
        zLHx11KwI36yUYgLBIH5/kKffCNLCK0=
Date:   Sat, 20 Apr 2019 21:04:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] ras: fix an off-by-one error in __find_elem()
Message-ID: <20190420190442.GF29704@zn.tnic>
References: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
 <20190416214634.GP31772@zn.tnic>
 <CAM_iQpVd02zkVJ846cj-Fg1yUNuz6tY5q1Vpj4LrXmE06dPYYg@mail.gmail.com>
 <20190420113444.GC29704@zn.tnic>
 <CAM_iQpXKWDr4AbROO=ZbkxwQHkj4anA9FJAaohOqg1SCq0L7eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_iQpXKWDr4AbROO=ZbkxwQHkj4anA9FJAaohOqg1SCq0L7eg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:25:43AM -0700, Cong Wang wrote:
> If you want to go that far, you can choose to use lib/bsearch.c too in
> case you want to reinvent the wheel.

Well, that doesn't give me the @to functionality which points to the
slot where the new element should be inserted, when the search was
unsuccessful.

> What's your point here?

My point is to fix it properly. Obviously.

> You know my fix is targeted for -stable,

Well, first you sent me this:

https://lkml.kernel.org/r/20190416012001.5338-1-xiyou.wangcong@gmail.com

then this:

https://lkml.kernel.org/r/20190416213351.28999-1-xiyou.wangcong@gmail.com

Tony liked this second version more and if you look at the final result of mine:

	int min = 0, max = ca->n - 1;

	...

                if (this_pfn < pfn)
                        min = i + 1;
                else if (this_pfn > pfn)
                        max = i - 1;
                else if (this_pfn == pfn) {
                        if (to)
                                *to = i;
                        return i;
                }

it has basically *both*: the correct [min:max] range *and* the return of
ithe ndex when found. But the algorithm this time is the correct one.

> I doubt your 83-line change could fit for -stable.

My 83-line change has debug output only for experimentation. It will,
*of* *course* be removed before committing it upstream. That's why I
called it "a conglomerate patch" and I said "It has some debug output
for easier debugging, that will be removed in the final version, of
course." I guess you didn't read that either.

And the sanity_check() piece will be a separate patch, of course.

In the end the diffstat will be 30-40 lines max.

> Feel free to drop my patch to favor yours. I am really tired.

Suit yourself. Thanks for the reporting.

> Good luck with that!

Ditto.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
