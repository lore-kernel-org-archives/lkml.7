Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7861C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F592054F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfC0Uku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:40:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:25426 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfC0Ukt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:40:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 13:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="129216894"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2019 13:40:49 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 59B8B3015ED; Wed, 27 Mar 2019 13:40:49 -0700 (PDT)
Date:   Wed, 27 Mar 2019 13:40:49 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
Message-ID: <20190327204049.GW18020@tassilo.jf.intel.com>
References: <20190321220009.29334-3-andi@firstfloor.org>
 <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
 <20190326213803.GN18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
 <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
 <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de>
 <20190327145918.GU18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903271600050.1789@nanos.tec.linutronix.de>
 <20190327154522.GV18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903271958320.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903271958320.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +     asm(".pushsection .rodata, \"a\"\n"                             \                                                
> +         NATIVE_LABEL("start_", ops, name)                           \                                                
> +         code                                                        \                                                
> +         NATIVE_LABEL("end_", ops, name)                             \                                                
> +         ".popsection\n")                                                            

> 
> It's static so it's scope is within the file and whatever GCC does with
> that C function it has to respect that it accesses static data. If that's
> not true then this really needs to be fixed at the compiler side and not in
> the kernel.

Ok so you did the statics with undefined size, so kind of an extern static. 
That's a weird construct (not sure if it's even allowed in standard C), but
somehow it seems to work in gcc with the inline assembler.

I checked the code general and with the .globl in NATIVE_LABEL the 
generated assembler looks like it should work even for LTO yes.

I guess it's an interesting alternative to making them all global.
Maybe that will work for more cases too.

Thanks.

-Andi
