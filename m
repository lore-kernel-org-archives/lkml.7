Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64A7C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B42C20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HrjBeS9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfHLUrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:47:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40130 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:47:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so50077493pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hAImoiaUIllvdsBRFvJI6AVDH7GSLwPssj/NGvLfhGc=;
        b=HrjBeS9ZsyLwpI+3rMjl+CHZ311L6zE/1Ign9jTBQ4c4bZeGZ1oNrKSzY7jklwfZO4
         jQz8qscJDMHkT8vWn/AKmJswfNLnvSHbdqAS9ciRAZt2QV2W7tn8eKuJL1iuU0y5Rt3J
         opoSVCa4fYTt4ao5aYgahFxd6xI828mrQq9z9l9I/RDpxckQaSfg6mFv2k5u3RmFXzqx
         IalBD4kFyngp+o5yIvxtk3xxAsUghKBb0Vedfr3B5suwP+TWukez9VqD3MB6aiSLc+xe
         TlBRrRy0VSsyU/qJANpdR1I8y7/IWXiICWjwQGwq6UgTd83Ee82vjynJKciy94+7YYes
         1mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hAImoiaUIllvdsBRFvJI6AVDH7GSLwPssj/NGvLfhGc=;
        b=YfPJ84n2Zxr23FLm1nnyBn2hpd06c29IT1iVFanbC8Sb642lqS28gLRzUmUBXnuh8H
         LbAjyym3i/W5TlE5BfnnPtzk9GKwGS4B7jz+4iLK44altBLBaEadmd2uaO6K6qyKtfHy
         IzJOVjyXoKI4iXbLFaHGFEFWx7MMq2wNV5TOeHdSUZIJ+WeB9c7o77BMuVVd41sY0Mfh
         MvMW6Lws1bOwP2omDlucs+LqTJTocPhXyAua/1IP0bn8woOdwAJgsWr9VTNC412SfvTB
         xKqXn28Cq1bRoFuDSgW25cZdi/4yhbJnouQbAB2F2qWrnPWdVWQTKRmaer3cuILto3Pf
         /Rmw==
X-Gm-Message-State: APjAAAW1ZcoSQUb8LK8+ezHVsVhtUEN1Xm7Vd3HwUprbnf2HG1hpAs92
        ffdItq/QFwEz7cD8djrLOs91qA==
X-Google-Smtp-Source: APXvYqzeXAq4ry5YjGbwv5kPRL4fMM13o6q1ipU3KtUFAp8Qt4Y/TkCu66N8CMtnsn0Zb3DXcgVCPw==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr31765219pgp.368.1565642841591;
        Mon, 12 Aug 2019 13:47:21 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:14bb:580e:e4d6:b3a8])
        by smtp.gmail.com with ESMTPSA id k8sm100204280pgm.14.2019.08.12.13.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 13:47:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux.amoon@gmail.com, ottuzzi@gmail.com, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/1] ARM: dts: meson8b: persistent MAC address for Odroid-C1
In-Reply-To: <20190812175004.24943-1-martin.blumenstingl@googlemail.com>
References: <20190812175004.24943-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 12 Aug 2019 13:47:20 -0700
Message-ID: <7hv9v2157r.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This series makes Odroid-C1 use the MAC address which is programmed into
> the eFuse.
>
> build-time dependencies:
> none
>
> runtime dependencies (without these a random MAC address is assigned,
> just like before these patches), both are already part of -next:
> - "nvmem: meson-mx-efuse: allow reading data smaller than word_size"
>   from [1]
> - "net: stmmac: manage errors returned by of_get_mac_address()" from [1]
>
>
> Changes since v1 at [2]:
> - only add the nvmem cell to meson8b-odroidc1.dts as suggested by Neil.
>   It turns out that neither MXQ and EC-100 have the MAC address in eFuse
>   (which means only 1/3 boards has it at the given eFuse offset, so it's
>   not worth having it the common .dtsi)
>
> Kevin: you already have v1 of this series in your tree. Feel free to
> replace the two patches from v1 with this single one.

Replaced.  Thanks for the update.

Kevin
