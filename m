Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57799C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198472171F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vm9pnwwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCRXDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:03:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCRXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z/7+DOJfW8DrjWrvEuuButbDYoh6Ix51JyH+yl8myFw=; b=Vm9pnwwfQHcDOhu//yIFSVLDF
        McwqAg/QE+vgVrNHMlMLV/KgonsoflWYZOm6aCsiN5KmQKhOZk0KTCqxVC9zCk0BicWgTxbGZe9PF
        vaNb6FA5BF4D8X3fcwuKNPeJTJGPx4aBC669xptWhYJ/9KLxJeaE+6DIAVInvTaNGxL8JbXPHY81C
        2PgmXvLbdAYA5Ddb7vFisWgomcqkvYAXXr4q7Fk+K50YuZNSq3Gd9wo51ppolLPtuRtqci8F09QV+
        K171svJgk2TBRHNOu3eppEjsPN160BixkPNukHxS71J2JkVsPiqRgdZEPljKMiZ3HLhboUkJrHmFs
        CELR6S4zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h61I6-0005hX-Js; Mon, 18 Mar 2019 23:03:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2F2221422950; Tue, 19 Mar 2019 00:03:31 +0100 (CET)
Date:   Tue, 19 Mar 2019 00:03:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
Message-ID: <20190318230331.GW6058@hirez.programming.kicks-ass.net>
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
 <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
 <20190315222906.GC112750@google.com>
 <CAKwvOdkXobdu74Fo0fiS4xkikqZdKS=gWN61pVAFBbXRPoenRw@mail.gmail.com>
 <20190318171604.GU6058@hirez.programming.kicks-ass.net>
 <20190318204435.GH112750@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318204435.GH112750@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 01:44:35PM -0700, Matthias Kaehlcke wrote:
> You have a point, enabling -Oz (aggressive optimization for size)
> doesn't seem a good choice for the entire kernel.

Note that in this instance, -Os actually generates _smaller_ code than
-Oz, now that's mostly because of stupid register shuffling, but still.

> I'll send a patch to change it (back) to -Os.

Thanks!
