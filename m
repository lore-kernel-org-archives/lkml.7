Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CCCC31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035C3216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="feHop8Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfHGACG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:02:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36490 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfHGACF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:02:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so97180673oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 17:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EsLJ2/WO+JOrpoglqRsrGS0vmJibi9voB0KhRKPNQUg=;
        b=feHop8KeJUz1KDFucXnATMzna85iQds8u7MC4cAVeZqxlp/qlB8phz6FXT9QG1Lg7o
         r3RPSMpLym1QeKcCeS2yigwu+N8+rPhCjC3GJmBUp5pCPvvNq4HObxmQlTCGFqiF32s9
         dLYh9E4Dyi4tSzEsXZECs+3s9UT4KOZpTYzaVk0Al/apddubi5Z0jmYLkSV9ue59GZyJ
         gsfzDl6uS/64YZf7/lzRxcuprGZ3547IB/2SZuPSS1K0Vdfx7tTyZuLqmV9AkJUJ33g2
         cki7Vi5G6YkxCxNYtskVnT7WwROwaLVriEgHMD7nvbNb/qbsld2osBi6G4bAEikG2t3e
         f/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EsLJ2/WO+JOrpoglqRsrGS0vmJibi9voB0KhRKPNQUg=;
        b=O1vk+hdPME0vng/UtOR4ogJJ/ylTMmJtvQgE/rqR4KXshn1fSd3EieDGqrnH9UCQBP
         nFjdtp1Rfzp2iVDBwUltTJPZCmwJi1p5LfzFrtv4pv+CfNoeDEwahBEo1A2rZ18+mEVi
         401xUEhc/swPagmH7SW2YhLymSjZb7htiD15SI72yO5OhhdZKSsjxBAuweqw1gDZYKeP
         F+d6UyA7TAgIODS4TnErkknSLBoV9OC+BoeyPQEdlUZND7MaeVBdR/pnL0L+O+N5OvPm
         efuaIrmTQLjV3qCPskkBjyjLWPNdfxGxjc7wjPih3SdseiLJlo6S9i52nGGLAcjT2MrH
         Xcpg==
X-Gm-Message-State: APjAAAXaOlxUaTpjccPf/28xvWkutz04tRRJkTLlTgPit9nzZw0nBb/X
        xQotyYdzzDsGE3wdvdyW38ha3w==
X-Google-Smtp-Source: APXvYqzBQs0khY8qe+AqoyOpzrk/0CG77v1CoPKjVxs9FbYTqqUqRYV4cypEJ/zJSoB8fbxNMi61Lw==
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr6572247iog.255.1565136125193;
        Tue, 06 Aug 2019 17:02:05 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id p3sm76970566iog.70.2019.08.06.17.02.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 17:02:04 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:02:03 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] riscv: kbuild: add virtual memory system selection
In-Reply-To: <20190802084453.GA1410@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1908061648220.13971@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com> <20190802084453.GA1410@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019, Christoph Hellwig wrote:

> On Fri, Jul 26, 2019 at 01:00:49PM -0700, Paul Walmsley wrote:
> > 
> > The RISC-V specifications currently define three virtual memory
> > translation systems: Sv32, Sv39, and Sv48.  Sv32 is currently specific
> > to 32-bit systems; Sv39 and Sv48 are currently specific to 64-bit
> > systems.  The current kernel only supports Sv32 and Sv39, but we'd
> > like to start preparing for Sv48.  As an initial step, allow the
> > virtual memory translation system to be selected via kbuild, and stop
> > the build if an option is selected that the kernel doen't currently
> > support.
> > 
> > This patch currently has no functional impact.
> 
> It cause the user to be able to select a config which thus won't build.
> So it is not just useless, which already is a reason not to merge it,

The rationale is to encourage others to start laying the groundwork for 
future Sv48 support.  The immediate trigger for it was Alex's mmap 
randomization support patch series, which needs to set some Kconfig 
options differently depending on the selection of Sv32/39/48.  

> but actively harmful, which is even worse.

Reflecting on this assertion, the only case that I could come up with is 
that randconfig or allyesconfig build testing could fail.  Is this the 
case that you're thinking of, or is there a different one?  If that's the 
one, I do agree that it would be best to avoid this case, and it looks 
like there's no obvious way to work around that issue.

> Even if we assume we want to implement Sv48 eventually (which seems
> to be a bit off), we need to make this a runtime choice and not a
> compile time one to not balloon the number of configs that distributions
> (and kernel developers) need to support.

The expectation is that kernels that support multiple virtual memory 
system modes at runtime will probably incur either a performance or a 
memory layout penalty for doing so.  So performance-sensitive embedded 
applications will select only the model that they use, while distribution 
kernels will likely take the performance hit for broader single-kernel 
support.


- Paul
