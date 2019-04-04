Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C25C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF2620882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SZHu3Qz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDDI2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:28:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39793 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfDDI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:28:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so2555725wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v/7hDVVq0c79F7CqrBEOQ+MVHIF0lrBpWK8mMVV/3ew=;
        b=SZHu3Qz5UPw7/NFXDE0vZmCJxEsoy1LHLLw2izZNR1Q8FdtzY3tCdqfdnDQrUkt3lf
         bNNYzwQiIzkEogO1ekREcKb/0dAaI7uuCCnBQHD0XLaP99I0HsI6PTXduJA7GjWDIeBK
         weQr663dHCMAYatnVLBIg0wb0bLvk5zbVqaht24VCo36lMkatdTrJ7zbf79yAw3THB3m
         CupX5f/KOuQuoDlUjFKaNgobXzfBCe04DpBPsBsYYXIJK8LO/Xfk2TmC1xl1UQ9+vD8H
         59W62g8smaawOVnuWVDdjPDCbTtNVLvYR7Z117CMjpBqq3S+lbd0SU5Dy6bQca7MA9Nb
         MoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v/7hDVVq0c79F7CqrBEOQ+MVHIF0lrBpWK8mMVV/3ew=;
        b=bvA2I0ZTWRTlNSkAQSE5qRHOsPKEjHape7csy14PZeXkwCi8lHheCWUneQzjbdwT99
         pu8wjVcp4c9FLk91CIwTXEAWBlQHSP8PgUCMD0LNYHJqiXAKtf7Psz2f6ETpT4GjIQIl
         xiRjo45+9FUfEvLEbpkaVc6P6PcCj1jiTHwrTvsJ7sOflw1BO1/G7myTZ9nyEuCnrHZn
         ivrZHv4E5kE4M3LhiYxyNfgLQYzB4fiuDdjCI+Wgl9aXCOk7z36mtYRYS4LhkN4bHzw7
         Vpy22MP41/DmHOQGDLDlQh6G0V3GRP0uYmtCe0jER4oJ0x4liOyEvUq+sQO1DuCfoz9l
         PIjw==
X-Gm-Message-State: APjAAAVJvsHP6uFiO7IdcLFfZb+N9VcyaGLCXDoL+wOnpUb0ykDYiupC
        u7BX+1R0SLHNuZjQMPI0A/1G53hDgIDZhA==
X-Google-Smtp-Source: APXvYqwP382NZtvF/sCrqWPSEIaW5n6pW3BUbNsaEt4dyx0klW3opa0FePkhKqiPvLv5yVQ6BmatNQ==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr3044886wrr.63.1554366511223;
        Thu, 04 Apr 2019 01:28:31 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id m13sm20341592wmg.42.2019.04.04.01.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 01:28:30 -0700 (PDT)
Subject: Re: [PATCH] Documentation/gpu/meson: Remove link to meson_canvas.c
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190403205652.183496-1-sean@poorly.run>
 <2afc7c09-a6e4-5191-d7e3-7a3a75451aab@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <de19dd7b-40dd-408b-a024-53036dedf7c3@baylibre.com>
Date:   Thu, 4 Apr 2019 10:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2afc7c09-a6e4-5191-d7e3-7a3a75451aab@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 08:56, Neil Armstrong wrote:
> On 03/04/2019 22:56, Sean Paul wrote:
>> From: Sean Paul <seanpaul@chromium.org>
>>
>> The file was removed in the below patch and is causing this error:
>> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -function Canvas ../drivers/gpu/drm/meson/meson_canvas.c' failed with return code
>>
>> Fixes: 2bf6b5b0e374 ("drm/meson: exclusively use the canvas provider module")
>> Cc: Maxime Jourdan <mjourdan@baylibre.com>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-amlogic@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> ---
>>  Documentation/gpu/meson.rst | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/Documentation/gpu/meson.rst b/Documentation/gpu/meson.rst
>> index 479f6f51a13b..b9e2f9aa3bd8 100644
>> --- a/Documentation/gpu/meson.rst
>> +++ b/Documentation/gpu/meson.rst
>> @@ -42,12 +42,6 @@ Video Encoder
>>  .. kernel-doc:: drivers/gpu/drm/meson/meson_venc.c
>>     :doc: Video Encoder
>>  
>> -Video Canvas Management
>> -=======================
>> -
>> -.. kernel-doc:: drivers/gpu/drm/meson/meson_canvas.c
>> -   :doc: Canvas
>> -
>>  Video Clocks
>>  ============
>>  
>>
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 

Applied to drm-misc-fixes

Neil
