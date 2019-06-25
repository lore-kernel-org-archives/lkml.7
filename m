Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C661C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621AF208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561494236;
	bh=ty8OSeUCz/5XvL7ic9s3yUJgWM1ofmFAG2h2f5h8eOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tS5Ia4OJffi4UTfMEeb1+04rlWWdGSPFOUsSpUmc0M0wUvfLE8kbhrX6Y1zw9xfBw
	 wvR8pk9zc69Yq+vU4bBBptJOMQl/btkaJ4QkyN/yo7eiALvcm4rpFJlGNig2hQTZFp
	 b70ahboxyxTXR1zyRRCRTlqGzZaQdi15LX2tMSEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFYUXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfFYUXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:23:54 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B4B2085A;
        Tue, 25 Jun 2019 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561494233;
        bh=ty8OSeUCz/5XvL7ic9s3yUJgWM1ofmFAG2h2f5h8eOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CITJOOm379AFpZGiqQaxvlLl8CMO38VIjXbovh/3uocIqEnmtaRAdl8ZZnNvzMF+t
         7y0jyLhD6my9mIEPL31WT0Wn00z+MlSfk49SVd3BtPxyg4LZmFlXwHYPWXvlLS6DEh
         KpNI+8QriqEKN54YTmS06SIeRqjo9OOOqloxzZ+s=
Date:   Tue, 25 Jun 2019 13:23:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Doug Berger <opendmb@gmail.com>
Cc:     linux-mm@kvack.org, Yue Hu <huyue2@yulong.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        =?UTF-8?Q?Micha=C5=82?= Nazarewicz <mina86@mina86.com>,
        Laura Abbott <labbott@redhat.com>, Peng Fan <peng.fan@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cma: fail if fixed declaration can't be honored
Message-Id: <20190625132353.ba16040d27366fae4ec5bef0@linux-foundation.org>
In-Reply-To: <1561422051-16142-1-git-send-email-opendmb@gmail.com>
References: <1561422051-16142-1-git-send-email-opendmb@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 17:20:51 -0700 Doug Berger <opendmb@gmail.com> wrote:

> The description of the cma_declare_contiguous() function indicates
> that if the 'fixed' argument is true the reserved contiguous area
> must be exactly at the address of the 'base' argument.
> 
> However, the function currently allows the 'base', 'size', and
> 'limit' arguments to be silently adjusted to meet alignment
> constraints. This commit enforces the documented behavior through
> explicit checks that return an error if the region does not fit
> within a specified region.
> 
> ...
>
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -278,6 +278,12 @@ int __init cma_declare_contiguous(phys_addr_t base,
>  	 */
>  	alignment = max(alignment,  (phys_addr_t)PAGE_SIZE <<
>  			  max_t(unsigned long, MAX_ORDER - 1, pageblock_order));
> +	if (fixed && base & (alignment - 1)) {
> +		ret = -EINVAL;
> +		pr_err("Region at %pa must be aligned to %pa bytes\n",
> +			&base, &alignment);

CMA functions do like to use pr_err() when the caller messed something
up.  It should be using WARN_ON() or WARN_ON_ONCE(), mainly so we get a
backtrace to find out which caller messed up.

There are probably other sites which should be converted, but I think
it would be best to get these new ones correct.  So something like

	if (WARN_ONCE(fixed && base & (alignment - 1)),
		      "region at %pa must be aligned to %pa bytes",
		      &base, &alignment) {
		ret = -EINVAL;
		goto err;
	}


