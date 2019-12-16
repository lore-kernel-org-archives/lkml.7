Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42EDC47409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32A22072D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/jCrwoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfLPLLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:11:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42653 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727140AbfLPLLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576494695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WjOUTFpOi6Gu4d+B9mMstxxsH+1mt4QNI2pngEePaBo=;
        b=P/jCrwoVUgSuRPZ0wEoMSKFN5dladWd8opE3ZpD/VNx9IDHniBn6Wa1Elw8EDWwTofUa+s
        tUneswKjaVOVeq/I85dTNWALicBxwZG8A6FDzH3YEHIOzAKs7aPZjs4ULe6ufAtWc71WBp
        uD/jURIiFCDT/thlQEsqetCCLDjm1UY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Shv1eYX1M1eLoUpTDSTpkw-1; Mon, 16 Dec 2019 06:11:34 -0500
X-MC-Unique: Shv1eYX1M1eLoUpTDSTpkw-1
Received: by mail-wr1-f72.google.com with SMTP id u12so1871225wrt.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WjOUTFpOi6Gu4d+B9mMstxxsH+1mt4QNI2pngEePaBo=;
        b=TKWlqmrnxcUUwmlzam9/eXA2B4xR06rRInsLWaxgXZQ+7XQ9xpLMvhA6EWby+y3dgk
         fAWyrRjGGjWxT1CXhIbiHkeGm/RmjNRo/MiYbveEsuC1/6w4/hG8o6b8w0b1S8MF8SfL
         /2GaheEEQPdxH6iK2+mqpUzFzzUGGPO6DSF2k3bCqhxhuuDA4Oe7OSc8N78oG+7YA98U
         f9lO6kKfsd4pGDJP8eTzOszvgl01JFJ6/nOsAMaCwqcK5LalhnKd5B+3VVV5weLjusdi
         nLwzE4UQcRqt5UJLtLKp1OsdXGIjZdi2BB95HPqGKBAzpznej9ffM4g+fRoVrhadWhO1
         kIhA==
X-Gm-Message-State: APjAAAXbamZDPMAg26KDHJkz8ZBcEZXAJEOWcWr8MXyUv6ranJwfLnni
        cjFV5Jmgf+AzjQSiJzJmOhuPaI8OVBP1UeBYArTKpHHy8dUQrr1F88kTtiarFOJFxx8xz6VN02l
        XXpVBltUYMeonV6iOttzLozHZ
X-Received: by 2002:a1c:7dc4:: with SMTP id y187mr28955306wmc.161.1576494693445;
        Mon, 16 Dec 2019 03:11:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqz95JVS+9hzCpx2tUeBC+2E8wF70N/Kg5EXyntvwnCxuCB6OinaKV46tDHhavo+POTw6isKJw==
X-Received: by 2002:a1c:7dc4:: with SMTP id y187mr28955289wmc.161.1576494693250;
        Mon, 16 Dec 2019 03:11:33 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x18sm20950368wrr.75.2019.12.16.03.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 03:11:32 -0800 (PST)
Subject: Re: [PATCH 0/5] drm/i915/dsi: Control panel and backlight enable
 GPIOs from VBT
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20191215163810.52356-1-hdegoede@redhat.com>
 <CACRpkdarJ5chDfgc5F=ntzG1pw7kchtzp0Upp+OH9CH6WLnvXw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1474a983-3e22-d59b-255a-edd3a41f0967@redhat.com>
Date:   Mon, 16 Dec 2019 12:11:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdarJ5chDfgc5F=ntzG1pw7kchtzp0Upp+OH9CH6WLnvXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16-12-2019 11:26, Linus Walleij wrote:
> On Sun, Dec 15, 2019 at 5:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Linus, this series starts with the already discussed pinctrl change to
>> export the function to unregister a pinctrl-map. We can either merge this
>> through drm-intel, or you could pick it up and then provide an immutable
>> branch with it for merging into drm-intel-next. Which option do you prefer?
> 
> I have created an immutable branch with these changes and pulled it
> to my "devel" branch for v5.6:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-pinctrl-unreg-mappings

Ugh, taking one last look at the "pinctrl: Export pinctrl_unregister_mappings"
patch it is no good, sorry.

I just realized that if the mapping has been dupped, the if (maps_node->maps == map)
check will never be true, because maps_node->maps is the return value from kmemdup
and map is the map originally passed in while registering.

Linus, can you please drop this from your -next ?

So I see 2 options:
1) Add an orig_map member to maps_node and use that in the comparison,
this is IMHO somewhat ugly

2) Add a new pinctrl_register_mappings_no_dup helper and document in
pinctrl_unregister_mappings kdoc that it can only be used together
with the no_dup variant.

I believe that 2 is by far the best option. Linus do you agree or
do you have any other suggestions?

Regards,

Hans

