Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE1CC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C499B2235C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbfHGRIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:08:13 -0400
Received: from foss.arm.com ([217.140.110.172]:52162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfHGRIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:08:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C10F344;
        Wed,  7 Aug 2019 10:08:12 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AEBD3F575;
        Wed,  7 Aug 2019 10:08:11 -0700 (PDT)
Date:   Wed, 7 Aug 2019 18:08:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] firmware: arm_scmi: Use {get,put}_unaligned_le32
 accessors
Message-ID: <20190807170808.GD27278@e107155-lin>
References: <20190807130038.26878-1-sudeep.holla@arm.com>
 <4102ce79ef7a4f5ba819663d072bccc8@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4102ce79ef7a4f5ba819663d072bccc8@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 03:18:59PM +0000, David Laight wrote:
> From: Sudeep Holla
> > Sent: 07 August 2019 14:01
> >
> > Instead of type-casting the {tx,rx}.buf all over the place while
> > accessing them to read/write __le32 from/to the firmware, let's use
> > the nice existing {get,put}_unaligned_le32 accessors to hide all the
> > type cast ugliness.
>
> Why the 'unaligned' accessors?
>

Since the firmware run in LE, we do byte-swapping anyways.

> > -	*(__le32 *)t->tx.buf = cpu_to_le32(id);
> > +	put_unaligned_le32(id, t->tx.buf);
>

If you look at the generic definition for put_unaligned_le32, it's
exactly the same as what I am replacing with the call. So nothing
changes IIUC. In fact, I see that all the helper in unaligned/access_ok.h
just do the byte-swapping.

> These will be expensive if the cpu doesn't support them.

The SCMI is currently used only on ARM platforms which have
HAVE_EFFICIENT_UNALIGNED_ACCESS defined.

--
Regards,
Sudeep
