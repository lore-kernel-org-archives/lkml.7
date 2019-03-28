Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE40C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACAD2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw3yv7uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfC1Uyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:54:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44851 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfC1Uyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:54:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so48875ljg.11;
        Thu, 28 Mar 2019 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jr4NPlCQ0dB7/OxX6a3n/TlV+U+V8P/4RfcjP08szW8=;
        b=Xw3yv7uoqE2kfIpS42NQRb9iPhzTgx9LF26YLrsJvbkT+nykqNqkHJfLrvK4qhGu/r
         W1xgbsIE8VR476/L4wrngMkBFPiD7VQqdZHpzKhR6PxTwxhlJ9hvktdXNx1q9P/dh89u
         5tWY9vja2O6WYj11Nvq24ArDg1PZZ9owfeSbE0+r6BrzcQFG3gP6XCRNMhfIRfJGvy50
         MBdyBfNEFYOLSF4wPPk93+YMe6z2RWhzcbM0y7QRtR8wK6xisx4SA+t2Y1t1gZGbwWXc
         cHb52telouoPS1FMerYT949HzukbHYn/fghUoumQoqI8p2WG26aXCrhWoLtp5F6bIW+J
         Uyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jr4NPlCQ0dB7/OxX6a3n/TlV+U+V8P/4RfcjP08szW8=;
        b=r6rLKU2BY4kAc7XrQSs/dIfgrU0Tq0xp2oevwYMXVwRvWyslUCDukBijBqsf0KPGld
         5t51pW/jeqH2iEiRu8J5XMbrgLsFd5fbSVPx1fZS+XBdsp//E/0f5qZOlmymeWHe6I1a
         z+juFKCzT5qm6qnYE5I7rmFrwBFknAHTyqVEV5zs65oRusieW7qNvxjaz10fn77tfi16
         M+akmaFM1JDZEIqTMVL7ftva0vhTYMWkQnpjAXR+Gso4zC5JDVDU9vStW0g5hgL2o2tY
         bwvqGbqSlj9bXOIFWf77hFBWeDh7ViGCU5c8IjH9Uca/5V9xXQDs0LLQqtAMk00WmtG0
         S98A==
X-Gm-Message-State: APjAAAWBt7n9KTTc4juPj7W4ZTHMArfKPlUXpuspBKevR8kjcGw5WK3c
        sJaFx3Ftqv8yUPX5BJ3+H08=
X-Google-Smtp-Source: APXvYqzneoANKsExD2adTNfZet6/BYCaryiaJ6NqNMhWRBhaS5DyihN5qNJ/3cSQX9jss2vCrRXicg==
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr24909058ljj.84.1553806492050;
        Thu, 28 Mar 2019 13:54:52 -0700 (PDT)
Received: from [192.168.1.19] (blb244.neoplus.adsl.tpnet.pl. [83.28.195.244])
        by smtp.gmail.com with ESMTPSA id 77sm27532ljc.69.2019.03.28.13.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:54:51 -0700 (PDT)
Subject: Re: [PATCH v2 00/25] Add generic support for composing LED class
 device name
To:     Rob Herring <robh@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190328001930.GA22901@bogus>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <46cf838b-ae41-4c0e-ba73-9a55b0ca03c0@gmail.com>
Date:   Thu, 28 Mar 2019 21:54:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328001930.GA22901@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 1:19 AM, Rob Herring wrote:
> On Sun, Mar 10, 2019 at 07:28:11PM +0100, Jacek Anaszewski wrote:
>> Changes from v1:
>>
>> - improved led_parse_properties() to parse label property at first
>>    and return immediately after parsing succeeds
>> - added tool get_led_device_info.sh for retrieving LED class device's
>>    parent device related information
>> - extended LED naming section of Documentation/leds/leds-class.txt
>> - adjusted the list of LED_FUNCTION definitions according to the v1 review
>>    remarks
>> - added standard LED_COLOR_NAME definitions
>> - removed functions.h and moved both LED_FUNCTION and LED_COLOR_NAME
>>    definitions to include/dt-bindings/common.h
>> - rebased leds-as3645a changes on top of the patch switching to fwnode
>>    property API
>> - updated DT bindings to use new LED_COLOR_NAME definitions
>> - improved common LED bindings to not use address unit for sub-nodes
>>    without reg property
>>
>> Generally I still insist on deprecating label property and devicename
>> section of LED name. The tool I added for obtaining LED device name
>> proves availability of the related information in other places in
>> the sysfs. Other discussed use cases are covered in the updated
>> Documentation/leds/leds-class.txt.
>>
>> Beside that, I tried also to create macros for automatic composition
>> of "-N" suffixed LED functions, so that it would not be necessary
>> to pollute common.h with plenty repetitions of the same function,
>> differing only with the postfix. Unfortunately, the preprocessor
>> of the dtc compiler seems not to accept string concatenetation.
>> I.e. it is not possible to to the following assighment:
>>
>> function = "hdd""-1"
>>
>> If anyone knows how to obviate this shortocoming please let me know.
> 
> Raise the question on devicetree-compiler list. I've done my share of
> dtc patches, but the parsing side is generally not an area I touch.

I'll probably come up with additional property function-enumerator.

-- 
Best regards,
Jacek Anaszewski
