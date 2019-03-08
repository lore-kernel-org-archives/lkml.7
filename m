Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1F820811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="IRmCpkKo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJ/7nar+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCHFYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:24:22 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32789 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfCHFYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:24:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 91F172202C;
        Fri,  8 Mar 2019 00:24:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 08 Mar 2019 00:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=eMUKKB1zPDC3YKL0mYQYCd5vuOL
        hPBa2EO0OfvGJOMw=; b=IRmCpkKoobKuG0Hmhry+DuobY0zERN9csXwUIx3kXAG
        bo4Xb/EKHJEecR6Hlnj7hGxVmIY+kdsU9t2rx2wrsH4WFrZOMvt6ZQEpT9VZseYN
        3Whs8/SEbHV96qZEmQexywoNLl6gPbFmq8GLHub8HIvH6JawJy7r4p42OcHkbotv
        xuswW6WKSdmIyYNgOi+e+8abeG8hkx/qQsIyRwe01oBc6WW03Qth7XJ5/DPOZMbB
        gyLaihvaxdbO+gRIVrJ0yEwybDZs2tLTVuveVzXITX6+OpKsODGEOjyKuvk1F/oV
        fIBBQKry+Wqq7dKMR5gTypmLvSepAT2B38mVr3ZVhUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eMUKKB
        1zPDC3YKL0mYQYCd5vuOLhPBa2EO0OfvGJOMw=; b=PJ/7nar+17JSM9dj4k97Yf
        Gi2eo99QW8T4Jh4szpAozgEYA+pVgOlB3iJl+bm65FQbOv3Obn/7fCDokKVxI37R
        hAqDot4/sC7Lt+9qA6GzwdKUxJc5lhEO2Y9NKTWBaZMgiy5wk4taT+B9D7vWo3KF
        cCxsNvrWtu4xpCdLcOiS2lfWsCp3zxcQttMxZJFHXO4ileQ9PAbEB4YzBv3X4gbQ
        pp8Rv2cCNYeRQxqqBOYJkrkya+by+f7MdFE1FuQUNs+pBipXbEYxQKN03FcVImKx
        A9bdi5wW2a1YfzM0CIKPEn8EuCMeZMIngu2LAxxaxvpKXpbnECnmuGXopUEEf2Ow
        ==
X-ME-Sender: <xms:f_yBXJKkRjfQzwIBSWWtknmPH-OKJNVygj_QzU0RrgglN6bygCuGaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:f_yBXEt9pfHMMpkdCAmLQA5c4Y7zyWrZxTetyZxoy3l9NEteHXHH2w>
    <xmx:f_yBXGBOp__lsPnc7_G6a6FN3__pC2ru3oyb7x4zjGql8iiIn9N_3g>
    <xmx:f_yBXM4eB-w6Uj2Zam3OcwW4zo1zpWROuqMZU8HiMUKAdvYOx114ng>
    <xmx:gvyBXHozn-Dofs6H208bD2Y_6JTDGAVkyIULiPTr5tzT-hn_0r1MBA>
Received: from localhost (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42681E4360;
        Fri,  8 Mar 2019 00:24:14 -0500 (EST)
Date:   Fri, 8 Mar 2019 16:23:53 +1100
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
Message-ID: <20190308052353.GD17221@eros.localdomain>
References: <20190306214226.14598-1-tobin@kernel.org>
 <20190306214934.GA16461@eros.localdomain>
 <20190307211858.GA28495@eros.localdomain>
 <CAGXu5jLdCQ0QtCdbbfE+=JccZk01aSdV_5dWVj6g8X-dKpOr8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLdCQ0QtCdbbfE+=JccZk01aSdV_5dWVj6g8X-dKpOr8Q@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 02:43:57PM -0800, Kees Cook wrote:
> On Thu, Mar 7, 2019 at 1:19 PM Tobin C. Harding <me@tobin.cc> wrote:
> >
> > On Thu, Mar 07, 2019 at 08:49:34AM +1100, Tobin C. Harding wrote:
> > > On Thu, Mar 07, 2019 at 08:42:19AM +1100, Tobin C. Harding wrote:
> > > > Hi,
> > >
> > > Man, I didn't see the merge window was open, I thought rc8 only came out
> > > on Sunday.
> > >
> > > Sorry, please ignore this.  Will re-send again later in the cycle.
> >
> > Multiple people have suggested to me (offlist) that it is fine to go
> > right ahead and send patches whenever.
> >
> > Shuah, do you take patches to kselftest at any stage of the dev cycle?
> >
> > Kees, same question please?
> 
> I don't official "close" my tree, but I'm certainly less likely to
> respond in a timeline manner near the merge window. ;) (And as a
> result, I haven't had a chance to look these over yet.)

Two weeks and I'm throwing eggs at your house.

	Tobin
