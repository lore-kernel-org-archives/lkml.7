Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD73AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1A42147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfC0PpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:45:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:3893 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfC0PpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:45:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 08:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="129133921"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2019 08:45:22 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0F8673015ED; Wed, 27 Mar 2019 08:45:22 -0700 (PDT)
Date:   Wed, 27 Mar 2019 08:45:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
Message-ID: <20190327154522.GV18020@tassilo.jf.intel.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-3-andi@firstfloor.org>
 <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de>
 <20190326213803.GN18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
 <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
 <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de>
 <20190327145918.GU18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903271600050.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903271600050.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why on earth is this needed for LTO?
> 
> From the GCC manual:
> 
>  "This attribute, attached to a global variable or function, nullifies the
>   effect of the -fw hole-program command-line option, so the object remains
>   visible outside the current compilation unit."
> 
> Neither the variable nor the data generated are global anymore. This data
> is only used inside this compilation unit and I don't see why LTO needs a
> reference outside of it. If so, then I really want to understand WHY
> exactly.

The LTO code generation doesn't compile file by file, but reorders
all the functions and other top level statements into "partitions".
The partitions are ordered by call graph so that inlining and some
other optimizations work efficiently

Then it finally runs multiple copies of the gcc code generator that
generate code from these partitions, each generating an own assembler file.

The top level assembler is not part of the call graph that drives
the partitioning.

So it can happen (in fact it's likely) that the top level assembler
statement ends up in a different partition and final assembler file
than the other functions in the same source file.

The repartitioning handles all symbols that are visible to C
automatically.

But for top level asm() referencing C symbols gcc doesn't know what
it is referenced.

Normally in non LTO it just works because everything ends up 
in the same assembler file and the assembler can resolve the static label.

But that won't work if it's in a different assembler file,
as in LTO.

Fixing it would probably require adding some new syntax to top
level asm to declare symbols it referenced, so that gcc understands
the references.

But if we make it __visible and global it works too because
the linker resolves it. That's simple enough, although can be a bit
unexpected.

More information on LTO internals:
https://gcc.gnu.org/onlinedocs/gccint/LTO-Overview.html#LTO-Overview

-Andi

