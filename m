Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC459C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD31206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znJp3nwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbfIPW5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:57:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44457 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387505AbfIPW5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:57:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id q11so1236457lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laPzJt3OJIMvrVA37EX/dFU7vRHt+cwZVws62wvSA/w=;
        b=znJp3nwhbqMBu2QAKp9RYV3SDs8zPy5m34NCexeUJEAQoLYKVghX2NFQ2jnPfGIU40
         m0AAW+8gNWSBtJKDa77UnZ8Je04DN1fvW9oL4xItbaQXGhJRvk73Yq9doB5D7vjqxEzF
         ePeBLRHPCA0eIzIWaloUSAiJHybpqSrsp2y6sRMVo2xbHspDrz8ML0SMKAxR1f8Z5KNQ
         7JZV9Tr9X+pvJULaVf7lAPwmoJJ0VTkArH0vxrPdVudyqY6uCayF2nGuZO56OMZEFqOu
         e1aGq9wrtO0/xNZ8RiheEcPzTQC86IICadwUtZww0F0M8S0WQx2dWHSzwFsJWb+KQUG6
         2uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laPzJt3OJIMvrVA37EX/dFU7vRHt+cwZVws62wvSA/w=;
        b=cYlMQ4SHKe9BcoldL8bD3yeOLSs1NVvbiF0DhXsiwmFvN8s8HVWkRLLOIz4C+M6YtM
         oAtpg0GCSO82M1Yppla4Or7lgF3aXgVEJdPx5C5GuGyO4i2dUPtJ7mf3m5gXPdJEfVw2
         KtpqaI1Awqb7O+OEjdETpYuj0PmbLR0Wwqzwqqrvsn/OZQFrRkHj1hJ7PHDlfPo1jqvI
         OjT/NjF1nJSTqoQOFgEEE/kjxt+L7k6TRzea3BTDsrBdacpUfSNBLELwu9lVfDxZvDYM
         f4jRinMNHeyNQsvyI1wOpzE/ctf3IxblbYA3YhMZggOlz5H/890sw3p0sOR/SRLkLlyw
         Mo0A==
X-Gm-Message-State: APjAAAV5F480oINTkHfoUEhEM+kjYWfhNYU/lrsOn82IT/53wR2UnnlY
        WLZ7gB6zJeAx+rh2cGLO0KFl08JdBXsN5VbTFABKIQ==
X-Google-Smtp-Source: APXvYqxGugmI/q00XRABn7wo1+xpinSyI8nPcr9dZ0fY7WFEmhoKKmYDwsalRoHPv3m8HXeSHBXbBXgJYckrJpHoqR4=
X-Received: by 2002:ac2:55ab:: with SMTP id y11mr284333lfg.165.1568674673341;
 Mon, 16 Sep 2019 15:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org> <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Sep 2019 00:57:41 +0200
Message-ID: <CACRpkdZC9t-1ZtFzn=4tyWjVteRog6M=VDb5Y+g_3qSfVO_epg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux-actions@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 5:46 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
> controller.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Neat use of yaml!

Yours,
Linus Walleij
