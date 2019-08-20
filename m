Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9570CC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D162332A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oDSjhL2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfHTUcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:32:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43303 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfHTUcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:32:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so4060463pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=kyEHbcI8OaQsdijhpYJ247ryUC+AhRoozS5mgSer0Qw=;
        b=oDSjhL2YNHp14i8G4UOYppX2LDYc+KQATpHHF3wGLc0y5v0WksfEU2Q+9UzD0p0SHN
         n/Nr+6HeVKShQwoQTzdLC+R8lxmiDFcjgussLq1WpOPFpSPqxMKByyofImYkvntJqwNk
         3Mbspm+ItArW2F26vGCm2bdg0vYXDZe+SrhMg8zu4du0MoVWXnSLPMyxsSf3zianCYo0
         A02OsSc2AWfDxCB8b0GLmTc1bblPdww2Yjy+0cIBAaQjiRmhYf1Uw/plFXOQsUJnD0QW
         6pwxwP4B3WbDJbe15yloVqI100IM4BuDM/PPqkWuKpqgAk29WzRZDCGu+ayucYgoznCT
         RcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kyEHbcI8OaQsdijhpYJ247ryUC+AhRoozS5mgSer0Qw=;
        b=a9/n62jtkt9Gac9nFcic/LDZW7SbGDtGU15HEnV8qSFPGmdBE+TO9g+JWdDCavo+Tj
         PAXmkXLdH5JmzwsafTzqgXrdpiIWxs9YnF7XNsST3cxUynMrFLlzpylFQM31na4P8qhJ
         0ssemd9WtxRgSZV6u+5cShWoxUCQ/JvIIzAOQ91J3PpI6msefDusnMSwcYFiFh3Dsj/q
         F3xT8YG4I+bMfQjIxJwvx/lObpHjGi7iJGsArZnWbk3J5h8owGDtQo58PPsrEFMKjw51
         xz+A8Vmokz0EiLnNFr87qrzWb5Y79kLPxkXX0FqO7rjblzQTlADmYsNiL0rc2eF17xEf
         ypVg==
X-Gm-Message-State: APjAAAUAagwFpJXEQIBI4fIsmnE0bvSsWlzzgQWTxc/W8sm14ss+AumM
        LlzgIqg+fDMWiZiIRxo49AelpQ==
X-Google-Smtp-Source: APXvYqxRPX9c2O6zHA+5ot8vijJAGlXF9Zjo5KF2B+Iw4rrZszh1tbBUVvSTk6/XMqwI7rzVhcpG/Q==
X-Received: by 2002:a63:b346:: with SMTP id x6mr26638801pgt.218.1566333161272;
        Tue, 20 Aug 2019 13:32:41 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y16sm27494422pfc.36.2019.08.20.13.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 13:32:40 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: add support for SM1 based SEI Robotics SEI610
In-Reply-To: <CAFBinCCNN_DBiriJRjw-AA-OCMFc+UgYi4oSJasJSypYFSbw9g@mail.gmail.com>
References: <20190820144052.18269-1-narmstrong@baylibre.com> <20190820144052.18269-7-narmstrong@baylibre.com> <CAFBinCCNN_DBiriJRjw-AA-OCMFc+UgYi4oSJasJSypYFSbw9g@mail.gmail.com>
Date:   Tue, 20 Aug 2019 13:32:40 -0700
Message-ID: <7hwof7d1cn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Neil,
>
> On Tue, Aug 20, 2019 at 4:43 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add support for the Amlogic SM1 Based SEI610 board.
>>
>> The SM1 SoC is a derivative of the G12A SoC Family with :
>> - Cortex-A55 core instead of A53
>> - more power domains, including USB & PCIe
>> - a neural network co-processor (NNA)
>> - a CSI input and image processor
>> - some changes in the audio complex, thus not yet enabled
>>
>> The SEI610 board is a derivative of the SEI510 board with :
>> - removed ADC based touch button, replaced with 3x GPIO buttons
>> - physical switch disabling on-board MICs
>> - USB-C port for USB 2.0 OTG
>> - On-board FTDI USB2SERIAL port for Linux console
>>
>> Audio, Display and USB support will be added later when support of the
>> corresponding power domains will be added, for now they are kept disabled.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> I don't have any details about this board but overall this looks sane, so:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> [...]
>> +       /* Used by Tuner, RGB Led & IR Emitter LED array */
>> +       vddao_3v3_t: regultor-vddao_3v3_t {
> that should be regulator-vddao_3v3_t - maybe Kevin can fix this up, if
> not then we can still fix it with a follow-up patch

I fixed it up while applying,

Kevin
