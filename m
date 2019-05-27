Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431A4C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F482133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jwdSKNwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfE0Kxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:53:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfE0Kxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uVfy/lu/NyhO7gs/yTDr0U1v9NIKN7O4ba0GqTFT89s=; b=jwdSKNwofdLW9xZVXVF9A/LpJx
        Cd9/MtEOfxbNkI6fzdegmk8U9nHgsG+d6S6ih5nbwKH+MG1fjh71PotDcsHqQkoidfkCgRrT5pEW5
        /KGV1YUPF429Of951i4tfXEtjFLe2BU4xID55x3rHJQizvIr9niyegrWwONhoPkhBtjf83u8I0csT
        v0rW+aUAnqbCcetKsmcsPzoU8t8ZO+z6+DMKQeXMtCBhrNNMKffIcrLEJ+zbmnq8xMhSK4uXENnfi
        7v20O2+9lTaD3TCEYP5jzkkIXlR16YhUa0EL3uokVutdcczCvG63D+NZwfkG15nuve7GSLBgBGDHc
        5hvi0x0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDG8-0000jz-Pr; Mon, 27 May 2019 10:53:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4ED722027F766; Mon, 27 May 2019 12:53:39 +0200 (CEST)
Date:   Mon, 27 May 2019 12:53:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp,cpumask: Don't call functions on offline CPUs
Message-ID: <20190527105339.GZ2623@hirez.programming.kicks-ass.net>
References: <20190522111537.27815-1-andrew.murray@arm.com>
 <20190522140921.GD16275@worktop.programming.kicks-ass.net>
 <20190522143711.GC8268@e119886-lin.cambridge.arm.com>
 <20190522144918.GH16275@worktop.programming.kicks-ass.net>
 <d8ec196590237c047bbe6805b933ec9dd2ec42c4.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d8ec196590237c047bbe6805b933ec9dd2ec42c4.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 02:23:47PM -0400, Rik van Riel wrote:
> On Wed, 2019-05-22 at 16:49 +0200, Peter Zijlstra wrote:
> > On Wed, May 22, 2019 at 03:37:11PM +0100, Andrew Murray wrote:
> > > > Is perhaps the problem that on_each_cpu_cond() uses
> > > > cpu_onlne_mask
> > > > without protection?
> > >=20
> > > Does this prevent racing with a CPU going offline? I guess this
> > > prevents
> > > the warning at the expense of a lock - but is only beneficial in
> > > the
> > > unlikely path. (In the likely path this prevents new CPUs going
> > > offline
> > > but we don't care because we don't WARN if they aren't they when we
> > > attempt to call functions).
> > >=20
> > > At least this is my limited understanding.
> >=20
> > Hmm.. I don't think it could matter, we only use the mask when
> > preempt_disable(), which would already block offline, due to it using
> > stop_machine().
> >=20
> > So the patch is a no-op.
> >=20
> > What's the WARN you see? TLB invalidation should pass mm_cpumask(),
> > which similarly should not contain offline CPUs I'm thinking.
>=20
> Does the TLB invalidation code have anything in it
> to prevent from racing with the CPU offline code?
>=20
> In other words, could we end up with the TLB
> invalidation code building its bitmask, getting
> interrupted (eg. hypervisor preemption, NMI),
> and not sending out the IPI to that bitmask of
> CPUs until after one of the CPUs in the bitmap
> has gotten offlined?

One possible thing would be if cpu-offline didn't remove the bit from
mm_cpumask() because it entered lazy state earlier or something.

Then, mm_cpumask() would contain an offline CPU and the WARN could
trigger, but I don't _think_ we do that, but I didn't check.
