Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC554ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBAB20700
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WPpYuDJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbfJANdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:33:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43959 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfJANdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:33:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so15550566wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=q8MDE5plyoRNJmUuOBtTSfs834j7Iqw1FfFcyxYnumg=;
        b=WPpYuDJwCz9iNVKgfF0rxipBxqDz6nlIWJyQIYTX2tjmWW31ckS60u4AMpswyn2LXa
         t/z/KbgIpMw0jeuBWup6RQaWXmzgbkMuviyWh7pu/BS7MFjCd5YodsekhVnLC2jJbeM5
         v1Xlo9Ye4EKeKfKyubaQzvhchUSVrEKefUqWTNWKoD+agXHS2Lj4h/Nwmk+haJiKOpad
         +6zU2nJo+igVlwYj/14q/YChadBZJmS+2yMEomfmzDXPJZsF994+SqMSkXntC1anNA/L
         0SMsHeTkXHiS5IZ5boMwcT5i8VVU2Aev2dTD23LStWXuQi8qaFI7OmkknTiLH5NWqaCm
         13kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=q8MDE5plyoRNJmUuOBtTSfs834j7Iqw1FfFcyxYnumg=;
        b=AKaWRtxdqEbdHFZMK4YV21GmHtP3kpqjZr25jB41OiJ073Qoj88OEMCoq1pFVKbIXp
         YoSSpQnoV3nf7RheWswE+1mRndoVJbWupbTDDgAQ6pL4MdB5vxnfRNCYDoXboQAacGfg
         8QyWJ75MWfEFRSg0ITUE2BoTyBvPtIKI8rG5t4pyZNh2OHtbTbaYfiAaeN7jlIBystZ4
         gJzVTkpZAHSZ61HTLHW+ShMKkiK/Oy1DmUUPm3tjmjVThOyMTdQWsJ7e+Sk2m8Z7QspM
         xAnEBBK7ymQo04yLurcvNYHc81DDIHY8KMeFczNpdADE7hhKfWEYF9Rl9EajxBFm5e0w
         VsSg==
X-Gm-Message-State: APjAAAUg6Dx7zRU4n816MMGLPRfaFDh4JWWMpE0zGTh2DMcoIAEbceYj
        TnhSuThQjo92cSC32nC1DvWXDg==
X-Google-Smtp-Source: APXvYqx5UTPwgHB49ZkRR24PRLoPJyqRoXoDTxxZ9PbUtFADeW5Y7oQDqDrFvTZvadHS8fHEj1cltA==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr17074158wrn.291.1569936786513;
        Tue, 01 Oct 2019 06:33:06 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a18sm24360812wrh.25.2019.10.01.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:33:05 -0700 (PDT)
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com> <1jsgons4wy.fsf@starbuckisacylon.baylibre.com> <CAFBinCAHD+D=a2mHeHMGq12MvoksHBr308jSrdcH+UYsUmwd8w@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/6] add the DDR clock controller on Meson8 and Meson8b
In-reply-to: <CAFBinCAHD+D=a2mHeHMGq12MvoksHBr308jSrdcH+UYsUmwd8w@mail.gmail.com>
Date:   Tue, 01 Oct 2019 15:33:04 +0200
Message-ID: <1jeezwr3ov.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 23 Sep 2019 at 22:49, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Mon, Sep 23, 2019 at 12:06 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> On Sat 21 Sep 2019 at 17:18, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>>
>> > Meson8 and Meson8b SoCs embed a DDR clock controller in their MMCBUS
>> > registers. This series:
>> > - adds support for this DDR clock controller (patches 0 and 1)
>> > - wires up the DDR PLL as input for two audio clocks (patches 2 and 3)
>>
>> Have you been able to validate somehow that DDR rate calculated by CCF
>> is the actual rate that gets to the audio clocks ?
> no, I haven't been able to validate this (yet)
>
>> While I understand the interest for completeness, I suspect the having
>> the DDR clock as an audio parent was just for debugging purpose. IOW,
>> I'm not sure if adding this parent is useful to an actual audio use
>> case. As far as audio would be concerned, I think we are better of
>> without this parent.
> there at least three other (potential) consumers of the ddr_pll clocks
> on the 32-bit SoCs:
> - CPU clock mux [0]
> - clk81 mux [1]
> - USB PHY [2]
>
> I have not validated any of these either
>

Then I would suggest to leave patch 4 out until we can somehow validate
this. 

>
>
> Martin
>
>
> [0] https://github.com/endlessm/u-boot-meson/blob/345ee7eb02903f5ecb1173ffb2cd36666e44ebed/board/amlogic/m8b_m201_v1/firmware/timming.c#L441
> [1] https://github.com/endlessm/u-boot-meson/blob/345ee7eb02903f5ecb1173ffb2cd36666e44ebed/board/amlogic/m8b_m201_v1/firmware/timming.c#L452
> [2] https://github.com/endlessm/u-boot-meson/blob/f1ee03e3f7547d03e1478cc1fc967a9e5a121d92/arch/arm/cpu/aml_meson/m8/firmware/usb_boot/platform.c#L22

