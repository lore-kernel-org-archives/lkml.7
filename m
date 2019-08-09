Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DDFC32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3C42171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JtU59l5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406856AbfHIOQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:16:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34542 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:16:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so45061257plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wEEYT8R6kbETJL+MHE9pqOtA1Rd0k8PXAV4pufeBj9Q=;
        b=JtU59l5aKujavuAkjvCG00hRT1H7YlYCwO/VlZwgscdjcqFMpqesoFFnLBC0DzR5es
         Mjv5GeomhXPky/0Ynu3L6dI5oM101sEi02C0zyiTvbtoX/lU8v3c4Urx48GPn5nQGKLq
         BBM+iIPv41ErgiymA+DcbSXBz6v1zBjMhIqLXDQI16V1AZLJABeFhBINYhyDVwg9ViCa
         +TN6iEi5iMWxxPgZNYmYJV3xH5aBTVezozjyh9dAy+jnhjX43BMb5nc2yHAHSnPXqhvs
         uXf8WtoAathuYGRQp3povtlAt58EaDJpf1AfrEchKI/z3/KWEu+BJTuejv3/P5r2KKEB
         v/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wEEYT8R6kbETJL+MHE9pqOtA1Rd0k8PXAV4pufeBj9Q=;
        b=h1XkL/y/ayRhmcohe+v8ayQ5nmk6idTk9v+42MaBFDugSBuoSYA7tbfFVAl9jcH2lK
         fGEW1gxQsVXvYAskWRXIT+K2DTPIovCv53eIIkxw1U5/r+NlozIwIipx0de5Tufjhx4w
         PPT074Wr5X+Ioa9/YLkzwsVkyOPQr4j3IcSBXGUDVJtgPYcXm7e/xIhaTFhFXWOc18am
         feTdHnFVrNXaHBUJkXW5BB0pR0TlRmI0ev044fAhNr0JvSd92cgSMk6Kiv7IlmJ1ZmX3
         5Q1wv+RMsulNydXLaGJk6IsYA2RS5ycAYxDaXXviKTeJNrr9kMdKHx3Ygyf1qxK+BN1p
         My3Q==
X-Gm-Message-State: APjAAAW54r1oyqgzSH2/f4ZARghLxwlZgX7kOjp1y48J7rovQQC5UQ4M
        jKwQ12O3IMI5ayg1KrOOFLGdeT4gPd+WIw==
X-Google-Smtp-Source: APXvYqwFSw+R60Lr2IilScX8ubLIswLgfr7IumG6FYxisKLYQlbe7XzlDnbn2kpIk3K4fjYiCC8ilQ==
X-Received: by 2002:a17:902:2884:: with SMTP id f4mr18965297plb.286.1565360173479;
        Fri, 09 Aug 2019 07:16:13 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:80e5:933f:36b7:b13c? ([2605:e000:100e:83a1:80e5:933f:36b7:b13c])
        by smtp.gmail.com with ESMTPSA id i126sm117566696pfb.32.2019.08.09.07.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 07:16:12 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20be9bbb-5f09-c048-d98d-7398657c0c8f@kernel.dk>
 <9f7821b3-5bc2-bda1-eae6-4d7213677c9b@silicom-usa.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d6a03c30-14f1-1c3f-9ae6-02d95128fe77@kernel.dk>
Date:   Fri, 9 Aug 2019 07:16:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9f7821b3-5bc2-bda1-eae6-4d7213677c9b@silicom-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/19 7:13 AM, Stephen Douthit wrote:
> On 8/8/19 11:46 PM, Jens Axboe wrote:
>> On 8/8/19 1:24 PM, Stephen Douthit wrote:
>>> Intel moved the PCS register from 0x92 to 0x94 on Denverton for some
>>> reason, so now we get to check the device ID before poking it on reset.
>>>
>>> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
>>> ---
>>>     drivers/ata/ahci.c | 42 +++++++++++++++++++++++++++++++++++++++---
>>>     1 file changed, 39 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index f7652baa6337..7090c7754fc2 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -623,6 +623,41 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>>>     	ahci_save_initial_config(&pdev->dev, hpriv);
>>>     }
>>>     
>>> +/*
>>> + * Intel moved the PCS register on the Denverton AHCI controller, see which
>>> + * offset this controller is using
>>> + */
>>> +static int ahci_pcs_offset(struct ata_host *host)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(host->dev);
>>> +
>>> +	switch (pdev->device) {
>>> +	case 0x19b0:
>>> +	case 0x19b1:
>>> +	case 0x19b2:
>>> +	case 0x19b3:
>>> +	case 0x19b4:
>>> +	case 0x19b5:
>>> +	case 0x19b6:
>>> +	case 0x19b7:
>>> +	case 0x19bE:
>>> +	case 0x19bF:
>>> +	case 0x19c0:
>>> +	case 0x19c1:
>>> +	case 0x19c2:
>>> +	case 0x19c3:
>>> +	case 0x19c4:
>>> +	case 0x19c5:
>>> +	case 0x19c6:
>>> +	case 0x19c7:
>>> +	case 0x19cE:
>>> +	case 0x19cF:
>>
>> Any particular reason why you made some of hex alphas upper case?
> 
> No good reason.  These were copied from the ahci_pci_tbl above and I
> didn't notice the mixed case.

Ah I see.

> I'll resend.
> 
> Would you like a separate cleanup patch for ahci_pci_tbl as well?

Yes please, I have a hard time reading the weird mixed case.

-- 
Jens Axboe

