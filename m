Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F568C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D960D2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDEVBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:01:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49843 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEVBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:01:19 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCVxc-0004gT-Hj; Fri, 05 Apr 2019 23:01:16 +0200
Date:   Fri, 5 Apr 2019 23:01:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 19/29] x86/exceptions: Split debug IST stack
In-Reply-To: <20190405205549.GE15808@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1904052300500.1802@nanos.tec.linutronix.de>
References: <20190405150658.237064784@linutronix.de> <20190405150930.129884669@linutronix.de> <20190405205549.GE15808@linux.intel.com>
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

On Fri, 5 Apr 2019, Sean Christopherson wrote:
> On Fri, Apr 05, 2019 at 05:07:17PM +0200, Thomas Gleixner wrote:
> > +	/*
> > +	 * Note, this covers the guard page between DB and DB1 as well to
> > +	 * avoid two checks. But by all means @addr can never point into
> > +	 * the guard page.
> > +	 */
> > +	return addr > bot && addr < top;
> 
> Isn't this an off by one error?  I.e. "return addr >= bot && addr < top".
> %rsp == bot is technically still in the DB1 stack even though the next
> PUSH/CALL will explode on the guard page.

Right you are.

