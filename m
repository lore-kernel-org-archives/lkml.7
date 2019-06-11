Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E22FC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759D221721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="heQKtZwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408121AbfFKX2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:28:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40833 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404692AbfFKX2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:28:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so7808022pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+oMmkCfixuI/MqPYHub3W35V/q9CnrMMpoLjwoXjlsg=;
        b=heQKtZwm9AYpXp4xFj2WNqLeBV6TSqS+fbbwm3nUiGF0ueyGWMc5iH8uau3G+73CkY
         KJiIn0dJUCjTA1gUeYJv6Tao99oW/4d+ObEIOA+7kczKgDDaIccrv2xK51zkyjOKwlk4
         lyCeKfNvBqg9DctrZzfhfbAjN5WUeZtJjp3OmqUqf0CRhqHjFBFwmnJTp+GeRkc/inhZ
         3Mcm6Wp7bO17hqFK0m7LBS6GgOHYymrU01Sqbp7JriYcorZ/fp8vWhYcvPkz27Dut+lZ
         Dzm06Gd4m6aYSWzrZudV8U3FR0/iZUzyewsMF4yifXMvHHx9ym+jtX0ZdZsk8Cqk13as
         MVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+oMmkCfixuI/MqPYHub3W35V/q9CnrMMpoLjwoXjlsg=;
        b=ljQ4xFGYKn0eRs1yJ5QqFzttgasgGSU1B1GjryHdugTdQnWur1PBzGIlRfsmSKLosr
         4uHGLMcYKMgmc5RjJox4GYv47n1muAhBvGkwth4L8QdxFo9Rs8nOiqmbSGmx4C17yYPr
         RJhG8sg+7jPT8tOfItWeOhazB58IKlUSjVwNS83A1iO6EjA1NKIYq8lNxSgwY4gu/ymf
         cn+yrA9q/jaLf36IbzUTupPqgqE9hg2lFb4OgG+ERgETgaQ0KF/U3hyV9VckZsoTqpj9
         EJ+6RvVhNkNCrkSGn8UULeZY+yZiUloCqOCvmq82q56UxNBS5KpN4WnysQsAQ6VFu166
         tRWg==
X-Gm-Message-State: APjAAAXgOVXCkrc8ld9ApZ/TFKhwsCPPawdIK933KaFCEY36lLRm4EDH
        Fu2PyvfhIOjMcYWgXIsXFv1erg==
X-Google-Smtp-Source: APXvYqyypyOI2ab62NriV/Ikw2ubSujEH42W7AEpYKg52+a33UKb21IRMffBKdbn2eKlFyi34SuhAg==
X-Received: by 2002:a62:58c4:: with SMTP id m187mr25340442pfb.147.1560295732812;
        Tue, 11 Jun 2019 16:28:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id f11sm217738pjg.1.2019.06.11.16.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 16:28:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        olof@lixom.net, linux-arm-kernel@lists.infradead.org,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: defconfig: enable Lima driver
In-Reply-To: <d3275b3d-7b1a-369c-11c5-e62553a383cf@baylibre.com>
References: <20190606085645.31642-1-narmstrong@baylibre.com> <d3275b3d-7b1a-369c-11c5-e62553a383cf@baylibre.com>
Date:   Tue, 11 Jun 2019 16:28:51 -0700
Message-ID: <7hy3273dn0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 06/06/2019 10:56, Neil Armstrong wrote:
>> A bunch of arm64 boards can now use the Lima driver, let's enable it
>> in defconfig, it will be useful to have it enabled for KernelCI
>> boot and runtime testing.
>> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index d588ceb9aa3c..7e9d684332be 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -505,6 +505,7 @@ CONFIG_DRM_HISI_HIBMC=m
>>  CONFIG_DRM_HISI_KIRIN=m
>>  CONFIG_DRM_MESON=m
>>  CONFIG_DRM_PL111=m
>> +CONFIG_DRM_LIMA=m
>>  CONFIG_DRM_PANFROST=m
>>  CONFIG_FB=y
>>  CONFIG_FB_MODE_HELPERS=y
>> 
>
> Hi Kevin,
>
> Could you apply this changeset on the linux-amlogic tree ?
>

No, this should go through arm-soc (already cc'd)

Kevin

