Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081F4C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF47208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IYBBHeDk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Yvao/Qm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfH3C7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:59:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63313 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfH3C7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:59:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65F156F6EF;
        Thu, 29 Aug 2019 22:59:21 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=l4QL4FpUZNiWb9/l08DglR4Jbac=; b=IYBBHe
        Dkdt7TJuCtYVXxSj0PSFwLx7PhjJoDATWE8yxJicVrs9mPK4JC4Pk4PwdFutL853
        Q6D1J0ZQHbeHi/Hq5rqE5/q/XrJ/KsEDt7UeIfyo/504b/hlfuShzaL8uBM33TZR
        8Wieu44bKbnT2kQ53nzJFp0n68xm1irFqgcBA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CED46F6EE;
        Thu, 29 Aug 2019 22:59:21 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=056AWXTPXdma/lTN2ricI7xgmYosmePSD2y0+f9HBTQ=; b=Yvao/Qm+JO9ZUzBs5wXHtktXnKX1AxMDNu+h8mOqR4iYYYran1R55i0UIQ7QRcO1JVnl+yIp/lqlrOIp86MsZz6VZwmiShwg+sO0iNx9kq2PpEvE6e5FmrzeKc0axRENGgrJIXHPDjFztRTQTM+rqxBfMW40kndkf8FuYHbtyu4=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4318B6F6E4;
        Thu, 29 Aug 2019 22:59:18 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 6BFEA2DA05E1;
        Thu, 29 Aug 2019 22:59:16 -0400 (EDT)
Date:   Thu, 29 Aug 2019 22:59:16 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __div64_const32(): improve the generic C version
In-Reply-To: <nycvar.YSQ.7.76.1908202301490.19480@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1908292256290.3091@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1908202301490.19480@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 287F9F62-CAD2-11E9-B01E-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ping.

On Tue, 20 Aug 2019, Nicolas Pitre wrote:

> Let's rework that code to avoid large immediate values and convert some
> 64-bit variables to 32-bit ones when possible. This allows gcc to
> produce smaller and better code. This even produces optimal code on
> RISC-V.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> 
> diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
> index dc9726fdac..33358245b4 100644
> --- a/include/asm-generic/div64.h
> +++ b/include/asm-generic/div64.h
> @@ -178,7 +178,8 @@ static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
>  	uint32_t m_hi = m >> 32;
>  	uint32_t n_lo = n;
>  	uint32_t n_hi = n >> 32;
> -	uint64_t res, tmp;
> +	uint64_t res;
> +	uint32_t res_lo, res_hi, tmp;
>  
>  	if (!bias) {
>  		res = ((uint64_t)m_lo * n_lo) >> 32;
> @@ -187,8 +188,9 @@ static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
>  		res = (m + (uint64_t)m_lo * n_lo) >> 32;
>  	} else {
>  		res = m + (uint64_t)m_lo * n_lo;
> -		tmp = (res < m) ? (1ULL << 32) : 0;
> -		res = (res >> 32) + tmp;
> +		res_lo = res >> 32;
> +		res_hi = (res_lo < m_hi);
> +		res = res_lo | ((uint64_t)res_hi << 32);
>  	}
>  
>  	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
> @@ -197,10 +199,12 @@ static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
>  		res += (uint64_t)m_hi * n_lo;
>  		res >>= 32;
>  	} else {
> -		tmp = res += (uint64_t)m_lo * n_hi;
> +		res += (uint64_t)m_lo * n_hi;
> +		tmp = res >> 32;
>  		res += (uint64_t)m_hi * n_lo;
> -		tmp = (res < tmp) ? (1ULL << 32) : 0;
> -		res = (res >> 32) + tmp;
> +		res_lo = res >> 32;
> +		res_hi = (res_lo < tmp);
> +		res = res_lo | ((uint64_t)res_hi << 32);
>  	}
>  
>  	res += (uint64_t)m_hi * n_hi;
> 
