Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B7C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F090125AE2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfE3Gy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:54:56 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:56320 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727297AbfE3Gy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:54:56 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x4U6n038060958;
        Thu, 30 May 2019 14:49:00 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 30 May 2019
 14:54:35 +0800
Date:   Thu, 30 May 2019 14:54:36 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= 
        <greentime@andestech.com>, "palmer@sifive.com" <palmer@sifive.com>,
        "albert@sifive.com" <albert@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "green.hu@gmail.com" <green.hu@gmail.com>
Subject: Re: [PATCH v2] riscv: Fix udelay in RV32.
Message-ID: <20190530065436.GA15137@andestech.com>
References: <67a14915b99ee5d933ef9e7e056fc6e1935e775e.1559198255.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67a14915b99ee5d933ef9e7e056fc6e1935e775e.1559198255.git.nickhu@andestech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x4U6n038060958
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 02:49:10PM +0800, Nick Chun-Ming Hu(胡峻銘) wrote:
> In RV32, udelay would delay the wrong cycle. When it shifts right
> "UDELAY_SHITFT" bits, it either delays 0 cycle or 1 cycle. It only works
> correctly in RV64. Because the 'ucycles' always needs to be 64 bits
> variable.
> 
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> ---
>  arch/riscv/lib/delay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
> index dce8ae24c6d3..ee6853c1e341 100644
> --- a/arch/riscv/lib/delay.c
> +++ b/arch/riscv/lib/delay.c
> @@ -88,7 +88,7 @@ EXPORT_SYMBOL(__delay);
>  
>  void udelay(unsigned long usecs)
>  {
> -	unsigned long ucycles = usecs * lpj_fine * UDELAY_MULT;
> +	u64 ucycles = (u64)usecs * lpj_fine * UDELAY_MULT;
>  
>  	if (unlikely(usecs > MAX_UDELAY_US)) {
>  		__delay((u64)usecs * riscv_timebase / 1000000ULL);
> -- 
> 2.17.0
>

Hi All, I forgot to add "Reviewed-by: Palmer Dabbelt <palmer@sifive.com>".
I will send another patch.

Sorry.
