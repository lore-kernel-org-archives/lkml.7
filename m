Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17604C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1712173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k120kgxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfH2X2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:28:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32981 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfH2X2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:28:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id go14so2352900plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UELrewFF8NN0iH92okVL2LENf/NFX05X05hyTPWg0IU=;
        b=k120kgxKbzdzvv8c0Tgeo+3CuDk8ZtJzhLlATwlcEqhC/5C5t+wUkeQnzhND/1Nmd1
         6M78GmbDAJsrtaQhm6jNUjG7jee+RtBK7aetuQvupAYvXWRgoUlo+d7h6BzzrBTKefC2
         1eXKS2n4azk4TMQm7MaIHIZVAVeQ21qmyL5DRY8DeuR8mRwKI4BGf8YT91scLV/mbCY0
         /ZJUIuwC0lBbgdG1UZZI1l9/3QCMYOCLAhfCC3nZh/db85OEpcnhUEmoU/SK2N/LNq9U
         e6kLGvZwbGxQZRHIf6uFAmkxLtXO5BpDKlq7OyeRIdkn7p8hEn4iYohyh7yXDD/CPAWh
         ytZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UELrewFF8NN0iH92okVL2LENf/NFX05X05hyTPWg0IU=;
        b=WEno6cZ0LTJzNFFFfvZrVrTjTksfiHL4Por02vXejqs8ucs3a6yjMHgLaKu+VBiV44
         mZZfzQllLcm0X3BFbVutuEQtTjbGmkKFheJ8UOS5ifb57q8+EkyPr+KvZfTEqP9NUQVM
         xJ794a6JQCKbuPPNI4zmdB18Kgvx5BpEfg8IAXvsPvlV27hajkBWrhSaxD/KAa7ft+L/
         yeqxGDzWL5Bn/B5wR/PCNq77MEZv400pw1g4j/m6AIo0ZKldCIx+NwQXC1DYW3wYDNP1
         W6caU6IrI9qL5+qUd6zgjwH5jpNYzoDgkJRRACRoaQ9r7OER4hAQSTz9zn4BczfObb7e
         qhQQ==
X-Gm-Message-State: APjAAAWPim2ZpO67Zlla685QYpWryzVz691grsPUd7U1E1DGy2u5iSAa
        Mp49Cxsr9S1lUiyLLBlprPOUKioRysrhoqCFiOQdrw==
X-Google-Smtp-Source: APXvYqxF8GTTIW5esjRxN2qu78uhNM5IBHoP85JOWcDzALTrrZV1TDADOXjuJ1weL4cTxfZFBAARSF+74BWd4bhJA9w=
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr12618288plm.264.1567121295532;
 Thu, 29 Aug 2019 16:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190827062309.GA30987@kroah.com> <20190827222145.32642-1-rajatja@google.com>
In-Reply-To: <20190827222145.32642-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 29 Aug 2019 16:27:39 -0700
Message-ID: <CACK8Z6EAqVb20rXHut8mqTaeO1R6uH_zLxi=3wVPgYycDuuPSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI/AER: Add PoisonTLPBlocked to Uncorrectable errors
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 3:21 PM Rajat Jain <rajatja@google.com> wrote:
>
> The elements in the aer_uncorrectable_error_string[] refer to
> the bit names in Uncorrectable Error status Register in the PCIe spec
> (Sec 7.8.4.2 in PCIe 4.0)
>
> Add the last error bit in the strings array that was missing.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: same as v2
> v2: same as v1

Hi Bjorn,

This patch seems like independent of the other patch to split the AER
stats. Can you review and apply this one so that I don't have to keep
sending v4, v5 (where each version is basically same as v1) ... of
this patch with every iteration of the other patch?

I'll be working on Greg's and your comments on the other patch.

Thanks,

Rajat


>
>  drivers/pci/pcie/aer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b45bc47d04fe..68060a290291 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -36,7 +36,7 @@
>  #define AER_ERROR_SOURCES_MAX          128
>
>  #define AER_MAX_TYPEOF_COR_ERRS                16      /* as per PCI_ERR_COR_STATUS */
> -#define AER_MAX_TYPEOF_UNCOR_ERRS      26      /* as per PCI_ERR_UNCOR_STATUS*/
> +#define AER_MAX_TYPEOF_UNCOR_ERRS      27      /* as per PCI_ERR_UNCOR_STATUS*/
>
>  struct aer_err_source {
>         unsigned int status;
> @@ -560,6 +560,7 @@ static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
>         "BlockedTLP",                   /* Bit Position 23      */
>         "AtomicOpBlocked",              /* Bit Position 24      */
>         "TLPBlockedErr",                /* Bit Position 25      */
> +       "PoisonTLPBlocked",             /* Bit Position 26      */
>  };
>
>  static const char *aer_agent_string[] = {
> --
> 2.23.0.187.g17f5b7556c-goog
>
