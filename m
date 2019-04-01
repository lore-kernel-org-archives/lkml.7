Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC065C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B573E20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDAXqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:46:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:27624 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfDAXqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:46:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 16:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="147173511"
Received: from unknown (HELO localhost) ([10.249.254.142])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2019 16:46:27 -0700
Date:   Tue, 2 Apr 2019 02:46:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Actually fail on TPM errors during "get random"
Message-ID: <20190401234625.GA29016@linux.intel.com>
References: <20190401190607.GA23795@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401190607.GA23795@beast>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 12:06:07PM -0700, Kees Cook wrote:
> A "get random" may fail with a TPM error, but those codes were returned
> as-is to the caller, which assumed the result was the number of bytes
> that had been written to the target buffer, which could lead to a kernel
> heap memory exposure and over-read.
> 
> This fixes tpm1_get_random() to mask positive TPM errors into -EIO, as
> before.
> 
> [   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random
> [   18.092106] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-64' (offset 0, size 379)!
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1650989
> Reported-by: Phil Baker <baker1tex@gmail.com>
> Reported-by: Craig Robson <craig@zhatt.com>
> Fixes: 7aee9c52d7ac ("tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure")
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: fix never-succeed, limit checks to tpm cmd return (James, Jason)
> v2: also fix tpm2 implementation (Jason Gunthorpe)
> ---
>  drivers/char/tpm/tpm1-cmd.c | 7 +++++--
>  drivers/char/tpm/tpm2-cmd.c | 7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 85dcf2654d11..faacbe1ffa1a 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -510,7 +510,7 @@ struct tpm1_get_random_out {
>   *
>   * Return:
>   * *  number of bytes read
> - * * -errno or a TPM return code otherwise
> + * * -errno (positive TPM return codes are masked to -EIO)
>   */
>  int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  {
> @@ -531,8 +531,11 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  
>  		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
>  				      "attempting get random");
> -		if (rc)
> +		if (rc) {
> +			if (rc > 0)
> +				rc = -EIO;
>  			goto out;
> +		}
>  
>  		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
>  
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index e74c5b7b64bf..8ffa6af61580 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -301,7 +301,7 @@ struct tpm2_get_random_out {
>   *
>   * Return:
>   *   size of the buffer on success,
> - *   -errno otherwise
> + *   -errno otherwise ((positive TPM return codes are masked to -EIO)
>   */
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  {
> @@ -328,8 +328,11 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  				       offsetof(struct tpm2_get_random_out,
>  						buffer),
>  				       "attempting get random");
> -		if (err)
> +		if (err) {
> +			if (err > 0)
> +				err = -EIO;
>  			goto out;
> +		}
>  
>  		out = (struct tpm2_get_random_out *)
>  			&buf.data[TPM_HEADER_SIZE];
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
