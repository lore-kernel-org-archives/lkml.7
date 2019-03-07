Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D28AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D613F20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lB6bq99i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCGDqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:46:19 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42612 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCGDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:46:18 -0500
Received: by mail-vk1-f193.google.com with SMTP id j195so3376784vkj.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 19:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKeno2vk9ZpXcVLaFoCZ6PPGc/TuRXeTkIg0oC+zwCo=;
        b=lB6bq99itE6osLmVvYNxpykvHh2b+Lk1nXSePboL+VNFZH5gR5kaXb7mn6Nrr2CP3p
         tJ3J5SqSmT4bPuu+t4TPm1Sd1zsk9+HZktNuePChb8htQWX/mNuauDBB1BOn2lGDsa0z
         VY//25vzN7YgQuUYDOi9kBkZ/35vnb2WxZMSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKeno2vk9ZpXcVLaFoCZ6PPGc/TuRXeTkIg0oC+zwCo=;
        b=K/J7xIyJK+xv+5AEz57CQX5DqAgE4SV0fYcKDaInwhCFXvXeMc45YvL+ly4z8txsi6
         6KsNmAySMpr/IGIgZ1OLzA/MxvbHqC4deNY5GN2iORyuDft/Un9mfrNYICgSIcqsTU18
         VrflC6VANyGLHW04KAS7mu0QRsHP5jTLPgwCfqF7sLXWB5J3e1hJ8R5KwqYVc4/cHJF7
         NUfCcfQ0ndCjtQx8Thv15KAP0wBmst7P3KdvIKMNPVbpie4FbhbpNs8QGwJIO0kiHBml
         /WrEwhJ8YdsAy2E/AzdaqxHRnZPiyFHS0+3AmZyms/n09qwISmwi+F2OrcVXUy7aMMJc
         aOyA==
X-Gm-Message-State: APjAAAU3/tJxJQ/X/C+lIbmCHbB1a09N8yHyrzxSVOF8ewLVfvlhthNP
        i0+wucOCpmYPsZCmELe535zyTz5G1co=
X-Google-Smtp-Source: APXvYqwqPosmkJSrlLeV4FfL7GOhCN0IHV0YSJFUrRpjfyBVza3tpwFQL6hArN9VGu4QkvboQOLbWw==
X-Received: by 2002:a1f:1408:: with SMTP id 8mr4924396vku.36.1551930376822;
        Wed, 06 Mar 2019 19:46:16 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a3sm865905vkb.29.2019.03.06.19.46.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 19:46:15 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id j12so3647451vsd.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 19:46:15 -0800 (PST)
X-Received: by 2002:a67:6983:: with SMTP id e125mr5679489vsc.222.1551930375197;
 Wed, 06 Mar 2019 19:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20190302094312.13363-1-oded.gabbay@gmail.com>
In-Reply-To: <20190302094312.13363-1-oded.gabbay@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 6 Mar 2019 19:46:04 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLGCfP8Wv58swP_=w6-xNSOvOqZW9WUjSMaJQAXbYHnSQ@mail.gmail.com>
Message-ID: <CAGXu5jLGCfP8Wv58swP_=w6-xNSOvOqZW9WUjSMaJQAXbYHnSQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use %px instead of %p in error print
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 1:43 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> When parsing the address of an internal command buffer, the driver prints
> an error if the buffer's address is not in the range of the device's DRAM
> or SRAM memory address space.
>
> Use %px to print the real address that the user gave the driver and not a
> hashed value, so the user will get a clue regarding the origin of his
> error.
>
> Note that if the print occurs, the pointer that is printed is a
> user's virtual address and not some kind of physical address.

Err, which virtual address space is this? If this is mapped into the
kernel's virtual address space, this should not be %px...

-Kees

>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index c4f3ec1e9d8b..238dd57c541b 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -4293,7 +4293,7 @@ static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
>                         return 0;
>
>                 dev_err(hdev->dev,
> -                       "Internal CB address %p + 0x%x is not in SRAM nor in DRAM\n",
> +                       "Internal CB address %px + 0x%x is not in SRAM nor in DRAM\n",
>                         parser->user_cb, parser->user_cb_size);
>
>                 return -EFAULT;
> --
> 2.18.0
>


-- 
Kees Cook
