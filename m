Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE41EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D9020675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNlIS/nM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfCDSQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:16:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38114 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCDSQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:16:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so3592030pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzZS7vUmOuArgCTdS12aw5KUZU0PZ2f1ZbiejdHArOg=;
        b=MNlIS/nMvRb1P/mCJMAVJsQwrrsJ7l8I1FODCzthHhGTFHkwInlIguWvbDWybjkK7y
         XNBwVOrcF6gj0SNzfW6zD2cm1ZRhtD2D/XDhjCe8yO4W5LbmuA8UQ8G0BtMWgxWSMg0c
         dngyP764+Zab2R2pDr5p8Yjl7Oa/5X5lLhUyd5tqjd+da0JLCio1YYEdkinGWo3qzEPc
         kvC/NRA2+TuV3jO+jffq4oh3zaL55q5+vKk2SJNJOQqyiiW0xuQwjSxzUKDVPxG1Fz1y
         AWArH8W7zIV4SaYy4h2Q2FfMvw1UxTNNgEXvyMZxNzpcyuW053afAVS0XaBMQb4PBfFX
         w9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzZS7vUmOuArgCTdS12aw5KUZU0PZ2f1ZbiejdHArOg=;
        b=iyyYQQ69om+YhHcsvNHIMHmbYMb5Tip+7fHYiTMTAExb7Vctqbv4XYDP3NFZCPY7zC
         dlFjGyE9yNKI/BYtZnIV37uSH5ZIFuOKc1NRb832Tg0/X8+jytI6WpzwLKDx1NOd4JlR
         09VgC/e+NzTtggz9fWck1XifylrVbYuOMZB+AX2SIIphUhfj0TwkFaB01Mm9pfD3Fas2
         vmUNEBLmYqK6oz2dthCwT17NILfA1Q68urDtVLm4BXWjUjyyOHsnpuOxsnzuPxv0jadr
         f0vxaJchunpFPfu5hhI5Esa+Dp6LftJu+AFcjYALbMm2poZ7gtD1BMZXYLUD0cbAVZ0w
         nPwQ==
X-Gm-Message-State: APjAAAWNgvl1P3iWJRyGv50p9CvsnGYXBIOi9joDSGZO2PNZMmbMZ9bM
        4cDAx9Pe19zA/rsn+jS3ymZrevTL9orocKHL7L9glw==
X-Google-Smtp-Source: APXvYqweQ4xJ2k9PBij9V7XeIiaEzRlNIL2inywS0f/hhHJKL3MfIrnOXTC2zrRJWGwCVV6tLqjO/uOv9mq/EpAWc90=
X-Received: by 2002:a62:2b88:: with SMTP id r130mr21131821pfr.93.1551723412306;
 Mon, 04 Mar 2019 10:16:52 -0800 (PST)
MIME-Version: 1.0
References: <20190302141836.24638-1-louis@kragniz.eu>
In-Reply-To: <20190302141836.24638-1-louis@kragniz.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Mar 2019 10:16:41 -0800
Message-ID: <CAKwvOdn3_xXm09V8PPdfwkV7CMxGDxgODK3an3HuPiRBBzGM1w@mail.gmail.com>
Subject: Re: [PATCH] i2c: sis630: correct format strings
To:     Louis Taylor <louis@kragniz.eu>
Cc:     jdelvare@suse.com, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 6:19 AM Louis Taylor <louis@kragniz.eu> wrote:
>
> When compiling with -Wformat, clang warns:
>
> drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS,
>                         ^~~~~~~~~~~~~~~~~~~~
>
> drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                  "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
>                                           ~~~~~   ^~~~~~~~~~~~~~~~~~~~
>
> This patch fixes the format strings to use the format type for int.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  drivers/i2c/busses/i2c-sis630.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
> index 1e6805b5cef2..a57aa4fe51a4 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> @@ -478,7 +478,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
>         if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
>                             sis630_driver.name)) {
>                 dev_err(&sis630_dev->dev,
> -                       "I/O Region 0x%04hx-0x%04hx for SMBus already in use.\n",
> +                       "I/O Region 0x%04x-0x%04x for SMBus already in use.\n",
>                         smbus_base + SMB_STS,

Even additions with 0x00 imply integer promotions (my least favorite part of C).
Thanks for the cleanup.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
