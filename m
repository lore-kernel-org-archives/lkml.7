Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D3AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26499214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564660888;
	bh=D5new/YYn3kPcHh7di/Fven4S2ktVYG0OmdgPvAh4PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JiyDvQSLqUuKC4IOJzy4QlLsy3hD/LF/FjLBXTuOtVLYgOzl+uyanbsZl0pxm+Tsr
	 MR1N5RuSsobeeWDsuKjirKu8y0pQoWRTkuffS/nq9fnxmVAxzaerq022Hn/NgnNaEV
	 ySSHpQA9PdV6cKSmESB8FxAmMAhEiNUVUsb+kpoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfHAMB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfHAMB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:01:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2202E20644;
        Thu,  1 Aug 2019 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564660886;
        bh=D5new/YYn3kPcHh7di/Fven4S2ktVYG0OmdgPvAh4PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IE6mLKyYjztotryxL/tOSZEH2cYaxcN7ViYug7D8wjScOTcPomkuNZHqr/8jCnLW6
         bTgmlMcfqYjfIeldb1Y7t9tpmc81NrLEkP1pPZrs6mp9fo8KJlf6T2TpY6zhsbFo8E
         bbSrtyff0KUD+Hy8tCu67p+NewAjDYSazxoV+WFg=
Date:   Thu, 1 Aug 2019 13:01:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: fix variable 'tag' set but not used
Message-ID: <20190801120121.6cmtho3wd32nzfoz@willie-the-truck>
References: <1564605498-17629-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564605498-17629-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:38:18PM -0400, Qian Cai wrote:
> When CONFIG_KASAN_SW_TAGS=n, set_tag() is compiled away. GCC throws a
> warning,
> 
> mm/kasan/common.c: In function '__kasan_kmalloc':
> mm/kasan/common.c:464:5: warning: variable 'tag' set but not used
> [-Wunused-but-set-variable]
>   u8 tag = 0xff;
>      ^~~
> 
> Fix it by making __tag_set() a static inline function.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/include/asm/memory.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b7ba75809751..9645b1340afe 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -210,7 +210,11 @@ static inline unsigned long kaslr_offset(void)
>  #define __tag_reset(addr)	untagged_addr(addr)
>  #define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
>  #else
> -#define __tag_set(addr, tag)	(addr)
> +static inline const void *__tag_set(const void *addr, u8 tag)
> +{
> +	return addr;
> +}

Why doesn't this trigger a warning in page_to_virt(), which passes an
unsigned long for the address parameter?

Will
