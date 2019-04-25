Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A052C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DD3218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0pPktUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDYIse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:48:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44859 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:48:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so6937685ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMr8bu5kl5BcuDVONmGfFOjhUj3h7CSULUX9UnXjHUA=;
        b=C0pPktUnyqduUGe8cPB/Q4nL72VxaNffrr+NhYVICD+TZEhaSULBaYM4f8tKQPQzNH
         cfvG/WfXCJofJte8uHKpERjxNL8N63oYQmOTAx0HqU5vgy0JRo1WsrxAvZa93fQIRT6n
         UBthNqtrMCoAbHg7Hur1a2diLuFvWcpNnT9zSWSE8Rnq/zRdshCP4pmEW5THXCVRkeTL
         Uw7TLqWr5iwxqgXbwUr9m4gn2NCCCq6sQKZAI5aBcuof5bxsVOEhE99nbW0PvYLsrWPf
         KSFfd7fMGUemPDjrOCL2Qthb9I7avNks0ko5wnQAwsLbw97ADCkE2/VBrNGkqJ2Hng5q
         A6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMr8bu5kl5BcuDVONmGfFOjhUj3h7CSULUX9UnXjHUA=;
        b=TqHg7ip+rcPvIz0jLVLyEuhIaA4Po/jsHLcJemnmCqYk7gEajN8DWJMZ3Q2C/oO+GD
         IkwgROTEb4AKtEJEMv+bE/cDQtjLIN71wXVMhV0HCwE5d97/zSwYcjVKiDhYVbDdZdW0
         JIYP2rFyYabtq4JKUecpct6p5gN/5TExC6Qob26nHbx9Xu9MYLqW8jZUc8fgpMtm5JfO
         zite8wvnXHVbpPP6lEHpnOgRfuL1bTtUwiLk4zfSRHUKf0nQ2AmoHnVRyVaKUMWJ9qwa
         9C31ht5qsMj87/8ILqBi1W+0F1dhag6eW+ShF6x1GsM/f9Rzvfy3ccLE81aCKkQaOj53
         nGag==
X-Gm-Message-State: APjAAAVDDc6MUyfQJXC+epyk4zcmaAF2ri47yW+qL/Nqsry38HvKhML+
        DPnu20VwxiV0uEFwNa5zHmY5Zqtmd1jUFfBdfoOo6w==
X-Google-Smtp-Source: APXvYqzKtIoL/f4WakBCPUJKI9REJmMR16Ho5tei/70YYa5QkN+9FnG19pd0Cr8GwWofrhKhdPLaO3db4thx6yvoUG0=
X-Received: by 2002:a2e:8703:: with SMTP id m3mr19386715lji.107.1556182111810;
 Thu, 25 Apr 2019 01:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org> <20190424120224.22660-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190424120224.22660-3-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Apr 2019 10:48:20 +0200
Message-ID: <CACRpkdZW=3muxWNnDKDnBFroYD5ZQWGqmw23o8ZFkf4+Y6DjCA@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: bitmain: Add pinctrl support for BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 2:03 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add pinctrl support for Bitmain BM1880 SoC. This SoC only supports
> pinmuxing and the pinctrl registers are part of the sctrl block.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
