Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDAC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583A206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vpj5yLvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfDDMyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:54:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55944 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfDDMyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:54:32 -0400
Received: by mail-it1-f196.google.com with SMTP id z126so3464185itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHLQN3NUrDGEbudveKvi/CUxy6nUoP3CXW0iO/pZX8c=;
        b=Vpj5yLvRuz61rZ5Bfb9y8VDOaZfdovi+PSl5lZvhMED1FpamALUmLsdMasyJ9DaXOr
         pQGb+c5DNP44tXiIUAXnan0tkMLmbKh219QGQSNrqo68Txxj43nN6tM6A4U60lov68hM
         JC1vp+6U2bEKg9bflE85ihRw3QcPmcyBSgKXqsI6a6NMsMvowrZczAYwnC5AtbPqUXmD
         zDAJII0WyUxuNkOKc4q6PyQcdCjqB/mSWR0X2dn/iGbJIpCfcMr/INExfd2USG3vaiMS
         4h3LjDR4rhigdx3ClO3Z8nKxM+VrVPCRmUzz1RIB9PCa8fGUCA+v5uri0pUP9votBzLs
         DlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHLQN3NUrDGEbudveKvi/CUxy6nUoP3CXW0iO/pZX8c=;
        b=jXExpVxbqkgpl8+fkeXs7SsxwN6reSzF1tJrVf7i/29vxqQWDgZGrKEpZjGU83Tsyb
         SpVO4pWGAnG6Jq2pGqxMBXWrlWXDRR23+xApDDQpX7zu0AmlD/F1ZZ77lcjjs9HKtltr
         JihC4Q2dfalcTI8wOHnxhZwyK48OKjWGW/XiPz/1OSUpqBCLTYqhSNnQS21V/bT2+qPZ
         E0gbBGzcbcjEmQCAFPgjKphhIRWnYVuSUPI2cazR3tM2YKivKh3x8nRf2NPr3dmPIzRK
         TmDbHcQ4m4CXYmc93fuiDKaiD8LHtq6LTA/0EEN3LhovdwR+N7IYVrUimvXPNbiOAWBv
         OWuQ==
X-Gm-Message-State: APjAAAUpUy2ZIQqXw7wpCpbMfxNyFArY5HCHAfA6kYOKtOgfcdbM1D07
        N14+Kuw4GWPcqM5dQ4PCDLqekEiaInPsYNQ3N+xrew==
X-Google-Smtp-Source: APXvYqygWNF766C0HYL0fI7hxDNRUDz48C93PO+BOi05G1vCu9uvnHT+k0cl09QQMbyF2245UNUw0wUIq1SPTpTLTqU=
X-Received: by 2002:a24:12:: with SMTP id 18mr4617085ita.117.1554382471660;
 Thu, 04 Apr 2019 05:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190402215556.257406-1-matthewgarrett@google.com> <20190402215556.257406-2-matthewgarrett@google.com>
In-Reply-To: <20190402215556.257406-2-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 4 Apr 2019 19:54:20 +0700
Message-ID: <CAKv+Gu_yPKjK64qDEWgyacvKcoXwivoi4tq35T=uNE0syRhm8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi: Fix cast to pointer from integer of different
 size in TPM log code
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thiebaud Weksteen <tweek@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 at 04:56, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> 8bfcff4a6a1d9d7226bb63a7da758b82d9ab4373

Which tree is this commit in?

> introduced a cast from
> efi_physical_address_t to (void *), which are different sizes on 32-bit.
> Fix that. Caught by the 0-day test bot.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I'll pick this up as a fix if we can clean up the commit log so it
doesn't refer to a commit that does not exist in mainline.

> ---
>  drivers/firmware/efi/libstub/tpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index b6e93e14fcf1..6b3b507a54eb 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -114,8 +114,8 @@ void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
>                          */
>                         last_entry_size =
>                                 __calc_tpm2_event_size((void *)last_entry_addr,
> -                                                      (void *)log_location,
> -                                                      false);
> +                                                   (void *)(long)log_location,
> +                                                   false);
>                 } else {
>                         last_entry_size = sizeof(struct tcpa_event) +
>                            ((struct tcpa_event *) last_entry_addr)->event_size;
> --
> 2.21.0.392.gf8f6787159e-goog
>
