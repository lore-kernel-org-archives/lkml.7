Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE52C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE9C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="AMlvJ74l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfFRGr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:47:26 -0400
Received: from ozlabs.org ([203.11.71.1]:46175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbfFRGrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:25 -0400
Received: from neuling.org (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 45Sd4w30GDz9sDX;
        Tue, 18 Jun 2019 16:11:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
        s=201811; t=1560838288;
        bh=uLeN3JvliJrrWmBBPBEg+QalZIGnGRnRT7IRnPElTPo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AMlvJ74llgIPBvEBzG1nNMm7QQtDD7fDcC6V8gqITcdfNDndxaXnsrlAuPixXs29a
         0nIFFLgtySP4DzClUAseH5nloiXZ4wg/wPXBHV77xN9aZwKBkm0UPlA3O1ediVxRD3
         bZMCWcZWyWQeGxoXV/by1cIA1/T75CbIhX3E2TmxsUue9HHqo7VhWr96lv7ueHWcQI
         e5d1chyRCxCbdF6Sx/pQ9VjH5nj8hMpgUxV1rHWk1Lk937v5f/D8dKJjpG28UjCsrg
         B09oWpbxAK9StLsRmkp7yMvErJBxxm2UFPQdEgBAJ7ZvYSvZDtdtB51Y0WcObcCdDc
         kNWUorW49OC4w==
Received: by neuling.org (Postfix, from userid 1000)
        id 512FA2A2538; Tue, 18 Jun 2019 16:11:28 +1000 (AEST)
Message-ID: <b8d8682c8cf13d307ca1e936f924f31a9eac3227.camel@neuling.org>
Subject: Re: [PATCH 3/5] Powerpc/hw-breakpoint: Refactor set_dawr()
From:   Michael Neuling <mikey@neuling.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com
Date:   Tue, 18 Jun 2019 16:11:28 +1000
In-Reply-To: <20190618042732.5582-4-ravi.bangoria@linux.ibm.com>
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
         <20190618042732.5582-4-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is going to collide with this patch=20
https://patchwork.ozlabs.org/patch/1109594/

Mikey


On Tue, 2019-06-18 at 09:57 +0530, Ravi Bangoria wrote:
> Remove unnecessary comments. Code itself is self explanatory.
> And, ISA already talks about MRD field. I Don't think we need
> to re-describe it.
>=20
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  arch/powerpc/kernel/process.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index f0fbbf6a6a1f..f002d2ffff86 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -799,18 +799,11 @@ int set_dawr(struct arch_hw_breakpoint *brk)
> =20
>  	dawr =3D brk->address;
> =20
> -	dawrx  =3D (brk->type & (HW_BRK_TYPE_READ | HW_BRK_TYPE_WRITE)) \
> -		                   << (63 - 58); //* read/write bits */
> -	dawrx |=3D ((brk->type & (HW_BRK_TYPE_TRANSLATE)) >> 2) \
> -		                   << (63 - 59); //* translate */
> -	dawrx |=3D (brk->type & (HW_BRK_TYPE_PRIV_ALL)) \
> -		                   >> 3; //* PRIM bits */
> -	/* dawr length is stored in field MDR bits 48:53.  Matches range in
> -	   doublewords (64 bits) baised by -1 eg. 0b000000=3D1DW and
> -	   0b111111=3D64DW.
> -	   brk->len is in bytes.
> -	   This aligns up to double word size, shifts and does the bias.
> -	*/
> +	dawrx  =3D (brk->type & HW_BRK_TYPE_RDWR) << (63 - 58);
> +	dawrx |=3D ((brk->type & HW_BRK_TYPE_TRANSLATE) >> 2) << (63 - 59);
> +	dawrx |=3D (brk->type & HW_BRK_TYPE_PRIV_ALL) >> 3;
> +
> +	/* brk->len is in bytes. */
>  	mrd =3D ((brk->len + 7) >> 3) - 1;
>  	dawrx |=3D (mrd & 0x3f) << (63 - 53);
> =20




