Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A50FC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6510721906
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9rs+Q2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfDNP1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:27:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41138 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:27:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so7378950pgs.8;
        Sun, 14 Apr 2019 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q3iypn555McbAcE3yoICWRpRh2ucW+vk+bBTuDr2NPw=;
        b=p9rs+Q2gjsQDNvfwiJiNecaGCCI3naRVRc2PVKa/VK+na0dJKcbwL4qVTWb/ipeUHq
         Zex9nEzzKBvstN87mxckK25z+2iF5h/kgZbuhtPLM5ln61tOwhgTlXkgYTrrYv0FrID/
         yYu5d4hYeynlQciUWv94JC5rguc29d0Gph6I0bWBMk4Gu5xXa/iTBlSFUN3hG8fQAoj8
         2PQuHz2DVPGPRcYzO6bBNFqHk1HYATCzShGtw1EtbmRP4kfCSFCqZz6S9nXfzj4CjdI7
         IQflaSs8xNb+YavTNAH5joAwZ7CqwR7K6VH2FbCjY6+Sq2SNilzY5rl3boJ1tn0vYJ+Y
         bfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q3iypn555McbAcE3yoICWRpRh2ucW+vk+bBTuDr2NPw=;
        b=rYUWVKIOBVKLiumXBYM4ApbKWpQwsv8Ng+y8ZWH07eYvjOEZ3xR1QpTLu6Fr+IJgxZ
         +lYwqxyCSQ1n7/6BgooEVyoBwvk68QqdIi9n0i2uf1a2tPKGov6yW896BP1J5hVBKko1
         iHsyBV3XHzT72WaYBIqVLIlcZDY+f2N0lg7ZfR83yOLQeI29RC6tiGdE4T4Z2YONApnl
         vudxqHcU4UR1PpWKO9eLoFIQLfFfZXWfTB/wVpJefa588QXq++Dk2ET9TLGLvGzTm/bo
         3XEyTMQk6jKr+rZiUjTCw4VtH9sQYYhiGQtw9o9GCZHwV7XbuLzPAB2dkTUWRph1Yrg3
         ZqNw==
X-Gm-Message-State: APjAAAWwQfC6h8Jm7QMx0YziT4USqKuIYWWUFOdAe4ynQkw/tKnGPSEF
        6rPkqyuRpAhaUPqA4BvGiKZzHm36
X-Google-Smtp-Source: APXvYqwJg+x21fjQnaTcn/dD+rZg+5lB0fYmLq+FpegpSPcklW48PcN7k65OExA3TDs0ucanv5+p4w==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr70308664pfh.165.1555255672205;
        Sun, 14 Apr 2019 08:27:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id c18sm123252663pfc.0.2019.04.14.08.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 08:27:51 -0700 (PDT)
Subject: Re: [PATCH RE-SEND] clk: tegra: Don't enable already enabled PLLs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190224153222.8142-1-digetx@gmail.com>
 <b64760b5-0d37-ae05-9c8e-9e6d47293c92@gmail.com>
 <20190304081857.GE21084@pdeschrijver-desktop.Nvidia.com>
 <9171e4f6-1ede-ab3a-caa6-83a2d9033650@gmail.com>
Message-ID: <45e82026-3240-1c98-758b-d41fcc404377@gmail.com>
Date:   Sun, 14 Apr 2019 18:27:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9171e4f6-1ede-ab3a-caa6-83a2d9033650@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.03.2019 16:42, Dmitry Osipenko пишет:
> 04.03.2019 11:18, Peter De Schrijver пишет:
>> On Wed, Feb 27, 2019 at 06:15:04PM +0300, Dmitry Osipenko wrote:
>>> 24.02.2019 18:32, Dmitry Osipenko пишет:
>>>> Initially Common Clock Framework isn't aware of the clock-enable status,
>>>> this results in enabling of clocks that were enabled by bootloader. This
>>>> is not a big deal for a regular clock-gates, but for PLL's it may have
>>>> some unpleasant consequences. Thus re-enabling PLLX (the main CPU parent
>>>> clock) may result in extra long period of PLL re-locking.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>
>>> Peter (and everyone else), yours r-b and ACK will be appreciated since you kinda already took a look at this patch in the past and were okay with it (IIRC, we had some brief discussion on the #tegra IRC a few months ago), thanks. 
>>>
>>
>> Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
>>
> 
> Awesome, thanks again!
> 

Hello Stephen and Michael,

Could you please pick up this patch to get it into linux-next to get some more testing exposure before it will hit upstream? Thanks in advance.
