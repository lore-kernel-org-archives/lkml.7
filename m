Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10441C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3F720989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557217459;
	bh=eUSQgtGWPy5pFKH1GUY8hxSIVNfzmhNgY4FrPa2GdiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zBE5eZ3AAiNojwmL1JLFQDnAUlhRvCQhe01cQZ81jmIDRSYco7XGiAk5zBakbL92N
	 a/wEHGkcNynNyiVM/yXO5ws2hy+ke12jbMeK9wDHM7AsEELnCgXFYOp84iYUk15PHR
	 NL7hSQbp0IOhVc5/GtERpIZ1euC40F+eZMnND+UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfEGIYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:24:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37044 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:24:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id a12so10885291wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W7d2mrADug3XTBNYsFOZammJ4d/L/QrWNlLiF6TfPyM=;
        b=eK5jW7pSEG9BtgYtYJvEbhxT2CoGybhtibMDNW0x7wOO3U91oxvhCyFBeaPevA2JRB
         eVnYQx7Z8vHA0ilSZif8qi3e3U3QwvC/RCzkApn8HT75XihnMbTPWiy5St1/wGIberaR
         69YtTzuZZY7lUyNzfciRJFXSYub14BkNVb3AQa7mZA8KvRaz7lhwGacpB4NeBJh0s7Lu
         tQkYqi4NGFqB4+kCJ8oScUcpdcG/yK9dMiRxM90b2rIdxjDxiuoJQXk284N2k0kWvaHw
         NsP1LlAV8hv7w2OZLNneZ3/cbheepaFymtWNWiQGZOm1BKRaov3q3K+vELIWA5AggtMc
         femw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W7d2mrADug3XTBNYsFOZammJ4d/L/QrWNlLiF6TfPyM=;
        b=lThyJKR1bCLGVrPgMSKJTFtJBy9dBeYOuEAjI16gmeqyqscrzaqsa77d3fT1usnWEz
         GRVReAnlj9tvn3xIvzQp2J7YryNq0gwkSvBhwSst1LvNv/q+cqIk7op+tkhaGOMMKcoz
         kWlaoTh5LrZADH0/aZJjb/IaFLOyu08gshMJkYtosOVQLJcasl/LFQtDEp2Wmvg8Cw/V
         YWWiUJlV9gC1L0NZs1Lu9WzI+9bSLezNFMYoU0Dm82eaNY2aDSndc5PMDYd0yyjM9hNO
         rKR1da39MirB8P6uUXZK/gyLZmX/ch7Yaxshd1a4c5FNYqCsJ6QiIxgR+jh12Rbl1Zuo
         T4Xw==
X-Gm-Message-State: APjAAAWFUBPGEOkcGI3gmHCMghj5Ya3vyZ5AHnVpj7Kw/7APJewYbNHG
        g9Frf8E4Dm4M1wc1M/5Kr+s=
X-Google-Smtp-Source: APXvYqw7NxYBTeDrgSa9VKE3q7FyImHDfeLB53MHdgmQTDwmv6YGCpWGqMC0Oqh+fveKUJw1J2Ah8A==
X-Received: by 2002:adf:e902:: with SMTP id f2mr3615571wrm.301.1557217456841;
        Tue, 07 May 2019 01:24:16 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i16sm8028436wrs.5.2019.05.07.01.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 01:24:15 -0700 (PDT)
Date:   Tue, 7 May 2019 10:24:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman9394@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] locking changes for v5.2
Message-ID: <20190507082413.GA125993@gmail.com>
References: <20190506085014.GA130963@gmail.com>
 <a5ee37fe-bdcf-2da7-4f02-6d64b4dcd2d3@gmail.com>
 <20190506194339.GA20938@gmail.com>
 <CAHk-=wifHYK-NKCTbT3_iHpy3QeK7H+=RLbFUaFpPziPn3O8Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifHYK-NKCTbT3_iHpy3QeK7H+=RLbFUaFpPziPn3O8Ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, May 6, 2019 at 12:43 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Sure - how close is this to a straight:
> >
> >         git revert 70800c3c0cc5
> 
> It's not really a revert. The code is different (and better) from the
> straight revert, but perhaps equally importantly it also ends up with
> a big comment about what's going on that made the original commit
> wrong.
> 
> So I'd suggest just taking the patch as-is, and not calling it a
> revert. It may revert to the original _model_ of wakup list traversal,
> but it does so differently enough that the patch itself is not a
> revert.

Ok, Waiman's patch is now the following commit in locking/urgent:

  a9e9bcb45b15: ("locking/rwsem: Prevent decrement of reader count before increment")

it should get to you in a couple of days.

Thanks,

	Ingo
