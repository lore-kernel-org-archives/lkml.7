Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2EAC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E262D21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqSPRhDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEIJdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:33:23 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45524 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEIJdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:33:23 -0400
Received: by mail-vk1-f196.google.com with SMTP id h127so414974vkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjNhpWRs8f71yrAy3RgUQYa6ESreaTDpHDF1kJYFLi4=;
        b=KqSPRhDS3nRo6SLQ0wCjG0lGUyZOeVoZJ2tjzg1y89vGU86T/aglOfWjN70bV/PozK
         SAQdDSt46ucXZgJcYI6xYNd4nFSG3cVQgB9iMZzfJNa6xQHrZU54uFOofmTVvvGkCslG
         EuCVUYEKIrKT8zWq2ATAwg+uYKnBlO9FvOxNEbeiNlJPDQGtHBnNNkae9Yb7U4mf8+A0
         nUFznRgVCbXsfBW0qnQORreJPuSBrxVMUYohEHe/gMaq0Plod8r+j1aRgNCbAuzIJKpJ
         isFey/3STdqpSu7IJb0l+4UQADxf2l5/vKY43R4EPnXXLbuWjsvVfRs5YVzFw/GSo1NB
         2oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjNhpWRs8f71yrAy3RgUQYa6ESreaTDpHDF1kJYFLi4=;
        b=CkEkNreH/6xfFwKBAFCo1ZsU/tFDzayM0oG3Cszluhtk7/z2pNOekYHFjDyKEL3WAA
         HdjPWXCJuQxn1NFlu9+2FRc0/wp9PZjjTMmXS1rshhpR8Mna8AHmkctda8Ttuw89OQkv
         w9fckstoPlo4ORF+IBOcavyW8lbJErMA+tYtxSSQQMfg+ueU6o/n1DKNt1b2QZFrlkW2
         +Gj0CuEaMBY+IxF+uvypWyKU37u0++z4ducVRvaORed2HRaUSdo2cMdyCJxwVIqJItPa
         7ynPtRmsVmr4m1+4x8RusX4Lsp0Z/Grg0CvOM/TY03Cb46CSPeZm7EEbQXSkq9yiOdCO
         gLdQ==
X-Gm-Message-State: APjAAAVC4Jbb5ioaXpLY0ts9x6FWzeo0tZAmuKjsSw9PjZi+XG3n+YYv
        GHzRoxPzsG3553kiSBKNJZlWmkkG3y9n3lKkVlB+1A==
X-Google-Smtp-Source: APXvYqw6L3/4Ch+tH/DhayP44e50T5LigFBZhZJZQfM8xmm5TYt/0B4S7cFMoCH6vW3b0Xni4ybNxsJKxGoH6NVT8pU=
X-Received: by 2002:a1f:2d90:: with SMTP id t138mr1110666vkt.14.1557394402774;
 Thu, 09 May 2019 02:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <1557310449-30450-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1557310449-30450-1-git-send-email-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 9 May 2019 15:03:11 +0530
Message-ID: <CAFA6WYMPKxwxzbU=CFYLw83kpXP9LwMQ3-N-hp2NyExhs_HjSQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add mailing list for the TEE subsystem
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 at 15:44, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add a mailing list for patch reviews and discussions related to TEE
> subsystem.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I forgot to include following tag as this change was suggested by Daniel. So:

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>

-Sumit

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 920a0a1..c05dff7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11556,11 +11556,13 @@ F:    drivers/scsi/st.h
>
>  OP-TEE DRIVER
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> +L:     tee-dev@lists.linaro.org
>  S:     Maintained
>  F:     drivers/tee/optee/
>
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>  M:     Sumit Garg <sumit.garg@linaro.org>
> +L:     tee-dev@lists.linaro.org
>  S:     Maintained
>  F:     drivers/char/hw_random/optee-rng.c
>
> @@ -15312,6 +15314,7 @@ F:      include/media/i2c/tw9910.h
>
>  TEE SUBSYSTEM
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> +L:     tee-dev@lists.linaro.org
>  S:     Maintained
>  F:     include/linux/tee_drv.h
>  F:     include/uapi/linux/tee.h
> --
> 2.7.4
>
