Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AC7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8232067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmPFqplF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgAINgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:36:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36041 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgAINge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:36:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so3410092pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cf95WORT6GX1WJSn8Af/G1OCB1Irn/cMBwQxwXC43X4=;
        b=rmPFqplFiG2J23km4wRX/Ng/4kLCh6mrZt9F0tbMq9Fkk952L8sqSIO4o7LgYULfwU
         1KtC1gWAKTfa0XSUUAQOR/AmiotKOiyRCtMVmsyZgWl7wiNros6lsyIzVBKk/lEPxX0N
         5O4IjgJWkFY0lyOJzBgBeSNBDQagktLXZMzfFMLURXzGXfLJjyf9u7JhjvdvJVIPPoIV
         +FpzI1GmzdsT0mwz6RfBwpQvN5KYst18bnDXEZX/R66raaG4xngUb7fMMFDFr4XRrHLC
         HS0EaXm5BYy8/MMd3k9yPgsTCotJx3MtIWFki3GxVm5+umLuLYzDRu1kI/QqXQdGnzea
         4fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cf95WORT6GX1WJSn8Af/G1OCB1Irn/cMBwQxwXC43X4=;
        b=ESoiF44ANtBrD2REWUY99BRe3TRL3cTTuQKjwlGy1oGtiDvosD9C6KdCu5euc7C/D5
         6kSr1U701C/DqciSlHTLlyCfTIyWuvVB/JzC9ZUkKaLxA9XFZ2BdzP++y634GbfvBBjn
         2sisN3TyVvwx9QBun5Xop7N7Z996gwXNplFMaFIqVZg9JHO/erp6EsfMh/gFUGTe8rYZ
         aMoY60g+FnU0X4crnrK/61CsipqTDx6yExdmU0x8OmzsHT0qhDd6QQQVQPvSVERbgwPG
         iJ8GKCqSlMlTirTkEe0NGc4c3+vUllDITWMCS9uykbxk4g8/zrACUx3kGI3X45GoY/qM
         H4Tw==
X-Gm-Message-State: APjAAAVExdD493MjGGKdIj86Tyv0tvYA1mRyA30+hdiPiV2jyEauEwoq
        maMv8YEf8YND0pAR0P7p8DHhUV8dtXuASl2mIGU=
X-Google-Smtp-Source: APXvYqzYs38vcWA8XTYQ6/bQR6VN+il7W5RyHWICEMlfnkK4VOVNx6yJKOpUbeM/o/gNmhfTvQD92qFBUgw0+jdnlik=
X-Received: by 2002:a63:3dc6:: with SMTP id k189mr10954174pga.396.1578576993895;
 Thu, 09 Jan 2020 05:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20200108152100.7630-1-sergey.dyasli@citrix.com> <20200108152100.7630-5-sergey.dyasli@citrix.com>
In-Reply-To: <20200108152100.7630-5-sergey.dyasli@citrix.com>
From:   Paul Durrant <pdurrant@gmail.com>
Date:   Thu, 9 Jan 2020 13:36:22 +0000
Message-ID: <CACCGGhCGcdEq7CC3J0201ETvAd+PZ2fTDNUS3mo599Tuf-61yA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xen/netback: Fix grant copy across page boundary
 with KASAN
To:     Sergey Dyasli <sergey.dyasli@citrix.com>
Cc:     xen-devel@lists.xen.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 at 15:21, Sergey Dyasli <sergey.dyasli@citrix.com> wrote:
>
> From: Ross Lagerwall <ross.lagerwall@citrix.com>
>
> When KASAN (or SLUB_DEBUG) is turned on, the normal expectation that
> allocations are aligned to the next power of 2 of the size does not
> hold. Therefore, handle grant copies that cross page boundaries.
>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
> ---
> RFC --> v1:
> - Added BUILD_BUG_ON to the netback patch
> - xenvif_idx_release() now located outside the loop
>
> CC: Wei Liu <wei.liu@kernel.org>
> CC: Paul Durrant <paul@xen.org>
[snip]
>
> +static void __init __maybe_unused build_assertions(void)
> +{
> +       BUILD_BUG_ON(sizeof(struct xenvif_tx_cb) > 48);

FIELD_SIZEOF(struct sk_buff, cb) rather than a magic '48' I think.

  Paul

> +}
> +
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_ALIAS("xen-backend:vif");
> --
> 2.17.1
>
