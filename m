Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232792133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2oPEFBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfCRWfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:35:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39626 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfCRWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:35:21 -0400
Received: by mail-io1-f65.google.com with SMTP id e13so5789561ioq.6;
        Mon, 18 Mar 2019 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDHzoJ9qFnRaG/yRDfNhAq7S7FN7hFrHpZIYID38RB0=;
        b=H2oPEFBlZPaMdVnP9yTldjctwpcWH8UOxF+0vQVhcvabv+5ky7BUd8JhM5ZPx8JiXM
         HgDf831MVYzhTV8Psyksqf2AYEWCH1D/SE6pDlgQ4QC9a0RfqxNfoQfT/KoImgMKTKyj
         KajsFCad+KgSpfCeGQj9d8hrD8DSLb4aDfi/qmkwK35Cxq5ADQ82J8Z1I7OCWc3J9Pp8
         sqZkG+I1AcuHBwn1Gr6hZFYLHDPj6RPW8iC/01er4dxR70Zp08V3rqC+FQhXTDL1/O8W
         FiC4zVz45H2U8/HB3x5dB/Cf7V2l6GsetXJOdx9Gjh7eRMpbljTAirHtSmo+eTDGf7wi
         818g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDHzoJ9qFnRaG/yRDfNhAq7S7FN7hFrHpZIYID38RB0=;
        b=rDHxjyXOCGI/bR+znWorPAXnRmXDMJ9cC9V6/9x2Ew2SM2Z4vwN9HWIsRS7upc9A/m
         xWM4Az8avVwTJRCB/DDTe+b4mP6GSXEgjsDHN2qEAXzWS6TuvpazxJRQas7wzunDGATD
         EHpyWChJVL00kpLZc886yYxMebTFVhN02IgD5DXR/WMwfsleceGhrYlbv+YOeri40wHg
         MyUWcleQkyjk/80cnDN7/R1oxXfI0TNdA2rUi5PBd/ymutslHY0kXgqEpnbGz4bmIVZW
         QhExQYDLbJMIrVCRrb34aY8rwccR7dqj01qzc6B6ncTTtinlhBIm02l27/1UiI6PMWh9
         uy/A==
X-Gm-Message-State: APjAAAWBaksbbsCjDbtR+IfbPtaqjZuSuNHOZNHC46MJ3NGwRTWSIac/
        FluXg2aaKEIRo68mkS1r8YhzeNELVctA3k97nmM=
X-Google-Smtp-Source: APXvYqxt8ymuUvxxSmefsZ4Am5G+XdbcWtjzD7kLEHxe6Gue0ly7GLO50pgbkGrtpkPx2HvRd7pOUcPaW8WwSGP8o9Y=
X-Received: by 2002:a5e:c742:: with SMTP id g2mr13122392iop.56.1552948520209;
 Mon, 18 Mar 2019 15:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190206162452.7749-1-roberto.sassu@huawei.com> <20190206162452.7749-6-roberto.sassu@huawei.com>
