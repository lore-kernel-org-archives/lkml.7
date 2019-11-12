Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65665C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCC3206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573549315;
	bh=7D34SoJmpLmfC9T9gY6o93RugeKDvEuH5fLN3uop8wI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dCMO7b5Z6x8egPwd1JE4De80ySUN+aq5i1bTnVjvez0IhL3iCj/24S7P8dRorte3z
	 2/vygSVjmPcbxaLuZjRYLgiQHu2q7BhxDSiz8CDHU3dC1nU7RBDdZC71BNfBIMFQeQ
	 LMQ/KMqMJBVByf5w0qlqRUKOJlR32zKA89W39oJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKLJBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:01:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34877 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:01:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so14148443oig.2;
        Tue, 12 Nov 2019 01:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYn2o69wsvGZPAuGLdk3PmyXa9qfMINjGKG1oBvRpUs=;
        b=JP853p0Ll6jVMTOBwPEfa/46johROuJsFny92WIOoi83e5D5W7a3ta9S7Is+2OwaAa
         e2U4PvwUD45lx61qzdQlfAZw0f55yN9ir2T4eU3YX0YaZX968eOoY5n2rZtXS2jqSHML
         Nzh/tV5le8qWUBiPKB60VEmB15ppX6Q4NpxTS48G42g5+RJ91ECZLMEKpMBTpRXcE3xa
         zo1vNxnlYlTAvkee5NiZ0d/Pz1U79d/O7Tn/+zuX6zch4iqw0i0neLufTpT82qNialaN
         09BMTifVJwCAea7cQt/rTfSbRgGL6/kvnVvetA+kb+Irnn6RBWWTE++k3iz7gzLn2nq1
         W94A==
X-Gm-Message-State: APjAAAWRk7bZgYS3hWG1fPk5X17GFHofaZ0YC/tA2GELwNA2cRzSphus
        sthDD+rSHStGX81aMpF144sffkzdEZI75ez2wmHvZg==
X-Google-Smtp-Source: APXvYqx+TvQRWOeVargE9TyXa3wSvdRA1dTrur04NFtQuErKbPKiELBO/s97GRKV6nHC00VAPI7hsVkImdv62/oC9lE=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr3090487oih.57.1573549312903;
 Tue, 12 Nov 2019 01:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20191111213426.1415-1-cai@lca.pw>
In-Reply-To: <20191111213426.1415-1-cai@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Nov 2019 10:01:41 +0100
Message-ID: <CAJZ5v0h45YKtEfggt91Cfw=hz_wE7R8raqMbOvBLG2McuQY_0g@mail.gmail.com>
Subject: Re: [PATCH -next] acpi/numa/hmat: fix a section mismatch
To:     Qian Cai <cai@lca.pw>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:34 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved"
> memory as an "hmem" device") introduced a linker warning,
>
> WARNING: vmlinux.o(.text+0x64ec3c): Section mismatch in reference from
> the function hmat_register_target() to the function
> .init.text:hmat_register_target_devices()
> The function hmat_register_target() references
> the function __init hmat_register_target_devices().
> This is often because hmat_register_target lacks a __init
> annotation or the annotation of hmat_register_target_devices is wrong.
>
> Since hmat_register_target() is also called from hmat_callback(), and
> then register_hotmemory_notifier() where it should not be freed when
> hmat_init() is done, it indicates the annotation of
> hmat_register_target_devices() is incorrect.
>
> Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
> Signed-off-by: Qian Cai <cai@lca.pw>

Applying with minor modifications of the subject and changelog, thanks!

> ---
>  drivers/acpi/numa/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 42cafeaac336..600ae3babd15 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -694,7 +694,7 @@ static void hmat_register_target_device(struct memory_target *target,
>         memregion_free(id);
>  }
>
> -static __init void hmat_register_target_devices(struct memory_target *target)
> +static void hmat_register_target_devices(struct memory_target *target)
>  {
>         struct resource *res;
>
> --
> 2.21.0 (Apple Git-122.2)
>
