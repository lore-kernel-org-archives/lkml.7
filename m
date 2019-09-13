Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5753C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EB02084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568388082;
	bh=+6GdpZ0O3YbNJKjrM1giv9kYLtozeTpToDWgbjtGWX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xk5z3P2MLv7i4uCV7ebnFk4eyI6x9wjAQAPRh649QqUkyBPaRdiflvL0MBiytrU0P
	 uNjU2hkCCdKSl9L9aXBfqnK7250IrUnKjqGRIalipgpqbfatixxSVRHf5rhmFPJNCD
	 efVsHFoRBIv9/V2vormacbG2kiDW97txKOk+pLNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403910AbfIMPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388354AbfIMPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:21:20 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821DB20717;
        Fri, 13 Sep 2019 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568388080;
        bh=+6GdpZ0O3YbNJKjrM1giv9kYLtozeTpToDWgbjtGWX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJfj29OEMLko69rdIb/Mnmjca/GGH9fAeRSRzlZsd34LIqyPtSVdsMV2T1zz7a3Un
         90LQxOCZoL0njVuVqptkAA/Db5+ieByVY5Uge10RA4AHGuAhwfdx+UJ7ep9bqqrwVL
         j2cvVHVtyW6F0WLcGH+Bn5aDEWc/4yQUhysJ86Y8=
Date:   Fri, 13 Sep 2019 16:21:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 0/6] make use of gcc 9's "asm inline()"
Message-ID: <20190913152117.GA458892@kroah.com>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
 <CANiq72n_KxKGwrN4onWotocTuZjVSAqENF_5Pk9t1-pk7NDrgQ@mail.gmail.com>
 <d47740cc-a373-91a9-df33-d2def69a370d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47740cc-a373-91a9-df33-d2def69a370d@rasmusvillemoes.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 08:11:24AM +0200, Rasmus Villemoes wrote:
> On 13/09/2019 00.30, Miguel Ojeda wrote:
> > On Fri, Sep 13, 2019 at 12:19 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> Patch 1 has already been picked up by Greg in staging-next, it's
> >> included here for completeness. I don't know how to route the rest, or
> >> if they should simply wait for 5.5 given how close we are to the merge
> >> window for 5.4.
> > 
> > If you want I can pick this up in compiler-attributes and submit it as
> > a whole if we get Acks from rtl8723bs/x86/...maintainers.
> 
> Ingo has now acked the x86 parts, and Greg has already picked up the
> rtl8723bs patch, which is at least an implicit ack. I'm just unsure of
> how and if it will work if you also pick up that one - but, if you
> don't, your tree would be (somewhat) dependent on Greg's staging-next :(

Feel free to also take that patch through any tree, it's "obviously
correct" :)

greg k-h
