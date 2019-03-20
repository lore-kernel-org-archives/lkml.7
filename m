Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B76C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8D7218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="W3ljHHUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfCTUrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:47:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44691 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:47:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so2742618pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LXbyAZLkt2VB7jEtAgbet0eHFze4KgeF8lZT5KLgas4=;
        b=W3ljHHUNBtexEeUTuAfjX4c2iyf0mCRtzbgvCMYupV1rEwSxgpeZuZEhIlmd64hOjM
         pppP/hLU+trzbXusLZQKDE2DbzxWiRYmzUaMsX4hi+7VBxNKFlNCk0V+l0zH4Lx5zqcj
         fB7oenB78BR8tAE01YAKxEl85X3XD3/RVK2q7ervBvqC4yY6ByZfsyIhT1XaMULQP0Nq
         yE3rQEiWauStljy3MaAgge+3M2QZpqfhMI+cRVEkmIZRVOM9upsJ3T0uTARbtseybBdn
         1x1rGTHOvYD4P9yMT+bWoEKqlCNAfnZ48uZicqW4+QrxPNbWd++taGAt8EuEAG031bbM
         NLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXbyAZLkt2VB7jEtAgbet0eHFze4KgeF8lZT5KLgas4=;
        b=fB71/KtH0/mBin5k93thMywWEQiAJ0gAggiXOZuBXzlzr57T+Wq8y1sXuDj2yoxhfV
         8bOsH2C0dRThbchhCmdBmEz+BrZoC1U2Sldpvo+NdFA6giH4Wc1WvE+/RkIQAaKb1Q+a
         9X64e/Zaqp5O3Z+zqtWmrrA49xSiabBt1uvtfJh4sboBkLWTRUGgSfiHe6rXtHxXD/L5
         LMNWQ0jNIMVdL5wvszlwYjj9EcTSThqORMT7ST8l5dRcyS6bHliG3Q9g1G76NRd8fOzs
         Pa3k88eAcLPtcNaXZTa5JAvC44BRRYpk2xdy7sUcaRkbJ0bWI0/7Ofq/zzxyur5AOJIM
         4T+w==
X-Gm-Message-State: APjAAAWOf9siCi4hEaUlvEcKofy0sO/D/RmdnSh53NNLh2cg+wbgdm81
        kG6egKmmEMPmV9xI93j58LBL8A==
X-Google-Smtp-Source: APXvYqwRVvrXVoglL7JPKVCU+ax/UYM0CwF8aFbiyKZs4F2eRICj6QsLqCdrHLph0GxlKnTAivbpQg==
X-Received: by 2002:a17:902:a716:: with SMTP id w22mr10321778plq.280.1553114860028;
        Wed, 20 Mar 2019 13:47:40 -0700 (PDT)
Received: from brauner.io ([12.25.160.29])
        by smtp.gmail.com with ESMTPSA id k22sm3808630pfa.84.2019.03.20.13.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:47:39 -0700 (PDT)
Date:   Wed, 20 Mar 2019 21:47:37 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: pidfd design
Message-ID: <20190320204736.x4p5m7gxz6rbxlo3@brauner.io>
References: <20190320200702.GA27111@avx2>
 <CAKOZuespjOTbaTDbgQLo=7PXTE-nYCLy7k=s+RJh_GpZ_5gwgg@mail.gmail.com>
 <20190320203910.GA2842@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320203910.GA2842@avx2>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:39:10PM +0300, Alexey Dobriyan wrote:
> On Wed, Mar 20, 2019 at 01:14:01PM -0700, Daniel Colascione wrote:
> > On Wed, Mar 20, 2019 at 1:07 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > > What would be your opinion to having a
> > > > /proc/<pid>/handle
> > > > file instead of having a dirfd.
> > >
> > > This is even worse than depending on PROC_FS. Just for the dependency
> > > pidfd code should be backed out immediately. Forget about /proc.
> > 
> > We already have pidfds, and we've had them since /proc was added ages
> > ago.
> 
> New pidfd code (or whatever the name) should NOT depend on /proc and
> should not interact with VFS at all at any point (other than probably
> being a descriptor on a fake filesystem). The reason is that /proc is
> full of crap and you don't want to spill that into new and hopefully
> properly designed part of new code.

Yes, I agree. That's why I was thinking that translate_pid() is a good
candidate to provide that decoupling.
