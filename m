Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A3FC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5400E2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drTB1igf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFTUiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:38:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45363 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfFTUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:38:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so6495523edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3NNpxQC9inEMdQiCtKdevzqLpK6p/o11oFFffa2tXtA=;
        b=drTB1igfYgyVGqDFahZ5NCLWxeC+zgZym5tNhHU9P8EVSYWsif8ATO7pGEP+d9b4jh
         JAOnze86pJuhlaTw0qlD/nW6rmrmbt2IBo7iigDcsRG6wUQWA25EcHINzbbeiMWc6kbv
         TIuJ7KJQbLsp195+3AwE47Er77voagXXJT1rsAjFejlw31omdfGinBG6DPOUaGItFu+D
         ys8HdSTj7s+FDlec/VPr03RWlEH28OKXZuN5/b58TkSNoU+KY/KedGOeatIk/zPPPXh0
         /tB97o72J1eTHRzAcS1bmSx1VBukLqxVclGb2OyRv47B3yeHVfSUQUjUoYCoslao1nwy
         iMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3NNpxQC9inEMdQiCtKdevzqLpK6p/o11oFFffa2tXtA=;
        b=Xv+x6F6WxapgwKqTgv1wIW7DFHARCHFFpIvvaVqA2BVdK+sTFKN8gD5UlFRlIV+FW3
         EfQaulFSHDCzha7UQPRLuEGVYaGFbPwvI6PwMyKF3F1Vs3MU0VHpKMUzAqaNNddBGzEc
         +v7qkmSaIMeSjwUzfEiF0uBAm768g9TIcA+5u4gusN9vGL0NZSL/1Pei1uy9BiFpJkeW
         2mWPgOICH68O5hZlng9BdQscc0eWx3FyhcZ+KfG3XeXPWYnVtCd8xwjlrtbQf+y9TCNC
         8yufn50sRgwf8REAvt7Dj3wc73L2bYtvzfTX33vazkv985ziuk9Xnny96DW+gfkM+ZRN
         5qyA==
X-Gm-Message-State: APjAAAUud7mQsjIOfKgXv2/RFTxtg3UV+5Nc6NCU6JVW9ABPhOj5tfCB
        +ZyW2yJcbewCvn7IERSRZr9PmleRPeMOdQ==
X-Google-Smtp-Source: APXvYqyFv7TcKmDYh6aGGxLZIuOvRIKKOd88Mr+MJzIGjGqg4v29rEZylk+bGGm4BsLzINtBP1v0qQ==
X-Received: by 2002:a17:906:3385:: with SMTP id v5mr112020844eja.301.1561063128315;
        Thu, 20 Jun 2019 13:38:48 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id g6sm69844ejb.18.2019.06.20.13.38.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 13:38:47 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:38:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Doug Anderson <dianders@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tom Roeder <tmroeder@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Ryan Case <ryandcase@chromium.org>, Yu Liu <yudiliu@google.com>
Subject: Re: [PATCH] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
Message-ID: <20190620203845.GA102280@archlinux-epyc>
References: <20190620184523.155756-1-mka@chromium.org>
 <CAKwvOdn-o9UszRW+MQ9Z0Ds9B2wSVBWUsPBPSF0S2DYxVFYpqA@mail.gmail.com>
 <CAD=FV=WcH=dVeVWznO7Ti5A8HBDRM=rPvvH=-XJ2o1PKXvHAQw@mail.gmail.com>
 <CAKwvOd=twuZAAyKsBRSeJEFuQZGdyTw+=JAwmJugUhV+bppdtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=twuZAAyKsBRSeJEFuQZGdyTw+=JAwmJugUhV+bppdtg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 01:25:36PM -0700, Nick Desaulniers wrote:
> On Thu, Jun 20, 2019 at 1:13 PM Doug Anderson <dianders@google.com> wrote:
> > On Thu, Jun 20, 2019 at 12:53 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > I do miss Doug's Kbuild caching patches' speedup.
> >
> > You actually get quite a bit of this by grabbing a new version of
> > ccache (assuming you use ccache).  :-P  You still have to pay the
> > penalty (twice) for all the options that are tested that the compiler
> > _doesn't_ support, but at least you get the cache for the commands
> > that the compiler does support.
> 
> Hello darkness my old friend:
> https://nickdesaulniers.github.io/blog/2018/06/02/speeding-up-linux-kernel-builds-with-ccache/
> Man, that post has not aged well.  Here's what we do now:
> https://github.com/ClangBuiltLinux/continuous-integration/blob/45ab5842a69cb0c72d27d34e73b0599ec2a0e2ed/driver.sh#L227-L245
> 
> > Specifically, make sure you have a ccache with:
> >
> >     * https://github.com/ccache/ccache/pull/365
> >     * https://github.com/ccache/ccache/pull/370
> 
> Oh! Interesting finds and thanks for the pointers.  Did these make it
> into a release version of ccache, yet? If so, do you know which
> version?
>

It should be available in 3.7 if I am reading git history right.

Cheers,
Nathan

> > I still have it in my thoughts to avoid the penalty for options that
> > the compiler doesn't support but haven't had time to work on it
> > recently.
> 
> It had better not be autoconf! (Hopefully yet-to-be-written GNU C
> extensions can support feature detection via C preprocessor)
> -- 
> Thanks,
> ~Nick Desaulniers
