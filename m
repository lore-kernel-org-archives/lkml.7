Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0990BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0892147A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfGXOiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:38:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44227 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:38:01 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqIOx-0002MW-0J; Wed, 24 Jul 2019 16:37:55 +0200
Date:   Wed, 24 Jul 2019 16:37:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Price <steven.price@arm.com>
cc:     Mark Rutland <mark.rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
In-Reply-To: <fd898367-b44e-9328-bdab-7a3de0db6bda@arm.com>
Message-ID: <alpine.DEB.2.21.1907241620140.1791@nanos.tec.linutronix.de>
References: <20190722154210.42799-1-steven.price@arm.com> <20190723101639.GD8085@lakrids.cambridge.arm.com> <e108b8a6-deca-e69c-b338-52a98b14be86@arm.com> <alpine.DEB.2.21.1907241541570.1791@nanos.tec.linutronix.de>
 <fd898367-b44e-9328-bdab-7a3de0db6bda@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019, Steven Price wrote:
> On 24/07/2019 14:57, Thomas Gleixner wrote:
> > From your 14/N changelog:
> > 
> >> This keeps the output shorter and will help with a future change
> > 
> > I don't care about shorter at all. It's debug information.
> 
> Sorry, the "shorter" part was because Dave Hansen originally said[1]:
> > I think I'd actually be OK with the holes just not showing up.  I
> > actually find it kinda hard to read sometimes with the holes in there.
> > I'd be curious what others think though.

I missed that otherwise I'd have disagreed right away.

> > I really do not understand why you think that WE no longer care about the
> > level (and the size) of the holes. I assume that WE is pluralis majestatis
> > and not meant to reflect the opinion of you and everyone else.
> 
> Again, I apologise - that was sloppy wording in the commit message. By
> "we" I meant the code not any particular person.

Nothing to apologize. Common mistake of trying to impersonate code. That
always reads wrong :)

> > I have no idea whether you ever had to do serious work with PT dump, but I
> > surely have at various occasions including the PTI mess and I definitely
> > found the size and the level information from holes very useful.
> 
> On arm64 we don't have those lines, but equally it's possible they might
> be useful in the future. So this might be something to add.
> 
> As I said in a previous email[3] I was dropping the lines from the
> output assuming nobody had any objections. Since you find these lines
> useful, I'll see about reworking the change to retain the lines.

That would be great and as I saw in the other mail, Mark wants to have them
as well :)

That reminds me, that I had a patch when dealing with L1TF which printed
the PFNs so I could verify that the mitigations do what they are supposed
to do, but that patch got obviously lost somewhere down the road.

Thanks,

	tglx

