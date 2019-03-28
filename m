Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51E0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917E021773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfC1IIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:08:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52441 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1IIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:08:45 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9Q5b-0005Hx-MK; Thu, 28 Mar 2019 09:08:43 +0100
Date:   Thu, 28 Mar 2019 09:08:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 4/6] x86, mm: make split_mem_range() more easy to read
In-Reply-To: <20190328072027.GA6531@richard>
Message-ID: <alpine.DEB.2.21.1903280902390.1789@nanos.tec.linutronix.de>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com> <20190212021215.13247-5-richardw.yang@linux.intel.com> <alpine.DEB.2.21.1903232345500.1798@nanos.tec.linutronix.de> <20190328072027.GA6531@richard>
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

On Thu, 28 Mar 2019, Wei Yang wrote:
> On Sun, Mar 24, 2019 at 03:29:04PM +0100, Thomas Gleixner wrote:
> My question is to the for loop.
> 
> For example, we have a range
> 
>        +--+---------+-----------------------+
>        ^ 128M       1G                      2G
>    128M - 4K
> 
> If my understanding is correct, the original behavior will split this into
> three ranges:
> 
>    4K size: [128M - 4K, 128M]
>    2M size: [128M, 1G]
>    1G size: [1G, 2G]
> 
> While after your change, it will split this into two ranges:
> 
>    ?? size: [128M - 4K, 1G]
>    2M size: [1G, 2G]
>
> The question mark here is because you leave the page_size_mask unchanged in
> this case.
> 
> Is my understanding correct? Or I missed something?

Yes. You misread mr_try_map().

Thanks,

	tglx
