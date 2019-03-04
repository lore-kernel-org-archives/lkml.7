Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7608C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78F820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HH4nnaAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCDJag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:30:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfCDJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QcXu8ISGzcfSnNAoBShyc5Hsl+sS/5h/tmU38bN3rrA=; b=HH4nnaAnpIyAMMXjAXG7fO6eD
        QQMOG2ArktSKRQdm+AcKiSbszxBbXojd10wSAhEfkqwi2HWarlfpRlhQuIcUHeUeDheUweuxyCrUa
        cVpSl/iiW32x+ZkAWxrVBhlJyoyyShw4Hq4UyXcDBC03B7tWe6ZNVpSuOtSCIFiuqZJJyZwutiniO
        vWZhmxKlFy/SdjAqplk4/5OFxS4GnKcMJxv52WUwtfwNHACymEbHzk856nSem/MineqDUkF6PoGER
        6B/pen9s/Jzsh/f7CzV91a0oQTsX5POeqKu98w+t1RXmApRFdn4Q8nwVvrP550himBEm+f9+PAk8D
        BgYB8Kv6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0jv9-0003S5-EJ; Mon, 04 Mar 2019 09:30:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E35420295AAE; Mon,  4 Mar 2019 10:29:59 +0100 (CET)
Date:   Mon, 4 Mar 2019 10:29:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nicolai Stange <nstange@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Banman <abanman@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        Varsha Rao <rvarsha016@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: uv: Fix potential NULL pointer dereference of
 kmalloc_node
Message-ID: <20190304092959.GZ32477@hirez.programming.kicks-ass.net>
References: <20190302210905.13032-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302210905.13032-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 03:09:04PM -0600, Aditya Pakki wrote:
> kmalloc_node might fail to allocate memory for thp field. This fix
> attempts to avoid a potential NULL pointer dereference.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  arch/x86/platform/uv/tlb_uv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
> index a4130b84d1ff..5a6d51e30a36 100644
> --- a/arch/x86/platform/uv/tlb_uv.c
> +++ b/arch/x86/platform/uv/tlb_uv.c
> @@ -2011,6 +2011,9 @@ static void make_per_cpu_thp(struct bau_control *smaster)
>  	size_t hpsz = sizeof(struct hub_and_pnode) * num_possible_cpus();
>  
>  	smaster->thp = kmalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
> +	if (!smaster->thp)
> +		return;

This is init code; memeory allocation is 'unlikely' to fail. If it were
to fail, we'd have gotten a nice crash pinpointing the failure.

Now, we boot but get weird crashes later. Note how the rest of the code
assumes smaster->thp to be set. How is that any better?

