Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7057C072AF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDC121743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSrZMjgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfEUJ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:27:07 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40896 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:27:07 -0400
Received: by mail-it1-f193.google.com with SMTP id h11so3583630itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePk/LAdsqK2QuSF3FET//AcaRKkYpEyvxNQW6KJ/bws=;
        b=oSrZMjgc40gkhwPG8kTuosCy4j5ESU04gGMKEkf0GdmeFvHK4617JT9UO0kpDMR5gR
         uOOnaRMEo13PaYAcntSMUfDsO1tftEMx2SVH5dtzwRZ6vgOQwW0dr9gzzaB+ujwg7opd
         EPsT8G/RATkTcL1c7CiIhGloBHzUHmXsJDqGH3EQpqcRSaCVptPNybSR1iHnJ/mx8mc0
         8cTMvG0bjaeLH4g0Q70Mkv8lduNWi0dpP5bZde1ZDfkWa387tqtnscASrXXL6f3EJLYp
         m0CkwcY5hKt2oJ3XDt9Y+DI5948LulMyWhWGXZiF3SEzx3gpL2tmcsTVHMETUZL+D9FD
         A+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePk/LAdsqK2QuSF3FET//AcaRKkYpEyvxNQW6KJ/bws=;
        b=HFcZ9ydcVa7l9NpdfDTV1zzA0K+RAN4KidSkIkDLYf8VpndAgUfJGWb61CZysS4PgS
         nbQlw/9LGa2LllUXnYZf6+fRKhHkhIv4oPm8+vP4KVUu4qmLvh83Jhmn9M5VGCfLQ11G
         LbOWPHsoR5oo88ImbXu26eRuWfnQKaP5R863r39XlXpovPEjpiO0nG6bCxMDduF1QiCz
         qWbgtA4Q3otUIut/5uD34weNx6wqUnN0gLpeX+7Eg3+Lxp6H9kpFSlku6z4fQsIMLhRY
         gk9/kZKMS9HKb76F1tqazZt6bK8h/Buz/JOgw/urhiS8IZggrsLu6wFXhziutoRmokPg
         ZDRw==
X-Gm-Message-State: APjAAAXprm6OMw1di5rBQxFMQ4osa46FVL9bxxYn1o/cYip7arky/8Te
        OuXVZqDgtvv4XQGRoZsTcv7l362LEPyzHUTnRQkHfg==
X-Google-Smtp-Source: APXvYqym/rMUjcND+RN86l3Cp2nFHg4D9twsmW0gO/li4PAykqhcdAZnjz9F3PvZW+/H3Q4HNsIBGYqgQRX9KjbyFoo=
X-Received: by 2002:a02:b047:: with SMTP id q7mr8721430jah.2.1558430826102;
 Tue, 21 May 2019 02:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com> <20190520205501.177637-5-matthewgarrett@google.com>
In-Reply-To: <20190520205501.177637-5-matthewgarrett@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 21 May 2019 10:26:54 +0100
Message-ID: <CAKv+Gu8R==HfdkN_DMZs85QGfJPrNoxvkiSOEq7GbJ3tRSNVHw@mail.gmail.com>
Subject: Re: [PATCH V7 4/4] efi: Attempt to get the TCG2 event log in the boot stub
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thiebaud Weksteen <tweek@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 at 21:55, Matthew Garrett <matthewgarrett@google.com> wrote:
>
> From: Matthew Garrett <mjg59@google.com>
>
> Right now we only attempt to obtain the SHA1-only event log. The
> protocol also supports a crypto agile log format, which contains digests
> for all algorithms in use. Attempt to obtain this first, and fall back
> to obtaining the older format if the system doesn't support it. This is
> lightly complicated by the event sizes being variable (as we don't know
> in advance which algorithms are in use), and the interface giving us
> back a pointer to the start of the final entry rather than a pointer to
> the end of the log - as a result, we need to parse the final entry to
> figure out its length in order to know how much data to copy up to the
> OS.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Provided that this gets a tested-by from Bartosz,

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/firmware/efi/libstub/tpm.c | 50 ++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index 5bd04f75d8d6..6b3b507a54eb 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -57,7 +57,7 @@ void efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg)
>
>  #endif
>
> -static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
> +void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
>  {
>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>         efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
> @@ -67,6 +67,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>         unsigned long first_entry_addr, last_entry_addr;
>         size_t log_size, last_entry_size;
>         efi_bool_t truncated;
> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
>         void *tcg2_protocol = NULL;
>
>         status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
> @@ -74,14 +75,20 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>         if (status != EFI_SUCCESS)
>                 return;
>
> -       status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
> -                               EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2,
> -                               &log_location, &log_last_entry, &truncated);
> -       if (status != EFI_SUCCESS)
> -               return;
> +       status = efi_call_proto(efi_tcg2_protocol, get_event_log,
> +                               tcg2_protocol, version, &log_location,
> +                               &log_last_entry, &truncated);
> +
> +       if (status != EFI_SUCCESS || !log_location) {
> +               version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +               status = efi_call_proto(efi_tcg2_protocol, get_event_log,
> +                                       tcg2_protocol, version, &log_location,
> +                                       &log_last_entry, &truncated);
> +               if (status != EFI_SUCCESS || !log_location)
> +                       return;
> +
> +       }
>
> -       if (!log_location)
> -               return;
>         first_entry_addr = (unsigned long) log_location;
>
>         /*
> @@ -96,8 +103,23 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>                  * We need to calculate its size to deduce the full size of
>                  * the logs.
>                  */
> -               last_entry_size = sizeof(struct tcpa_event) +
> -                       ((struct tcpa_event *) last_entry_addr)->event_size;
> +               if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
> +                       /*
> +                        * The TCG2 log format has variable length entries,
> +                        * and the information to decode the hash algorithms
> +                        * back into a size is contained in the first entry -
> +                        * pass a pointer to the final entry (to calculate its
> +                        * size) and the first entry (so we know how long each
> +                        * digest is)
> +                        */
> +                       last_entry_size =
> +                               __calc_tpm2_event_size((void *)last_entry_addr,
> +                                                   (void *)(long)log_location,
> +                                                   false);
> +               } else {
> +                       last_entry_size = sizeof(struct tcpa_event) +
> +                          ((struct tcpa_event *) last_entry_addr)->event_size;
> +               }
>                 log_size = log_last_entry - log_location + last_entry_size;
>         }
>
> @@ -114,7 +136,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>
>         memset(log_tbl, 0, sizeof(*log_tbl) + log_size);
>         log_tbl->size = log_size;
> -       log_tbl->version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +       log_tbl->version = version;
>         memcpy(log_tbl->log, (void *) first_entry_addr, log_size);
>
>         status = efi_call_early(install_configuration_table,
> @@ -126,9 +148,3 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
>  err_free:
>         efi_call_early(free_pool, log_tbl);
>  }
> -
> -void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
> -{
> -       /* Only try to retrieve the logs in 1.2 format. */
> -       efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
> -}
> --
> 2.21.0.1020.gf2820cf01a-goog
>
