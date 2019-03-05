Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD45C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8272F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xXY4/hU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfCERAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:00:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33700 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCERAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dnGbtuQxm9uv/P8uxHKnMGGrNN4+rM7V1ZMobsOOHU4=; b=xXY4/hU+RC+xMIZh0QHtv9aR4
        K2kqqoA2XO22reZy+p0oG5HaP2+VHSxECUAhWCKZYdM9LA+QCEDBhjk1QSgV1J8qQjEy0YmASWalU
        WDbpRXWui2xGPjMe9pxWmZEiicGF2KTpAas6L3dtMOBY2kMDJAwu0i2d+HrzOizskEEmhK74SHP8r
        XphFc1564C3/Qsn70FqPsdtvihUtRyOs13QxSaOf6Zok+MEMLI5gNKGBcqJmbqoCjy8dwLTis6uh0
        H0kAh2BlQCZ7YrHIJkmx7chJkepTh757n4j2DK4LWxjwcNTF2N17DUPfr4UqCQauknCnEDwsmpR6o
        cVbi/SAiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1DPy-00089Q-Em; Tue, 05 Mar 2019 16:59:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A437D2029F862; Tue,  5 Mar 2019 17:59:47 +0100 (CET)
Date:   Tue, 5 Mar 2019 17:59:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Meijboom <robin@meijboom.info>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 3/3] objtool: move tools/objtool/ to scripts/objtool/
Message-ID: <20190305165947.GN32477@hirez.programming.kicks-ass.net>
References: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
 <1551764896-8453-3-git-send-email-yamada.masahiro@socionext.com>
 <20190305144625.bjmkr6ebufbly5ba@treble>
 <CAK7LNAS=K2Hp+idOsHQBCYwk5YndzSdHL=GmJZRxsF6De3isNA@mail.gmail.com>
 <20190305163609.gz2cvpj7bxrnzdvm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305163609.gz2cvpj7bxrnzdvm@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 10:36:09AM -0600, Josh Poimboeuf wrote:
> Anyway I would like to hear what Ingo and Peter think about moving it.

Pain :-)
