Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BEDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2EA2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F+EjFb8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfH0WYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:24:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35650 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfH0WYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:24:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so250313pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=vCX5b31iY8wVKWn4s0MiMbZnH0WhFm1gAfks1OXyHmA=;
        b=F+EjFb8mnDRedjegmCbjOeCNiw919VuMRS1FKW3wGCXia8C4iKHKjDFThdV6YyAepH
         IVxQKZBtOjFgT0DVcbfw0yvET5QE2z4FPf5b0EiriI4ohsgDMXB2xXfkaS6dZOtviPRl
         ewk7TlBPUAIOYOsGvyzenlF2UoYhChVGU9EW4i6+Hw8fLjfKoD9kqtw+D4z9J3w/9iaX
         AyM/gejkEBTGy+AGHf1SALhYnvs44Gnc/RDa1yQkKXX3ON/LH+VILy/+3PPo+HigkX2q
         Wf12xyWgkf6oNs7VoBquCPVKLz1lH7XgGxdvcq2f/rQLw4WqoajzaCI/hgjcY8AeBJLg
         V4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vCX5b31iY8wVKWn4s0MiMbZnH0WhFm1gAfks1OXyHmA=;
        b=ZrIBzOXsOPpM2b4h1G3N9kaaEfGUpvaRA2ayCvi6iDek4lcAO0KW9yvlAl6Z5Cm/aa
         CEfSPVhuwXXv6fOK4iRoebhFTnE0wOkYJkfWnYdYYSM1mdverOD/uWAdTqA0I/Bft8pb
         MKASuEevJHW7AQDKOa6w9rZZTs8acImr5ZRfrcVyRxj8apg7h6EoZr8bizrioLvUvr/8
         jkJQl5izvo2FlgnLycvNTC8mORewDoKVpcKuRP5L/6YCHtg4i14ib40o5jHyeBDaKmNR
         Jiw8VPM+vkyTzIzXnhY6RWWY8HRjthnuLr/c8R55gS2Nd3MTw7eh+oS455/eLuBXhYZ+
         CNHg==
X-Gm-Message-State: APjAAAVqqPFaDC9M+gzCCWhbUoF2d+NAcEDsvLAGgQL2uNAiRC7bckNY
        I+W3c6xNxheuRQYaXcsBSYeQog==
X-Google-Smtp-Source: APXvYqxx1tZzErI7XJVc/UYjGuLNFMxrAtv5a6h2jHs+k/r7nNepgGtzkViHmUpx9AdKzhbPP5zTnA==
X-Received: by 2002:aa7:9edc:: with SMTP id r28mr860234pfq.219.1566944651789;
        Tue, 27 Aug 2019 15:24:11 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id e21sm327759pfi.13.2019.08.27.15.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 15:24:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] arm64: dts: meson: ir keymap updates
In-Reply-To: <CAFBinCD0uhE9Fj1we2MkaTbk7RwtmKh7Fn1C-2nn9wiWqCoNfg@mail.gmail.com>
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com> <CAFBinCD0uhE9Fj1we2MkaTbk7RwtmKh7Fn1C-2nn9wiWqCoNfg@mail.gmail.com>
Date:   Tue, 27 Aug 2019 15:24:10 -0700
Message-ID: <7h7e6yuu0l.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Sun, Aug 25, 2019 at 6:03 AM Christian Hewitt
> <christianshewitt@gmail.com> wrote:
>>
>> This series adds keymaps for several box/board vendor IR remote devices
>> to respective device-tree files. The keymaps were submitted in [0] and
>> have been queued for inclusion in Linux 5.4.
>>
>> The Khadas remote change swaps the rc-geekbox keymap for rc-khadas. The
>> Geekbox branded remote was only sold for a brief period when VIM(1) was
>> a new device. The Khadas branded remote that replaced it exchanged the
>> Geekbox full-screen key for an Android mouse button using a different IR
>> keycode. The rc-khadas keymap supports the mouse button keycode and maps
>> it to KEY_MUTE.
>>
>> [0] https://patchwork.kernel.org/project/linux-media/list/?series=160309
>>
>> Christian Hewitt (7):
>>   arm64: dts: meson-g12b-odroid-n2: add rc-odroid keymap
>>   arm64: dts: meson-g12a-x96-max: add rc-x96max keymap
>>   arm64: dts: meson-gxbb-wetek-hub: add rc-wetek-hub keymap
>>   arm64: dts: meson-gxbb-wetek-play2: add rc-wetek-play2 keymap
>>   arm64: dts: meson-gxl-s905x-khadas-vim: use rc-khadas keymap
>>   arm64: dts: meson-gxl-s905w-tx3-mini: add rc-tx3mini keymap
>>   arm64: dts: meson-gxm-khadas-vim2: use rc-khadas keymap
>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.4 w/Martin's tag,

Thanks,

Kevin
