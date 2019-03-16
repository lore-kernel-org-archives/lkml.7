Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399B0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00593218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OsIybtZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCPOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:46:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38941 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfCPOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:46:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so8584861wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=Izjb63p2HaZHE2clhxW4ay43O6ayzT6ddHaT/zcyC7c=;
        b=OsIybtZMBcL7eYxdwtGFMGNBhu4cr1O7cYqznis4qPkmMFMC2xRg1jvqEmm6yWZ+uY
         nDgR7OJ39MXFEurGxjbZ0yKD9poRTld1q9ynZuz64h11V1x9e8ueJFVsncwm9RdC+rvg
         VS7MTypVdk8fAp3sSL2WSkgpTZ+NtEZLo6oKS5ONLbC4EB7/8tDbVG6BOTIDa4aM8I8h
         HoN6aIKXx+Xkw3UntrDT4RS6+zmAXA5AMp5BKFrnl0TpkeB4IC3QbqPuImryxCN/3y1i
         K+Dsl2hY9dpJNaZ6bC/GkGpL/tykqvjjGjJ0CwJo74+cQQEqKOAV1lILL+wPDHtkzQxm
         0POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=Izjb63p2HaZHE2clhxW4ay43O6ayzT6ddHaT/zcyC7c=;
        b=TTvpBAjeV5aa+LAYWyQKkwGOXqkYZKixTb8u0vB+XEMiPRCCiAPiTMcjHVATCP90Hn
         KQeWAePR7i3Of5/UwUPahgB+i+DTXnjJ/NnxaxxgkT8yknqYKE2PeG3a5/H52qtd919i
         jDU93EHgfpxmzJvgbNDN4A/sKkpSYZeErBlklDOZMTJH+5IMVMTGmv9ZHQjw1GVEP97y
         y66qXTD4a4wgABEc8Lc6/IKtN1MzJCpwT7SWbl5AYed4Q2HfOXT2VMGzcNGFszsFQdHS
         uKn+tKxPQvVqSBJ/JBChSVugTL2jlv0aoJn8rZn90c7FljrPF1gB1BbRNNucnpC43aZV
         buvA==
X-Gm-Message-State: APjAAAWh1zYkYJQNHwpjr9iFcSNAgRxktX63dHLNURaByOIaN31l5grm
        za3UrR2rqwmhNJKTuyonptxszA==
X-Google-Smtp-Source: APXvYqwDrshQotCuqfmaQZ7frmkLcdbe6cviivQMvCvYvo4PmYA6LU27kHMd22RNxp+EsSMRic+iLg==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr5639549wmh.53.1552747565340;
        Sat, 16 Mar 2019 07:46:05 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u14sm4991785wrr.42.2019.03.16.07.46.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Mar 2019 07:46:04 -0700 (PDT)
Message-ID: <5C8D0C2B.2010605@baylibre.com>
Date:   Sat, 16 Mar 2019 15:46:03 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/11] arm64: dts: meson-g12a-x96-max: Enable USB
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-12-narmstrong@baylibre.com> <CAFBinCDU_6JEJJS8yZkq0rjbqKcy2eBKFaYqgX3txGMiO5U9Fg@mail.gmail.com>
In-Reply-To: <CAFBinCDU_6JEJJS8yZkq0rjbqKcy2eBKFaYqgX3txGMiO5U9Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/03/2019 22:50, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Mon, Mar 11, 2019 at 10:58 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +&dwc2 {
>> +       status = "okay";
>> +};
> your patch description states that this enables the "USB host ports"
> but dwc2 is only used for peripheral mode (meaning: dr_mode =
> "peripheral" or dr_mode = "otg").
> do we still need to enable dwc2 in a host-only configuration?

DWC2 is peripheral-only, but we can still manually switch one of the
ports and use it as peripheral with a Type-A to Type-A cable, thus
enabling dwc2.

If the OTG capable PHYs was behind an USB Hub or directly connected to
a device, we could disable dwc2, but for now this port is always tied
to a physical Type-A or micro-USB connector.

Maybe it would be sane to always enable dwc2, and disable it for specific
boards only.

Neil

> 
> 
> Regards
> Martin
> 
