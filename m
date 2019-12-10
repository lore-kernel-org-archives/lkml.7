Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B499C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ACE20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EFHEE4np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfLJVrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:47:14 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:45703 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbfLJVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:47:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id r11so7904336pjp.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 13:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=iqFEfJ5VTHI7kv90uHb92Xkx2XtyoVgSFCJnm1RQLQU=;
        b=EFHEE4npHM3CozjgfjX1aweI4Bpjv9tMkX7xoMDlYeDvYISZA1sB3lk/hc1BhVkwtP
         dIuPZnj/E+ceF7h3Lg/s6mSR+sX02nUmEwnoilqX5KdbLwi4R8FOG1pyrZwWvIxQul4l
         yDXbRQB8pTU8Q6o4BhW36BY/0LNhm55Qyx66I1fZVehSiVDY4Dy1hEe75GmrPHauDAn3
         CYyTr50CFdq/4RtMbtJitPUhC98IGnL0uiQ87KciKaY12CPMslMMGAOlsmfy8DFhva2W
         Z5IaHcTcHflle6A/9NHtMDvq0Kxrofj54cjqMwbMsl2tqxES0SWNEBT+iqIYuS5mhuYB
         BTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iqFEfJ5VTHI7kv90uHb92Xkx2XtyoVgSFCJnm1RQLQU=;
        b=HUeTDcgTH2tjQ+qZtuwZERIkedaQY6FZcRNwEBYp0RWRYR9t9rt6PjZrPkoliF/zQb
         huZNJeG6wCnl9W5eOlOHXqlFq9PqFoOVO8yW4kRTxV0Z7ySstHsGCxAt6WWbTfuf05dD
         xnk2CZ2lL21hrIRcA5HoDlxE4yYLJjzyNAlj4rCn0a0HwqsJHNJRn+rB+bHaaN9wAkZp
         j2+MBCIVILiyCsxJKaFmh1xfj0A/j3OTjIFQ8vzjM8DDQDQYHkgTdpqjD7o4EbuuzFiI
         NlH0YmEzuBel9PjKI/AP6Pzm5nwPRxBl0UMJvacpvrfSYsLh4r51+iVPKN2jFoyUK0/+
         Rb3Q==
X-Gm-Message-State: APjAAAVDRVWxMaZlcvSDDPwDwBMvhVg6jUdjrr+9AVGuPXc41bs2Uh+R
        bhOH92UDW03vPxwiWjJRw0IUXw==
X-Google-Smtp-Source: APXvYqyWouSgn/WCq+jtqr4txQVR8xZ2GAJa0L6IdvZrZdsbAFw3Sl3H8rvTIGgfc48jOCynsAqafw==
X-Received: by 2002:a17:90a:86c7:: with SMTP id y7mr7936504pjv.102.1576014431457;
        Tue, 10 Dec 2019 13:47:11 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z1sm4338pfk.61.2019.12.10.13.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 13:47:10 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC-next 0/1] Odroid C2: Enable DVFS for cpu
In-Reply-To: <CAFBinCBfgxXhPKpBLdoq9AimrpaneYFgzgJoDyC-2xhbHmihpA@mail.gmail.com>
References: <20191101143126.2549-1-linux.amoon@gmail.com> <7hfthtrvvv.fsf@baylibre.com> <c89791de-0a46-3ce2-b3e2-3640c364cd0f@baylibre.com> <CANAwSgQx3LjQe60TGgKyk6B5BD5y1caS2tA+O+GFES7=qCFeKg@mail.gmail.com> <7hfthsqcap.fsf@baylibre.com> <CAFBinCBfgxXhPKpBLdoq9AimrpaneYFgzgJoDyC-2xhbHmihpA@mail.gmail.com>
Date:   Tue, 10 Dec 2019 13:47:09 -0800
Message-ID: <7hpngvontu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Tue, Dec 10, 2019 at 7:13 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Anand Moon <linux.amoon@gmail.com> writes:
>>
>> > Hi Neil / Kevin,
>> >
>> > On Tue, 10 Dec 2019 at 14:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> >>
>> >> On 09/12/2019 23:12, Kevin Hilman wrote:
>> >> > Anand Moon <linux.amoon@gmail.com> writes:
>> >> >
>> >> >> Some how this patch got lost, so resend this again.
>> >> >>
>> >> >> [0] https://patchwork.kernel.org/patch/11136545/
>> >> >>
>> >> >> This patch enable DVFS on GXBB Odroid C2.
>> >> >>
>> >> >> DVFS has been tested by running the arm64 cpuburn
>> >> >> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
>> >> >> PM-QA testing
>> >> >> [2] https://git.linaro.org/power/pm-qa.git [cpufreq testcase]
>> >> >>
>> >> >> Tested on latest U-Boot 2019.07-1 (Aug 01 2019 - 23:58:01 +0000) Arch Linux ARM
>> >> >
>> >> > Have you tested with the Harkernel u-boot?
>> >> >
>> >> > Last I remember, enabling CPUfreq will cause system hangs with the
>> >> > Hardkernel u-boot because of improperly enabled frequencies, so I'm not
>> >> > terribly inclined to merge this patch.
>> >
>> > HK u-boot have many issue with loading the kernel, with load address
>> > *it's really hard to build the kernel for HK u-boot*,
>> > to get the configuration correctly.
>> >
>> > Well I have tested with mainline u-boot with latest ATF .
>> > I would prefer mainline u-boot for all the Amlogic SBC, since
>> > they sync with latest driver changes.
>>
>> Yes, we would all prefer mainline u-boot, but the mainline kernel needs
>> to support the vendor u-boot that is shipping with the boards.  So
>> until Hardkernel (and other vendors) switch to mainline u-boot we do not
>> want to have upstream kernel defaults that will not boot with the vendor
>> u-boot.
>>
>> We can always support these features, but they just cannot be enabled
>> by default.
> (I don't have an Odroid-C2 but I'm curious)
> should Anand submit a patch to mainline u-boot instead?

It would be in addition to $SUBJECT patch, not instead, I think.

> the &scpi_clocks node could be enabled at runtime by mainline u-boot

That would work, but I don't know about u-boot maintainers opinions on
this kind of thing, so let's see what Neil thinks.

Kevin


