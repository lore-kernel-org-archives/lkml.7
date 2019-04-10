Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6429C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C242082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSF7T6mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDJVfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:35:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46925 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDJVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:35:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id s81so2189849qke.13;
        Wed, 10 Apr 2019 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ySzheS1JXeunYOuWLUqItZd04WNFz/ogbzqCdrLPAg=;
        b=mSF7T6mxNs0lplAVxJczUq/zOuBJ887WOQrwqN0nuyNXWyzeQngDhLSZZ1jim0C8JA
         AGwpfFVrpQoflXJrGuBgQrh5aUH+xJTC2am8z5jI6z45PleesfDHt4jf6R/gXqdoYaBa
         2MlrFqdJQIN+XrfI4qAOxad6Tfmd2Nc+bnsehHa6prr67gHjBweNCFnrZW1sNSPs6F6r
         Ks1wzr1Zzja4zUTPCeWpdt3DRXzbScKmq3/X7XCNbqC32rx+iX/VUSmgGei8SoZ4bWrO
         qe8VF5RM19urhKY27vVQEPbIzVrUm16LmHJV4JYjcOfEfyZNWC1uS9D5YoIrK2B2xuGt
         4kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ySzheS1JXeunYOuWLUqItZd04WNFz/ogbzqCdrLPAg=;
        b=aQy0fzSy6fnEiMlrwKwQN04tEElMa1KWzQvHqO/2oKsDQt6RW6v8FO5Kh08uRx8joC
         cVU/ZTpJ3QRqm/jvUnPV2/AdxEota4Gcwy9MX6rtWT1WDRJM4OB+4OKoTYc8jXzaLpR5
         wD+9OkxJyJuUXzgdRM13800N4HSrZs21kcuDwaRWKTxOkVjYyBbcE51nZ1PuK6RW0dQJ
         UlPS7/jjDpry0Z3jkyrFv7f1YaV17//k4xUworbPP44bLmG3CWQPaEoef6OyhK+XPe0f
         KF9RjYkFfyK19uGjwnIu8ToZAvL/Y338dhrdC/GSpBde8z1o4JtLlDIfQCwEzxcavm+o
         H5kg==
X-Gm-Message-State: APjAAAXTjbSKYQLWTKt7FVtrZsD1686tzbTLdduimY0oDbXovBtjr0Ih
        j+u7bDCCcGjuAgChqIkFI4BrGyIvXHhbwvri1f3m
X-Google-Smtp-Source: APXvYqxiFXlLSRti5LHKbWsmB0qRHmgC/iBZXf/+MUJa3NJtlRnfIXMf8KQnQrAr6Wm+Gg0E7gnfbWjyBtW0QkuoOXw=
X-Received: by 2002:ae9:e313:: with SMTP id v19mr33694579qkf.153.1554932105469;
 Wed, 10 Apr 2019 14:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190411072758.4fa7b9a8@canb.auug.org.au>
In-Reply-To: <20190411072758.4fa7b9a8@canb.auug.org.au>
From:   Rob Herring <robherring2@gmail.com>
Date:   Wed, 10 Apr 2019 16:34:53 -0500
Message-ID: <CAL_JsqLWOtOe5CTOe0YbJ_mCqnz6zEcFEA8zWAW9YDhr=6+yYA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the devicetree tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 4:28 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Rob,
>
> In commit
>
>   7800990023f4 ("of: use correct function prototype for of_overlay_fdt_apply()")
>
> Fixes tag
>
>   Fixes: commit 39a751a4cb7e ("of: change overlay apply input data from unflattened to FDT")
>
> has these problem(s):
>
>   - leading word 'commit' unexpected

I've fixed it up now.

Rob
