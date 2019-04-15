Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7825AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD2D218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfDOVWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:22:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfDOVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:22:20 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hG93S-0005wV-Aq; Mon, 15 Apr 2019 23:22:18 +0200
Date:   Mon, 15 Apr 2019 23:22:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch V4 01/32] mm/slab: Fix broken stack trace storage
In-Reply-To: <CALCETrXLa9ec8Lcz2WPML8qQiStpTtDSAGkW=Rv9bMSiunNNMw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904152320540.1806@nanos.tec.linutronix.de>
References: <20190414155936.679808307@linutronix.de> <20190414160143.591255977@linutronix.de> <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com> <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de> <alpine.DEB.2.21.1904151101100.1729@nanos.tec.linutronix.de>
 <20190415132339.wiqyzygqklliyml7@treble> <alpine.DEB.2.21.1904151804460.1895@nanos.tec.linutronix.de> <20190415161657.2zwboghblj5ducux@treble> <CALCETrXLa9ec8Lcz2WPML8qQiStpTtDSAGkW=Rv9bMSiunNNMw@mail.gmail.com>
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

On Mon, 15 Apr 2019, Andy Lutomirski wrote:
> On Mon, Apr 15, 2019 at 9:17 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Mon, Apr 15, 2019 at 06:07:44PM +0200, Thomas Gleixner wrote:
> > > > Looks like stack_trace.nr_entries isn't initialized?  (though this code
> > > > gets eventually replaced by a later patch)
> > >
> > > struct initializer initialized the non mentioned fields to 0, if I'm not
> > > totally mistaken.
> >
> > Hm, it seems you are correct.  And I thought I knew C.
> >
> > > > Who actually reads this stack trace?  I couldn't find a consumer.
> > >
> > > It's stored directly in the memory pointed to by @addr and that's the freed
> > > cache memory. If that is used later (UAF) then the stack trace can be
> > > printed to see where it was freed.
> >
> > Right... but who reads it?
> 
> That seems like a reasonable question.  After some grepping and some
> git searching, it looks like there might not be any users.  I found

Anymore. There was something 10y+ ago...

> SLAB_STORE_USER, but that seems to be independent.
> 
> So maybe the whole mess should just be deleted.  If anyone ever
> notices, they can re-add it better.

No objections from my side, but the mm people might have opinions.

Thanks,

	tglx
