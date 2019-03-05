Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B18C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1F02082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbBItcwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfCEHzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:55:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43600 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCEHzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:55:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id z20so6717226ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=El5/IOpQW3DaHrXc6Y6xm24wKtnN6rgAAQR6xTcsMiw=;
        b=TbBItcwmkvQ5nCLng3GfkWi2VaDC51ljF7/9s7G+HE7gfdETNNlpZdz/8il73N7EZR
         7PgBy5b4BRwCubyJxbkEvB3QeXI5wTch5Purl14/4m4wLmm/CxtICavycenDcTPGHGEb
         kOGCdbVKINa8/s3QpRggX3VCpw6f00trELHKbIUF0/34gfzEUxvRkgwX5Mr0FT23apI2
         horCUJ03ct95qONuKkki+QNIQHfqR/RgbmfKJmvdMA/UobptxQvqTb+xsjeRH6ln/BzZ
         pkCaAK43cvydelY3+NQC30lMCHW7z0tGO8pSmzy0KupsQvwuhCDcRsNmAtwhO1Frc4c4
         w8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=El5/IOpQW3DaHrXc6Y6xm24wKtnN6rgAAQR6xTcsMiw=;
        b=ZjF3BKyDZO9aHN2DOZ+/SMYtz9wDRNZ9P/qzx3YJCYbFtMNgFgZGCA9llS+HxH3p/r
         NO8vAjhA4rpydE2RRjvrnWc/RW7eM4gLaP4FeDu3dcnbROMoqgjDvUDYFzT7GY2A5aHV
         XvFsJPMrcD+mQTmIt0hTUO6LwWi5de791LUD7q725nB59bhZ5HjrGyhp2B//QyGT+Zvu
         OIs7VnHGnhjf57SnVuPVgPJpEdafk38l55PwoK9T1uNPN2ZA9BXjGYzw3Dn1GbChBa9G
         SQTx8lrlr/nMupY+BIsZQ2Z8RHrzPT87c1bEEjypeN4fDuV10/mZhUT2dwjKbmmVTOmk
         8I9w==
X-Gm-Message-State: APjAAAXEfey34gcXj8K5DSlVh31FspTNkSLMf0inM3j/9gcAhDV11/BF
        a2chiNIWfMyClBZFyzx7OT77Ap6EMHXXAtln9swgeDqc
X-Google-Smtp-Source: APXvYqxcSz1a6vx9SQwewBsmnPctK7bVZz4TAjIrufkepCp679KmhJYir0Z+UQYZ277AVnk8+EniOZqi1+2vaCn8CaQ=
X-Received: by 2002:a2e:9217:: with SMTP id k23mr3041728ljg.159.1551772514158;
 Mon, 04 Mar 2019 23:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Mar 2019 08:55:02 +0100
Message-ID: <CACRpkdbzhAZUjJYLPnaoOsWzHNXzPGvxYHz0b3fZGd38e_i-dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: bitmain: Add GPIO support for BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:50 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add GPIO support for Bitmain BM1880 SoC based on Designware APB GPIO
> controller IP. IP exposes 3 GPIO controllers with a total of 72 pins.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
