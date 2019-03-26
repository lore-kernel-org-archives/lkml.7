Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D96C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0819D20830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S03B/KDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfCZI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:57:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45963 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:57:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so13281775wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5Tz3wiRpjF0Mq12Vxuppx71KxfddHDW/nfg/z4vZ3Tw=;
        b=S03B/KDdTHgISK7wgZdI1tTNpisTew7QoSJvcZta7f6QyHVmlNK5qfCMeOWnh+N18u
         Pa3XofvpsU0CFPkVQhmV330qpEL7hE8VMbVDW9d9ZmVsFVpEjGc+7BRd4eb+4kNtLZeQ
         GyDQhirUA4Gv0AhNCuhWtcW98xXkyDXsNA55ZouvrVlymJ3bmT8HDCPhsmHVupxgdhYo
         uqQV9qvz+L62N51zWdZLUK9NGrSSN72be/JOR39fJMaFxb97ZEekomrUB5PVKCxaEkKl
         wEFMPMLF/mEAyBSSC806ZuOosL6nFEoRwHZAE6S8bFHtWbGAS4he8bvYJjqFGd4EfOi3
         ahGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5Tz3wiRpjF0Mq12Vxuppx71KxfddHDW/nfg/z4vZ3Tw=;
        b=kfKVCET1cb0AYOi6NRYB/+OrZrx7VdHdRQzQcIlbqCbjZVCii/0GCNXLmYueMpSXT4
         BWG3/OkrFBn1ZUnaaOVkdTfIY6+Li3dfAK1H3Ip7iY/Po0Eg4p/pwEuvcAMoJ7A6C458
         kHEJn6TQaHEFyuQ9JUT2nkr8A1w83TQSrH1Phqt9NoEpy/xKKW5zADAmhySis1h6lBrn
         jb96AZ4ai4IL4Irtpl9XP1Wzbp/LwXS4c/GBgkLZwxpZtMQp0e0LZWxiipr/kiSbMCFc
         yPliL9bQFLhPmg5mzVVfkj+zDyuU1nWbJl7iEfAFDMLYLGiiRKjng4UQtNw6VGjBS00U
         P7TQ==
X-Gm-Message-State: APjAAAXcZ3AXJ1vG53BucGXHx1uWrwgV7EEzBEduQxK/Os0Uc/GJXXOJ
        ds+jjesQqnw7FCUFDcm56EX/VLtsfMo2Hmj8
X-Google-Smtp-Source: APXvYqxf+ahoiRNoy9rXL+GxoKBXtZrtqPrv1OzG+3GTHX4p2rAaprM4OFwCAL5W6FSVqR61nlhfGA==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr18235712wro.216.1553590658119;
        Tue, 26 Mar 2019 01:57:38 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id r196sm10838597wmf.22.2019.03.26.01.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 01:57:37 -0700 (PDT)
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <47e944da1c3b0a11cf46fc5ad5678ba961b9f9d3.camel@baylibre.com>
 <CAFBinCCPW8wAoiN4hjj9tAYSqQqChpSB6+urAiXU95VYaZZKGg@mail.gmail.com>
 <88a731b0f1c2ce18d2cf7aff6e2ffc24a395a067.camel@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <2a3bdd86-ae52-eea3-9ede-47da5dd6d8a7@baylibre.com>
Date:   Tue, 26 Mar 2019 09:57:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <88a731b0f1c2ce18d2cf7aff6e2ffc24a395a067.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 09:37, Jerome Brunet wrote:
> On Mon, 2019-03-25 at 19:04 +0100, Martin Blumenstingl wrote:
>>> Thanks for fixing this Martin.
>> you're welcome!
>>
>>> As for the future enhancement, I'd like to know what you have in mind.
>>> As I have told you previously, I think the clock bindings of this driver are
>>> not great.
>>>
>>> The global name of the input clocks are hard coded in this driver and it
>>> sucks. CCF is evolving to rely less on these global names.
>> I fully agree with you on the clock setup, but I'm not sure if we have
>> to break the dt-bindings for it.
>>
>> the datasheet notes: "Each PWM is driven by a programmable divider
>> driven by a 4:1 clock selector".
>> In my own words this means that each PWM controller has up to 8 clock inputs:
>> - up to 4 inputs for the first channel (PWM_A)
>> - up to 4 inputs for the second channel (PWM_B)
> 
> Not from the pwm device POV. there is one device (PWM_AB) with 4 (max) input
> clocks. Those are consumed by two internal muxes. There would be 8 if the
> input was different between path A and B.

