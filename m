Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3DB217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw5NrQAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDKLbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:31:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42345 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDKLbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:31:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so4404153lfc.9;
        Thu, 11 Apr 2019 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eobaGoWYk57pOxmjBz1z37XKx5tEVnBH0OcE4Z9OEcw=;
        b=Tw5NrQADK5KlSnOZvSE7YnKTY+29BX95CXv/Kua502MlpLLK0/C+0JBTtL/uI0Fj1j
         ch3zvwMy6wognmnTGkn52xIzOnNK6YmYubZFnteXOWdvHJoPKs2DxE2tEL+KvRqUMjJU
         lO/ZMbFQD207eFCy/Lx5grQVw6Oni6wpx+ZfHhM6dLkV0mRDBXivR/ptya0GDgs6iEQr
         TEz35P73LM4TjViDkiNvHik+SjU8ZFCbTIHSUmWGHDMwuhFgLkVkAwT8lTOowGD/+cML
         DF8toIWUnBYgt3c+UL1M7ThRJ16Vsk+w3FXDDI4QS3SKfyjT3fHS6XLK+2tOt/jpl3dW
         6Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eobaGoWYk57pOxmjBz1z37XKx5tEVnBH0OcE4Z9OEcw=;
        b=i33DIvx7DKV27cGOWd1pZ5PD4xpRyLWivZEZ5c5pAYoRBvBJ8nSb0ueZHNKGinykTz
         A8ODVa8to81Yu6VLc574sp+AXK9n9wdjMi7a/9xdvt5IqNKRVwIGdh3zx/d57WUeWyVZ
         DwHAE4v80apcruWEk6UkF/uNuGSeZZiZ2PIS/OOif5ux8wx/lHoZY9QMY/aNU+J9bsaN
         ZRH9Zo8K3gKGFhFLDkoOzCJYqSgV0tME4ZPExhlMtGtE5HJ8QQyD+qaHDvhg/Bf9L/02
         VGYA6cxdkTCgRvyUyIYI9T5AisWkoTYCfuqGd3OgOEoFqquDgYhS6uKgIy1NEe6WketM
         psTQ==
X-Gm-Message-State: APjAAAVFzEJCjpRVrJjAOPiaSrrUn36FxGtRM5QJAUgDG3MnOWME6v3u
        K545uNMH58VKo/6ZHpEvwsni2dTH
X-Google-Smtp-Source: APXvYqyejN1Eo+KO5BiLHFu3Y/6c40xrUVuMeExKQJjHjWw0XCrOeOW3nkHWbIhx8IJamUi4faRsjg==
X-Received: by 2002:ac2:420b:: with SMTP id y11mr27199272lfh.104.1554982310220;
        Thu, 11 Apr 2019 04:31:50 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id p14sm434877lfk.6.2019.04.11.04.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:31:49 -0700 (PDT)
Subject: Re: [PATCH] gpu: host1x: fix compile error when IOMMU API is not
 available
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Stefan Agner <stefan@agner.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-tegra-owner@vger.kernel.org
References: <4c3d021c73c001f633803e364cfbc6ace3381205.1554936354.git.stefan@agner.ch>
 <7371b1573ddd0b127713724ef5051a6f@codethink.co.uk>
 <20190411083017.GB4633@ulmo> <c73bb650-7175-150b-a678-c707e5f0e7e7@kapsi.fi>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ff7e06b6-587c-6098-92ab-ff2fbab6e651@gmail.com>
Date:   Thu, 11 Apr 2019 14:31:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c73bb650-7175-150b-a678-c707e5f0e7e7@kapsi.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.04.2019 13:06, Mikko Perttunen пишет:
> On 11.4.2019 11.30, Thierry Reding wrote:
>> On Thu, Apr 11, 2019 at 09:23:13AM +0100, Ben Dooks wrote:
>>>
>>>
>>> On 2019-04-10 23:47, Stefan Agner wrote:
>>>> In case the IOMMU API is not available compiling host1x fails with
>>>> the following error:
>>>>    In file included from drivers/gpu/host1x/hw/host1x06.c:27:
>>>>    drivers/gpu/host1x/hw/channel_hw.c: In function
>>>> ‘host1x_channel_set_streamid’:
>>>>    drivers/gpu/host1x/hw/channel_hw.c:118:30: error: implicit
>>>> declaration of function
>>>>      ‘dev_iommu_fwspec_get’; did you mean ‘iommu_fwspec_free’?
>>>> [-Werror=implicit-function-declaration]
>>>>    struct iommu_fwspec *spec =
>>>> dev_iommu_fwspec_get(channel->dev->parent);
>>>>                                ^~~~~~~~~~~~~~~~~~~~
>>>>                                iommu_fwspec_free
>>>>
>>>> Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>
>>> would it be better to provide something like this i nthe header that
>>> defines dev_iommu_fwspec_get() to be:
>>>
>>> static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>>> { return NULL; }
>>>
>>> although returning an PTR_ERR would have been better.
>>
>> I don't think there's really a large number of failures here. Either
>> your device has an IOMMU fwspec or it doesn't.
>>
>> But yes, I think it'd be better to have the above static inline dummy in
>> iommu.h, but I'll apply this for now in the hopes of getting it in
>> before v5.1 final.
> 
> A similar patch was already sent before by someone. That one also programs the bypass stream ID (0x7f) even if IOMMU is disabled. We should pick that patch instead.

For the record.. here is that patch https://patchwork.ozlabs.org/patch/1052364/
