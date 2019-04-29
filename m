Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B4C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A24820656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mg3zcpHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfD2Opr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:45:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42604 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfD2Opp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:45:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id f23so8801043otl.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQsRWF6zIWFP6u6h0fPNHWWaz224ukr01sNXIEFyCVQ=;
        b=mg3zcpHysM6rxTpxenL9XK1Zvah5E8w7vALbhvoiC1TTSma8Uh03KVN2sZ/4CiEuYD
         rh1/u68dnX0A/77n7RkiSethSJB1plU2anOxMkHaaARyjqBdZoRbLqjDcITWeOwaqDcI
         e1Pzj4PkAkhkdZKp06TdV5TzX5pJ6R0U3I9zrrUXIX97GPLKLnuj9Vmyo8alefksc6IQ
         OBknpz6qeF5s+/12FcMhebcfTBS0ZMW00lYtSAKIYiPzTtU9VazgAyPd8nYIvfJMxBUB
         IXC3tdnl/MKwn/p3XtylFqWgkCCXS37gjkUFW4K+t/orEQHMJMB/uMahCEV8Kwl6H+m6
         79zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQsRWF6zIWFP6u6h0fPNHWWaz224ukr01sNXIEFyCVQ=;
        b=AtvlLkkRfLwsBUQSxFcdJ1perbvHJHSzYHLhbRHp7iUXugPSaf+MpK9UMQc0vr/2ch
         Hh0UbDMQCwzshvj17RkEu2WGQPnpaULrnQGi+K/w4IvQDulzyp6mstff70nm8K3BkIGs
         YOOxhqfYOdG4FNuaMW/D/hGVceOSFJVgpy5ZhkBUuaQJ06R/bhUxf1xMxhYIJwZGPULg
         +zOSNCjYM+WfDKbPopyC08NZzY0QxYJmKPlF64MtM8xYL6RWsARooQNRSiAw7mnguYi6
         amSYR0FRzq1mSFujVBZvbIbmQ6RKbjt49ZN4dYfSYS1mPDaFqhHRn4cp3shR38Br3XxQ
         VVvA==
X-Gm-Message-State: APjAAAWgqwRbNUOKqH4Si3XFDr7YKXg78ZVF7omRo//murc6gHB4Lco0
        qPXh+lcXtrEGyDES/sbkX/wm7dl8qh4BLO0whEJvKQ==
X-Google-Smtp-Source: APXvYqxqg+I+R6IIaH5kNEYHVK7570HerFOrgSzrqloi1r1ZqXhWIBt8AfWeSDPOfld3FTAKn8gp1GCbdSfV+VpC4HA=
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr3105184otn.367.1556549144567;
 Mon, 29 Apr 2019 07:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190429115535.12793-1-hch@lst.de>
In-Reply-To: <20190429115535.12793-1-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Apr 2019 07:45:34 -0700
Message-ID: <CAPcyv4iJo6QdDdaXWJCnF3LqO-wSkRcKx1wwWF1h-=q=z2UZdA@mail.gmail.com>
Subject: Re: [PATCH] kernel: remove the unused device_private_entry_fault export
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 4:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This export has been entirely unused since it was added more than 1 1/2
> years ago.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/memremap.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 4e59d29245f4..1490e63f69a9 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -45,7 +45,6 @@ vm_fault_t device_private_entry_fault(struct vm_area_struct *vma,
>          */
>         return devmem->page_fault(vma, addr, page, flags, pmdp);
>  }
> -EXPORT_SYMBOL(device_private_entry_fault);
>  #endif /* CONFIG_DEVICE_PRIVATE */

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
