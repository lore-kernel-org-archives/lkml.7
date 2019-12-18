Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081862082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLROtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:49:46 -0500
Received: from smtp2.axis.com ([195.60.68.18]:38195 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfLROtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:49:45 -0500
IronPort-SDR: vTUCunjVXjVdRehuOm46Tk7M0Sq5tcfe897Iy+3eq8hNMAkvYYuPyyY8s1+XbFPzDkR0aUXi0i
 6mx2DlMFWULC+a/bYxL23AzOJN4feB/IHpQg4cD5uweDmpuAaoxs2KhCzU3qYJ/t83erwAXtPj
 TfikBrJigFx/wYnKm0sZ0ifmWoRaDTySZL8CO2pt71l6tSuv20bA76DM4YvGOJP069Cozcs0jn
 h8mcaVDbp2bTBII9/YlWJiCdPcsd5aJRZZ7vhwgpRaUIIUh08LFDRLwfjaeTKx6cpc+t8sXZRJ
 Iuk=
X-IronPort-AV: E=Sophos;i="5.69,329,1571695200"; 
   d="scan'208";a="3614878"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Date:   Wed, 18 Dec 2019 15:49:43 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] asm/sections: Check for overflow in memory_contains()
Message-ID: <20191218144943.bf5vqykvggtfnph7@axis.com>
References: <20191217102238.14792-1-vincent.whitchurch@axis.com>
 <20191217102831.GP25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217102831.GP25745@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:28:31AM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Dec 17, 2019 at 11:22:38AM +0100, Vincent Whitchurch wrote:
> > ARM uses memory_contains() from its stacktrace code via this function:
> > 
> >  static inline bool in_entry_text(unsigned long addr)
> >  {
> >  	return memory_contains(__entry_text_start, __entry_text_end,
> >  			       (void *)addr, 1);
> >  }
> > 
> > addr is taken from the stack and can be a completely invalid.  If addr
> > is 0xffffffff, there is an overflow in the pointer arithmetic in
> > memory_contains() and in_entry_text() incorrectly returns true.
> > 
> > Fix this by adding an overflow check.  The check is done on unsigned
> > longs to avoid undefined behaviour.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  include/asm-generic/sections.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> > index d1779d442aa5..e6e1b381c5df 100644
> > --- a/include/asm-generic/sections.h
> > +++ b/include/asm-generic/sections.h
> > @@ -105,7 +105,15 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
> >  static inline bool memory_contains(void *begin, void *end, void *virt,
> >  				   size_t size)
> >  {
> > -	return virt >= begin && virt + size <= end;
> > +	unsigned long membegin = (unsigned long)begin;
> > +	unsigned long memend = (unsigned long)end;
> > +	unsigned long objbegin = (unsigned long)virt;
> > +	unsigned long objend = objbegin + size;
> > +
> > +	if (objend < objbegin)
> > +		return false;
> > +
> > +	return objbegin >= membegin && objend <= memend;
> 
> Would merely changing to:
> 
> 	return virt >= begin && virt <= end - size;
> 
> be sufficient ?  Is end - size possible to underflow?

Something like this would trigger an underflow and return an incorrect
result with that expression, wouldn't it?

 memory_contains((void *)0x0000, (void *)0x1000, (void *)0x0, 0x1001))

AFAICS no current callers actually send in an object size which is
larger than the size of the memory, but perhaps it's best to be
defensive?
