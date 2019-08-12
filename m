Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC697C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90191214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rudSRbBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHLPCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:02:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfHLPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UhputOm7Ak6HCMxwndND9cIz3++zl7ARWXtZ8+0gz9o=; b=rudSRbBvABcwONIWmJQsPrqfy
        oT9J49pX1Xpt6dG8Xjtvf4/1jzNESJ9C91FA5RTNHKSP0WR7mKO91LsujMJswJC8g63QG5vjGmBJe
        w8ParGgO9AbOawH4FsMaH2uQY9DdaklyjbS8+IzIe9Nl48iANlzXBUxK9eX6Q7KMUJz57ogF8lJYX
        0j9KFtMMsAwJabswbufx58p/bhIBrlm5AT9RpL8+PPSCzfIE+u93+c3C/5LjLo2a6fXZH/HpvTCbK
        aj7FwBjwn3lV0N0M4jjT4OVuja1X9Eu7ZV0dBXN5uGcjgvvLPO4UOcQ+ViWcRBoH/S3/Hroeeo/v2
        Jy+p/QLqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBpv-0005ZL-CF; Mon, 12 Aug 2019 15:02:15 +0000
Date:   Mon, 12 Aug 2019 08:02:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Johan Hovold <johan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [v5 PATCH] RISC-V: Fix unsupported isa string info.
Message-ID: <20190812150215.GF26897@infradead.org>
References: <20190807182316.28013-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807182316.28013-1-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	for (e = mandatory_ext; *e != '\0'; ++e) {
> +		if (isa[0] != e[0]) {
> +#if defined(CONFIG_FP)
> +			if ((isa[0] == 'f') || (isa[0] == 'd'))
> +				continue;
> +#endif
> +			unsupported_isa[index] = e[0];
> +			index++;
> +		}

I'd just use if (IS_ENABLED()) here to get full compiler coverage.
Also no need for the inner braces.

> +	if (isa[0] != '\0') {
> +		/* Add remainging isa strings */
> +		for (e = isa; *e != '\0'; ++e) {
> +#if !defined(CONFIG_VIRTUALIZATION)
> +			if (e[0] != 'h')
> +#endif
> +				seq_write(f, e, 1);
> +		}
> +	}

This one I don't get.  Why do we want to check CONFIG_VIRTUALIZATION?

>  	seq_puts(f, "\n");
>  
>  	/*
>  	 * If we were given an unsupported ISA in the device tree then print
>  	 * a bit of info describing what went wrong.
>  	 */
> -	if (isa[0] != '\0')
> -		pr_info("unsupported ISA \"%s\" in device tree\n", orig_isa);
> +	if (unsupported_isa[0])
> +		pr_info("unsupported ISA extensions \"%s\" in device tree for cpu [%ld]\n",
> +			unsupported_isa, cpuid);

And I'm not even sure why we care about unsupported extensions.  Sooner
or late a few will op up and they should be harmless.
