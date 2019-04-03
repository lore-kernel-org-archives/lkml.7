Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF7D206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="WxQ/hWGP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnBZStai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDCA0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:26:02 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53857 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfDCA0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:26:02 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D157622033;
        Tue,  2 Apr 2019 20:26:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2019 20:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Tz26dWEbMGggtlREnkrDtbVMgLz
        iI8ZbrSw5g/Znei4=; b=WxQ/hWGP2sJsgmli7XKDUWvZv7ylVyD7VK/ryyG2A4L
        tXNYcJ5lGTngJxLFR8f7APBeQg9+tL3RNWhHJVqoeSVqKuY7BqkWeDxM3EguB0Hc
        NyGJEP7THaYyN8X9pnBec1QXqNtc+B1VlI/LhsC8cU/hVdj1+UJ/embFDeyNeGPY
        CFO83R18MOoAgHa37ddXLBoP1tZ2vdSX5BiWgimohr3f6x+Z27cTc3Kdm6Xk8yxn
        pV0KcHzbMikc9iyGwfWw5iXaCC0PWkPe91AV48xezVJIpGXBnDBqcbqhyefK6k6o
        UGQ9j+4L/WJ+YxLh6bG8ty7RvfbTKS73XS0ALSwPXpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Tz26dW
        EbMGggtlREnkrDtbVMgLziI8ZbrSw5g/Znei4=; b=JnBZStaihT9G6boh0IpKkm
        W2QqWTJmW20c5152ju5fwpTbQjzc3jKd0LxN1Kg64jtKnmTg+yGRuOQDSR7GlTVh
        77Kmgs+xMVxoTbJ6pyKfefaWelpKh1pmdyQSHGYJHMp9sdZBA284S1AQE7VRo+Cs
        1KcFm3aiJES4zEuZXuIivNaTXwXpv7CkEutJjT4+eAIZN5bvHjK68pxyKxgTUBso
        +2Td5cUuZwERh0ztvnlqUDw/+p7pkSwTpGsay+UlY8d5hXw2ZopfsAPBilM+2xR6
        1wd9BEFITHJOFipURPxAG5kleaOqXRWiHUpmV6wG35ct7WV7NX/1Mf+1FrmP6xVQ
        ==
X-ME-Sender: <xms:lf2jXDY823Md3OfhYFJI2DVIz1r4eCLsL1_Q8ulaCI0LcVL8-pGPBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdefvdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhf
    gggtuggjofgfsehttdertdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrug
    hinhhgfdcuoehmvgesthhosghinhdrtggtqeenucfkphepuddvgedrudeiledrvdejrddv
    tdeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluh
    hsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:lf2jXJzsjdtWPEyVM6KMXOzVtu1wkm-ze0nrA-8xgFaiZg-cIeD5rA>
    <xmx:lf2jXB80QdhOoqZTPeiBlS0VJ3XGTAIxve_7rDxo4ATi4XtWOcFgmw>
    <xmx:lf2jXDSgsIqdqg9nhF5vKOBn9wRagcnyk2ZhuEUpuY8GuqSPF2Ab9w>
    <xmx:mP2jXHojYIL23mIcNVdBUl3cbHBx7pYCmfKF-RwmFJT8wsXyYnTS0g>
Received: from localhost (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 368D0100E5;
        Tue,  2 Apr 2019 20:25:55 -0400 (EDT)
Date:   Wed, 3 Apr 2019 11:25:27 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] lib/string: Add strscpy_pad() function
Message-ID: <20190403002527.GB29296@eros.localdomain>
References: <20190306214226.14598-1-tobin@kernel.org>
 <CAGXu5jJeFOBBiofjG6_rqbf+_0fbKC46pzyfoACWt+NBg-bXtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJeFOBBiofjG6_rqbf+_0fbKC46pzyfoACWt+NBg-bXtg@mail.gmail.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:37:57PM -0700, Kees Cook wrote:
> On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
> > This set makes an attempt at adding a framework to kselftest for writing
> > kernel test modules.  It also adds a script for use in creating script
> > test runners for kselftest.  My macro-foo is not great, all criticism
> > and suggestions very much appreciated.  The design is based on test
> > modules lib/test_printf.c, lib/test_bitmap.c, lib/test_xarray.c.
> 
> Hi Shuah,
> 
> The bulk of this series is in the kselftests. Would you be willing to
> carry this series?
> 
> I think it might be able to use a v4 just to clean up the
> script-finding logic, but I might be entirely missing something about
> the best way to do it.

v4 to come once I grok the bash stuff you suggested in 'PATCH v3.1'.

thanks,
Tobin.
