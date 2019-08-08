Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75789C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D3C206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bs5i/HLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404913AbfHHX4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:56:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42743 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404428AbfHHX4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:56:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so44249882plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=biT4M0YoucThQSlA/K5VgSiTRUXRF7LeVpBHBAObouA=;
        b=bs5i/HLmqpFLNfigz0Plz7De8d6lkN6hXwBWct8V8PSzTT1gZmybZTTSaBX2gcQz1v
         v+7+2uQleyUr9NGkcELJe3PZuhNx3AsEC/S1wtLUp/oqgHJGfSCL+kZAfe403EZ0iOCe
         azgHd3tVGBsX1d6DBelSeXFm62Bh1g95sWpPcBua8YwMfpdyLVBcgR9LF76ZyhwBxF3m
         C24AakAWdz7BY4zFnxV4GkBN9U6qMBYkKu9X5km6u7ECs7tXBSzZZ4Qk/ZLt5264adm6
         MhUQF+1Slcha3iS9i5kCM0BIBkkTfEW8+DF8B6M3mEy55X1AmkuKRcgq8LX0XDlU8PDS
         UFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=biT4M0YoucThQSlA/K5VgSiTRUXRF7LeVpBHBAObouA=;
        b=WZb4ItovYAw5IMBaLzijPhIDm3wWdlGXgUP8wvchSitPG5283Ymu+WJwZk6xF0FgWL
         6VCXkWMYmuFyEU9Wyw01ZhhfRKK9LC/TnNC81MlH9Ld21tU1onXZOR+y/oIY4uD6PHoj
         4xF1bpIs0imQIb2jZg8z9nV1XOgFd5/1EXeFq7QnvFjNDAZkvTksuA3Pu0K8/I/Q9RoL
         JLctKug1XjxIF8AyncbNOHnQQh1R9QUYZFj2btqQ98C13dU12yyNowWBqTZas9kZTm4X
         1YemQwQyUEr9mykyZ/Doo63YoJ0RZduGZb7FeYxjRcW77l+3NCt1mVOhad/dLCNi4PD6
         LRdA==
X-Gm-Message-State: APjAAAUfB6nUxvdlwW7/rW6cDMDH9w0VkRnCURptYPe+k4GxfMrIfG3v
        6SOaCuDMCUnfE89UtJWdqC7AHw==
X-Google-Smtp-Source: APXvYqxps1OkwzB/X0vvisKNGQAqs8R5cKyD/OoIPRFmJS3FKuqkJGigsszmdTGeScs7OS0FWzmHGQ==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr16472342pls.267.1565308570262;
        Thu, 08 Aug 2019 16:56:10 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id h14sm126117376pfq.22.2019.08.08.16.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 16:56:09 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: g12a: add support for DVFS
In-Reply-To: <7hwofrh1md.fsf@baylibre.com>
References: <20190729132622.7566-1-narmstrong@baylibre.com> <7hwofrh1md.fsf@baylibre.com>
Date:   Thu, 08 Aug 2019 16:56:09 -0700
Message-ID: <7hk1bn43fq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> The G12A & G12B SoCs has kernel controllable CPU clocks and PWMs for
>> voltage regulators.
>>
>> This patchsets moves the meson-g12a.dtsi to meson-g12-common.dtsi to simplify
>> handling the G12A & G12B differences in the meson-g12a.dtsi & meson-g12b.dtsi
>> files, like the OPPs and CPU nodes.
>>
>> Then G12A & G12B OPP tables are added, followed by the CPU voltages regulators
>> in each boards DT.
>>
>> It was voluntary chosen to enabled DVFS (CPU regulator and CPU clocks) only
>> in boards, to make sure only tested boards has DVFS enabled.
>>
>> This patchset :
>> - moves the G12A DT to a common g12a-common dtsi
>> - adds the G12A and G12B OPPs
>> - enables DVFS on all supported boards
>>
>> Dependencies:
>> - None
>
> Not quite.  The last patch to enable DVFS on odroid-n2 has a build-time
> dependency on the clock series that adds the CPUB clock.
>
> I'll apply the rest of the series to v5.4/dt64 until there's a stable
> clock tag I can use for the clocks.

In order to test this, I noticed another dependency needed for the PWM
regulators to work:

   https://lore.kernel.org/linux-amlogic/20190729125838.6498-1-narmstrong@baylibre.com/

With that and the clock deps, it's working well on my odroid-n2.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Thanks,

Kevin
