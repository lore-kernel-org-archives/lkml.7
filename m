Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD75C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C0214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJuAtUUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfHALLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:11:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41340 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHALLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:11:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so68939362ljg.8;
        Thu, 01 Aug 2019 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K8e4hrDcsp4be0Ory1S+uKZbjey4PHhTQwgmYUnn3bQ=;
        b=CJuAtUUyxHmGNcvqWCtDUZe66p46usUOJRNj1NMEyZzaJy1o5StfVJazYYI13FVMtW
         MSt4uHOFmXbl7mp1p2I5BjFTdKoKAst0nCrWqXuUXCyk1olBcKyUIZTaBUTeNK6HIr+g
         htwigO9x8s4cB5o79esjbE/MCuRp8svV2xX919qCjEa4hnde6M9ODfs1rdA2A8oLooqk
         netQ/Olv9nCI+N/3oBpVBk+yCn+6YLiSyTfsEZIYbHj5I+W+xz9v9cDz00GXqpcZHOA0
         U876fVhjeWW/PIixTRqfVjifAL7a4njO/d0n8IxeUsJNI1p11g8E/dO4UHUEpcDdyOuu
         vMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K8e4hrDcsp4be0Ory1S+uKZbjey4PHhTQwgmYUnn3bQ=;
        b=CmBsf8ov2NnTyN+8GwEpShUK/jwyZRICQjJBZ1kiXUwKiZZZHOW35UnnLdNr4HNhv/
         KKceSgzVBUNlqeGvdRfLe8Gj8sX2IyKQUEeFhiVfEn2SACDg+8/Zudyj4VYCE0uX/BPV
         HoNgjXJVpJS/xfNhl3KdRJ9EYMAn1j560eh8g83R1eycU+vEVQrb21K4oyxXzHLvhHx0
         61eq9unhVvK2I2+TL3AVU7IkflpLEUq6mCbH2QPAsLDCvlNcOux/5kNGjVQ3tSpVfjGA
         8DYwjsjaacUbMd5VcuN9HSLR3AiZlgTjlAC3MZROwWgP6BLRx42EBDvXmFFp3CqLG3nm
         eRNg==
X-Gm-Message-State: APjAAAVIkndf/ItsAzkkf2QMd40bDMGp7kd9t1BYqGPa3dqUnQVk9ggE
        7ESWTW6zTpNQlJRhCKAMQynZ/4UO
X-Google-Smtp-Source: APXvYqzkr+8EzGVav0VJvfDyIm0X2edu9GsTb/z7LUFnd/R5ZKRDADrd3k6/jDvjQlLNnNd9lQ8y1g==
X-Received: by 2002:a2e:8802:: with SMTP id x2mr47065479ljh.200.1564657895466;
        Thu, 01 Aug 2019 04:11:35 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id d21sm12194718lfc.73.2019.08.01.04.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 04:11:34 -0700 (PDT)
Subject: Re: [PATCH v9 01/15] clk: tegra20/30: Add custom EMC clock
 implementation
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190730165618.10122-1-digetx@gmail.com>
 <20190730165618.10122-2-digetx@gmail.com>
Message-ID: <ac9a29b2-d65e-9b20-ff47-c9e5eacae31b@gmail.com>
Date:   Thu, 1 Aug 2019 14:10:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730165618.10122-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.07.2019 19:56, Dmitry Osipenko пишет:
> A proper External Memory Controller clock rounding and parent selection
> functionality is required by the EMC drivers, it is not available using
> the generic clock implementation because only the Memory Controller driver
> is aware of what clock rates are actually available for a particular
> device. EMC drivers will have to register a Tegra-specific CLK-API
> callback which will perform rounding of a requested rate. EMC clock users
> won't be able to request EMC clock by getting -EPROBE_DEFER until EMC
> driver is probed and the callback is set up.
> 
> The functionality is somewhat similar to the clk-emc.c which serves
> Tegra124+ SoCs. The later HW generations support more parent clock sources
> and the HW configuration / integration with the EMC drivers differs a tad
> from the older gens, hence it's not really worth to try to squash
> everything into a single source file.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Hello Stephen and Michael,

The clk-driver changes are quite solid now, could you please take a look
at the relevant patches once again and give an ACK if everything is good
to you?
