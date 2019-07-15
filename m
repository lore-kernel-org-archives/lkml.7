Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F8CC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0D220868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RZoOxuRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfGOAAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:00:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37216 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfGOAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:00:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so15193015wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 17:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFoVp1Q2Isjq38d8Qu6pDRz3M1RQhAEnTa7Rdh4NrcU=;
        b=RZoOxuRPc5U9CrSizmsFaG5NX2BJtxoKrxwWzkQ9GLnSr5s+6f3i2eyJP83aJyMDQ5
         PvXm0ZnSWfszYrfeaEr5/mQpt5F+a+Vu7f4lHB5HnZehSya9VG3PI4bjtr+wSD+r7Gse
         d5bD7mVjJqVzbmoHUF5qisy7Ycj6vHlbjcK6Z9AC710KdULc8BUcBe7hmpCNE23sSJxu
         0/zwCPPxOuht4+1dl0iXxjarfujEwqy3ovEzxgVnexa4CThmq144zm4Lstir/bhQs/bT
         ESl9BjuJY/bdTsLJdx/l24JWAmDMjUUGWoJWK6Rdx7szqxbSJMRuorknid4Tq2d52B5F
         UVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFoVp1Q2Isjq38d8Qu6pDRz3M1RQhAEnTa7Rdh4NrcU=;
        b=ngKzF5e+YmG405xEkgvlW9jXEKXrPG1vD6eYNmJIA2qJ9onKxsKU5oAoAvPo03Ttnm
         9IMZjOpZ9M/E6LhY91NsrMh5sSxyCW2KlWv1XutO8BRo2cijl2r7WTJhtBGPDWDoJiuy
         HPDy0hocQmSQRvOjH6yqSfAW0J/pIEKVSDkGttUjDWEIAZqgVkSIACRh5ZKK9EALZvq6
         ShO0HsoSLUxL4lwl17S35ot5E5tyfGnaQ8Sj1Eqr/x0xTp2npimDPkKlGCq/YAOpakj3
         B0FVGwoh7T5H2vwbwaaZUgM/qfDCaHmwvuwJlm29kgy2SW8P/x5lNzYZOXjcW8/HvlaD
         1rYg==
X-Gm-Message-State: APjAAAURkLVKDjKPGFan9q0E27CnKbREsyvY41mw+yU1OJQEp++B0LF+
        T+IeOGcpQxSfqD9m81ExIX8=
X-Google-Smtp-Source: APXvYqxIiqXlxrPLf7W6fKJaZVpdO02oiCDEKNSNhqd24guECC16aTaAwbGnEk/0m0svDxo1RPPBKg==
X-Received: by 2002:adf:df90:: with SMTP id z16mr12038379wrl.331.1563148816442;
        Sun, 14 Jul 2019 17:00:16 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id t140sm14967596wmt.0.2019.07.14.17.00.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 17:00:15 -0700 (PDT)
Date:   Mon, 15 Jul 2019 02:00:14 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab+samsung@kernel.org
Subject: Re: [PATCH] MAINTAINERS: add new entry for pidfd api
Message-ID: <20190715000013.uukrbvsc2onbac7z@brauner.io>
References: <20190714193344.29100-1-christian@brauner.io>
 <8dbfa2d12bb0c76a19f46128af083921c8feb562.camel@perches.com>
 <20190714223228.f32lkszztbuencbn@brauner.io>
 <62147462c38b7764eca3a97405fef536846be034.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62147462c38b7764eca3a97405fef536846be034.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 04:35:07PM -0700, Joe Perches wrote:
> On Mon, 2019-07-15 at 00:32 +0200, Christian Brauner wrote:
> > On Sun, Jul 14, 2019 at 03:10:06PM -0700, Joe Perches wrote:
> > > On Sun, 2019-07-14 at 21:33 +0200, Christian Brauner wrote:
> > > > Add me as a maintainer for pidfd stuff. This way we can easily see when
> > > > changes come in and people know who to yell at.
> > > []
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > []
> > > > @@ -12567,6 +12567,18 @@ F:	arch/arm/boot/dts/picoxcell*
> []
> > > > +PIDFD API
> []
> > > > +K:	\b(clone_args|kernel_clone_args)\b
> > > > +N:	pidfd
> > > 
> > > This one I'd suggest using 2 F: patterns instead
> > > as the patterns are more comprehensive and do not
> > > use git history when looked up with get_maintainer
> > 
> > Just to clarify, you suggest removing N: pidfd and just leaving in the
> > two F: patterns for samples/pidfd and tools/testing/selftests/pidfd/
> > below?
> > 
> > > F:	samples/pidfd/
> > > F:	tools/testing/selftests/pidfd/
> 
> Yes.

Ok.
