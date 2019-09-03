Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6262C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C695820828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfICScs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:32:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:50902 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfICScs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:32:48 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x83IVx20018430;
        Tue, 3 Sep 2019 13:31:59 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x83IVvlH018429;
        Tue, 3 Sep 2019 13:31:57 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 3 Sep 2019 13:31:57 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>, alastair@d-silva.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
Message-ID: <20190903183157.GB9749@gate.crashing.org>
References: <20190903052407.16638-1-alastair@au1.ibm.com> <20190903052407.16638-4-alastair@au1.ibm.com> <20190903130430.GC31406@gate.crashing.org> <d268ee78-607e-5eb3-ed89-d5c07f672046@c-s.fr> <20190903160415.GA9749@gate.crashing.org> <321b003a-9633-5ff4-c4a2-59a47ec23421@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321b003a-9633-5ff4-c4a2-59a47ec23421@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 07:05:19PM +0200, Christophe Leroy wrote:
> Le 03/09/2019 à 18:04, Segher Boessenkool a écrit :
> >(Why are they separate though?  It could just be one loop var).
> 
> Yes it could just be a single loop var, but in that case it would have 
> to be reset at the start of the second loop, which means we would have 
> to pass 'addr' for resetting the loop anyway,

Right, I noticed that after hitting send, as usual.

> so I opted to do it 
> outside the inline asm by using to separate loop vars set to their 
> starting value outside the inline asm.

The thing is, the way it is written now, it will get separate registers
for each loop (with proper earlyclobbers added).  Not that that really
matters of course, it just feels wrong :-)


Segher
