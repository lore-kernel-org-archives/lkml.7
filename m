Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94630C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B709214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwvbBZ4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfCLUYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:24:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43381 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfCLUYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:24:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so4117952wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JTXNBwk8SCiPTwAEie/bcnT4XkESteANRpMaJv1ngqI=;
        b=EwvbBZ4KSMOuBKHyRmLX6z3TyXLAhR1nLk0khhlMf3j0373hDL2h2s6Fsc4jSIPldk
         OqxCPbneplHA1MCHSI6+nxj6ysDiRKK4t/9es28FexZ+HM/+TzAryOOO9iSx7pDbw3iY
         kyOQBtLrgmOoiwlkL0GVJe0zmmjSfMKmbphXkj6TuYw/2cX6IQ2CcHfwX1oU/OZeTENW
         i73uqbf4FP7f0d2iSZvO+W5WGpAmOgSzQbfhi/8zKgoAMlJE0Jf9DmW2/ZYVBFougdHn
         +K8vyJ2MsAsr9ChERcoA1tmSp1/4o9vMe6KFa/ptvCziDvdDExBztbZsAj1vrITDrGGw
         meMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JTXNBwk8SCiPTwAEie/bcnT4XkESteANRpMaJv1ngqI=;
        b=SSkMIDFIq5T6Op7Zczn1buwwk7x9xfexJZ2eTLLXvf2YlHjyH7EqJaAMlffKKqCN0W
         b0VZ1dZKkZwu8IpG6qz1k/TRPRuzDFI/zjrPVYDwEAgd6h1+nqY58ELACI/ScFl13WCu
         IWf821hRtT4l9GxWkHFBtHfHt+XVNNrQU1O4Kub4ANVmS7bqbvB3RVO3lzhA7f5o86yV
         UBDN7sBT977Rvlk+88B4GSpJsbATg35IKMm4vn+1ux726wsaZzP8UevgCDjzOSrEL7nf
         2DUO3X3AsSzauz2rUpddHv5/Hg/ozQD6DKIb4gcHH88gs0CfVjN6By5Rq4/wamhmLEUE
         kruw==
X-Gm-Message-State: APjAAAWdaeZUEFvY080Z6z+/I8m5D/XREue+7D2nVBNYy4F45AricAp6
        V/SjVYxtoAc9iUiLuAmHpBStmow=
X-Google-Smtp-Source: APXvYqx7j5/F1Qh/kWWTwH5pHpOp+LL+LGaoNRjnN4KFYc8QL8IRkMrnCmK7rjSCECJsQfE1Wg1OXQ==
X-Received: by 2002:adf:f9c7:: with SMTP id w7mr9710187wrr.311.1552422248151;
        Tue, 12 Mar 2019 13:24:08 -0700 (PDT)
Received: from avx2 ([46.53.244.57])
        by smtp.gmail.com with ESMTPSA id 62sm11075174wra.46.2019.03.12.13.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 13:24:07 -0700 (PDT)
Date:   Tue, 12 Mar 2019 23:24:05 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop -Wdeclaration-after-statement
Message-ID: <20190312202405.GB9013@avx2>
References: <20190310133535.GA20473@avx2>
 <20190311173845.53c2e4e4d2257a3701fa2033@linux-foundation.org>
 <20190312172447.GA10166@avx2>
 <20190312125017.b1f5af3350434ca05b5fe35e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190312125017.b1f5af3350434ca05b5fe35e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:50:17PM -0700, Andrew Morton wrote:
> On Tue, 12 Mar 2019 20:24:47 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > On Mon, Mar 11, 2019 at 05:38:45PM -0700, Andrew Morton wrote:
> > > On Sun, 10 Mar 2019 16:35:35 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > 
> > > > Newly added static_assert() is formally a declaration, which will give
> > > > a warning if used in the middle of the function.
> > > > 
> > > > ...
> > > >
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -792,9 +792,6 @@ endif
> > > >  # arch Makefile may override CC so keep this after arch Makefile is included
> > > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > > >  
> > > > -# warn about C99 declaration after statement
> > > > -KBUILD_CFLAGS += -Wdeclaration-after-statement
> > > > -
> > > >  # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
> > > >  KBUILD_CFLAGS += $(call cc-option,-Wvla)
> > > 
> > > I do wish your changelogs were more elaborate :(
> > 
> > > So the proposal is to disable -Wdeclaration-after-statement in all
> > > cases for all time because static_assert() doesn't work correctly?
> > 
> > Yes. I converted 2 cases in /proc to static_assert() and you can't write
> > 
> > 	{
> > 		[code]
> > 		static_assert()
> > 	}
> > 
> > without a warning because static_assert() is declaration.
> > So people would move BUILD_BUG_ON() to where it doesn't belong.
> 
> Sure.
> 
> > > Surely there's something we can do to squish the static_assert() issue
> > > while retaining -Wdeclaration-after-statement?
> > 
> > It is not good in my opinion to stick to -Wdeclaration-after-statement.
> 
> Why?
> 
> > > Perhaps by making
> > > static_assert() a nop if -Wdeclaration-after-statement is in use. 
> > > Perhaps simply by putting { } around the static_assert()?
> > 
> > Making a statement out of it would disable current cases where it is
> > placed in headers.
> 
> I think you mean cases where static_assert() is used outside functions?
> 
> We could have two versions of it, one for use inside functions, one for
> use outside functions?

I don't know. It was made a declaration in the standard specifically
to have only one name which is a good thing.

Just count the number of BUILD_BUG_* variants, it is ridiculous for such
a simple thing. Or even better, all *alloc* variants. :^)
