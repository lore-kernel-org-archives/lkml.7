Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B96CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C6420868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbA+vTjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfFGVNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:13:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41699 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfFGVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:13:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id s21so2923320lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buV+QOyxzNDlDJH8veXIKdL2iiFBfuvxwZCwvBEfDTQ=;
        b=PbA+vTjbgf9IPXeh/acYRqrHgQ/Cjj1yrQprtGznL/es8T3gCcNRwDa3YZdRJ/uF/v
         32h/I3BSs26eSDvUTKOdMkrK+uYPnnZTsZv5z4EdDPgVzhWZqXBKVULLsGZX0xqNpcAn
         SVhfqA2WQ90XxZnoYxFuvdF0bCBSWXYCLUVaO3+zVqn8HY2gFJ5AzkFFpTp5JR0fU0wc
         1hDS5MjiNH0JecOnCuNnqbqaS88kPpYSRSdW/XiJwMe1fSSEPUqs9fgRQz23dlySJ18o
         CApFNcY1FIynSD0OEVggMunh4iBVIRm6OK6zhhZGMmD3SOfb4tiBA5WpvkZmiUU88aCC
         TCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buV+QOyxzNDlDJH8veXIKdL2iiFBfuvxwZCwvBEfDTQ=;
        b=ShhF39cuiRsC+UMdaocpLVibrB9oXky7EuWPZfyCnElQzBABsHSzxVzbdmBjQKsyef
         vMrNFtJBllFgOfE/dkwhlUCqJbGx4NshX4NtZ2WcJHQzZ8tSX3MP9xAUhymQE2ItEUXW
         fJitE0+F/eXHkRitLj4B+BMMaZK0pOYZxGSD7/kgSZ7SYyG/CuPcl9shKvqkx6BcNVSQ
         O3q7jzJvc+QVAx67xXnyV8keTOEnHNSMztY82hOquTNRHYI8PC+FuYKiTwSLwQems9sM
         dx4Bii6+nrkJaEEIjNnb4fTBbJiO4KS94UfNanjQjiWQVvBQl8CtKvQwl/Df1qk/Tg3c
         2VPg==
X-Gm-Message-State: APjAAAWxJawncKKbfuqi+7wbM2oX25ixTBr0HeymovJVKpZo21J78wEq
        nn8MI0ajD/uV2//xRypmOSP238r4FIyUDtLu09eOwQ==
X-Google-Smtp-Source: APXvYqwcF6ADHtl33t9VDfzL225Zx/JgITfxxEzGI9UwCFCbx97hu3h2mIvOoT6ew9/mRJxwXE0v0pl6avRqO2cwvZ4=
X-Received: by 2002:a2e:8902:: with SMTP id d2mr29179625lji.94.1559942022414;
 Fri, 07 Jun 2019 14:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190603073421.10314-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190603073421.10314-1-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 23:13:34 +0200
Message-ID: <CACRpkdZcwZks6eKOb=Mq1EfCP8Kir+nPC1r9=FrA=si5WpwQww@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: Document drive strength
 settings for BM1880 SoC
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

On Mon, Jun 3, 2019 at 9:35 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Document drive strength settings for Bitmain BM1880 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Standard bindings, uncontroversial so patch applied!

Yours,
Linus Walleij
