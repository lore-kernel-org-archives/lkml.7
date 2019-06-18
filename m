Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A46C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBEB20673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="Tz1x9QBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfFRGwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:52:24 -0400
Received: from ozlabs.org ([203.11.71.1]:36515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfFRGwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:52:23 -0400
Received: from neuling.org (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 45Sd9C3hMDz9sNk;
        Tue, 18 Jun 2019 16:15:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
        s=201811; t=1560838511;
        bh=SXPCd1WoGf+poGC7TcVU//uBUHMfckPpSH22kDTOs88=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Tz1x9QBmql6pHgCR0xXLI6o8RUYhTE/51mro8K5ulnDbbGXV/dwg3nEZGalqQG0gF
         rQef7ubbJY4GQr0l6ogbgm11VQaqyf7cOWLIZPfKQhlLMIU/nY+PKnZIicZ3QHj7J7
         /BfI0ZRHL+XTZbZFav5+pwlmhXmptQxTG2ZiRlxgdeem+Tq9lEvM+w7UHmVlb84skh
         tyUnGDg1b4PRh95dqUcD3ImI9fyyNiMxNNUxC/Pbuia/5Mp90lsGJ6AcUlSrMC2ZgV
         RYFGV3chAW3D7XNH/QPzwAiH9esFG8m5kcekq6Vnf/nfc5HPjUpKV5WGKbnSNaWmqw
         2Q1DskdwiWk3A==
Received: by neuling.org (Postfix, from userid 1000)
        id 664B12A2538; Tue, 18 Jun 2019 16:15:11 +1000 (AEST)
Message-ID: <ab7e5fac2a1ea78181900f5df7411b1f51b65eb9.camel@neuling.org>
Subject: Re: [PATCH 4/5] Powerpc/hw-breakpoint: Optimize disable path
From:   Michael Neuling <mikey@neuling.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com
Date:   Tue, 18 Jun 2019 16:15:11 +1000
In-Reply-To: <20190618042732.5582-5-ravi.bangoria@linux.ibm.com>
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
         <20190618042732.5582-5-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 09:57 +0530, Ravi Bangoria wrote:
> Directly setting dawr and dawrx with 0 should be enough to
> disable watchpoint. No need to reset individual bits in
> variable and then set in hw.

This seems like a pointless optimisation to me.=20

I'm all for adding more code/complexity if it buys us some performance, but=
 I
can't imagine this is a fast path (nor have you stated any performance
benefits).=20

Mikey

>=20
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_breakpoint.h |  3 ++-
>  arch/powerpc/kernel/process.c            | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h
> b/arch/powerpc/include/asm/hw_breakpoint.h
> index 78202d5fb13a..8acbbdd4a2d5 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -19,6 +19,7 @@ struct arch_hw_breakpoint {
>  /* Note: Don't change the the first 6 bits below as they are in the same
> order
>   * as the dabr and dabrx.
>   */
> +#define HW_BRK_TYPE_DISABLE		0x00
>  #define HW_BRK_TYPE_READ		0x01
>  #define HW_BRK_TYPE_WRITE		0x02
>  #define HW_BRK_TYPE_TRANSLATE		0x04
> @@ -68,7 +69,7 @@ static inline void hw_breakpoint_disable(void)
>  	struct arch_hw_breakpoint brk;
> =20
>  	brk.address =3D 0;
> -	brk.type =3D 0;
> +	brk.type =3D HW_BRK_TYPE_DISABLE;
>  	brk.len =3D 0;
>  	if (ppc_breakpoint_available())
>  		__set_breakpoint(&brk);
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index f002d2ffff86..265fac9fb3a4 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -793,10 +793,22 @@ static inline int set_dabr(struct arch_hw_breakpoin=
t
> *brk)
>  	return __set_dabr(dabr, dabrx);
>  }
> =20
> +static int disable_dawr(void)
> +{
> +	if (ppc_md.set_dawr)
> +		return ppc_md.set_dawr(0, 0);
> +
> +	mtspr(SPRN_DAWRX, 0);
> +	return 0;
> +}
> +
>  int set_dawr(struct arch_hw_breakpoint *brk)
>  {
>  	unsigned long dawr, dawrx, mrd;
> =20
> +	if (brk->type =3D=3D HW_BRK_TYPE_DISABLE)
> +		return disable_dawr();
> +
>  	dawr =3D brk->address;
> =20
>  	dawrx  =3D (brk->type & HW_BRK_TYPE_RDWR) << (63 - 58);

