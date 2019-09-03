Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6048DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38431233A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkuHlxpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfICQjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:39:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45038 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbfICQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:39:49 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so37343899iog.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4ZEq7vH4LyybBLltNPsggnz+MnaF8ltq7+1mV3M7z8=;
        b=jkuHlxpeTffQzyKV7i+2JpBXYeno5qGkifyuRpdFr9yRwi+/bp2jvkxx9lYBVPAkpc
         QoZrOZWkcUWulrSc1aWcPUCpSqIXq3wwat3oMQyk/b84xNgzpclPZvcP0kSIs7YfB7i6
         CBNOVJronTNdu4mWyF/x5DwEr0QXKAykO90Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4ZEq7vH4LyybBLltNPsggnz+MnaF8ltq7+1mV3M7z8=;
        b=cPkfyDFwW5QDNcG5UUTwsZaewAMI0y4aQ+RvHiQxQDZWAOF+Yi5D5fC14QUQEm0rL+
         pzc6v079lyFBxBpTmnuAth8bO8sTtu7G+jPriEDTy/tMS73xNEZCw6iZBobZTmQMpcCA
         mBROzq96YjN9bmQimCNXFwGootMikQpVOAb1P7qhNu/OTeyf6IcdTvPpqfdPY9I6ae+g
         wD91sHPuRjcKEJNP7aCd/VAwhYOqGfOR2lht9WoykHtH10O+50bwsOxafzkoJajfehL8
         xg+7bxgbW25cA5zZjGFvW5A5FXbJOHdAD+n1fbZxBEqNXg20jSWSdXMW9JzYzhB+yrr7
         KSqg==
X-Gm-Message-State: APjAAAX3nKi25T8sP1gOlZ92nDdsNqA1seR1RYF35ajVG8zXmyuqcCPN
        lB1T1C/yVoZ0pnwxQbbNHs8/0ip5D/Y=
X-Google-Smtp-Source: APXvYqyGd/VE2Vf91vS2Ef0bGLRYAS2GOyygSUKQrrmnV639vRBQqAG7zz3JYICS0ORciW+zst/5OA==
X-Received: by 2002:a5d:9403:: with SMTP id v3mr33440657ion.281.1567528788802;
        Tue, 03 Sep 2019 09:39:48 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id j26sm11423388ioe.18.2019.09.03.09.39.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 09:39:48 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id u185so33568980iod.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:39:48 -0700 (PDT)
X-Received: by 2002:a02:a703:: with SMTP id k3mr26897198jam.12.1567528787667;
 Tue, 03 Sep 2019 09:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190903162519.7136-1-sashal@kernel.org> <20190903162519.7136-126-sashal@kernel.org>
In-Reply-To: <20190903162519.7136-126-sashal@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 Sep 2019 09:39:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W0YodeoOCiCv9zmv+-gswuU8U_XgrBnesE=wynTbDBiA@mail.gmail.com>
Message-ID: <CAD=FV=W0YodeoOCiCv9zmv+-gswuU8U_XgrBnesE=wynTbDBiA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 126/167] tpm: Fix TPM 1.2 Shutdown sequence
 to prevent future TPM operations
To:     Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 3, 2019 at 9:28 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Vadim Sukhomlinov <sukhomlinov@google.com>
>
> [ Upstream commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 ]
>
> TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
> future TPM operations. TPM 1.2 behavior was different, future TPM
> operations weren't disabled, causing rare issues. This patch ensures
> that future TPM operations are disabled.
>
> Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
> [dianders: resolved merge conflicts with mainline]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Jarkko: did you deal with the issues that came up in response to my
post?  Are you happy with this going into 4.19 stable at this point?
I notice this has your Signed-off-by so maybe?

-Doug
