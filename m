Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FB2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89DE206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E61aTytX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfDASj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:39:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46247 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfDASjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:39:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so11843655qts.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XgbJBvNu4pvrs53PGaaY8D5kaVsJdQn54CRa8+MNjYc=;
        b=E61aTytXuBoRX0zRYaT5rGQ8hPnIc8UzSZ63Jbq4KtZMHmu8atgNRwJSJ2npT6Rb1i
         7miMqf0sKbhnsJhcrvAN0eloAChoKtqxjqPLF3a7cIsz7KWiBuIZESBjLAFmJXkLrvY8
         F095iigJI3GIP5m7DsEC3eiZm1ury78Op9xvhunDTvYEHb1rMIuV8pxw/+/0y/R8BiYX
         yp4/RwkaoNrMS/TtQypeLjiERT0iczL7Cm0y5TMKwntNIyp6qEbDn25pq7dAZusp963U
         XvmcConv6FfscrvlSeC+hW0g4U1Tw/OZnoTMX8kCVM1EYXjrMtmL08punoTvOmzYxXeb
         i0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgbJBvNu4pvrs53PGaaY8D5kaVsJdQn54CRa8+MNjYc=;
        b=DJYROCNTKQVyfey0YiaFPPzIehP5RlA+8UXP/aThE/REprweMFX/q07b9zkK1KhSEb
         Ix+eSAXsLa7RrA8bMuo9WDq2VaGsRwsW3POx/9cdDVuJ1dEq+m+uEB7TNRBjHuaBwZZ+
         UYStDRbNLHAWTrYGMA0uljDEJgZQZTREpZTN8bJzByfVGlxBd8I1Y+DXcvBLadZ8D3yW
         V2BJ2Z+ZWfE1gDSMucVBKPiy4cGb+9Xd7DTNPrbvFVe3tQo2kThPKx6Ls9y5r/cNw93s
         ubqmltZUwZ1XUJUalnbCPP56wZFx5LdX8YDZCWEgoeVO2tus5QkArdDFwjSGzj4jC3LH
         DhXQ==
X-Gm-Message-State: APjAAAVEW2RYbyqmc5i+++VzCgJdDt3Ff7e9WWi+zx1mSGPVHUE2dFgO
        q32wBieiDBX0DYfQNZE2dKSxTA==
X-Google-Smtp-Source: APXvYqx6wyjZ7ar/0p8nRR/lMoeHMvZy8z6Rqv31cu4LF5/6H+lwBwGzxGJT1XfSd8khqZsdWFfNgQ==
X-Received: by 2002:a0c:93f2:: with SMTP id g47mr3476851qvg.22.1554143994708;
        Mon, 01 Apr 2019 11:39:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id b37sm9313923qtb.92.2019.04.01.11.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 11:39:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hB1qb-0003js-8S; Mon, 01 Apr 2019 15:39:53 -0300
Date:   Mon, 1 Apr 2019 15:39:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Phil Baker <baker1tex@gmail.com>,
        Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Actually fail on TPM errors during "get random"
Message-ID: <20190401183953.GI6209@ziepe.ca>
References: <20190401183211.GA21228@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401183211.GA21228@beast>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:32:11AM -0700, Kees Cook wrote:
> A "get random" may fail with a TPM error, but those codes were returned
> as-is to the caller, which assumed the result was the number of bytes
> that had been written to the target buffer, which could lead to an kernel
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
>  drivers/char/tpm/tpm1-cmd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 85dcf2654d11..faeb78ecf960 100644
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
> @@ -524,7 +524,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  
>  	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
>  	if (rc)
> -		return rc;
> +		goto fail;

?? Does tpm_buf_init() return positive?? Shouldn't..

I think you actually want this:

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 85dcf2654d1102..a01e6fba1aacb6 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -510,7 +510,7 @@ struct tpm1_get_random_out {
  *
  * Return:
  * *  number of bytes read
- * * -errno or a TPM return code otherwise
+ * * -errno
  */
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
@@ -531,8 +531,10 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
                rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
                                      "attempting get random");
-               if (rc)
+               if (rc) {
+                       rc = -EIO
                        goto out;
+               }
 
                out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e74c5b7b64bfbd..9fa498b4cf8816 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -328,8 +328,10 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
                                       offsetof(struct tpm2_get_random_out,
                                                buffer),
                                       "attempting get random");
-               if (err)
+               if (err) {
+                       rc = -EIO;
                        goto out;
+               }
 
                out = (struct tpm2_get_random_out *)
                        &buf.data[TPM_HEADER_SIZE];
