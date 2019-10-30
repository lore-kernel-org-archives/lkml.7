Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF6CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A6220873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8p3TGCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfJ3W0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:26:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43847 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfJ3W0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:26:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id s4so4434703ljj.10;
        Wed, 30 Oct 2019 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ghyKzMOt9noacqcW8gijvIBX51lIWlQ2FC12YmCxtvQ=;
        b=P8p3TGCy8MV1WlfFblsWQyXzqgtkUuF8eoQE8T02IWdtjfi22N4gyn720vMo//QKEQ
         w5kXkpijc3XFD1OQpXnmtxZqQa0kdFqv7Dm0mm1q4wmGYLrwp3V5PEHOTrv/auteZs19
         fSTD87LuiG0fsjhKpRTC+xcBPKKDoXP9XjuAny8X+1R/aXVir8oBfViVnv01uv94yWcO
         yx8d2JeqK9utaXL+rSBrE01+y1oxUJ2Mm+zK1DEAOmVvr7Vtzw4h0DvtGNa7ETzEbIJZ
         gNcb5+BTIwFA+OsVB2qwv7pqduJv0ZvTxyxvP5G8x9/JB1y9JScpVSrnOtRz2hJzXkD8
         rUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ghyKzMOt9noacqcW8gijvIBX51lIWlQ2FC12YmCxtvQ=;
        b=qO5yiVGh/W6RC3giileWFs9dr8b8nL8olbC5TgNhQu4PcvjjxDWSiqAy/BILoW0Y35
         avcdcnmByyaQbzoSC/Obc23wFQnXnFSUpDmMS6kamb+YGLMLBi1C7gdNfXry70w8URRS
         +S7AiFtuvzeDfYOFuHBT4uW1Y7Ta+F7XBc9HIIqG0FhmWcbrmnvIfEVAyGivyqR6+xVv
         hUxLFZm7JD8CRtor1vYQbD/n3ehvjIHM+voVfwmkDz9iXFbGS8ngWE7GfexlJ1GHKNf8
         3ztfT0JNtSImqB13MMN3gQCnYnuoQGW7xN7gWhg8m01kG1gGn4GzzrEAKCpGbT2xu43N
         pZpg==
X-Gm-Message-State: APjAAAULExtgXV9J594wbNYoc6Ay1EWnwZgDUgW9TlzZ9NiEFS+/42d2
        eM93N5Ld2SC9mjp3izBnu9g6k34I
X-Google-Smtp-Source: APXvYqxKePoldR1zNVEQWFMsbOhcscgsBBrkafCI669vkMg6MuihGz3TFUtR0jB78Klpzab6EvBjiw==
X-Received: by 2002:a2e:3919:: with SMTP id g25mr1392037lja.232.1572474373677;
        Wed, 30 Oct 2019 15:26:13 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id y189sm1010882lfc.9.2019.10.30.15.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 15:26:12 -0700 (PDT)
Subject: Re: [PATCH -next] gpu: host1x: Fix compile test failure
To:     YueHaibing <yuehaibing@huawei.com>, thierry.reding@gmail.com,
        mperttunen@nvidia.com, arnd@arndb.de, seanpaul@chromium.org
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191030135458.27960-1-yuehaibing@huawei.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <283304d6-bf23-8107-29b6-9f3e7dda943c@gmail.com>
Date:   Thu, 31 Oct 2019 01:26:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191030135458.27960-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.10.2019 16:54, YueHaibing пишет:
> If IOMMU_SUPPORT is not set, but IOMMU_IOVA is m and
> COMPILE_TEST is y, building fails:
> 
> drivers/gpu/host1x/dev.o: In function `host1x_remove':
> dev.c:(.text+0x624): undefined reference to `put_iova_domain'
> dev.c:(.text+0x624): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `put_iova_domain'
> dev.c:(.text+0x62c): undefined reference to `iova_cache_put'
> dev.c:(.text+0x62c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iova_cache_put'
> 
> Select IOMMU_IOVA while COMPILE_TEST is set to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 52499a6ad2ae ("gpu: host1x: select IOMMU_IOVA")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/host1x/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
> index cf987a3..354232d 100644
> --- a/drivers/gpu/host1x/Kconfig
> +++ b/drivers/gpu/host1x/Kconfig
> @@ -2,7 +2,7 @@
>  config TEGRA_HOST1X
>  	tristate "NVIDIA Tegra host1x driver"
>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
> -	select IOMMU_IOVA if IOMMU_SUPPORT
> +	select IOMMU_IOVA if (IOMMU_SUPPORT || COMPILE_TEST)
>  	help
>  	  Driver for the NVIDIA Tegra host1x hardware.
>  
> 

It should be better to unconditionally select IOMMU_IOVA here.

The same could be done for drivers/staging/media/tegra-vde/ and
drivers/gpu/host1x/, please see [1].

[1] https://lore.kernel.org/linux-iommu/20190829154902.GC19842@ulmo/
