Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69802C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358072071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w17yBLFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKVUbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:31:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C1si9QuwchvONyAzPXv9Cv2CkeECZom3n9MQE6CHo/M=; b=w17yBLFj8UqtRwHBnAGJEidgQ
        9hPpEuT/LjJ2FLQxK8pMoZwWflA0mY2TCp8sTvnoXoWyPZ2NySsslq//nREZ4mRqzrnisOfAmTxMO
        JIzuNxnqURxHgZ5kEOIfgUuI4iunPnUYMxVXDoJLMMo5L6GGdXA9oBPvVMUkNCMWAeFNJx2xps8Ca
        KNMbGiFjcCd/oM4v0zQGJxAfMrLnLoxLJCXih6WpfyrBtdlQ6BpcSnLOaWAH5h0QEA8PiIDqz3NTG
        bOw10MKGkI7dJOtP2RQBUAN/YgkVohIyb/JhgAP+VMp92BBHTooGw8ObF94aDjhYUwhVzklqz75kw
        bxg4EixAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYFa6-0006FK-KG; Fri, 22 Nov 2019 20:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6E8C30173D;
        Fri, 22 Nov 2019 21:29:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A62120B2867F; Fri, 22 Nov 2019 21:31:05 +0100 (CET)
Date:   Fri, 22 Nov 2019 21:31:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122203105.GE2844@hirez.programming.kicks-ass.net>
References: <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 05:48:14PM +0000, Luck, Tony wrote:
> > When we use byte ops, we must consider the word as 4 independent
> > variables. And in that case the later load might observe the lock-byte
> > state from 3, because the modification to the lock byte from 4 is in
> > CPU2's store-buffer.
> 
> So we absolutely violate this with the optimization for constant arguments
> to set_bit(), clear_bit() and change_bit() that are implemented as byte ops.
> 
> So is code that does:
> 
> 	set_bit(0, bitmap);
> 
> on one CPU. While another is doing:
> 
> 	set_bit(mybit, bitmap);
> 
> on another CPU safe? The first operates on just one byte, the second  on 8 bytes.

It is safe if all you care about is the consistency of that one bit.

