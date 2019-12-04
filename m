Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37F8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C4C207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VvlqX/hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfLDP27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:28:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33826 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbfLDP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h87ip3hGwhH4oIF/zayIPJ2ZwZuEoxtcahchs45r+eM=; b=VvlqX/hslMRwwQbo/hbpVXpeE
        fFlwFikcGnyw4SoT6bxSGgRrjKJXJ4GDGQEgLFT92+DIaup/o+e6MV8AlTctJl2eM2PrL4Hn6YjyD
        /vI2PzPEDGXBUkvWu5vlPEwfPgnq+GkOz96B3Nkc8vxGMKDCOOJlnOy1DcTmVhPC1yE/ypbDsq5A2
        owpRtdMD/bDDvwy1NPYEMOQCInmF9pNcrNxKmgODuTo+if43PYXpzbypOxCgUWI7QFKgyLISyw/Uq
        bWi0vOSnDYnVlNM2yO+/Nn5JpFaGmaiyBarDzXOqMNPfBbSAZVoQ/ZqSV9EQUcJAgVEVy6lKU6mDt
        hg9mQD70w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icWa9-0001kB-BX; Wed, 04 Dec 2019 15:28:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD3423006E3;
        Wed,  4 Dec 2019 16:27:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FA1720D1A245; Wed,  4 Dec 2019 16:28:47 +0100 (CET)
Date:   Wed, 4 Dec 2019 16:28:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, richard@nod.at
Subject: Re: [PATCH v2 3/4] mtd: rawnand: fsmc: Change to non-atomic bit
 operations
Message-ID: <20191204152847.GZ2844@hirez.programming.kicks-ass.net>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
 <1574710984-208305-4-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574710984-208305-4-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:43:03AM -0800, Fenghua Yu wrote:
> No need for expensive atomic change_bit() on the local variable err_idx[].
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/mtd/nand/raw/fsmc_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
> index a6964feeec77..916496d4ecf2 100644
> --- a/drivers/mtd/nand/raw/fsmc_nand.c
> +++ b/drivers/mtd/nand/raw/fsmc_nand.c
> @@ -809,8 +809,8 @@ static int fsmc_bch8_correct_data(struct nand_chip *chip, u8 *dat,
>  
>  	i = 0;
>  	while (num_err--) {
> -		change_bit(0, (unsigned long *)&err_idx[i]);
> -		change_bit(1, (unsigned long *)&err_idx[i]);
> +		__change_bit(0, (unsigned long *)&err_idx[i]);
> +		__change_bit(1, (unsigned long *)&err_idx[i]);
>  
>  		if (err_idx[i] < chip->ecc.size * 8) {
>  			change_bit(err_idx[i], (unsigned long *)dat);

I'm thinking this all can be written like:

		err_idx[i] ^= 3;

		if (err_idx[i] < chip->ecc.size * 8) {
			err = err_idx[i];
			dat[err >> 3] ^= BIT(err & 7);
		}

It seems unlikely that the @dat we're correcting has concurrency issues.
