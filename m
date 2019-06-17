Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD4EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79CE2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFQVAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:00:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45686 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:00:31 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcyjs-0005CJ-2H; Mon, 17 Jun 2019 23:00:28 +0200
Date:   Mon, 17 Jun 2019 23:00:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] rslib: Fix remaining decoder flaws
In-Reply-To: <20190330182947.8823-8-ferdinand.blomqvist@gmail.com>
Message-ID: <alpine.DEB.2.21.1906172249580.1963@nanos.tec.linutronix.de>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com> <20190330182947.8823-8-ferdinand.blomqvist@gmail.com>
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

On Sat, 30 Mar 2019, Ferdinand Blomqvist wrote:
> The decoder is flawed in the following ways:

...

> - Also fix errors in parity when correcting in-place. Another option
>   would be to completely disregard errors in the parity, but then the
>   interface makes it impossible to write tests that test for silent
>   failures.
> 
> Other changes:
> 
> - Only fill the correction buffer and error position buffer if both of
>   them are provided. Otherwise correct in place. Previously the error
>   position buffer was always populated with the positions of the
>   corrected errors, irrespective of whether a correction buffer was
>   supplied or not. The rationale for this change is that there seems to
>   be two use cases for the decoder; correct in-place or use the
>   correction buffers. The caller does not need the positions of the
>   corrected errors when in-place correction is used. If in-place
>   correction is not used, then both the correction buffer and error
>   position buffer need to be populated.

Again. A perfect changelog! Very nice to read, informative and technically
on the point.

> diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
> index 7ecc449e57e9..33621ea67f67 100644
> --- a/lib/reed_solomon/decode_rs.c
> +++ b/lib/reed_solomon/decode_rs.c
> @@ -22,6 +22,7 @@
>  	uint16_t *index_of = rs->index_of;
>  	uint16_t u, q, tmp, num1, num2, den, discr_r, syn_error;
>  	int count = 0;
> +	int num_corrected;
>  	uint16_t msk = (uint16_t) rs->nn;
>  
>  	/*
> @@ -182,6 +183,15 @@
>  		if (lambda[i] != nn)
>  			deg_lambda = i;
>  	}
> +
> +	if (deg_lambda == 0) {
> +		/*
> +		 * deg(lambda) is zero even though the syndrome is non-zero
> +		 * => uncorrectable error detected
> +		 */
> +		return -EBADMSG;

Good catch. Now that I paged all that stuff back in it's obvious.

> +	}
> +
>  	/* Find roots of error+erasure locator polynomial by Chien search */
>  	memcpy(&reg[1], &lambda[1], nroots * sizeof(reg[0]));
>  	count = 0;		/* Number of roots of lambda(x) */
> @@ -195,6 +205,12 @@
>  		}
>  		if (q != 0)
>  			continue;	/* Not a root */
> +
> +		if (k < pad) {
> +			/* Impossible error location. Uncorrectable error. */
> +			return -EBADMSG;

True.

> +		}
> +
>  		/* store root (index-form) and error location number */
>  		root[count] = i;
>  		loc[count] = k;
> @@ -229,7 +245,9 @@
>  	/*
>  	 * Compute error values in poly-form. num1 = omega(inv(X(l))), num2 =
>  	 * inv(X(l))**(fcr-1) and den = lambda_pr(inv(X(l))) all in poly-form
> +	 * Note: we reuse the buffer for b to store the correction pattern
>  	 */
> +	num_corrected = 0;
>  	for (j = count - 1; j >= 0; j--) {
>  		num1 = 0;
>  		for (i = deg_omega; i >= 0; i--) {
> @@ -237,6 +255,12 @@
>  				num1 ^= alpha_to[rs_modnn(rs, omega[i] +
>  							i * root[j])];
>  		}
> +
> +		if (num1 == 0) {
> +			b[j] = 0;
> +			continue;

A comment for this would be appreciated.

> +		}
> +
>  		num2 = alpha_to[rs_modnn(rs, root[j] * (fcr - 1) + nn)];
>  		den = 0;
>  
> @@ -248,29 +272,52 @@
>  						       i * root[j])];
>  			}
>  		}
> -		/* Apply error to data */
> -		if (num1 != 0 && loc[j] >= pad) {
> -			uint16_t cor = alpha_to[rs_modnn(rs,index_of[num1] +
> -						       index_of[num2] +
> -						       nn - index_of[den])];
> -			/* Store the error correction pattern, if a
> -			 * correction buffer is available */
> -			if (corr) {
> -				corr[j] = cor;
> -			} else {
> -				/* If a data buffer is given and the
> -				 * error is inside the message,
> -				 * correct it */
> -				if (data && (loc[j] < (nn - nroots)))
> -					data[loc[j] - pad] ^= cor;
> -			}
> +
> +		b[j] = alpha_to[rs_modnn(rs, index_of[num1] +
> +					       index_of[num2] +
> +					       nn - index_of[den])];

Way simpler indeed.

> +		num_corrected++;
> +	}
> +
> +	/*
> +	 * We compute the syndrome of the 'error' to and check that it matches

s/to// or s/to/too ?

> +	 * the syndrome of the received word
> +	 */
> +	for (i = 0; i < nroots; i++) {
> +		tmp = 0;
> +		for (j = 0; j < count; j++) {
> +			if (b[j] == 0)
> +				continue;
> +
> +			k = (fcr + i) * prim * (nn-loc[j]-1);
> +			tmp ^= alpha_to[rs_modnn(rs, index_of[b[j]] + k)];
>  		}
> +
> +		if (tmp != alpha_to[s[i]])
> +			return -EBADMSG;

Interesting it never occured to me that this can actually happen.

>  	}
>  
> -	if (eras_pos != NULL) {
> -		for (i = 0; i < count; i++)
> -			eras_pos[i] = loc[i] - pad;
> +	/*
> +	 * Store the error correction pattern, if a
> +	 * correction buffer is available
> +	 */
> +	if (corr && eras_pos) {
> +		j = 0;
> +		for (i = 0; i < count; i++) {
> +			if (b[i]) {
> +				corr[j] = b[i];
> +				eras_pos[j++] = loc[i] - pad;
> +			}
> +		}
> +	} else if (data && par) {
> +		/* Apply error to data and parity */
> +		for (i = 0; i < count; i++) {
> +			if (loc[i] < (nn - nroots))
> +				data[loc[i] - pad] ^= b[i];
> +			else
> +				par[loc[i] - pad - len] ^= b[i];
> +		}

Aside of the fact that I had to wrap my brain around this crime I committed
more than a decade ago, all of this was really a pleasure to review.

Thanks a lot for putting that effort in! I'm looking forward to V2 of that.

Thanks,

	tglx
