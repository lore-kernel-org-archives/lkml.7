Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED17C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CC12084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYQwLOvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfCKQDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:03:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45354 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:03:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id f16so3826030lfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ua4KOzq2dPCHdLI0iUSBP2EY8iPR6sAOnZK2+63CNc=;
        b=CYQwLOvsX5HPcmtp4CrvNxZf2U7RhK3pFL3EmIRs/fpXb1YPsxHG4CbAp1MU4McbJd
         bmxXNXk8r2M3BHGh0OFAv3rSc74rnat8iCjaq0NCwDZEiYyhVgjNpmUtb3pnkHDU2bNM
         k2DNKsgHTDKmINcSJLRXA5iqtXJKmHykw15j/nMowEuBAt6sobFvD9XR1AI7vLP8Oz+C
         hhL4wRQBXKV+GEzlEw+1WotQ4gEe/b5QZKjVl/pyn0ZJIzdZypbV9J5E84wFB4h4Q7Kl
         l1T4sb1NBE3UkG5PWA4Xe3PjS1k/3oLcPsktNw0UCQd7dltJdjI3BMcDuZVuO8stv+ZL
         7x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ua4KOzq2dPCHdLI0iUSBP2EY8iPR6sAOnZK2+63CNc=;
        b=pS+FVn4pEYuwt3e3OPTXDsshWm7AxrLv1RGh8F7pfbB4DxBKGADCJjS21+3hfTWk3f
         Euj5qSL76pX2bmr9d0QL3xc371U+FjOVpe9JUwC9wAVGny2HjBnT897O3gsO1iu8q3ra
         Csj2nBBeqo7tBK8TKbf4FPT9d8HjVw60iIXNEGIR72ehQgiTItr8hDEHvkjRAe9wARPZ
         uDVzvQrpuvMAAK4kfA4yu+ePAfR7SsT9qcqvlQhvuZB5rcZ91x3vBPZMk2v2gO48Cp36
         8vRRfgumTa86jObfBwHOxsOo756gjzdbdjEon/VsuQIKLxRnodThbwViSv8cg2PHJAM0
         Lx0w==
X-Gm-Message-State: APjAAAXnNx7CHDDme/mlg0D4IVAfLzTL6jH357AmTQ2kZRifHnPO8bFA
        w48f8bH5zlJAiGE2yQRjPqRWgCJaTNbLpL9lKdY=
X-Google-Smtp-Source: APXvYqwP+kDs0curejsikHA3wuO+VxI91/7Sg1icewpXSMc7sCbmgtCGzHt9tTUKbRIol/4Rxh2s/XxyceTxEdJwgv8=
X-Received: by 2002:a19:a417:: with SMTP id q23mr18847390lfc.27.1552320179719;
 Mon, 11 Mar 2019 09:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <5c86803d.1c69fb81.1a7c6.2b78@mx.google.com>
In-Reply-To: <5c86803d.1c69fb81.1a7c6.2b78@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 11 Mar 2019 21:32:48 +0530
Message-ID: <CAFqt6zb1AYsmUyokgwAAx5QU7fky3TrB+th9y5n4W1p6fnokpg@mail.gmail.com>
Subject: Re: [PATCH] fs/cachefiles/namei.c: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 9:05 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/xattr.h which is included more than once
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  fs/cachefiles/namei.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 95983c7..edecb7f 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -20,7 +20,6 @@
>  #include <linux/namei.h>
>  #include <linux/security.h>
>  #include <linux/slab.h>
> -#include <linux/xattr.h>
>  #include "internal.h"
>
>  #define CACHEFILES_KEYBUF_SIZE 512
> --
> 2.7.4
>
