Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A36C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 03:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FAD20880
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 03:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7bLl+eK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHKDRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 23:17:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52725 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKDRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 23:17:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so9268898wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 20:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJTRgRoQys59T83fv2iqLib5QcQAZ/wqe7J9GPlE24g=;
        b=B7bLl+eKaMPsG+QbROJDP7SGHYXqM2kTNx3nEIQH2QBkhUBT9udm2pQcMF+mSrFV89
         mTclRC7muzaGvAb8/iKYd3Wlhuuu062xXrqn4atB7ywTjmpY50mxr9uTPnzePodnRzUd
         P4l8tnFUJQFjFgxjM21n8zDYZru2mxwBPqXzkvL8ReJj+Agm0T44mCmktOcWbKXX3n2w
         pi+cExU6mK6dtWEa/9QTbDXG0kjdAFlnqQ6Wtq+uorte8AvF9tCE3eeIQXStnpk7SzJ8
         ocIKvclxx7AM3yBBzBiVHrF+0M2XL3EiuKsKcATgMSTMT1FaTjXKnlvogZEcCgTA/q9X
         Hxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJTRgRoQys59T83fv2iqLib5QcQAZ/wqe7J9GPlE24g=;
        b=nXCJYhOZgqiEpuIqdpeZepYpP3IL1Q/El1tUftLWTop8eGxPUjl3fc0eeKxTss2Mw9
         EvBw8R/wyF7qA816+ldn1wgftgkmhE18LAnpTn//dRx5uD5SbNprMHkBWkAiA/zwYUQH
         1sCBnOiOBpAb9Ytw4Gy5KJgJ8CL79oOk+XbOCVja2t0ADhasG2c9kFpRwbViwyDjhsgw
         /QZcppz7PakN/6F7u9ZmJRqIRNJnW4afoCnBW+70D5kB0QCLtbX/d36b9qMljR5822XS
         fTEpTxR8NxipukwOJcSbtyXzsf63n9rAXpQ942nm2MMrqtmrFROt/ljgsIbzr+EpihyI
         qeQA==
X-Gm-Message-State: APjAAAUfW5NvTAIGr91gNlBvb+QOPOKvaRQd/MmxXMc9ypatBL/XleGy
        temdwG/W91WH7Xi5qN/uguc=
X-Google-Smtp-Source: APXvYqz4tIfbTsWk6WavONnmqrVrMLrB+D3W4ERW37SCHjL2OtB6lwPl/M7DY2HGUoSv2IqJmzui4w==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr12149120wmj.112.1565493437886;
        Sat, 10 Aug 2019 20:17:17 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id l3sm17489437wrb.41.2019.08.10.20.17.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 20:17:17 -0700 (PDT)
Date:   Sat, 10 Aug 2019 20:17:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
Message-ID: <20190811031715.GA22334@archlinux-threadripper>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
 <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
 <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
 <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
 <20190811020442.GA22736@archlinux-threadripper>
 <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 08:06:05PM -0700, Joe Perches wrote:
> On Sat, 2019-08-10 at 19:04 -0700, Nathan Chancellor wrote:
> > On a tangential note, how are you planning on doing the fallthrough
> > comment to attribute conversion? The reason I ask is clang does not
> > support the comment annotations, meaning that when Nathan Huckleberry's
> > patch is applied to clang (which has been accepted [1]), we are going
> > to get slammed by the warnings. I just ran an x86 defconfig build at
> > 296d05cb0d3c with his patch applied and I see 27673 instances of this
> > warning... (mostly coming from some header files so nothing crazy but it
> > will be super noisy).
> > 
> > If you have something to share like a script or patch, I'd be happy to
> > test it locally.
> > 
> > [1]: https://reviews.llvm.org/D64838
> 
> Something like this patch:
> 
> https://lore.kernel.org/patchwork/patch/1108577/
> 
> Maybe use:
> 
> #define fallthrough [[fallthrough]]
> 
> if the compiler supports that notation
> 

That patch as it stands will work with D64838, as it is adding support
for the GNU fallthrough attribute.

However, I assume that all of the /* fall through */ comments will need
to be converted to the attribute macro, was that going to be done with
Coccinelle or something else?
