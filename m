Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E35C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE992075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k03miPaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfFEIcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:32:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34737 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFEIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:32:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so5090917plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dk0R1JeANwhvfJ8EQjNAn0p7Nj8AEAOaqyvCO9n4i9o=;
        b=k03miPaflHsYxMZvcILGpctdJhtceRMyyo9Sz+HkvQksJJ5V01qAuQPRb2/jd89gDK
         W6n3QXdOdbDFKXrQoM7emCK5pdtddXCUPmDIfXd7ruUGPhYAq8g4y4S8arksaz7/MZv1
         Xe/oBYbsELe4UOkCSaFDKyGfqoGV+H4qILh3HdKr4cpBGa7+YJ6dZuVXGE9XDl12Qby7
         OGiB7W+9JwHgOD+Ahlk4o/EW/Wo0knAZU9N+y0rCdxlKMJ65GdO6VjNosDTiZXaUfEKq
         SApCpBFPE4n/f+EVCTjab8t4+nsnS7hBs1IyP5Otrjj4xwplyT0oZ1m1uJ7gpNxp4m3a
         qXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dk0R1JeANwhvfJ8EQjNAn0p7Nj8AEAOaqyvCO9n4i9o=;
        b=FoYXTPSmTNuPv3uvtrTG87P3mIM/QJEAFeyKSqB6DR61KOTRgcKfDEQXZiUSw1hOsm
         /cHHHmN9QEHK0td3lwpc47qIunmdEbqE3sEQt8D0vQiAab6Qxx1Jghzlw1pIICpKLx84
         PnPJg1bHtmcJ1/aaguh65pGTFrslVw9z1BR1Mk0deM2bHrJanVNRNomL8erCgV88i6Gp
         b5onVt9CRddL09h3YzNWktlz6G5WzFy2H2aOhUg19PMDZ2xo25HhLLgyDxAHbZj9zqpf
         JvD5wLdp/NW4iSapv89nA/CdGQ6AkLuPP81ZPOF9rZQUnUuZPmXS0/rkJS3zkhgkjp/4
         Je+A==
X-Gm-Message-State: APjAAAWDpGbB7nR1IoJdjDKZkS5CySNvox/77n4zd37bHyQI2/K+kRe3
        /VVfMSv69RnhFj5oIW9LsA5rPzHQXVBDqL/mCYM=
X-Google-Smtp-Source: APXvYqwbZaGMyauKiFD++PrI2NLWR+EDp4DDtRCdyEdJmY9157nkeZUMvJH5Ca/fFXFKRHqlA5YUgzAWFuI8b1Jcpx4=
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr41234514plr.262.1559723573797;
 Wed, 05 Jun 2019 01:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190602143017.19645-1-benniciemanuel78@gmail.com>
In-Reply-To: <20190602143017.19645-1-benniciemanuel78@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jun 2019 11:32:42 +0300
Message-ID: <CAHp75Vf5Foj3FKD6DiRgck07KAVddGTTXJQhWib77yctfdAjOg@mail.gmail.com>
Subject: Re: [PATCH] pci: ibmphp: add check of return value from pci_hp_register()
To:     benniciemanuel78@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joe Perches <joe@perches.com>, Lukas Wunner <lukas@wunner.de>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 5:30 PM Emanuel Bennici
<benniciemanuel78@gmail.com> wrote:
>
> Check the return value of pci_hp_register() in Function
> ebda_rsrc_controller()
>

Maybe this is correct, maybe not.
You are changing behaviour of the function.
How did you test this?

> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
> ---
>  drivers/pci/hotplug/ibmphp_ebda.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
> index 11a2661dc062..7e523ce071b3 100644
> --- a/drivers/pci/hotplug/ibmphp_ebda.c
> +++ b/drivers/pci/hotplug/ibmphp_ebda.c
> @@ -896,10 +896,17 @@ static int __init ebda_rsrc_controller(void)
>
>         }                       /* each hpc  */
>
> +       int result = 0;
>         list_for_each_entry(tmp_slot, &ibmphp_slot_head, ibm_slot_list) {
>                 snprintf(name, SLOT_NAME_SIZE, "%s", create_file_name(tmp_slot));
> -               pci_hp_register(&tmp_slot->hotplug_slot,
> -                       pci_find_bus(0, tmp_slot->bus), tmp_slot->device, name);
> +               result = pci_hp_register(&tmp_slot->hotplug_slot,
> +                                        pci_find_bus(0, tmp_slot->bus),
> +                                        tmp_slot->device, name);
> +
> +               if (result) {
> +                       err("pci_hp_register failed with error %d\n", result);
> +                       goto error;
> +               }
>         }
>
>         print_ebda_hpc();
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
