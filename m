Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C7C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F2020859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GN7hESkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfDVCa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:30:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39760 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfDVCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:30:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id f10so8476985otb.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 19:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2h6fxVJ6czWNYrfVgyxPegO9tSDmbBJS+wIOKDOIY3E=;
        b=GN7hESkFdAl1JMCkZa8Dbzv2FSR/UtmCFi1g/8vkfMY8YMh8gSIMDRzE9hmGyc9gjl
         vC83ZGGMkmAOiR03hHMt5Oh9ba27nidD/FO8EskvjVtbVyjP2C2gdChGKfszOBO+dtq6
         yoBnGqx+nBOVMZrlTWx7x4KQxtA+zN160j0l9vM6yFaD3AApCgyDuK6RaSXfl0uJFsXc
         jsiHpftyqOee38V1chupnypOPDMHTdd1yafRLuUd/5aTa918tnAEMwm62LytHmJyL66r
         arFkETzWc4ixHTO6Yrq9RVDI49dZgadLMD33Nwz7fbe4C/8nBYL15ZnC1T2gBgIeNJwT
         K4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2h6fxVJ6czWNYrfVgyxPegO9tSDmbBJS+wIOKDOIY3E=;
        b=JqGAbaXjSmd48VAu61S0H52ZfJqIFpfTqpYMBn9RdhaXzJ4ZXjYHZHDdMnmXGawKGK
         YBEQ8Y9IIoD3J1u3Kb6iW4wTbgDR6Q/Kz43+dfCBhfRAjnx7pzHuzWFX4xxlfelmwhpk
         kKjyOgFr1yyiRpZy3DCPfZnoD7oag/NSKMHLt9xXbyIuLATBaRL9jqEb4Pjevd4Hl3Rx
         swNpB9eqr+flBRS7A20U8aKz1+dmqBFQoAutxVHqfwdQh+QHcOrdE7/vNlw/YhEqnph8
         rzN8UYGidmhgzRF18WiTg8Vup6py+PGXcV/emVM7c+TMe893FgMVl0St2mJ2gPkAO55a
         cUhg==
X-Gm-Message-State: APjAAAUe88LjwklHcY9CovBGyMBz3MlgSsUO3P+uGjOSfcDmjUR4vSr5
        4pXCS+vpN3tA6iAMkzketq4Ng1fojA2QunB/cpVogw==
X-Google-Smtp-Source: APXvYqz6747d8EcJc1DQPdXJl/GhJi6ASmu7vRdC/kszUvzupdicxMfEkE6fVJO6oyu5ybdhE8ol6LsEpcVtmveDFuM=
X-Received: by 2002:a9d:5784:: with SMTP id q4mr10609521oth.277.1555900257857;
 Sun, 21 Apr 2019 19:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <f7edc4078b2d6f44ed5ad47c14dd58da5cc50f21.1555670768.git.baolin.wang@linaro.org>
 <64ca5af0373c35590d8ac9f2b62e3c9fa46e3551.1555670768.git.baolin.wang@linaro.org>
 <20190419144125.GQ2803@sirena.org.uk>
In-Reply-To: <20190419144125.GQ2803@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 22 Apr 2019 10:30:46 +0800
Message-ID: <CAMz4kuKd4KF=62MX+Kf9mdNZhGa5zHDq-=2RceLFs-Aiqa3qqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: sprd: Add Spreadtrum multi-channel data transfer support
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 19 Apr 2019 at 22:50, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Apr 19, 2019 at 06:54:32PM +0800, Baolin Wang wrote:
> > On Spreadtrum platform, the audio subsystem will use the multi-channel
> > data transfer controller to transfer sound stream between audio subsystem
> > and other AP/CP subsystem.
> >
> > It can support 10 DAC channel and 10 ADC channel, and each channel has
> > 512 bytes depth data fifo. Moreover each channel can be used DMA mode
> > or interrupt mode to transfer data.
>
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks for your reviewing.

>
> However if there's no non-audio users of this DSP then it's probably
> better to just move the driver into sound/soc.

Yes, only audio will use this driver. OK, I will move it into
sound/soc if no other objections. Thanks.

-- 
Baolin Wang
Best Regards
