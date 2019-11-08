Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577C5FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D95215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfKHRmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:42:07 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:56406 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726199AbfKHRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:42:06 -0500
Received: (qmail 4415 invoked by uid 2102); 8 Nov 2019 12:42:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Nov 2019 12:42:05 -0500
Date:   Fri, 8 Nov 2019 12:42:05 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Will Deacon <will@kernel.org>
cc:     linux-kernel@vger.kernel.org, Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        <linux-alpha@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 10/13] tools/memory-model: Remove smp_read_barrier_depends()
 from informal doc
In-Reply-To: <20191108170120.22331-11-will@kernel.org>
Message-ID: <Pine.LNX.4.44L0.1911081241460.1498-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Will Deacon wrote:

> 'smp_read_barrier_depends()' has gone the way of mmiowb() and so many
> esoteric memory barriers before it. Drop the two mentions of this
> deceased barrier from the LKMM informal explanation document.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  .../Documentation/explanation.txt             | 26 +++++++++----------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 488f11f6c588..3050bf67b8d0 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1118,12 +1118,10 @@ maintain at least the appearance of FIFO order.
>  In practice, this difficulty is solved by inserting a special fence
>  between P1's two loads when the kernel is compiled for the Alpha
>  architecture.  In fact, as of version 4.15, the kernel automatically
> -adds this fence (called smp_read_barrier_depends() and defined as
> -nothing at all on non-Alpha builds) after every READ_ONCE() and atomic
> -load.  The effect of the fence is to cause the CPU not to execute any
> -po-later instructions until after the local cache has finished
> -processing all the stores it has already received.  Thus, if the code
> -was changed to:
> +adds this fence after every READ_ONCE() and atomic load on Alpha.  The
> +effect of the fence is to cause the CPU not to execute any po-later
> +instructions until after the local cache has finished processing all
> +the stores it has already received.  Thus, if the code was changed to:
>  
>  	P1()
>  	{
> @@ -1142,14 +1140,14 @@ READ_ONCE() or another synchronization primitive rather than accessed
>  directly.
>  
>  The LKMM requires that smp_rmb(), acquire fences, and strong fences
> -share this property with smp_read_barrier_depends(): They do not allow
> -the CPU to execute any po-later instructions (or po-later loads in the
> -case of smp_rmb()) until all outstanding stores have been processed by
> -the local cache.  In the case of a strong fence, the CPU first has to
> -wait for all of its po-earlier stores to propagate to every other CPU
> -in the system; then it has to wait for the local cache to process all
> -the stores received as of that time -- not just the stores received
> -when the strong fence began.
> +share this property: They do not allow the CPU to execute any po-later
> +instructions (or po-later loads in the case of smp_rmb()) until all
> +outstanding stores have been processed by the local cache.  In the
> +case of a strong fence, the CPU first has to wait for all of its
> +po-earlier stores to propagate to every other CPU in the system; then
> +it has to wait for the local cache to process all the stores received
> +as of that time -- not just the stores received when the strong fence
> +began.
>  
>  And of course, none of this matters for any architecture other than
>  Alpha.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

