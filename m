Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B02FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA28421850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1gd38/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCTJcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:32:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53505 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:32:34 -0400
Received: by mail-it1-f196.google.com with SMTP id w85so6298030itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKVEZSve2zu2cXVRSLdqOuBFfFmZNsci9pM14FVbTa4=;
        b=L1gd38/3IUcv35k4u2P8bTI56uQ4ryHg7Dtm09dAk0MRzlWf3O1wbvpQ+KEKC2cB/f
         LVQ7tabma/PmIgZXcbzraJ65sJDRpMjRw9j0PEd9+atP2gKI1PhMCl2W+hqPH4RcrxYw
         HRMZ7m9LVSmHqrqzULfI0sayxlVNIFOgfmdcaDBIlkc8SU5DIxA/Qmw803r4crqwNT6e
         VMXFfkwj1yQ/hK6Jhepw54OQ0+DnskzFImMaGrhBgOsxKJpu9oWm2hRVgoGrt58HlVNX
         ji6wHA8l6EMuyCx7kuoGiuMvEoULeffJbkcUoaNJ6ipKuWtRb85kOwbDpIqYpIwxHb82
         5evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKVEZSve2zu2cXVRSLdqOuBFfFmZNsci9pM14FVbTa4=;
        b=uBrqc/0aU7kVdePJxfKUiVDGxNyIO6ULZZk2CPjN9SwY4muxfFQg3abNzSlXa3hp7j
         luPrln2mRm/GH+6NYYJWw4bsFII5gzqkTGtKVwNq7E/lc0DuX8Vuh3gtB/lxuVF0SVi5
         js4KpkwIVrK8Dg7dsL+J2yy372Vd4Fug+GpMTj2y9i5P6xmkaQ1xXR9XJAy6GM11SAdB
         uLGp5TnX7mkbAfEqNO03Z2EepINC7dcZcH6brXZGquJ2yMnwsNSyE2tKl4eKWmdrrTyZ
         veBdKgpANbIub5SgopFltrgHAJpmtgNsi15k7OIpIlQhZlOG8nuUKRzuo11jx6LlKwCk
         4Bpw==
X-Gm-Message-State: APjAAAU/sd/ndalhhiNYE9NB+/YigI1WcNB5x5d9MsFv7TX+LA/v/5HM
        BNqXOLtOHErox8SGfUFgCmCS1B1SQkXS2qzuLGFvTA==
X-Google-Smtp-Source: APXvYqwGZz64S+Xmpqemv33DqVIdLhrtGLvmcYnAH1bLETyDXoJcbzhgF1GXmuPayyviJn0g9RWtUWykn9ZlDKgERio=
X-Received: by 2002:a24:ecc5:: with SMTP id g188mr4181367ith.97.1553074353723;
 Wed, 20 Mar 2019 02:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <1536345427-31425-1-git-send-email-volodymyr_babchuk@epam.com> <20190311130348.2157-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20190311130348.2157-1-volodymyr_babchuk@epam.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 20 Mar 2019 10:32:22 +0100
Message-ID: <CAHUa44EPe0K4pRg1DeBQx5NAgVtGqgrnZCJEawXOgG=HqfzedQ@mail.gmail.com>
Subject: Re: [PATCH v3] optee: allow to work without static shared memory
To:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Volodymyr Babchuk <vlad.babchuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Volodymyr,

On Mon, Mar 11, 2019 at 2:04 PM Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
>
> On virtualized systems it is possible that OP-TEE will provide
> only dynamic shared memory support. So it is fine to boot
> without static SHM enabled if dymanic one is supported.
>
> Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> ---
>
>  Changes from V2:
>   - rebased onto upstream
>
>  drivers/tee/optee/core.c | 80 ++++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 31 deletions(-)
>

Looks good, I'm picking this up.

Thanks,
Jens
