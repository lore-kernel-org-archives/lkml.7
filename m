Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BC2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB93217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9Vw1S7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfDYItD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:49:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32812 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:49:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so16888499lfm.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OL4rC5xbRXLOGAFn0UftOkSBXsoaN026I5KwUXfaRo=;
        b=H9Vw1S7Yvq60L61Ql6+a8Rg2EXu53l+JSupAwIYXFEjIAZyZJwl1o/R2B6slvmnyFL
         0Jn8eIezCtZn56p+BHaF1x78rr7Zdq+Yvln64cSOQRLUCteSOEfYPTjFlGpS6Emeyw6G
         kMxp/4zlFTAZmfb/mwv1CUtjxvOpFbsZCVbGclvvXDZ6Pik+ivEk4IEYVFsAKiyYyofH
         6zA3L5HWr0hQwz0++79ZvuREPb5H1//xS54+t653DVBPJH9VhfOI5njeTqUzlV3r6t1s
         U501Gggd5ilzxNG/cra0oU5Nh62wvRR9zeCP/O4Fmzv4TufIOkZTtDi3fPqi0rfJ9FDz
         moyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OL4rC5xbRXLOGAFn0UftOkSBXsoaN026I5KwUXfaRo=;
        b=RHKfLws7RnP5GkxI4lXtCEM8mYFT8IvQTkRQzHc6kzxCAJ2dY8bavYB998ulBmyFwK
         nB8Y+4ugGL2veQwqqt3IGocH6DWQ+WiFQb1s/JwJqv2DKnGaypWekuQxJ0ZC0NAWLGQj
         B0U2JiIqnCpYfKu2Rr+JgOWHNuph5rIC1u+Irlx8APX25bnOt803qgtZn56YkTbaNfk7
         aQWPDzoJbIjvD1XXCn7G7hB+ddyDR3LnLUl72kSEEP/sMRvH0ngjvPi9G3e1Gkp3enQv
         orkeu2OWcdd9K9sUYVr1vvaJjNUOi3JZJrQEuuqNYZ+W5CIhMHt0ZXd0iducO2Wz3mlO
         1HyQ==
X-Gm-Message-State: APjAAAWlFoD39FffOvX7UVD5R+jIsmcEQ30qHGSqHJXDv6WRqQEUnUc/
        B+J/ejdQExVwiigqnIpX5nosUnje5LFw6b+r/EZKOg==
X-Google-Smtp-Source: APXvYqxBVlMEEopmli/2w2NRLFpha2CSv00c1M/g/XY8Ssk7KxFHB1WXuKaJrLgmbyealpTvggTRQRbbkzQ4bD34WZ0=
X-Received: by 2002:a19:761a:: with SMTP id c26mr20021801lff.8.1556182141279;
 Thu, 25 Apr 2019 01:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org> <20190424120224.22660-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190424120224.22660-4-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Apr 2019 10:48:49 +0200
Message-ID: <CACRpkdYPU-y231Bd1ugfjkeni3ags+SBWdBNJd23gasdxSsWFA@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: bitmain: Add UART pinctrl support for
 Sophon Edge
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

> Add pinctrl support for UARTs exposed on the Sophon Edge board.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
