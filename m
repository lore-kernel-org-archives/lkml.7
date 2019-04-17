Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32706C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A759206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfDQOdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:33:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45810 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732557AbfDQOd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:33:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F8BA78;
        Wed, 17 Apr 2019 07:33:28 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E33E03F557;
        Wed, 17 Apr 2019 07:33:24 -0700 (PDT)
Subject: Re: [PATCH v8 00/20] Convert x86 & arm64 to use generic page walk
To:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190403141627.11664-1-steven.price@arm.com>
 <4e804c87-1788-8903-ccc9-55953aa6da36@arm.com>
 <3b9561d0-3bde-ef7a-0313-c2cc6216f94d@intel.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3acbf061-8c97-55eb-f4b6-163a33ea4d73@arm.com>
Date:   Wed, 17 Apr 2019 15:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3b9561d0-3bde-ef7a-0313-c2cc6216f94d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 15:44, Dave Hansen wrote:
> On 4/10/19 7:56 AM, Steven Price wrote:
>> Gentle ping: who can take this? Is there anything blocking this series?
> 
> First of all, I really appreciate that you tried this.  Every open-coded
> page walk has a set of common pitfalls, but is pretty unbounded in what
> kinds of bugs it can contain.  I think this at least gets us to the
> point where some of those pitfalls won't happen.  That's cool, but I'm a
> worried that it hasn't gotten easier in the end.

My plan was to implement the generic infrastructure and then work to
remove the per-arch code for ptdump debugfs where possible. This patch
series doesn't actually get that far because I wanted to get some
confidence that the general approach would be accepted.

> Linus also had some strong opinions in the past on how page walks should
> be written.  He needs to have a look before we go much further.

Fair enough. I'll post the initial work I've done on unifying the
x86/arm64 ptdump code - the diffstat is a bit nicer on that - but
there's still work to be done so I'm posting just as an RFC.

Thanks,

Steve
