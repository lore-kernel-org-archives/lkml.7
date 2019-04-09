Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342E0C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAABF20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eOCnJapW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDIIUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:20:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37628 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:20:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so2207593wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pfR4P9LrDyHZsIRepbvE2l2wqtRd7f4lG6Bo64BoQ5Y=;
        b=eOCnJapW8AyhnYNbT5fOzk+10ZoQ7HfKYH/mXH1CnFteToOmult6bf0d5jwY1k52nH
         CTfEJKwL6HumGiq1bEL1GCMEe0djZdmiPIQ16+yAMYr4I/ZNzfgaDAflRmADAC/XdFIe
         SQaXLsyPTfQ/oqouhQKu0MJMercvNnEQ7QC4JZUrzLP/domuT24sDRrQsqrpbKjxm+5G
         p7PMmQPLTFVXwicv/2NchgvOjyfJ47CkbK4oAJo+Tbrh2YrGA7e0ggnQNcTT+0vmr7XZ
         yVt/X4a0YAikKEiviZTLP2W0xiaLu92aZLwSgSaTsHGFoJ/rQv9HcRvP2Luzo+0OPvMN
         yHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pfR4P9LrDyHZsIRepbvE2l2wqtRd7f4lG6Bo64BoQ5Y=;
        b=iob9g2iUKrPm8MGPZVfO1EpQtVK8WalpXUyN6ZlXsx/gwIr/giwysqiimX7uvzq4wc
         9CTkEqM/+mRkK+MZdUmi/Vy+ImoPVwvxMBcqlRmGAUB/gP1JnjacbwUgD37/0qGT/1CY
         aXwIcHzXRIKzN3erHxFBaP8HHilU2U9zk/+kFyFDKzv5eMoVO1Nar7B4kqLI1TE1LGQX
         cJqG5b5pqMlsX8kpxTQ0nffrutViA+qx4hPI2qSZZVH6dOWP24sVexeIIBbD5pe/o/vF
         oUdVCIvLz45Q8pB+ulg1SsuVCdmq4SUgCQFAmmUKtD2YmxQwAHGu2LCoQtmvGsXMoeeN
         al6A==
X-Gm-Message-State: APjAAAWVeqreq8MUkTCYKagQ1aItx4jjSTVYDMONS2TMXGgclDpX28fw
        sjNAFNFm7S/jJSb76AnanO4juA==
X-Google-Smtp-Source: APXvYqzarK43oSf3PWYfZzP15Z8qkkfRB7FrQmeCYlIQKQ9hlqnnn5+hvRjnnHx/TCUyJNjI/+66Aw==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr12547793wmk.136.1554798040554;
        Tue, 09 Apr 2019 01:20:40 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o4sm24994090wmo.20.2019.04.09.01.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:20:39 -0700 (PDT)
Subject: Re: [PATCH v4] dt-bindings: gpu: add bindings for the ARM Mali
 Bifrost GPU
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190401080949.14550-1-narmstrong@baylibre.com>
 <1640dd7b-3576-d9ce-0641-6b6a64a87275@arm.com>
 <d26f1ce9-c56c-5e51-37f5-0689aa198dc0@baylibre.com>
 <5CA9CE1A.6060109@baylibre.com>
 <CAL_JsqJj4pae6AuK=HGU5GuZogFKyAbU_y7Ls_CyTcV6qXH_rg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <86843e8b-1dda-f7f3-c2ad-02b7b47743dc@baylibre.com>
Date:   Tue, 9 Apr 2019 10:20:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJj4pae6AuK=HGU5GuZogFKyAbU_y7Ls_CyTcV6qXH_rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 21:07, Rob Herring wrote:
> On Sun, Apr 7, 2019 at 5:17 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Rob,
>>
>> Le 01/04/2019 13:24, Neil Armstrong a écrit :
>>> On 01/04/2019 12:00, Steven Price wrote:
>>>> On 01/04/2019 09:09, Neil Armstrong wrote:
>>>>> Add the bindings for the Bifrost family of ARM Mali GPUs.
>>>>>
>>>>> The Bifrost GPU architecture is similar to the Midgard family,
>>>>> but with a different Shader Core & Execution Engine structures.
>>>>>
>>>>> Bindings are based on the Midgard family bindings, but the inner
>>>>> architectural changes makes it a separate family needing separate
>>>>> bindings.
>>>>>
>>>>> The Bifrost GPUs are present in a number of recent SoCs, like the
>>>>> Amlogic G12A Family, and many other vendors.
>>>>> The Amlogic vendor specific compatible is added to handle the
>>>>> specific IP integration differences and dependencies.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>> ---
>>>>>  .../bindings/gpu/arm,mali-bifrost.txt         | 92 +++++++++++++++++++
>>>>>  1 file changed, 92 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
>>>>>
>>>>> Changes since v3:
>>>>> - Added note about discoverable model/revision
>>>>> - Enforced fixed defined irq order
>>>>> - Fixed typo in accommodate
>>>>>
>>>>> Changes since v2:
>>>>> - moved to a single compatible since HW is fully discoverable
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
>>>>> new file mode 100644
>>>>> index 000000000000..711c9ead17a2
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
>>>>> @@ -0,0 +1,92 @@
>>>>> +ARM Mali Bifrost GPU
>>>>> +====================
>>>>> +
>>>>> +Required properties:
>>>>> +
>>>>> +- compatible :
>>>>> +  * Since Mali Bifrost GPU model/revision if fully discoverable by reading
>>>>                                              ^^
>>>> s/if/is/
>>
>> Should I still send a v5 to fixing this typo ? I can fix it while applying it.
> 
> No need to resend. I planned to apply it, but if you are going to:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks,

Fixed and applied on drm-misc-next

Neil
