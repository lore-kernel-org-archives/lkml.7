Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C729C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C4920700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfC1ICg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:02:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1ICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:02:35 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9Pzd-0005AJ-G5; Thu, 28 Mar 2019 09:02:33 +0100
Date:   Thu, 28 Mar 2019 09:02:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 4/6] x86, mm: make split_mem_range() more easy to read
In-Reply-To: <20190328065117.GA6202@richard>
Message-ID: <alpine.DEB.2.21.1903280856470.1789@nanos.tec.linutronix.de>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com> <20190212021215.13247-5-richardw.yang@linux.intel.com> <alpine.DEB.2.21.1903232345500.1798@nanos.tec.linutronix.de> <20190328065117.GA6202@richard>
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

Wei,

On Thu, 28 Mar 2019, Wei Yang wrote:

please trim your replies. It's annoying if one has to search the content in
the middle of a large useless quote.

> On Sun, Mar 24, 2019 at 03:29:04PM +0100, Thomas Gleixner wrote:
> >Wei,
> >-static int __meminit split_mem_range(struct map_range *mr, int nr_range,
> >-				     unsigned long start,
> >-				     unsigned long end)
> >-{
> >-	unsigned long start_pfn, end_pfn, limit_pfn;
> >-	unsigned long pfn;
> >-	int i;
> >+	if (!IS_ALIGNED(mr->end, mi->size)) {
> >+		/* Try to fit as much as possible */
> >+		len = round_down(mr->end - mr->start, mi->size);
> >+		if (!len)
> >+			return false;
> >+		mr->end = mr->start + len;
> >+	}
> > 
> >-	limit_pfn = PFN_DOWN(end);
> >+	/* Store the effective page size mask */
> >+	mr->page_size_mask = mi->mask;
> 
> I don't get the point here. Why store the effective page size mask just for
> the "middle" range.
> 
> The original behavior will set the "head" and "tail" range with a lower level
> page size mask.

What has this to do with the middle range? Nothing. This is the path where
the current map level (1g, 2m, 4k) is applied from mr->start to
mr->end. That's the effective mapping of this map_range entry. 

Thanks,

	tglx
