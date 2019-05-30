Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDF3C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC5A24B81
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ViocBpNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfE3FxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 01:53:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Fw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 01:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oHqVEIhqCwMex8GKlVQDi4KtDcsBFBMe3TYDNP4SewE=; b=ViocBpNvOg+Novr+owM9IAtqL
        mxbnKycuk76UKiKY6BtJbNuFG50XpOQ1P37OqQgdiTBUMuiMEHvHRfYRyfGrj3aGD6js3FV6dFkUl
        f6N9V1KXtGVAHiydLyhDrKNf5C0qB6cyHE0Q19ozUBT1lHYD9xSdq0JUszRtyynjiGEFYgeWdEUqX
        gdkPRik7oOTm+LbhV2kXM/2bF7nNRjHcTomKMX6TJIZzHnFWRKgOPOLCWJ5BFOciGFBpx5H/OVwNB
        EEumZRHqRHxurSmaxBNu3VEedlPsCDfV/dzoGjABVbmKtBPW0qZCqXFtdR50umTuzzd2TAz6t3cEX
        SAcNGPQxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWDzm-0003GK-GA; Thu, 30 May 2019 05:52:58 +0000
Date:   Wed, 29 May 2019 22:52:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Hu <nickhu@andestech.com>
Cc:     greentime@andestech.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        green.hu@gmail.com
Subject: Re: [PATCH] riscv: Fix udelay in RV32.
Message-ID: <20190530055258.GA7170@infradead.org>
References: <381ee6950c84b868ca6a3c676eb981a1980889a3.1559035050.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381ee6950c84b868ca6a3c676eb981a1980889a3.1559035050.git.nickhu@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 05:26:49PM +0800, Nick Hu wrote:
> In RV32, udelay would delay the wrong cycle.
> When it shifts right "UDELAY_SHITFT" bits, it
> either delays 0 cycle or 1 cycle. It only works
> correctly in RV64. Because the 'ucycles' always
> needs to be 64 bits variable.

Please use up all your ~72 chars per line in the commit log.

> diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
> index dce8ae24c6d3..da847f49fb74 100644
> --- a/arch/riscv/lib/delay.c
> +++ b/arch/riscv/lib/delay.c
> @@ -88,7 +88,7 @@ EXPORT_SYMBOL(__delay);
>  
>  void udelay(unsigned long usecs)
>  {
> -	unsigned long ucycles = usecs * lpj_fine * UDELAY_MULT;
> +	unsigned long long ucycles = (unsigned long long)usecs * lpj_fine * UDELAY_MULT;

And this creates a way too long line.  Pleaase use u64 instead of
unsigned long long to clarify the intention while also fixing the long
lines.
