Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC89C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A022054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqcxK4Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfE1Nlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:41:52 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38675 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfE1Nlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:41:51 -0400
Received: by mail-ot1-f41.google.com with SMTP id s19so17778134otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKsXUMCakUWgErOsaRITqa4FxEz2qOwMXsf6lvlti0M=;
        b=oqcxK4FaFOcW5GwJTKUXr7vekNKKcFx7LWt8JHxUwbg+cWVAhaEWYDNG6A+B3gN4K2
         cnua/jNczN9pL0pWaSmbMB5ANrUyJRTuCEFo43geNZw3B6W+VEb1akn9j10v/RIr87W1
         NUNN4Sj85NkLZgQysRZbSyqBShe1YNitUo2QS/nciFTGAds3pKrN8x4aeFn2oD3Z2FZU
         S92G5951kPvhevqgnn/CNkBhdGHWwnhZJx5fDBwfIBH5DeTd3Es/C7jWR/0qzk2MYcth
         A+k5puS4IulBgv3mGQnnzAgYTD/HarbY7Pi2E9twTv2/i89DeDlFprt6nL+AxKCQL8Kr
         swzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKsXUMCakUWgErOsaRITqa4FxEz2qOwMXsf6lvlti0M=;
        b=Y3YZYzXRu2qSSuDi8j+Nqg2qiHkJBTSnn088tLxzUeV28mQY4NjA1jq41trm1u+e2p
         8IooZzeaD1FWgtaDtR9yHRIfGSwK9yNstFha4lP4W4VCfk1/rn4ZPrJV2E0JU49LG+Ph
         1J9fs1UstF60ZbEd03sVv6f0vLvPUTF8CbhaLmVcYugtROzOcy/q5kAV+6f5jb78OubM
         PTPWRTDXFogCZgzjG5+8pzFdbWXJjCbJdPnSY8xKoSTJZtvNxii3CGVeHkidTlbZwfxv
         pcWe00UVPa4PUpCUehzv/v9gVSaSvyCpuAAUqDHQaBthA5fxaCYjISVMr7Wo6InLkR3g
         x5Jw==
X-Gm-Message-State: APjAAAVvpOUOb3WxnSDGSvOINKn1ZyUuCsw6YIiTnjyOow9eBD2t3RmP
        bPbW5N4Byiah7iJ0hR88XG2WZ+MFd1V0q0o4dfo=
X-Google-Smtp-Source: APXvYqzP0qT8QbEIUpML4WTjIG+mQEqMSn1zb42i3wQL0nMKL3SIL2EiVoclQJqCaUtFHCZ6Dsnjzh0AJHFZtS3EkXo=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr25567214oto.224.1559050910868;
 Tue, 28 May 2019 06:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190528133214.21776-1-yuehaibing@huawei.com>
In-Reply-To: <20190528133214.21776-1-yuehaibing@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 28 May 2019 09:41:40 -0400
Message-ID: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
Subject: Re: [PATCH -next] staging: fieldbus: Fix build error without CONFIG_REGMAP_MMIO
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello YueHaibing,

On Tue, May 28, 2019 at 9:33 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix gcc build error while CONFIG_REGMAP_MMIO is not set
>
> drivers/staging/fieldbus/anybuss/arcx-anybus.o: In function `controller_probe':
> arcx-anybus.c:(.text+0x9d6): undefined reference to `__devm_regmap_init_mmio_clk'
>
> Select REGMAP_MMIO to fix it.

Thank you for noticing this, I appreciate it !

However, when I run this patch through the scripts/checkpatch.pl
script, it reports
some issues. Could you fix and post v2 please?

checkpatch.pl output follows:

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#68:
arcx-anybus.c:(.text+0x9d6): undefined reference to
`__devm_regmap_init_mmio_clk'

ERROR: DOS line endings
#87: FILE: drivers/staging/fieldbus/anybuss/Kconfig:17:
+^Iselect REGMAP_MMIO^M$

total: 1 errors, 1 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.
