Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EDFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D522063F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pQSkpTK4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p8H23UJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfD2Mx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:53:29 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43099 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727764AbfD2Mx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:53:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 05BFD1712C;
        Mon, 29 Apr 2019 08:53:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2019 08:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7t6HCb5MIvBwPGd9lLqnMAnD0EN
        qZfjKArzh/jOYawQ=; b=pQSkpTK4Nkx+LOcWY6XPnQlB1rcCXgwe9VKB0vFHN0/
        uP43e5DhHA8tnuNAGk6n48DtBbVmJhaQ2aw6p2pimUmHcdAZ/u2nH66ZXn2MwFpS
        W66zeSBJxgqaNO1Gz/LWHyf1Afkd/Iriwf+GPVol/ODl/GumFLX2B7ot3o2O6H9b
        6DVNI9YB4+1YT3WplleBtu8JB6piIO6XTtI52NVTp26i0OIHf6Iof7dVzwOekg4/
        TvgAcCexMkqbrJcCr2DgVwG0TDKuv3Q+UqVvKwu+YTXJ34vp4hCgUoWw8yTRW2S8
        7VVZ8c14wft+WtiZ2uBvH479j/c5gRRYIc3ro74fHqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7t6HCb
        5MIvBwPGd9lLqnMAnD0ENqZfjKArzh/jOYawQ=; b=p8H23UJwrPfTA/Tt07gxfN
        Fw2uhKSfXiBPaYi9HLzyOZzm8yCLpDmXVBOoc0t9m9mM84guVHu7d1spMMnca/gd
        YOH1pEQKWBhRfykQcEeXRg7E3SJVgF5Z1vA1B2hXLXRENt3yXjgfKTxg1Lltl+Oo
        IIM5Z55OVO9QcUkyHvYB9FYmMAA7SeBLtkS1NbS+LC2euErgJnxbChrh67iI8kjx
        whcP8tFBBiBv+QG+qJA+thSZRneFV5uA1aIunQEjBX5/zJ6K78O9d2CnWPwWD9XG
        u9Lg/ZIzR5zY6uK9A8foQH3bBZrSqWPH4Ic0WyWN++9mbjIFrUiUgYfY5an/SV+w
        ==
X-ME-Sender: <xms:wvPGXOC4hPno-WwZ2-Thqar9pBscwHwmKsBTXJvIbhTseo9_keemeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddriedvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgpdhgihhthhhusgdrtghomhenucfkphepkeefrdekiedrkeelrddutdejnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvg
    hrufhiiigvpedt
X-ME-Proxy: <xmx:wvPGXPdU_z6N4-gCE-PCchdh8Zzi_S0fOFip13nfQhs-JkUN2g-hAg>
    <xmx:wvPGXGppsHCpeDm2-gGKUQjP3-LRQZsh09zV_O8LnywRMR7C5w-C-g>
    <xmx:wvPGXD5WQLglffVgvhKY8kIOwc9ZqYDDxbyzo_1eDRQ1DfrVh-WKcA>
    <xmx:xfPGXOmHDiEipAulLyviXuAmwNjBE7Zo6anWg53tX3PjYc5PtpgsZQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FF1CE432B;
        Mon, 29 Apr 2019 08:53:22 -0400 (EDT)
Date:   Mon, 29 Apr 2019 14:53:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [x86, retpolines] ce02ef06fc: will-it-scale.per_thread_ops
 3.1% improvement
Message-ID: <20190429125320.GA24513@kroah.com>
References: <20190313052715.GB8429@shao2-debian>
 <aa1de169-1c61-f8bc-10db-437f4e6ce6b3@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1de169-1c61-f8bc-10db-437f4e6ce6b3@iogearbox.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 09:39:35AM +0100, Daniel Borkmann wrote:
> On 03/13/2019 06:27 AM, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a 3.1% improvement of will-it-scale.per_thread_ops due to commit:
> > 
> > 
> > commit: ce02ef06fcf7a399a6276adb83f37373d10cbbe1 ("x86, retpolines: Raise limit for generating indirect calls from switch-case")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: will-it-scale
> > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> > with following parameters:
> > 
> > 	nr_task: 100%
> > 	mode: thread
> > 	test: futex3
> > 	cpufreq_governor: performance
> > 	ucode: 0xb00002e
> > 
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> > 
> > In addition to that, the commit also has significant impact on the following tests:
> 
> Any thoughts on whether the above one-liner gcc work-around should be backported
> to stable as well given these gains?

I have now done so, thanks.

greg k-h
