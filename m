Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC90C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B41B208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfHNVtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:49:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51452 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfHNVtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:49:47 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1hy19M-0002lm-EC
        for linux-kernel@vger.kernel.org; Wed, 14 Aug 2019 21:49:44 +0000
Received: by mail-qk1-f200.google.com with SMTP id d203so274979qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1D8Zv52DMVI+1tJMrYZUNsEQ+/Ls5xmkyTop5o1js0=;
        b=YgJgQ1u6bPgwMDqWQwxV60iuyOg0U/r2PqYUZ86BmSKArxkDzrHhGPK39Zic9g3ylC
         fRqLTsEBAgz1xUihh4C30XfycWhSokMGhsktkcdasUyr3O0U087UlJNU8eSwOsQIzorf
         C7PDpqUsmHLZHg0UCC4NPOZf7XydQyOSnGlFMn6kU5+8sP9LMmsuIGMi4MOdtg2o3xnO
         h7cHtM5Za7BGoZTzl1LZKhgF/MOSKGIh6y5M6rzJrs01zyBPygsFUSsVK1EDoAtEkdzT
         z2jYHJoe2cSw09D3qQSYpUgo2zgJw0Q660ygWau8jChEsNZbNjTVSgaj5pHzVNP1Dx9f
         Q0LQ==
X-Gm-Message-State: APjAAAV10XEhl/Cyht+6X+xKVcZEsexOvUlegjorl7AQ9A+t+rpjXQkE
        7ebTn7zQiZJF2Cc6KchtYH36Ax0O6nrfwtHJe8dwX468faJXdxCrGXrIBqX0FbaiO9TrO2K1DHo
        Gqa5vMvSacno6m6Xel4Ff/eL4c5648IcsxXEY7BHvHNZrCB43Pr5gYAzT0w==
X-Received: by 2002:a0c:f706:: with SMTP id w6mr1203589qvn.98.1565819383589;
        Wed, 14 Aug 2019 14:49:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcGzXZYUfIv5JuhgEy8csgt/G/+sxp+oSBTO1E+31KuR6LKUls9RsfxiIM2IRCFHVyk/GRcm+GmCe9i0bILN4=
X-Received: by 2002:a0c:f706:: with SMTP id w6mr1203573qvn.98.1565819383322;
 Wed, 14 Aug 2019 14:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
In-Reply-To: <20190814213118.28473-2-kherbst@redhat.com>
From:   Alex Hung <alex.hung@canonical.com>
Date:   Wed, 14 Aug 2019 15:49:32 -0600
Message-ID: <CAJ=jquaoA+_WmTJtcGq4b0A_Sb=Aw_3_TsUR-8nxJ+rJTdoFPA@mail.gmail.com>
Subject: Re: [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to enable
 dGPU direct output"
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the series of fixes. I will check whether these fixes work
on the original intended systems.

On Wed, Aug 14, 2019 at 3:31 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
>
> The original commit message didn't even make sense. AMD _does_ support it and
> it works with Nouveau as well.
>
> Also what was the issue being solved here? No references to any bugs and not
> even explaining any issue at all isn't the way we do things.
>
> And even if it means a muxed design, then the fix is to make it work inside the
> driver, not adding some hacky workaround through ACPI tricks.
>
> And what out of tree drivers do or do not support we don't care one bit anyway.
>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> CC: Alex Hung <alex.hung@canonical.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Dave Airlie <airlied@redhat.com>
> CC: Lyude Paul <lyude@redhat.com>
> CC: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/acpi/osi.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index bec0bebc7f52..9b20ac4d79a0 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -61,13 +61,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>          * a BIOS workaround.
>          */
>         {"Linux-Lenovo-NV-HDMI-Audio", true},
> -       /*
> -        * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
> -        * output video directly to external monitors on HP Inc. mobile
> -        * workstations as Nvidia and AMD VGA drivers provide limited
> -        * hybrid graphics supports.
> -        */
> -       {"Linux-HPI-Hybrid-Graphics", true},
>  };
>
>  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> --
> 2.21.0
>


-- 
Cheers,
Alex Hung
