Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F5C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 02:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D3A208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 02:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnPKGYpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfHKCEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 22:04:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39354 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfHKCEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 22:04:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so8854134wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 19:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zhVdjHruZiQl0JBTlSzBUsJPhxHlp6YhNl0glgh5GWg=;
        b=UnPKGYpx+TU+ogxlV/TpeiXnN2RnqVVrTmR8uQ3CDen4QFsOOIK9V8SlzcYkEUazte
         l2F5PX5QOOt6cAcpz5WK5C+8+IVKsYtdYvc1SESOoAbqUbUCOZy5ewgfV7J9OnqI5Au2
         bhngoMM03H4AVJR7djruzCaVgsvPLbAB79swf9Lnl/aAJ9NjsL4ithfDXi6wKXb9GQgi
         q6wbYo+iEZKFrPNW6nyZWX971NXqknuxgSxq0J0mf2gGZNVzEeC4HT9vF/ww2uKO1O8r
         L2O3fMHepeFDTFv7GudaKV/hlGoIXqSw+Vsxt2qHp/bWQPIZyupAkWN1Y9JqXXbXqVSy
         KGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhVdjHruZiQl0JBTlSzBUsJPhxHlp6YhNl0glgh5GWg=;
        b=U8vmGAZDWuvHFGLBZxEEKUPt4vqOUTdU1xNxW/Bz9EpejnJdv/XuHDMnFBx6sfOhr0
         JGRMaFF7GfLiy2yQK2es3k0HWOAbhN/jKw8oiBnaj1tuSDSHNbS2hKFjo81/TAjvSLYo
         fFkG2f8T0PJNqqcxGsK2DVtG7Q9cQ29bjfVvQfozFsWr5GxK9O44w0fNs/034TsP7xYf
         LeZRWBDogkaA5WaAMzYX4DWll3odNEVMTIgHs21wnWSYPlXNLyknU1KSYA5gFEnhRJcZ
         VeVjO+rMrr3ICFvQrbMU26LYUx+oACyILCEqXBDnSfJrvZ12wBL1hbOTuA6K9gq7t8RJ
         fu0g==
X-Gm-Message-State: APjAAAVW6TvpZEb0V7Bp7yvtVrHjk/0FCjvT5tuMa08XIuhq/CcM4IHo
        5Tn8OIBe0hCIRg6AgLRVAXI=
X-Google-Smtp-Source: APXvYqy9tFlsHk5EdA8inHoMhdRt8sYE95/WAvjzORB5AnSy3bPfa/6xv6dzExUc4ylKL+TTEYAFMg==
X-Received: by 2002:a1c:c188:: with SMTP id r130mr18532943wmf.73.1565489085159;
        Sat, 10 Aug 2019 19:04:45 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id f197sm1755333wme.22.2019.08.10.19.04.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 19:04:44 -0700 (PDT)
Date:   Sat, 10 Aug 2019 19:04:42 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
Message-ID: <20190811020442.GA22736@archlinux-threadripper>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
 <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
 <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
 <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 01:18:22PM -0700, Joe Perches wrote:
> On Sat, 2019-08-10 at 12:44 -0700, Linus Torvalds wrote:
> > On Sat, Aug 10, 2019 at 12:32 PM Joe Perches <joe@perches.com> wrote:
> > > What does it take for this sort of patch to be applied by you?
> > 
> > The basic rule tends to be: "normal channels".
> []
> > I pulled from Gustavo earlier today to add a few more expected switch
> > fall-through's, I guess I can take this Makefile change directly.
> 
> Thanks. It's simple enough.
> 
> There are classes of patches generated by scripts that have
> no real mechanism to be applied today.
> 
> For instance: global coccinelle scripted changes to use stracpy
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1907251747560.2494@hadrien/
> 
> and trivial scripted changes to MAINTAINERS
> https://lore.kernel.org/lkml/6482e6546dc328ec47b07dba9a78a9573ebb3e56.camel@perches.com/
> 
> that are basically impossible to be applied by anyone but you.
> 
> Otherwise there are hundreds of little micro patches most of
> which would not otherwise be applied.
> 
> There should be some process available to get these treewide
> or difficult to keep up-to-date and apply patches handled.
> 
> I believe these sorts of scripted patches should ideally
> be handled immediately before an RC1 so other trees can be 
> synchronized in the simplest way possible.
> 

Hi Joe,

On a tangential note, how are you planning on doing the fallthrough
comment to attribute conversion? The reason I ask is clang does not
support the comment annotations, meaning that when Nathan Huckleberry's
patch is applied to clang (which has been accepted [1]), we are going
to get slammed by the warnings. I just ran an x86 defconfig build at
296d05cb0d3c with his patch applied and I see 27673 instances of this
warning... (mostly coming from some header files so nothing crazy but it
will be super noisy).

If you have something to share like a script or patch, I'd be happy to
test it locally.

[1]: https://reviews.llvm.org/D64838

Cheers,
Nathan
