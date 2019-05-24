Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBEEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C369D20673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zadfwpf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391344AbfEXLws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:52:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37053 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391235AbfEXLws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:52:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so4801ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0Kts/0fjXS1PAYHGJKdlU6se3KA5XKc0egkbyyI/dg=;
        b=zadfwpf6mMh8AzqN6OHd8hRdjnqFMxEX6zMtMQo3Rf7CsHiESKkYa2RFtfnG16tsx4
         TIDu1DesFaUFM3gimkOQDcb2K8ZC0R9Q9xABtgGWuMRdpfaq2mRNbzI/NCNF8qkCzt8/
         s6iHDRKSk+WAko+qOj/8Ms4xEaYSg22u6soAnT4W4QvYijEAOiOGOPNieNEtG8QPb7w/
         HkN2X34NymvS9+kKXXVhxh/Mbz3bBWwRBWmKQhGSPnTBpfdqEWCP3+wO+sOgsKXBKfGq
         EfjqfZv1uzj2dZIHXlYSO5z2qyrHeAdO/EEdSKIv+O86wHv0U57qP7uDU/L+nfX/u91J
         oayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0Kts/0fjXS1PAYHGJKdlU6se3KA5XKc0egkbyyI/dg=;
        b=U6Tb24SuO4JTHJXnIxKIR6E6Tr5JpciJjc4UvcYymOxpFqmwyHhlAhNERh/i66INdw
         F8o5d1nnKEJY8PcEDBOAMqYqU/FNUmDC4N24deHICqbBqNmkSe+QiyubPZ+BAMjTuhFk
         MnxYj8AW7GVE942TTJGS53A2fGyUtZ/THlFl7Rp8i1KUT/Xd4h0fp0bo2ai0OXWHI+mY
         LfPJFFSOzJSQ3LhAFwxr1zlQaefLclJ9sSVh6I2LpET7BhcKR1Q258nBM7L0OuGCji9I
         Ei4NCgXkCEW/w5UDg3+aE9SqHjvzIza3sKdI3dg1+qFSPzGSiaFUNIpVp1Qu3Ljkv2Tu
         FZhA==
X-Gm-Message-State: APjAAAXqRKekdjslrAwLGjm2rPKt0f4F2uXLBf8hzBpj1sZjsK+ejCMa
        FnUia7rXax/QWbCvaqDEIi3gmsuN0Ai4K0/tTyPzcjvT
X-Google-Smtp-Source: APXvYqzLxiN+avbq24R1b9TWzEF95PSP6H4ILV+zwdhuAGkfwsLyWdUlcnWC3l/I4iShVVyAItRPYEgwEsqo8Dp4H34=
X-Received: by 2002:a2e:9456:: with SMTP id o22mr2636564ljh.56.1558698766270;
 Fri, 24 May 2019 04:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org> <20190520083101.10229-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190520083101.10229-4-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:52:34 +0200
Message-ID: <CACRpkdZUR-8Q+tD3szv+=QBJ3h-Mdue9ooj_OY-NkL4MGt7YGQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] pinctrl: Rework the pinmux handling for BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        alec.lin@bitmain.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:31 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Rework the BM1880 SoC pinmux handling by removing the
> BM1880_PINMUX_FUNCTION_MUX define and merging it with the
> BM1880_PINMUX_FUNCTION definition. Since the PWM muxing is handled by
> generic pin controller in the SoC itself, there is no need to have a
> dedicated code to do the muxing in PWM registers. So, lets club all
> pinmux handling in the same per pin mux handling code.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied.

Yours,
Linus Walleij
