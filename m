Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68AD2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPvRePWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfB1Upk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:45:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46015 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733277AbfB1Upk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:45:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so10254105pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Va/KJiFXOJNHNDj0/LvVsbvJb9pknbq+C46fNM5B750=;
        b=BPvRePWWtXehTGfNyYbvICjN6j8Vksw+6xzRlc4JEAW5xoPhxfyi2S9C5k/bX96EFa
         bYRFsJexQAVVoI019lSGyeTDvfHCdsy1f+vy16dImgAFd5PnyayipEuRyDrfAgPlIkFZ
         tHFEx7x4Oh+/WR+rtqPckLgfrw+WL5XYUpJKkC9jbTZAxHmwPgEZiiEGIohk+iRwDIU9
         gA+rfrqcs3z5JP65ohfS4mOysnnxBZSqKwuzVQUT5oiU1Mobpq+LE0Yvb3OwN3+Cdef/
         a8XLytIIytyinoO7PYN8m9rH5aMMIsYm9PR39MMXyqb3/bZWDggeFsgJ+ec/Ksbdu29k
         2/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Va/KJiFXOJNHNDj0/LvVsbvJb9pknbq+C46fNM5B750=;
        b=OVEA2tSk4EoEFPTJ+lLVPBuzM9FyjtsNDdYFha90sgDXge0aiE7dg4oRORY5Y/OrUU
         Pza7BXxZfi5H5qRwtBDd7EjjPFJMnYXREJsCC64VcXFUwNXSsj6g8GQCuzGMJZbe5+bE
         lGuORqwSP7H/5rs2LRsCVGHiMizUes25Z7wt8G+ZmXYZLNVII/h7eHY8ThMiB7JPJ0zA
         MkBDdeaeufZ7P92Ng7wRsyoF0RpbAIEuXmizszN0DvjETvuswLyRiOcj96YvC2ANGgpz
         ubbXQ3VWtdljm4X2WkRTlAaPKdEMZx1VacZmdPE2WpFvr5vbd1+A34Zc9Rnf6PvHUUOr
         NX1A==
X-Gm-Message-State: APjAAAXReQua7LKOuyIwru3Ae4ywDgJZLiOLAUn28j+9vV1xGSkXEQ77
        UJX9IjXUnVEta2kgI+Hhk1B9sQsxj7NdMP1Zj5Tr6w==
X-Google-Smtp-Source: APXvYqw8WUDineKx8oEPoeghuDXcNKGbeB8h/FJFdxJ57eJedxLlFtbqeMMd3kzqxZJDU9zJH6F9vrZLbzm8I7drgzQ=
X-Received: by 2002:a63:5506:: with SMTP id j6mr1094703pgb.202.1551386738966;
 Thu, 28 Feb 2019 12:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20190228194812.30929-1-louis@kragniz.eu>
In-Reply-To: <20190228194812.30929-1-louis@kragniz.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Feb 2019 12:45:27 -0800
Message-ID: <CAKwvOdkxcrNhEhgoTjZLOUwocqybS=fOr8vUgQVD6vCFMgcS9w@mail.gmail.com>
Subject: Re: [PATCH] vfio/pci: use correct format characters
To:     Louis Taylor <louis@kragniz.eu>
Cc:     alex.williamson@redhat.com, aik@ozlabs.ru, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:49 AM Louis Taylor <louis@kragniz.eu> wrote:
>
> When compiling with -Wformat, clang emits the following warnings:
>
> drivers/vfio/pci/vfio_pci.c:1601:5: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                 ^~~~~~
>
> drivers/vfio/pci/vfio_pci.c:1601:13: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                         ^~~~~~
>
> drivers/vfio/pci/vfio_pci.c:1601:21: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                                 ^~~~~~~~~
>
> drivers/vfio/pci/vfio_pci.c:1601:32: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                                            ^~~~~~~~~
>
> drivers/vfio/pci/vfio_pci.c:1605:5: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                 ^~~~~~
>
> drivers/vfio/pci/vfio_pci.c:1605:13: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                         ^~~~~~
>
> drivers/vfio/pci/vfio_pci.c:1605:21: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                                 ^~~~~~~~~
>
> drivers/vfio/pci/vfio_pci.c:1605:32: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                                            ^~~~~~~~~
> The types of these arguments are unconditionally defined, so this patch
> updates the format character to the correct ones for unsigned ints.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

Thanks for the patch! LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/vfio/pci/vfio_pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index a25659b5a5d1..3fa20e95a6bb 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1661,11 +1661,11 @@ static void __init vfio_pci_fill_ids(void)
>                 rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
>                                    subvendor, subdevice, class, class_mask, 0);
>                 if (rc)
> -                       pr_warn("failed to add dynamic id [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x (%d)\n",
> +                       pr_warn("failed to add dynamic id [%04x:%04x[%04x:%04x]] class %#08x/%08x (%d)\n",
>                                 vendor, device, subvendor, subdevice,
>                                 class, class_mask, rc);
>                 else
> -                       pr_info("add [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x\n",
> +                       pr_info("add [%04x:%04x[%04x:%04x]] class %#08x/%08x\n",
>                                 vendor, device, subvendor, subdevice,
>                                 class, class_mask);
>         }
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
