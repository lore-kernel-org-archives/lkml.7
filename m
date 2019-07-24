Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A62C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9885221871
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B49etVYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfGXQW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:22:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58156 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfGXQW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=htcr0HwWfZTO2fZDhlOnsFU5KgxRNA5yit/dcbMX3ew=; b=B49etVYt9Msj8vnMr6MkdqPGm
        yKkFNiQudN6pzocirl1HKFoDh7Qn9uzXA7Q/TDrz8gae87USJ+sF6Y4sOQI1W5Nlf7AuDost0Lz+3
        iCrZ3qiWtIPPzcFr9Qagysoqaf+5VD9frki/ZMknmb0tze4hBWmGCNrFnfJdrC9xxO347oU7KmaY+
        0hHapM55o873JOIMSea+jl4dLZMnNaVQvWzTp9NsKTx4Jm3Jwp8fxsOYG/3k2DhvOv6Ec1o3XwN3e
        LMLCnNR1//k8URyzbMDTjU9MnTTnSRhikg37NAck/PegkGwk5wt+sJeYjym3Nlc4yTTujahVyQg/F
        +PODkU9rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqK2G-0006qF-1x; Wed, 24 Jul 2019 16:22:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C77D20288388; Wed, 24 Jul 2019 18:22:33 +0200 (CEST)
Date:   Wed, 24 Jul 2019 18:22:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Message-ID: <20190724162233.GC31381@hirez.programming.kicks-ass.net>
References: <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com>
 <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
 <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com>
 <20190723130513.GA25290@kroah.com>
 <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com>
 <20190724153416.GA27117@kroah.com>
 <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
 <20190724155735.GC5571@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724155735.GC5571@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 05:57:35PM +0200, Greg KH wrote:
> Wait, does clang link things itself and not need ld?

There's ld.lld; which might be used by your clang.
