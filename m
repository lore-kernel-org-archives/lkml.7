Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0471AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FCB20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lT63tMDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDIOjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:39:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39653 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDIOjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:39:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so14692020ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qlDhnxDACuBK8FDzC88Tu2WKQxYpwT1zCWYXx/J5Wfk=;
        b=lT63tMDJS+pe85FRKa0e0QAA3pE42J9FpALxFEH3AUW9XW4mqmSM62WGJ+iOuSuZPQ
         W09YG1z16U2c91V6LIMU8gjL2Xj/RJZW9h/CqMuljk8tuuqpFlr+eEDHllIWvK1l44Ku
         GsKDhpWI+UfDktg99vMzgOvGOPZEH7cMwzdjPQamPMi9NA5EQr9+xdulal2wBUcE3QPn
         HAHGGfnP3cBxGIoxDTQx0t0rryx7igLsEbgaLPqdV17HMMgweUfqoSZiBHRFqyXZJNi/
         xkxVPrdQmjpV29vaL83vcWa1OBFZ0lxl43J+S1L3tpKKOy4OPbk68LNJn2juZ82Zq5AP
         v8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlDhnxDACuBK8FDzC88Tu2WKQxYpwT1zCWYXx/J5Wfk=;
        b=X5WSNQ6UMEMpoJrR1Pssuh7v4WAPYtjpYoVsmb4Wi+fJTu8kT3cnBVgdczdwPyLU4w
         OrB6iqX+AoxjlEaeSdwx8/kzSw2nOFVRUIdDkSROYuUhRguUbt0+suCZyxGlwmgq6I/J
         BOdwKhkUym6Xy2SP01VuFrx3j1BhGfKl5G47k7drgSjBZS+Pv+TUTNFp2NcWiD9sxfNu
         3eZlKyOR+YKONgY0zMJX2gJKmOrG2OKspd6ET8szDZuUauXnKJdJuJOwZvBvZl6AdEkU
         iQsStlP//fgG0+dj+cW3h4zjEXlnTK6p/qZuuz3OtbAhDwHLFMoYhCuQIOWeWIlxtusq
         Zotg==
X-Gm-Message-State: APjAAAV3JdPjAEoJXgtwchDJG6YjlES2O3YjCpUjOk/ytGTs0TioJEXs
        c2MVgeVOG14b74tw1uQKAvaUwg==
X-Google-Smtp-Source: APXvYqxt1Vq+L4R+uwOAELhm3DNFzsrCKx+m0hhrrSTFPJ780mKkAkpuP7k8FhV4+C+EwK8T/61wkQ==
X-Received: by 2002:a2e:81da:: with SMTP id s26mr20973098ljg.86.1554820751121;
        Tue, 09 Apr 2019 07:39:11 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u18sm6734336ljd.77.2019.04.09.07.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:39:10 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
To:     Rob Herring <robh@kernel.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-2-georgi.djakov@linaro.org>
 <20190328151255.GA5262@bogus>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <6d918bd9-489c-89fa-733e-90a5dabdaa0c@linaro.org>
Date:   Tue, 9 Apr 2019 17:39:08 +0300
MIME-Version: 1.0
In-Reply-To: <20190328151255.GA5262@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/28/19 17:12, Rob Herring wrote:
> On Wed, Mar 13, 2019 at 11:00:07AM +0200, Georgi Djakov wrote:
>> In addition to frequency and voltage, some devices may have bandwidth
>> requirements for their interconnect throughput - for example a CPU
>> or GPU may also need to increase or decrease their bandwidth to DDR
>> memory based on the current operating performance point.
>>
>> Extend the OPP tables with additional property to describe the bandwidth
>> needs of a device. The average and peak bandwidth values depend on the
>> hardware and its properties.
> 
> How would this work if you have 1 OPP (for the bus/interconnect/ddr) and 
> 2 devices with variable bandwidth needs? Or 'device' here means the 
> interconnect?

This is a property of the consumer devices and not of the bus. It's fine
for devices to have different bandwidth needs and to be connected to a
shared bus. In this case the framework knows the topology and can
determine which parts of the bus are shared and aggregate the traffic
accordingly.

>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>> index 76b6c79604a5..fa598264615f 100644
>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>> @@ -129,6 +129,9 @@ Optional properties:
>>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>>    opp-microvolt-<name> property, but for microamp instead.
>>  
>> +- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
>> +  the two integer values for average and peak bandwidth in megabytes per second.
> 
> -MBps would be better IMO. Either way, units should be documented in 
> property-units.txt.

Agree! Of course!

Thanks,
Georgi
