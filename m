Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12FCC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBFF217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HqgKPjcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfEUURH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:17:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45054 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfEUURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:17:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so47847pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+U7EhkgNCx5N+/sbOp9r4l15ZHheGrRGlRzMptIRhaA=;
        b=HqgKPjcEMLYIhTFv4+lXOB6xsRwOq5dQVBJ7DwfcuN5QXB15HgJCGvWuPCM9HX/Njp
         6olL31mUpSBOQVIQv3KZ3dIlBQ0T0GyJCrx7wdg18OL7sdvNmQxRfnjZQUi6di9OfESr
         YKkrcHQMKBwZHPfqya4JADQu0hYZawl74107Qik8twu+G0YdVTzctrRxHJTt9odcNQiO
         y0wZjx94ShhngdQgPCjJ2ML17wMQ7KQ8BRqJwIG4aPbU+Y0UsjsvTXHbu1TO9GRA5txn
         iYCMr967kSpiYV9CbA7XO1M/68G7Lr1wQX1B7c5KqhgnDeDCOms6G9MIQrwrKpuYqdmA
         5cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+U7EhkgNCx5N+/sbOp9r4l15ZHheGrRGlRzMptIRhaA=;
        b=DnPQyWNTCMIP/ZWMS9Gp3QVsyOPzaDkX1VhTsOXSJJoqhcF+iFrNbq3zmzmYL2FCfS
         NsNGJmt4f8Cdbi87TbVQSVgKI19jslRaVWRyFRR+EMacEO5PT4ooBR+k/LFSTx9ZruNI
         jypANM1JY4xCMrzLyek+f5CC1iirp52xIfQVlpBbN1bVrlnwTg3Qa4VZ4cZERHXBf/K+
         orSsmbWq+8aaypfVqnJpmnVqvOo4E+4V8JTd765KPYPt5gi5IaSHIOhLh+TnqrSE95CC
         h4MBT8wDKn4WutikBzXua/LtYo09mb/9Na0XQGIK1ptaHxq0D80yK9L1klWbkQHRnnZE
         WmiA==
X-Gm-Message-State: APjAAAUcmlES7sSPn4MwOr4i16LqDn/98oBBqiHEgSYBWgpZEmyAPPW5
        WerXg05OweUdTOt7U+u4otldaA==
X-Google-Smtp-Source: APXvYqyDm+21VAV1EKWAQN6SGykpfXphy7AS6UIfBbG7F2FB/TGrBZdTBYbfhc9xQUazNzi85VAuhA==
X-Received: by 2002:a63:d949:: with SMTP id e9mr84615322pgj.437.1558469826585;
        Tue, 21 May 2019 13:17:06 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b1ca:3800:3284:d770])
        by smtp.googlemail.com with ESMTPSA id j22sm29870986pfn.121.2019.05.21.13.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:17:05 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <ccaione@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/10] ARM: dts: meson8b: update with SPDX Licence identifier
In-Reply-To: <CAFBinCB3Q9ZZP6UwiivWB_eb47vh6j2N9Og1qZWAi6hm4+17Tg@mail.gmail.com>
References: <20190520143812.2801-1-narmstrong@baylibre.com> <20190520143812.2801-9-narmstrong@baylibre.com> <CAFBinCB3Q9ZZP6UwiivWB_eb47vh6j2N9Og1qZWAi6hm4+17Tg@mail.gmail.com>
Date:   Tue, 21 May 2019 13:17:04 -0700
Message-ID: <7hsgt75zr3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Neil,
>
> On Mon, May 20, 2019 at 4:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm/boot/dts/meson8b.dtsi | 42 +---------------------------------
>>  1 file changed, 1 insertion(+), 41 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
>> index 800cd65fc50a..c38b0828b7ec 100644
>> --- a/arch/arm/boot/dts/meson8b.dtsi
>> +++ b/arch/arm/boot/dts/meson8b.dtsi
>> @@ -1,47 +1,7 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR X11
>
> the GPL text below states "either version 2 of the License, or (at
> your option) any later version" so I believe this should be GPL-2.0+

The "at your option" here is key.  IMO, we should stick to the more
common kernel practice of GPL-2.0 unless the original author (Carlo
now Cc'd) wants to make it GPL-2.0+

Kevin
