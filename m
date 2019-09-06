Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D54C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B6D20693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b="i0IQ2nfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405831AbfIFPqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:46:20 -0400
Received: from out.bound.email ([141.193.244.10]:46721 "EHLO out.bound.email"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392834AbfIFPqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:46:20 -0400
Received: from mail.sventech.com (localhost [127.0.0.1])
        by out.bound.email (Postfix) with ESMTP id 233EB8A30DF;
        Fri,  6 Sep 2019 08:46:19 -0700 (PDT)
Received: by mail.sventech.com (Postfix, from userid 1000)
        id 0841C16001D9; Fri,  6 Sep 2019 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
        s=default; t=1567784779;
        bh=eBlOVLfggcwOPxI4VN9G8ioY2gar25PrXIsBZRxpLxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0IQ2nfNoO1DT3lznsrNlpQJeuJ2LVZtgy0gHfA31FcEkTne/nOalwG6ojr0OeZ1I
         978u89+rUiJVkYZmluwK/xtbBsRoFf4zednw75DIvvskcUIWcA9L2XDv5vDGCG9Ugo
         ybW9yY7u7wBoUOXMyeRRn66IYENpZkIhxnf7F6qs=
Date:   Fri, 6 Sep 2019 08:46:18 -0700
From:   Johannes Erdfelt <johannes@erdfelt.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190906154618.GB29569@sventech.com>
References: <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <20190906151617.GE19008@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906151617.GE19008@zn.tnic>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Sep 06, 2019 at 07:40:39AM -0700, Johannes Erdfelt wrote:
> > I ask because we have successfully used late microcode loading on tens
> > of thousands of hosts.
> 
> How do you deal with all the mitigations microcode loaded late?

We developed livepatches to add the necessary support. I understand we
aren't the typical Linux user. We do custom development and validation
to support our use case.

That said, we very much rely on late microcode loading and it has helped
us and our customers significantly.

> > I'm a bit worried to see that there is a push to remove a feature that
> > we currently rely on.
> 
> I'd love to remove it. And the fact that people rely on it more instead
> of fixing their infrastructure to reboot machines and do early microcode
> updates is making it worse. Microcode update should be batched with
> kernel updates and that's it. They happen normally once-twice per year -
> except the last two years but the last two years are not normal anyway
> - and done. No need to do some crazy CPUID features reloading dances in
> the kernel and making sure cores will see the updated paths and so on.

It's really easy to say "fix your infrastructure" when you're not
running that infrastructure.

Reboots suck. Customers hate it. Operations hates it. When you get into
the number of hosts we have, you run into all kinds of weird failure
scenarios. (What do you mean that the NIC that was working just fine
before the reboot is no longer seen on the PCI bus?)

The more reboots we can avoid, the better it is for us and our
customers.

I understand that it could be unsafe to late load some rare microcode
updates (theoretical or not). However, that is certainly the exception.
We have done this multiple times on our fleet and we plan to continue
doing so in the future.

There just aren't any good alternatives currently.

JE

