Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69796C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B89B22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5ibXSmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH1M75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:59:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38421 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfH1M74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:59:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id o70so1693596pfg.5;
        Wed, 28 Aug 2019 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQYjQEKx+pk9xunTic066tAg2N98pbyunLxiZPwNrWc=;
        b=D5ibXSmprjmd0nrYB034o67G7p4IAvRsMo16+h1yTJErfwE8lXN1xBcCf6Z00lKynp
         uLPpAc0QS39qXchQtkZS/naaItb8OgG8K4iUz6wYSuPuTDtgh5DX8DAXYUmzSADhXeBe
         eUvMn0SLn6aRwByHr0BRj7aGUsDg/no3qDrJirtf5x4fMWfQQP6sSXQDufsBOdA97/OZ
         enmzP/js+LX8yRqZWfV0Jc7SJw0vFMHlANay1aBoJnrJs5R623aq33W3GxTEg1g59/93
         ocaVdxxUQIyuCrhSjzqZNJDt/lzD2FM3XEJdXXF+pW/liJup1DFZTUL/NAbJkbQPoSyt
         cm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQYjQEKx+pk9xunTic066tAg2N98pbyunLxiZPwNrWc=;
        b=PxAr4Tzr2BYPZGdfikSrsUhoJB3+DED5YKZC1xevHr/va9gojhCQgzi2OKAyfRTbQW
         zQ+4R1tPGFascnbp9EOLwnYrZGjM33AC5RfbGhm8EzqfOfBizp+Tk936lbMxXdnGUixp
         /6Nm6la5KAPxTJRj4ePInnDIvFSdCuio5UGrNXJWuMYgxbJle/XGeePHnKKaopa/P6Mc
         KC2CmD+MvlsjpF+4deaT+E+4UH4E/X+4SsWqAZ63Ntqa7/H47WAH/R/Ihp3oPVwr0Q9y
         71Ww0/+nl7hncEn3YjTDS/rlFebQpP2b5p08r8flaVUeysV0UVV8XG/9iD+3dBo8CGSW
         s4KA==
X-Gm-Message-State: APjAAAUxaagLNOcbYlm772jF74mG+l2/vaCRaF+bI7j9tqYPRAPVMT/w
        vBQT5KBvGBM/jJxH5vUxEXQ=
X-Google-Smtp-Source: APXvYqzrPpOWTJJWhnUbKPR+vEQmsu9fCVoHA4kj6YedxO5kRFtjRob/4TjTFO9aYUYIZEWIeZ7OTg==
X-Received: by 2002:aa7:8d42:: with SMTP id s2mr4520451pfe.185.1566997196023;
        Wed, 28 Aug 2019 05:59:56 -0700 (PDT)
Received: from localhost ([39.7.47.251])
        by smtp.gmail.com with ESMTPSA id w2sm2258227pgc.32.2019.08.28.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 05:59:55 -0700 (PDT)
Date:   Wed, 28 Aug 2019 21:59:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Steven Rostedt <rostedt@goodmis.org>, Enrico@kleine-koenig.org,
        Weigelt@kleine-koenig.org,
        Andrew Morton <akpm@linux-foundation.org>,
        metux IT consult <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
Message-ID: <20190828125951.GA12653@jagdpanzerIV>
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
 <87o9097bff.fsf@intel.com>
 <20190828120246.GA31416@jagdpanzerIV>
 <087e8e18-8044-27ef-b0bd-8a1093f53b32@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087e8e18-8044-27ef-b0bd-8a1093f53b32@rasmusvillemoes.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/28/19 14:49), Rasmus Villemoes wrote:
> On 28/08/2019 14.02, Sergey Senozhatsky wrote:
> > On (08/28/19 14:54), Jani Nikula wrote:
> > [..]
> >>> I personally think that this feature is not worth the code, data,
> >>> and bikeshedding.
> >>
> >> The obvious alternative, I think already mentioned, is to just add
> >> strerror() or similar as a function. I doubt there'd be much opposition
> >> to that. Folks could use %s and strerr(ret). And a follow-up could add
> >> the special format specifier if needed.
> > 
> > Yeah, I'd say that strerror() would be a better alternative
> > to vsprintf() specifier. (if we decide to add such functionality).
> 
> Please no. The .text footprint of the changes at the call sites to do
> pr_err("...%s...", errcode(err)) instead of the current
> pr_err("...%d...", err) would very soon dwarf whatever is necessary to
> implement %pE or %dE.

New vsprintf() specifiers have some downsides as well. Should %dE
accidentally (via backport) make it to the -stable kernel, which
does not support %dE, and we are going to lose the actual error
code value as well.

	-ss
