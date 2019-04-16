Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7ABC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE092075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfDPSug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:50:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50229 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:50:35 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hGT9z-0001fF-2f; Tue, 16 Apr 2019 20:50:23 +0200
Date:   Tue, 16 Apr 2019 20:50:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, luto@kernel.org,
        jpoimboe@redhat.com, sean.j.christopherson@intel.com,
        penberg@kernel.org, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: remove store_stackinfo()
In-Reply-To: <902fed9c-9655-a241-677d-5fa11b6c95a1@suse.cz>
Message-ID: <alpine.DEB.2.21.1904162040570.1780@nanos.tec.linutronix.de>
References: <20190416142258.18694-1-cai@lca.pw> <902fed9c-9655-a241-677d-5fa11b6c95a1@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, Vlastimil Babka wrote:

> On 4/16/19 4:22 PM, Qian Cai wrote:
> > store_stackinfo() does not seem used in actual SLAB debugging.
> > Potentially, it could be added to check_poison_obj() to provide more
> > information, but this seems like an overkill due to the declining
> > popularity of the SLAB, so just remove it instead.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> I've acked Thomas' version already which was narrower, but no objection
> to remove more stuff on top of that. Linus (and I later in another
> thread) already pointed out /proc/slab_allocators. It only takes a look
> at add_caller() there to not regret removing that one.

The issue why I was looking at this was a krobot complaint about the kernel
crashing in that stack store function with my stackguard series applied. It
was broken before the stackguard pages already, it just went unnoticed.

As you explained, nobody is caring about DEBUG_SLAB + DEBUG_PAGEALLOC
anyway, so I'm happy to not care about krobot tripping over it either.

So we have 3 options:

   1) I ignore it and merge the stack guard series w/o it

   2) I can carry the minimal fix or Qian's version in the stackguard
      branch

   3) We ship that minimal fix to Linus right now and then everyone can
      base their stuff on top independently.

#3 is probably the right thing to do.

Thanks,

	tglx
