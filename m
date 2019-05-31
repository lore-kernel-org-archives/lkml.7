Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75903C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E6E26A7C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KxBXKt22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEaOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:22:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45871 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEaOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:22:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so6628453wrq.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z+Q4ZfujNTa+NRZcXxaYO45ttajACOxdq5aGN1n/qNI=;
        b=KxBXKt221Q+D12wYpPzSmLnVCoOwRNHlWf/GQk3+7YxkxU3xlU3w/pbE3dj1gZ95F8
         hG8vag53b8lHJzwO3PpIQsRlUkdk3L14e8IjbGfp64yGMBN2zgA9GAfPkRpP/vjuX7Rs
         ew0l/gcIRoUu/M3IkgMV1nenakTydP9LKFOxnCnOf5iyRjGJzTlwGcb8DnROObd7W668
         qILZVflzjsXhUqzP02WJnel6O7fkbVFsC8w74PlO/Mj8a9Q3F/nl+huRHa87iFovrDaK
         OmelFTRVeqjDWOjtKQ3LJUJb4insyn2ls05ypVWtxRMCy0rqHmHxT6UlImIaLovN7sc2
         1R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z+Q4ZfujNTa+NRZcXxaYO45ttajACOxdq5aGN1n/qNI=;
        b=PN49cxfa6h9/Wki8jpfMDngSKk2zN3llrv5Jl80nbhpQNBF3JjZU9mzQWgjN9dMLnY
         AztDZD/HhyvUb/JYBnQvwx/I16x7RAW7IbYb4uLBth1LhRYy+8FGTx9mR9HPGkyd8nKZ
         S5xycIHao9Xr8IYqqxIHt9yWCOBcduLUwbd7i67kt0XkyN/o5q1rYFE29EiduyL+XW6b
         WQ6ejeQvqQbm4IdqSyjcZrTLGNnCSSQcvGmpHanKjuunJ8CU1enGBnCrA/+AI3RfqUNh
         YYJ0HpzmW4XXlhRXomcnO5/RMkC67jVvLHNOK5+RYpGm8r81Q1l8HgLVHCMd1mbbzevH
         zJIg==
X-Gm-Message-State: APjAAAXlCTDe3aS2j0a73OWqeuHbURqGG+IQOIFhXVKDKzkla2zG1Ma/
        ObQcY1FP7g58wE9G0A01sLtJrg==
X-Google-Smtp-Source: APXvYqz4lQs/A0MJrDDKhYbmQWobkvfEm5JNi8xTH59pJmIfjtVtBuFZLsAVjkw+9ik/gR80FdQ6kw==
X-Received: by 2002:a5d:65c9:: with SMTP id e9mr6871207wrw.348.1559312528765;
        Fri, 31 May 2019 07:22:08 -0700 (PDT)
Received: from [192.168.1.24] (amarseille-652-1-291-131.w109-208.abo.wanadoo.fr. [109.208.94.131])
        by smtp.gmail.com with ESMTPSA id l12sm4828038wmj.22.2019.05.31.07.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:22:07 -0700 (PDT)
Subject: Re: [PATCH] phy: meson-g12a-usb3-pcie: disable locking for cr_regmap
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20190531103137.14901-1-narmstrong@baylibre.com>
 <4dc22a2e-66ca-0556-3aa3-4ed8887c2b1b@ti.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <2a354f12-61a8-6b4e-8006-e442245a92ec@baylibre.com>
Date:   Fri, 31 May 2019 16:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4dc22a2e-66ca-0556-3aa3-4ed8887c2b1b@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2019 12:35, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 31/05/19 4:01 PM, Neil Armstrong wrote:
>> Fix the following BUG by disabling locking for the cr_regmap config.
> 
> What caused the BUG in the first place? The commit log needs more details or
> else this looks like a workaround to mask a BUG.

I thought it was pretty explicit, phy_g12a_usb3_pcie_cr_bus_read() sleeps
with regmap_read_poll_timeout() while ran in spinlock_irq, caused by regmap fast_io = true

Locking is not needed in our case, this regmap is only used by the PHY init() callback.

Should I send a v2 with such explanation ?

Neil

> 
> Thanks
> Kishon
> 
>>
>> BUG: sleeping function called from invalid context at drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c:85
>> in_atomic(): 1, irqs_disabled(): 128, pid: 60, name: kworker/3:1
>> [snip]
>> Workqueue: events deferred_probe_work_func
>> Call trace:
>>  dump_backtrace+0x0/0x190
>>  show_stack+0x14/0x20
>>  dump_stack+0x90/0xb4
>>  ___might_sleep+0xec/0x110
>>  __might_sleep+0x50/0x88
>>  phy_g12a_usb3_pcie_cr_bus_addr.isra.0+0x80/0x1a8
>>  phy_g12a_usb3_pcie_cr_bus_read+0x34/0x1d8
>>  _regmap_read+0x60/0xe0
>>  _regmap_update_bits+0xc4/0x110
>>  regmap_update_bits_base+0x60/0x90
>>  phy_g12a_usb3_pcie_init+0xdc/0x210
>>  phy_init+0x74/0xd0
>>  dwc3_meson_g12a_probe+0x2cc/0x4d0
>>  platform_drv_probe+0x50/0xa0
>>  really_probe+0x20c/0x3b8
>>  driver_probe_device+0x68/0x150
>>  __device_attach_driver+0xa8/0x170
>>  bus_for_each_drv+0x64/0xc8
>>  __device_attach+0xd8/0x158
>>  device_initial_probe+0x10/0x18
>>  bus_probe_device+0x90/0x98
>>  deferred_probe_work_func+0x94/0xe8
>>  process_one_work+0x1e0/0x338
>>  worker_thread+0x230/0x458
>>  kthread+0x134/0x138
>>  ret_from_fork+0x10/0x1c
>>
>> Fixes: 36077e16c050 ("phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>> index 6233a7979a93..ac322d643c7a 100644
>> --- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>> @@ -188,7 +188,7 @@ static const struct regmap_config phy_g12a_usb3_pcie_cr_regmap_conf = {
>>  	.reg_read = phy_g12a_usb3_pcie_cr_bus_read,
>>  	.reg_write = phy_g12a_usb3_pcie_cr_bus_write,
>>  	.max_register = 0xffff,
>> -	.fast_io = true,
>> +	.disable_locking = true,
>>  };
>>  
>>  static int phy_g12a_usb3_init(struct phy *phy)
>>