The PWM pair is a imple duplicate of a PWM HW, sharing the same clock parents,
as he driver is already designed, you can only have (for now) only
4 possible parents per pair.

It may change in the future, but for SoC from Meson8 to G12B, it's how it's
designed _now_, no need to discuss an eventual future change.

> 
>>
>> the current pwm-meson driver assumes that both the inputs for both
>> channels are identical.
>> the "clock trees" section of the public S912 datasheet (page 65)
>> clearly documents the clock inputs per PWM channel, not per PWM
>> controller.
>>
>> Thus I believe we should name our clock-names (the inputs to the PWM
>> controller) "pwm-a-clkin0", "pwm-a-clkin1", "pwm-b-clkin0", ...
>> That way we don't have a conflict with the existing bindings (which
>> already reserve "clkin0" and "clkin1").
> 
> I think this is overkill an inaccurate. The experience of all the soc we have
> seen so far (meson8, gxbb, gxl, gxm, axg and g12) confirms the sources the are
> the same input clock for both path.
> 
> The documentation just shows the clock src of each pwm. That just how the the
> table is presented. That does not change the fact the pwms are organized in
> modules (pairs) and the that the clock source are the same for each pwm of the
> module. IOW, there is only 4 lines of clocks getting to the IP, not 8. Feel
> free to ask amlogic if you want to make sure.

Indeed, the possible parents for each pair on PWM is the same, so we would only
need 4 input clocks per PWM pair.

> 
> The name clash is not really my point. The purpose of the clock binding would
> be different (from stating a setting to describing hw connection)
> 
>>
>>> In addition, the 'clock' binding should be used to refer to the clock
>>> 'consumed' by the device, not to define a setting (as done now). 'assigned-
>>> clock' binding can be used for that.
>> using the assigned-clock* properties requires self-referencing the PWM
>> controller (which I'm not used to), for example:
>>   &pwm_ab {
>>       #clock-cells = <1>;
>>       assigned-clocks = <&pwm_ab 0>, <&pwm_ab 1>; /* references itself */
>>       assigned-clock-parents = <&xtal>, <&clkc CLKID_FCLK_DIV5>;
>>   };
>>
>> if we want to auto-detect the parent clock (like you suggested below)
>> we need to consider if we can detect whether a .dts-author assigned a
>> specific parent.
> 
> I (personally) don't want to keep supporting the manual assignment of the
> parent. If the driver can guarantee than it will pick the most appropriate
> parent, there is no reason to have that.
> 
>> I know that it's easy to detect this when the clock is passed in the
>> "clocks" property, but I'm not sure if it's easy to parse it from the
>> assigned-clocks/assigned-clock-parents properties.
> 
> Assigned parent is the poor man solution and not necessarily easier to
> implement (the pwm device would have to export its own clocks) ... I have just
> mentioned it to make  the point that current method is not ideal
> 
>>
>> [...]
>>> Last, instead of specifying the parent to be used, I think we should come up
>>> with some code to let the driver pick the most appropriate parent for the period/duty requested.
>> that will make it easier for .dts authors.
>> I would like to postpone this until we have solved the other topics though.
> 
> I much prefer this last solution. Since the algorithm and the bindings would
> change, I think it would be easier (in DT) to just make v2 driver with a new
> compatible, progressively transition dts to it and finally remove the old
> driver.

I'd prefer this, but to be frank, the parent only determines the precision of
the PWM internal divider to give the most precise period possible.
For this the highest frequency is the best.

But you could also use an input clock with the lowest jitter, and this cannot be
determined automatically.

> 
> 

Neil

