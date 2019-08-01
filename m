Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45708C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEDF206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw4qfwmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfHALGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:06:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34362 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfHALGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:06:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so68948625ljg.1;
        Thu, 01 Aug 2019 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N7392CDQ9zfjrUxB4Vg+yhkS8jE7K94qR1MBvJyxPvg=;
        b=mw4qfwmz8xZYrJPc00J4JqDGE6pehixBWYpv6nIvFF09CkdRnMaUn+n1imnpRbkCdN
         Ufktj73EMntqbgbyakht71HL11R8b63Sx1dqaW7ocEv4bjtQAbuwPZiB4CXRAC0CcFyL
         mH0IjeA1AooekdPH3Q+MouQ8qaksL5fM3hin30cQs5gzFsdenuqTAeNFpLVycb1Mmw8j
         ++D3rNf9LLKvcw5GyBw11CPEN0KUXX3G4wME5XyC+zVknGCcZHZ820LcREytCAGt8lvL
         NK/9emSUGvu3riIwwBdH/ROg4fX3xA+strixte3va3coyrcM5cejxa+nR9AMQoPx8Jez
         hrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N7392CDQ9zfjrUxB4Vg+yhkS8jE7K94qR1MBvJyxPvg=;
        b=maXNp3ffxynK9TrofYDFuBtrYbX61uKu4dQY3CQsoJVqd+4fS7Fy+bJ5GqDlQH4NAg
         PbXGtsVe4XYDZfB0NABAa2pgOVkx/4tqGfaSs/t20vYI9wynhnU/HBCtnjHNp6QfFoX1
         PVgOJE3jomRuxzBkdOUkx+EsssRQR8vH0uz8oJPdSsK+cI7aGcEMOfiJEZN4x3n9r3OD
         WaOQXglI8BiT2dS+a5RWn8IxQcno+l/Or9wci+Nkh9qXArGisnROgnGC2Z+WjBVcTCSF
         SpdfdX5J0JXbks5TqkAxIvCj8Nsf5rs7jfqCA71t2/WrHs+JmkrutqQSjGUftFXdacy4
         TFoA==
X-Gm-Message-State: APjAAAWb3HC+xhPppzfVByfQBFio9ytGXmWKpc0lUXtlJgXNTzv8m+7j
        0WliigY7AAQ9GSC/1B+vj6W9vJjm
X-Google-Smtp-Source: APXvYqxtLknd8NG+sh0zdTpDwQghnwIz75aJd9vr4Xpklx1kcNOtOj+m1rkH8GI2ZbAgkBhixc/l1w==
X-Received: by 2002:a2e:b003:: with SMTP id y3mr68401618ljk.72.1564657569627;
        Thu, 01 Aug 2019 04:06:09 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id x2sm11756651lfg.12.2019.08.01.04.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 04:06:08 -0700 (PDT)
Subject: Re: [PATCH v9 11/15] dt-bindings: memory: Add binding for NVIDIA
 Tegra30 External Memory Controller
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190730165618.10122-1-digetx@gmail.com>
 <20190730165618.10122-12-digetx@gmail.com>
Message-ID: <7fa8dd9c-1298-9a52-2529-86285797ab0e@gmail.com>
Date:   Thu, 1 Aug 2019 14:05:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730165618.10122-12-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.07.2019 19:56, Dmitry Osipenko пишет:
> Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
> The binding is based on the Tegra124 EMC binding since hardware is
> similar, although there are couple significant differences.
> 
> Note that the memory timing description is given in a platform-specific
> form because there is no detailed information on how to convert a
> typical-common DDR timing into the register values. The timing format is
> borrowed from downstream kernel, hence there is no hurdle in regards to
> upstreaming of memory timings for the boards.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Hello Rob,

Are the device-tree changes looking good to you?
