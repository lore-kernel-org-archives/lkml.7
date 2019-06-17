Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F5BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5957220861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfFQUqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:46:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45644 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfFQUqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:46:21 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcyWB-0004vT-6z; Mon, 17 Jun 2019 22:46:19 +0200
Date:   Mon, 17 Jun 2019 22:46:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] rslib: Fix decoding of shortened codes
In-Reply-To: <20190330182947.8823-3-ferdinand.blomqvist@gmail.com>
Message-ID: <alpine.DEB.2.21.1906172244450.1963@nanos.tec.linutronix.de>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com> <20190330182947.8823-3-ferdinand.blomqvist@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ferdinand,

On Sat, 30 Mar 2019, Ferdinand Blomqvist wrote:

> The decoder is broken. It only works with full length codes.

A short explanation what is missing and what is done to fix it would be
appreciated.

> Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
> ---
>  lib/reed_solomon/decode_rs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
> index 1db74eb098d0..3313bf944ff1 100644
> --- a/lib/reed_solomon/decode_rs.c
> +++ b/lib/reed_solomon/decode_rs.c
> @@ -99,9 +99,9 @@
>  	if (no_eras > 0) {
>  		/* Init lambda to be the erasure locator polynomial */
>  		lambda[1] = alpha_to[rs_modnn(rs,
> -					      prim * (nn - 1 - eras_pos[0]))];
> +					prim * (nn - 1 - (eras_pos[0] + pad)))];
>  		for (i = 1; i < no_eras; i++) {
> -			u = rs_modnn(rs, prim * (nn - 1 - eras_pos[i]));
> +			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
>  			for (j = i + 1; j > 0; j--) {
>  				tmp = index_of[lambda[j - 1]];
>  				if (tmp != nn) {

Code looks fine as is.

Thanks,

	tglx
