Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96249C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6703D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wGnT9m7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfHTAGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:06:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38704 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfHTAGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:06:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id m12so1761486plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qQOXa0QSQ8+7zZiklPWl3hCCcZsK+hqnhGUid1sWCU8=;
        b=wGnT9m7b9TR7M7i9MBlpKp6tEOWrDHxiWt77j4NAxEsRfJe/itBFxWCAr7XoUItxbK
         zeP9aFQ/wUJgiuSXIObMoXTjG6xFILJo8WmbIVvsE5IjpT1xQJFvDTJZ3z9i/ICG6t8D
         uZaiGVv8m+1cLepmoqsGHfcQsLCUNHsZ9uNwR7v0MTQsEjqeYijC80kN1yZM9T3qTo6B
         rlAISdOA/qwXYZCWu+6AsxlF/iAM/+nKcaZRPxMa9Knikvh7y4CWffTaqOc4tGUB5m74
         7cmuPVfGzBzCBA3wPl/JaYvwFeFl7dIz68XgvMUL4rVTW3O35pUyCwAtKvqFTer9YMkZ
         mGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qQOXa0QSQ8+7zZiklPWl3hCCcZsK+hqnhGUid1sWCU8=;
        b=NaLRBNuGxBNHJvePJO92Fkf1Xs4D7Cw0rxuuPk7q9plzJp9yfXgDKQPTQZt8aKZyzC
         38xlVLqamavOFs4qdpqNuj36TyieULyZCw9JBO5o52rUvd7oeeXrGzVznpuDU96IgUDB
         IFXQTCJ4TUCyWbGjIkvUqxaEFgPbpP2hO6ou1uG+p69UI/eXIa8TWvjEhXexkghXtT55
         rYi4dvh79mJT1Bmm/o/DZuX8n+Z/GjpzestsGm0Cqc7vr7boZJ/jF0kPg1Nc5wmTtcRd
         k6p/xFj9jGafVIq24zsKn9wEIJZkfdpHjuI3QZCx31bv+Tyds3NIZgg7qhJJb7zGhBH4
         Hdzg==
X-Gm-Message-State: APjAAAUrA7JnsunxGHx1LPwItf+PnkV9rRaizmdAxOk9JflhzBORqnAh
        MrDUBzESEPBoGWe39uUpn21Yrg==
X-Google-Smtp-Source: APXvYqxODMOaWdUOfaqCWz58eCyX2XpNVazF2y31NY989nA8wv08oSs0Wv5q/o/p1dAhx7h45OxnQA==
X-Received: by 2002:a17:902:6f10:: with SMTP id w16mr2661912plk.143.1566259565283;
        Mon, 19 Aug 2019 17:06:05 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:35:cf9b:bad:702c])
        by smtp.gmail.com with ESMTPSA id e129sm6062949pfa.92.2019.08.19.17.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 17:06:04 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 02/11] dt-bindings: power: amlogic, meson-gx-pwrc: Add SM1 bindings
In-Reply-To: <CAFBinCAT1JaK6ksD9OzCK_wEEWJdaZL2vLzGeCzVVbz9V67btQ@mail.gmail.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com> <20190701104705.18271-3-narmstrong@baylibre.com> <CAFBinCAT1JaK6ksD9OzCK_wEEWJdaZL2vLzGeCzVVbz9V67btQ@mail.gmail.com>
Date:   Mon, 19 Aug 2019 17:05:56 -0700
Message-ID: <7h1rxgvgyj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Neil,
>
> On Mon, Jul 1, 2019 at 12:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> +General Purpose Power Controller
>> +--------------------------------
>>
>> +The Amlogic SM1 SoCs embeds a General Purpose Power Controller used
>> +to control the power domain for, at least, the USB PHYs and PCIe
>> +peripherals.
> AFAIK each binding document should only describe one IP block.
> this one seems to be new / different
>
> should it get it's own file?
> also should it be a .yaml binding?

I don't think this is a new IP block.  Comparing across the various
(64-bit) SoCs, it seems to be very similar across all SoCs.

>> +
>> +Device Tree Bindings:
>> +---------------------
>> +
>> +Required properties:
>> +- compatible: should be one of the following :
>> +       - "amlogic,meson-sm1-pwrc" for the Meson SM1 SoCs
>> +- #power-domain-cells: should be 0
>> +- amlogic,hhi-sysctrl: phandle to the HHI sysctrl node
>> +
>> +Parent node should have the following properties :
>> +- compatible: "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd"
>> +- reg: base address and size of the AO system control register space.
>> +
>> +
>> +Example:
>> +-------
>> +
>> +ao_sysctrl: sys-ctrl@0 {
>> +       compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
>> +       reg =  <0x0 0x0 0x0 0x100>;
>> +
>> +       pwrc: power-controller {
>> +               compatible = "amlogic,meson-sm1-pwrc";
>> +               #power-domain-cells = <1>;
>> +               amlogic,hhi-sysctrl = <&hhi>;
>> +       };
>> +};
>
> I'm not sure that we want to mix HHI and AO power domains in one driver again

We're not mixing here. These are all EE domains.  They just have some
control registers in the AO memory region.

> back in March I asked a few questions about modelling the power
> domains and Kevin explained that we can implement them hierarchical:
> [0]
> unfortunately I didn't have the time to work on this - however, now
> that we implement a new driver: should we follow this hierarchical
> approach?

The more I look at this, I don't think we have a commpelling need to
model them hierarchically.  The main reason being is that of the 3
top-level domains I listed[0], we can only managing the EE domains in the
kernel.  It doesn't make sense to model/manage AO domains because, well,
they are always-on (AO).  The CPU domains are managed my the PSCI
firmware, and we don't/won't have any control over that.

For that reason, I think it makes the most sense to have a generic
driver that handles all the EE domains.

IMO, the SM1 driver that Neil wrote in patch 4 of this series is 80%
there.  If we generalize that little more, it can be quite easily used
for all the EE domains.

Kevin

[0] http://lists.infradead.org/pipermail/linux-amlogic/2019-March/010512.html

