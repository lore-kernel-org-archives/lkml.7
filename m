Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA54C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FAB20882
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfICUXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:23:01 -0400
Received: from outbound4sev.lav.puc.rediris.es ([130.206.19.177]:15068 "EHLO
        mx02.puc.rediris.es" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726009AbfICUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:23:01 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 16:23:00 EDT
Received: from mta-out01.sim.rediris.es (mta-out01.sim.rediris.es [130.206.24.43])
        by mx02.puc.rediris.es  with ESMTP id x83KBN0J009423-x83KBN0L009423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Sep 2019 22:11:23 +0200
Received: from mta-out01.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPS id 3AE24332E817;
        Tue,  3 Sep 2019 22:11:23 +0200 (CEST)
Received: from mta-out01.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPS id 2A326332E818;
        Tue,  3 Sep 2019 22:11:23 +0200 (CEST)
Received: from lt-gp.iram.es (219.red-80-24-122.staticip.rima-tde.net [80.24.122.219])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPA id 5A9B4332E817;
        Tue,  3 Sep 2019 22:11:22 +0200 (CEST)
Date:   Tue, 3 Sep 2019 22:11:21 +0200
From:   Gabriel Paubert <paubert@iram.es>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Alastair D'Silva <alastair@au1.ibm.com>,
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
Message-ID: <20190903201121.GD3547@lt-gp.iram.es>
References: <20190903052407.16638-1-alastair@au1.ibm.com>
 <20190903052407.16638-4-alastair@au1.ibm.com>
 <20190903130430.GC31406@gate.crashing.org>
 <d268ee78-607e-5eb3-ed89-d5c07f672046@c-s.fr>
 <20190903160415.GA9749@gate.crashing.org>
 <321b003a-9633-5ff4-c4a2-59a47ec23421@c-s.fr>
 <20190903183157.GB9749@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903183157.GB9749@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-FEAS-CONTENT-MODIFICATION:      
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 01:31:57PM -0500, Segher Boessenkool wrote:
> On Tue, Sep 03, 2019 at 07:05:19PM +0200, Christophe Leroy wrote:
> > Le 03/09/2019 à 18:04, Segher Boessenkool a écrit :
> > >(Why are they separate though?  It could just be one loop var).
> > 
> > Yes it could just be a single loop var, but in that case it would have 
> > to be reset at the start of the second loop, which means we would have 
> > to pass 'addr' for resetting the loop anyway,
> 
> Right, I noticed that after hitting send, as usual.
> 
> > so I opted to do it 
> > outside the inline asm by using to separate loop vars set to their 
> > starting value outside the inline asm.
> 
> The thing is, the way it is written now, it will get separate registers
> for each loop (with proper earlyclobbers added).  Not that that really
> matters of course, it just feels wrong :-)

After "mtmsr %3", it is always possible to copy %0 to %3 and use it as
an address register for the second loop. One register less to allocate
for the compiler. Constraints of course have to be adjusted.

	Gabriel
> 
> 
> Segher
