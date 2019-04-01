Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D85C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB4D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDATlp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:41:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:25001 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfDATlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:41:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 12:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="312258895"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2019 12:41:43 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 1 Apr 2019 12:41:43 -0700
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 1 Apr 2019 12:41:43 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.237]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.4]) with mapi id 14.03.0415.000;
 Mon, 1 Apr 2019 22:41:40 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH v3] tpm: Actually fail on TPM errors during "get random"
Thread-Topic: [PATCH v3] tpm: Actually fail on TPM errors during "get random"
Thread-Index: AQHU6L4DTy7PYCgxuEOQPC9C1rGO2qYnqrSw
Date:   Mon, 1 Apr 2019 19:41:39 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DAE177D@hasmsx108.ger.corp.intel.com>
References: <20190401190607.GA23795@beast>
In-Reply-To: <20190401190607.GA23795@beast>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.126.80]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> A "get random" may fail with a TPM error, but those codes were returned as-is
> to the caller, which assumed the result was the number of bytes that had been
> written to the target buffer, which could lead to a kernel heap memory
> exposure and over-read.
> 
> This fixes tpm1_get_random() to mask positive TPM errors into -EIO, as before.
> 
> [   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random
> [   18.092106] usercopy: Kernel memory exposure attempt detected from SLUB
> object 'kmalloc-64' (offset 0, size 379)!
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1650989
> Reported-by: Phil Baker <baker1tex@gmail.com>
> Reported-by: Craig Robson <craig@zhatt.com>
> Fixes: 7aee9c52d7ac ("tpm: tpm1: rewrite tpm1_get_random() using tpm_buf
> structure")
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: fix never-succeed, limit checks to tpm cmd return (James, Jason)
> v2: also fix tpm2 implementation (Jason Gunthorpe)
Looks good to me.
Thanks
Tomas

> ---
>  drivers/char/tpm/tpm1-cmd.c | 7 +++++--  drivers/char/tpm/tpm2-cmd.c | 7
> +++++--
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
>  int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)  { @@ -
> 531,8 +531,11 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest,
> size_t max)
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
>  		out = (struct tpm1_get_random_out
> *)&buf.data[TPM_HEADER_SIZE];
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
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)  { @@ -
> 328,8 +328,11 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest,
> size_t max)
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
