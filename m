Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA648C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 18:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856822087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 18:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VntitNls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfHCSuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 14:50:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43526 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHCSuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 14:50:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id j11so24164571otp.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9mbEKIVTR3rX3ubtzGIZrWOdTZFbd/rUfMNEZjb2L8=;
        b=VntitNls0mHbGzOMlt+i+UvbChblh92q/PPvM5C6UgtsjPJ8PRDMq+eIomOgT0xR2I
         V1l+xCSc1i4EkT3IBbhuerju6/UyCbjQXggP5UJNcLAFcFVdFP+kv0ClgrJrO9hn/2JP
         jh8+r1WQq2yIrUVBQx17AuRbW+5Sf99tj3gA72p0dfAOv2EXkOfuvfdjtFusopnu214S
         RH8SKnvENBLxdk3iAH2G3YvVGZ9kzAwTqZx2/jHl4LV9pB9TNOIeqxefRR2Sy4Q1mHof
         hvlL5sHDJV8z4AFTHpBuHNWga0BPUuz9elNC4E5pblZoFMxUL3u/DGdN2FrDmEvIZYmm
         bwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9mbEKIVTR3rX3ubtzGIZrWOdTZFbd/rUfMNEZjb2L8=;
        b=W84E8H1FCeL2uAbkm781sEJrQjkEJJWbLul6WpJ2ZHCWKhbQFUvMhMK6joeEVrqO/d
         06k14HB8Bj/sisu9L3zH9+bQA8PUNpAcB4gl71Owy7nBdJxo9N8pzV7v1IYzkKpi0Ce9
         IHm76z7Hh/s6hVbzTT/47kZ9P3ET/Gec+yKGmi8dZtC4yGWT//I2Lv6kVfi5j7bHXC2o
         BOt8iZrzLOBCQgRezWcDrsVAEjEnCPVRcbTuJVSVT6EkwO0eS5hpBpoJoIJ2Y0d9+8h7
         nmU0gaVxmQZuU3H7jkU8UqkE/J4O5Qu7+AKg3cCuNNEZPvq4aEkgftZCXbfeSzmGwEt6
         /YJQ==
X-Gm-Message-State: APjAAAXCAI8hFsyCwuIYcnGsUuSv7pSIxkvzImbPMf16/cjpPFT7myCw
        UjYzVeccY9ykCZP4bR/qiYQC6fHgxIyVeqZliQsan5LQ
X-Google-Smtp-Source: APXvYqx87Oonv7Txg2sa97Z+ShM9V1yVGyAf6/UIiu/oSv9ZcRopmssHB10WSoofKJKze3Y1SED6u/5b/hbNxXNNOnM=
X-Received: by 2002:a9d:6d8d:: with SMTP id x13mr36845346otp.6.1564858231216;
 Sat, 03 Aug 2019 11:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190731124000.22072-1-narmstrong@baylibre.com> <20190731124000.22072-7-narmstrong@baylibre.com>
In-Reply-To: <20190731124000.22072-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 3 Aug 2019 20:50:20 +0200
Message-ID: <CAFBinCAD6F=bEE8Z2MvNZLJVKZ3siPqdJ36GuCYkp=DuY3AecQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: meson-g12b-khadas-vim3: add initial device-tree
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 2:44 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x40000000>;
nit-pick: we typically use the memory size used in the board size with
the lowest amount of RAM - 2GiB in this case. so I would change it to
0x80000000

[...]
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               white {
> +                       label = "vim3:white";
downstream sources use label="sys_led"
should we call it vim3:white:sys?