In-Reply-To: <20190206162452.7749-6-roberto.sassu@huawei.com>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Mon, 18 Mar 2019 15:35:08 -0700
Message-ID: <CAA9_cmf0j1EoyrGmbfPWCWPafgGfKWR6cyPpN8YEFZdemeg1kA@mail.gmail.com>
Subject: Re: [PATCH v10, RESEND 5/6] KEYS: trusted: explicitly use tpm_chip
 structure from tpm_default_chip()
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        matthewgarrett@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        silviu.vlasceanu@huawei.com,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 10:30 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> When crypto agility support will be added to the TPM driver, users of the
> driver have to retrieve the allocated banks from chip->allocated_banks and
> use this information to prepare the array of tpm_digest structures to be
> passed to tpm_pcr_extend().
>
> This patch retrieves a tpm_chip pointer from tpm_default_chip() so that the
> pointer can be used to prepare the array of tpm_digest structures.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  security/keys/trusted.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 4d98f4f87236..5b852263eae1 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -34,6 +34,7 @@
>
>  static const char hmac_alg[] = "hmac(sha1)";
>  static const char hash_alg[] = "sha1";
> +static struct tpm_chip *chip;
>
>  struct sdesc {
>         struct shash_desc shash;
> @@ -362,7 +363,7 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
>         int rc;
>
>         dump_tpm_buf(cmd);
> -       rc = tpm_send(NULL, cmd, buflen);
> +       rc = tpm_send(chip, cmd, buflen);
>         dump_tpm_buf(cmd);
>         if (rc > 0)
>                 /* Can't return positive return codes values to keyctl */
> @@ -384,10 +385,10 @@ static int pcrlock(const int pcrnum)
>
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
> -       ret = tpm_get_random(NULL, hash, SHA1_DIGEST_SIZE);
> +       ret = tpm_get_random(chip, hash, SHA1_DIGEST_SIZE);
>         if (ret != SHA1_DIGEST_SIZE)
>                 return ret;
> -       return tpm_pcr_extend(NULL, pcrnum, hash) ? -EINVAL : 0;
> +       return tpm_pcr_extend(chip, pcrnum, hash) ? -EINVAL : 0;
>  }
>
>  /*
> @@ -400,7 +401,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
>         unsigned char ononce[TPM_NONCE_SIZE];
>         int ret;
>
> -       ret = tpm_get_random(NULL, ononce, TPM_NONCE_SIZE);
> +       ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
>         if (ret != TPM_NONCE_SIZE)
>                 return ret;
>
> @@ -496,7 +497,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>         if (ret < 0)
>                 goto out;
>
> -       ret = tpm_get_random(NULL, td->nonceodd, TPM_NONCE_SIZE);
> +       ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
>         if (ret != TPM_NONCE_SIZE)
>                 goto out;
>         ordinal = htonl(TPM_ORD_SEAL);
> @@ -606,7 +607,7 @@ static int tpm_unseal(struct tpm_buf *tb,
>
>         ordinal = htonl(TPM_ORD_UNSEAL);
>         keyhndl = htonl(SRKHANDLE);
> -       ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
> +       ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
>         if (ret != TPM_NONCE_SIZE) {
>                 pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
>                 return ret;
> @@ -751,7 +752,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>         int i;
>         int tpm2;
>
> -       tpm2 = tpm_is_tpm2(NULL);
> +       tpm2 = tpm_is_tpm2(chip);
>         if (tpm2 < 0)
>                 return tpm2;
>
> @@ -920,7 +921,7 @@ static struct trusted_key_options *trusted_options_alloc(void)
>         struct trusted_key_options *options;
>         int tpm2;
>
> -       tpm2 = tpm_is_tpm2(NULL);
> +       tpm2 = tpm_is_tpm2(chip);
>         if (tpm2 < 0)
>                 return NULL;
>
> @@ -970,7 +971,7 @@ static int trusted_instantiate(struct key *key,
>         size_t key_len;
>         int tpm2;
>
> -       tpm2 = tpm_is_tpm2(NULL);
> +       tpm2 = tpm_is_tpm2(chip);
>         if (tpm2 < 0)
>                 return tpm2;
>
> @@ -1011,7 +1012,7 @@ static int trusted_instantiate(struct key *key,
>         switch (key_cmd) {
>         case Opt_load:
>                 if (tpm2)
> -                       ret = tpm_unseal_trusted(NULL, payload, options);
> +                       ret = tpm_unseal_trusted(chip, payload, options);
>                 else
>                         ret = key_unseal(payload, options);
>                 dump_payload(payload);
> @@ -1021,13 +1022,13 @@ static int trusted_instantiate(struct key *key,
>                 break;
>         case Opt_new:
>                 key_len = payload->key_len;
> -               ret = tpm_get_random(NULL, payload->key, key_len);
> +               ret = tpm_get_random(chip, payload->key, key_len);
>                 if (ret != key_len) {
>                         pr_info("trusted_key: key_create failed (%d)\n", ret);
>                         goto out;
>                 }
>                 if (tpm2)
> -                       ret = tpm_seal_trusted(NULL, payload, options);
> +                       ret = tpm_seal_trusted(chip, payload, options);
>                 else
>                         ret = key_seal(payload, options);
>                 if (ret < 0)
> @@ -1225,17 +1226,26 @@ static int __init init_trusted(void)
>  {
>         int ret;
>
> +       chip = tpm_default_chip();
> +       if (!chip)
> +               return -ENOENT;

This change causes a regression loading the encrypted_keys module on
systems that don't have a tpm.

Module init functions should not have hardware dependencies.

The effect is that the libnvdimm module, which is an encrypted_keys
user, fails to load, but up until this change encrypted_keys did not
have a hard dependency on TPM presence.
