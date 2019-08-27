Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF80C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF7F2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbfH0TMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:12:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:51655 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfH0TMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:12:18 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7RJBseI002906;
        Tue, 27 Aug 2019 14:11:54 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7RJBrZL002905;
        Tue, 27 Aug 2019 14:11:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 27 Aug 2019 14:11:53 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: cleanup hw_irq.h
Message-ID: <20190827191153.GC31406@gate.crashing.org>
References: <0f7e164afb5d1b022441559fe5a999bb6d3c0a23.1566893505.git.christophe.leroy@c-s.fr> <81f39fa06ae582f4a783d26abd2b310204eba8f4.1566893505.git.christophe.leroy@c-s.fr> <1566909844.x4jee1jjda.astroid@bobo.none> <20190827172909.GA31406@gate.crashing.org> <1410046b-e1a3-b892-2add-6c1d353cb781@c-s.fr> <20190827182616.GB31406@gate.crashing.org> <00cc71bd-35f5-b0d5-e4fa-8368fe4fe78c@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cc71bd-35f5-b0d5-e4fa-8368fe4fe78c@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 08:33:45PM +0200, Christophe Leroy wrote:
> >So
> >   asm("add%I2 %0,%1,%2" : "=r"(dst) : "r"(src1), "ri"(src1));
> 
> "ri", not "n" as for wrtee ?

"n" means a number.  "i" means any constant integer.  The difference is
mostly that "n" does not allow relocations.  This probably does not matter
for this asm, not if you call it with correct values anyway.

(If you want to pass other than small numbers here, you need different
constraints; let's not go there).


Segher
