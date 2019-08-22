Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410CFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1720023402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Nt3rthPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbfHVUtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:49:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45480 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732014AbfHVUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:49:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so4131632plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PRyBdHjQx8YQuiWlWDuZaRk18ZPfvPfoxp9juAJhPE0=;
        b=Nt3rthPrwSqsNTxwWEFNc3alLqc2wECW4EsvmIl3hj6d8BU2kUpNDs5RWHcrvZ06Ha
         52lfo4PXNczdqV2WwSh7J71j1s9c2/Ird/b6f6N9/lKSXp1wyAiwpgq5ARNimV+FBJwv
         cL+uPV19RjKoXZFEHsh/wtmATmEuVokrT3eyx21oz/RoS6uwZNkGJWrW6uOyjEHcTS7i
         alC/R0Lz7KNgTCPha9tElM/8CQkIrGUCx+uDr6jKDLO0WS/BHxJ+xPSqDf3qIgmXI85b
         puBmPmgavEVgDXoUpxZ3OxLyXILsPEKWR37/0xyHymu6kVpnccpbfvneQBPPlwLEiaxh
         gOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PRyBdHjQx8YQuiWlWDuZaRk18ZPfvPfoxp9juAJhPE0=;
        b=PpuUCGzSSpBHuja/I6lRdhQTw9D/kP2g9kED6MpmCnNF81Ps+EIblHJOzT6WD4zNaK
         dlPGZS1a8prkPTzYbQAUCXVGBDRti5+kVzqn9r5BmDyeO6n4/yL/Idj6gGnmSd7u0r6P
         T5m4K6booA489BcCJuRx3TtMDprko4DUHvJx40ThjVDm/PFTyBzVYTEg6I91AewuaaRi
         7eymauI5ovjuS2GzanhJLL0wVDllsQWMQeVXuqhKEXC/Z4IJn1zy4rM0CUroSmQlL/Nd
         p9tKgS0og0lQurHkOrTY1FHydBI6uMU8Q5AH3eK2VW0+EHJRXFokvHl3tpCiwOCBsWpy
         AbpA==
X-Gm-Message-State: APjAAAXgAHI6QYNBeAhqNi57tlwiVtA1ENJ/OZ/ZO+1zdmDSSRvA3Uqw
        SbAKUIh0eYNbJrfV9/rUmWep4g==
X-Google-Smtp-Source: APXvYqyBOZY+Y8qPyRTGoHFxY7bYv7/YpxBaX72z5hY0CRGeCbyY7yfKY2UAF99J0VAB5mBEbwC5xA==
X-Received: by 2002:a17:902:f217:: with SMTP id gn23mr774044plb.21.1566506941988;
        Thu, 22 Aug 2019 13:49:01 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:89d4:68d1:fc04:721])
        by smtp.gmail.com with ESMTPSA id b123sm311081pfg.64.2019.08.22.13.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 13:49:01 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: clk: meson: add sm1 periph clock controller bindings
In-Reply-To: <20190822142455.12506-2-narmstrong@baylibre.com>
References: <20190822142455.12506-1-narmstrong@baylibre.com> <20190822142455.12506-2-narmstrong@baylibre.com>
Date:   Thu, 22 Aug 2019 13:49:00 -0700
Message-ID: <7hr25d2af7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Update the documentation to support clock driver for the Amlogic SM1 SoC.
>
> SM1 clock tree is very close, the main differences are :
> - each CPU core can achieve a different frequency, albeit a common PLL
> - a similar tree as the clock tree has been added for the DynamIQ Shared Unit
> - has a new GP1 PLL used for the DynamIQ Shared Unit
> - SM1 has additional clocks like for CSI, NanoQ an other components
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
