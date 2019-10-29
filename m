Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68BCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726622087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBYMwvi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbfJ2NUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:20:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36384 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:20:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id u16so10506793lfq.3;
        Tue, 29 Oct 2019 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ycp40O6pq7oAPfIa/Ey3geraavSMokBe/2ZuTNhAq48=;
        b=GBYMwvi1AAjVv9WA8DE6sfQWAApsDUxppNZiU7BA4qAHmdpjh5eHmqHjIJVGeTQyMu
         sBYua5PI1jpbKW7gk6C2b1wzabgczcqqFkCXuMku9iAQP+ds9AUw9nfcxZuepeB0DiR6
         GM9/+5c+iTjz8/SXStWWPTsMJGvECmp91y78oZjKibNH/gWYMOx1n5aRucp44RmkGDZb
         bkSWSyKfXKlniDQ62h+SJQuhEsKBOeLvu9iGjpKsrZWOLX7VKv9H9C2UasGFFqhNasMK
         aUBHEJHzcKPM4yZ3kcZD6j4WK4BBNMXxYRNtumlCz8+Nx/D8CQjyGludgJCo/knj/XBv
         OHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ycp40O6pq7oAPfIa/Ey3geraavSMokBe/2ZuTNhAq48=;
        b=CBUphTg8BRZYKgfumnA37/VPQJu3S7MSQsz6x6hPH6+APFA+zxNm5AyDoq5SiHPUef
         uCNh6E5lF8tZzuwh+IjKSNQOIVUTtuQTOFeNwddDXGBw4hP1Vj2FqL/awg0ouC1Lcsn0
         zH7MfRG0RebDblyIdiI7d4oDmxcwWKVVpfc4S8UsXh7HHYPs31iWh0y2t7UqyeofaRvO
         vk5+JUHVJ13tNLFcY7Yp/gouE3SaEPSX4qGO5EGsje++YQma+orM6iSw7XNhMVL91YfR
         x7wuIApVnWV99NGPB/IDQa0u+nAFnxypO9rgqCZyVca5f4AkqZrREGXUKS/NRt1RDQE0
         jYYg==
X-Gm-Message-State: APjAAAWtweVNyHmkswBOGzyt9uqnPrxUdAr6jjKg3M/a6fYW0C2Z06PV
        ct9LUIwGjTELZC7UR3/SARaewrjw
X-Google-Smtp-Source: APXvYqw2jGg9y5zxjv7afcepJps1o1UY+IMIRxfhjR3+8ctUUYRocgcNcnwvmYQhdSSlRIHBtKMlgw==
X-Received: by 2002:a19:cc07:: with SMTP id c7mr2512443lfg.107.1572355238190;
        Tue, 29 Oct 2019 06:20:38 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id w20sm9203418lff.46.2019.10.29.06.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 06:20:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clk: tegra: divider: Support enable-bit for Super
 clocks
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190723025245.27754-1-digetx@gmail.com>
 <20190723025245.27754-2-digetx@gmail.com>
 <20191028144157.GD27141@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <74ee0e7f-c257-8fdf-bf3f-eefab3281dfa@gmail.com>
Date:   Tue, 29 Oct 2019 16:20:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028144157.GD27141@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.10.2019 17:41, Peter De Schrijver пишет:
> On Tue, Jul 23, 2019 at 05:52:45AM +0300, Dmitry Osipenko wrote:
>> All Super clocks have a divider that has the enable bit.
>>
> 
> This is broken to begin with. The only clock of this type in upstream is SCLK
> I think. However, this clock is not a normal divider, it's a skipper, so
> the normal divider logic doesn't work for it. In practice this clock is
> only used when scaling SCLK, which is not (yet) done in the upstream
> kernel due to the complex DVFS relationship between sclk, hclk and pclk.
> A driver for it can be found here:
> https://nv-tegra.nvidia.com/gitweb/?p=linux-4.9.git;a=blob;f=drivers/clk/tegra/clk-skipper.c;h=f5da4f6ca44fe194c87f66be70c708e9791db74d;hb=eb8dd21affa2be45fc29be8c082194ac4032393a
> As you can see in that tree, we eventually splitted sclk into three
> clocks:
> 
> sclk_mux (controls SCLK_BURST_POLICY register)
> sclk (controls SOURCE_SYS register which is like a normal peripheral
> clock but without the mux)
> sclk_skipper (controls SCLK_DIVIDER)

I'll drop this patch, thanks again for the clarification.
