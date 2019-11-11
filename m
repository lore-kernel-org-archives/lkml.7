Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE843C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B133F2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LAzanCoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKKOkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:40:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39122 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:40:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so10826724pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HSZMQWzyEHnnHHGSgljiQy/rMe2MxTJvgjXJLTPB8Uw=;
        b=LAzanCohnqFWoF8gGT+BAns/rhQOt9zScUEdL2og/ftcWJRRiv37aXkm3RKjkwf2p+
         ALvBnZ0EdR41oJ1oipALK9HTNW3YLU06bdHqI2mCfXrRsOaH72lpnrDVj5qht22plo/I
         raY9u3gdnGyg9LrKuqIgdSuLbCkvJfvay3T8/j8RznOfP86n5uNku2uD8mRBWIFfzE+x
         G/+VqYJp/K+k64wGPG8tHH6inJ6Hd1ahzyAjEVin93HD7RgfQgN1EWHr0ZnCvNPTcbvR
         jqMd59qSv/jCqsbpiUag62bFCGY4vM8w9wV78ceO1YpZDuIddkh2Vm/IcPfH6F2kTCrD
         7hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HSZMQWzyEHnnHHGSgljiQy/rMe2MxTJvgjXJLTPB8Uw=;
        b=CU6O+98M3JUi/rxjnRw+yhDRlLTtLS29+Eo1ffG0O7uNMcHToGOGXk9gadD6oiQnpL
         gG+4Dxuz2tDgEaQ+mDfTw7AOgX7WAcNTofoO0GtSH9mszD45VJHL+RswFydDYCcERmPr
         kBl98ciz2W5N7SHjVyD7pGqyNOOaNwIBmSL9jQxnTYI8VxbOdKFpsc1pKGzA4/OXx95W
         U1LbJiBLcl5puEXabUsIn+guENWCDOjRkHLvO3FLTiCk23dE5CVlshTbPhpFAZoPdBk9
         7BmuqNzmawTl42T7u3XpOQ0iE5YlBtDcI+IJ9TtZDjX9vS4ML6GKwLS+sKHz446O6wbK
         cWUA==
X-Gm-Message-State: APjAAAUP8ohr+cVtGG7xTYpmCe67dbfP+yoG677+7r4GoexOom/E6HjA
        yAZC9gDwrG2MXaRTzIYnmjr0HQ==
X-Google-Smtp-Source: APXvYqzRF26meFYV5Haf+VOng2ZQhf2ivGmMtkGpcH5rhUWnKoKrEYEEDzl/1JLe7l1dj9g5OfIKpg==
X-Received: by 2002:a17:90b:110f:: with SMTP id gi15mr35797335pjb.128.1573483220407;
        Mon, 11 Nov 2019 06:40:20 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:dd5e:2cce:fe26:7bc6])
        by smtp.gmail.com with ESMTPSA id fz12sm13611195pjb.15.2019.11.11.06.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 06:40:19 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v4 2/4] firmware: meson_sm: Add secure power domain support
In-Reply-To: <420073b1-0a3f-1bfd-4422-34f8cd7e0d2d@amlogic.com>
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com> <1572868028-73076-3-git-send-email-jianxin.pan@amlogic.com> <7hk188stcy.fsf@baylibre.com> <420073b1-0a3f-1bfd-4422-34f8cd7e0d2d@amlogic.com>
Date:   Mon, 11 Nov 2019 06:40:18 -0800
Message-ID: <7heeyecw8d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> Hi Kevin,
>
> Please see my comments below:
>
> On 2019/11/10 4:11, Kevin Hilman wrote:
>> Jianxin Pan <jianxin.pan@amlogic.com> writes:
>> 
>>> The Amlogic Meson A1/C1 Secure Monitor implements calls to control power
>>> domain.
>>>
>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>> ---
>>>  drivers/firmware/meson/meson_sm.c       | 2 ++
>>>  include/linux/firmware/meson/meson_sm.h | 2 ++
>>>  2 files changed, 4 insertions(+)
>>>
> [...]
>>> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
>>> index 6669e2a..4ed3989 100644
>>> --- a/include/linux/firmware/meson/meson_sm.h
>>> +++ b/include/linux/firmware/meson/meson_sm.h
>>> @@ -12,6 +12,8 @@ enum {
>>>  	SM_EFUSE_WRITE,
>>>  	SM_EFUSE_USER_MAX,
>>>  	SM_GET_CHIP_ID,
>>> +	SM_PWRC_SET,
>>> +	SM_PWRC_GET,
>> 
>> These new IDs are unique to the A1/C1 family.  Maybe we should add a
>> prefix to better indicate that.  Maybe:
>> 
>>        SM_A1_PWRC_SET,
>>        SM_A1_PWRC_GET,
>> 
>> Thoughts?
>
> I consulted with the internal VLSI team, and it's likely that the latter new SOC will follow A1/C1.
> And then it may become common function in the future.

OK, but it's not a common function for the past, so it's useful to mark
that distinction.

Just like in device-tree, we often have compatibles named for previous
SoC families (e.g. "gxbb") used on newer SoCs, but we use that to mean
"GXBB or newer".

Similarily here, we can use SM_A1_ prefix to mean "A1 or newer.

Kevin

