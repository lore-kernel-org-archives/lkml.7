Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBF1C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82AF20878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPAhIPf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfDZBo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:44:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39192 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfDZBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 21:44:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id a9so2048559wrp.6;
        Thu, 25 Apr 2019 18:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Njko032HC0FXKNlRIXmBAsUHWAyTDCH5E6/XtjMfoA=;
        b=kPAhIPf2si6uFKYMRo4yOMGYxOcA79WBu3o/Nd493uPs+bgp+Vorxx0h3YZkXSBP/2
         bxaBRv/RNz0fdushrZjICJ/RZQOhafKtc3WkqGvEgtr0gDsiw06D3kDiAkl/nTEJjVV/
         ZHM8G03OYT7UBoBqMlE27CEhrWT0t5RQGMiRXRz2q8HhPe8o1N4IaJ1iCV5GgBPcBNYI
         RzJTRpvu3ZZ4RPVwnXhWWOD7cCU6MzDxTjQJTUdkb75RJToI+25J8b+gE5PtYu/Nz7Ot
         hY+aHN1ewKMvrLMeUIVTJnSicnOOefa+7W9sLs1PlgNCp71leIZz5ROrIvG3T8uDn/UC
         UQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Njko032HC0FXKNlRIXmBAsUHWAyTDCH5E6/XtjMfoA=;
        b=JIjkMwbHZuG3i5ku0lHvUDdWhaJz9S/TnMJmrZU/j/+xisnhEx3SjFt/PGqZi1Ojcw
         DsqX2aUzIGHkIlvjWmPPr2T1LB+vDhQRu600UfHigcfWBff7SOww1T+f+dNE9xJXu7MK
         v3gfBh0FAml+SJq0WmMMM5+bO1Zf10/I4X7HiqAnR1/wGU3cYGk2rCvZFtd638Ws9nna
         jWi42C15Nsr6uOhaeYITQY4iH+1vsTRO0WBnISVm3gq0Fmr2902zpmvDydzd6HoXRiZh
         sO3kIrsCad3soU9V7AHm5IKbWkTtsLB43UrGYUvJpQYwlg9eSS/NrMAc/RoEGUVoYvHS
         eR4w==
X-Gm-Message-State: APjAAAWTSI+4SR2EXk1Ui/Pi7u/YTnPf67zTmPgEU1rfZh+DJjsBVIQB
        flCFAxbUt2a/Sb8K/9UhIHg=
X-Google-Smtp-Source: APXvYqyxjNh7AkhxIws5E7Z5CNn3vcqbp6de+irznQLIUDSK9z0tmryyjjiCJcYBNiwRC+UyGfmnTQ==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr12122245wrp.96.1556243095382;
        Thu, 25 Apr 2019 18:44:55 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id w2sm17652272wrm.74.2019.04.25.18.44.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 18:44:54 -0700 (PDT)
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Julien Su <juliensu@mxic.com.tw>,
        Simon Horman <horms@verge.net.au>, zhengxunli@mxic.com.tw
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <CAL_JsqJDh3Z+iFn6fbkGT+jQ3HG2s4n3PT=LrmB-td++G99q_w@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <1426b1de-b2ae-9f8a-ba36-8aa81dfda161@gmail.com>
Date:   Fri, 26 Apr 2019 03:44:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJDh3Z+iFn6fbkGT+jQ3HG2s4n3PT=LrmB-td++G99q_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/19 1:07 AM, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 4:54 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>>
>> On 4/24/19 11:23 PM, Rob Herring wrote:
>>> On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
>>>> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
>>>>
>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>>> ---
>>>>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++++++++++++++++++
>>>>  1 file changed, 40 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>>>> new file mode 100644
>>>> index 0000000..668b822
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>>>> @@ -0,0 +1,40 @@
>>>> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
>>>> +--------------------------------------------------
>>>
>>> Looks like a SPI flash controller from the example. What makes it an
>>> MFD?
>>
>> It supports both SPI NOR and HyperFlash (CFI-compliant flash with
>> different bus interface).
> 
> Not sure that really makes it an MFD. Lee probably has an opinion.
> 
> In any case, can we get a complete binding that shows both.

Presumably that would only mean the flash compatible is some "cfi,nor"
or somesuch. But I agree, would be nice to have both in the example.

-- 
Best regards,
Marek Vasut
