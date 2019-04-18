Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8DDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966CB2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibDjBEJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbfDRRS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:18:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43760 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388388AbfDRRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:18:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id i68so2202279lfi.10;
        Thu, 18 Apr 2019 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xc/f8vECQFaC8JXGdTkPXt+eIGV4swHZrmQI5L4lnbU=;
        b=ibDjBEJwhiZyaERJyZ8GUW38qlXI+a+Z7pHqimSPWX0wUXVIhc+CSos7tK1+3Qnc21
         LlqfdgrcQqMp6nk721MIdSuKT/p797Rn8PgB2HiRoKkaq+8T7H1UZlVkUAsY83PJ6Ify
         wkDZ1OFSMU5SprMPIEHkhHY9z3YI72zv20jTXuNJf99qT31TldK/DII0Nm+RvswHZfRF
         es49j0uqTx0cX04eVTaY4EsDkO7DJERAUcExvLrlaa8L+N6GipOyk4tcbTr5L0Qp5n89
         zT54CDb5/yJAFgaxA4HVZOkdCUP0HDJeZRO33SQDxMjeJMr4hhw/uAlOZ1Tqfd+Ic5HG
         oRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xc/f8vECQFaC8JXGdTkPXt+eIGV4swHZrmQI5L4lnbU=;
        b=NlT8DfNZj8CojTNCRU+0V2IOCUANXGy+wXp+XBP5/kcb8HSn7XYwPdE6s5R7cTOMsy
         kB4PGpOL3AT8kSn9y2XL7REqywmHmHv9ZWzWv18n87aK/wPV6f2tQNvvp55CAgLEyeqw
         gZr38ETvFfjm9OoLt6RdckKu3sd45ibBiTxSbfqSLZWDxN/fgb6USRtoc+CPdqiTTozc
         U6NakYA4aCPcUr0gUGIL0Szl6/Vi1T0EHNDh/dlBJ186wWVuOcot4nc0XZe3Snb54Qj6
         7JIKMaL+I0sYZWxlWFudIdjQkVLWQYG42o/MOns0XtbB3VpJC1yZveqCmpg9cHBTD8tM
         zDwQ==
X-Gm-Message-State: APjAAAXa+fphqijnP0xfSGFtMI8fIQV/pHJn68Jd8eZMyYAOFGnLbzsI
        RjB8cSG60eUCleMPV8ta5yI=
X-Google-Smtp-Source: APXvYqxgXAwQD//9MI0qkQ9U7P317vLDoJDqRdtOTK8EwZRsAqWPRGSSoEynYBvQP/kM4UlHm2G7gA==
X-Received: by 2002:ac2:4214:: with SMTP id y20mr18059174lfh.75.1555607936964;
        Thu, 18 Apr 2019 10:18:56 -0700 (PDT)
Received: from [192.168.1.19] (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id l13sm511477ljj.96.2019.04.18.10.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:18:56 -0700 (PDT)
Subject: Re: [PATCH v4 11/26] dt-bindings: lp8860: Add function and color
 properties
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-12-jacek.anaszewski@gmail.com>
 <f942fe13-c38e-0cde-2991-ed67f2249e9f@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5e6fd5c8-77f9-ebd8-b91d-fa6f6664c445@gmail.com>
Date:   Thu, 18 Apr 2019 19:18:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f942fe13-c38e-0cde-2991-ed67f2249e9f@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 2:28 PM, Dan Murphy wrote:
> Jacek
> 
> On 4/17/19 3:54 PM, Jacek Anaszewski wrote:
>> Refer to new "function" and "color" properties and mark "label"
>> as deprecated.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Dan Murphy <dmurphy@ti.com>
> 
> I gave reviewed-by for DT docs and tested-by for code for the TI parts affected.

I know, but still there is change in one struct property name
in the patches.

I take your ack as granted then.

-- 
Best regards,
Jacek Anaszewski
