Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC646C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2C2208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L4akB9WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfFGQ7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:59:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33832 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfFGQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:59:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so1540487pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=MNcJZMA4q9Qof1r/YfMqt/g7trBAYJtueHwu9fzJ0WI=;
        b=L4akB9WNfbBACsOjFsABrYcUMZ0d45A2WBoImzWXvmDzcQfL5Z9zXF5ol6MTI1/Igh
         7pKIWrGAuHb4n0nXZdg1NdjUDchGYPC9QOZxMuh5PCgJCTKwZsxN9o/q3Irps0B2LtlG
         Lh2FWJdktH2VCUfpDaSfHxG62xGrNmB/kuoRpbzK4gS3dLpokLfSX2eW7ExInlFDuc1m
         ziXEQzAH5J1A1ad/7Ud2x/Wii4u1RO/16chpf8v3a1Y4CSHsixCLtbRaPbd2B6RuCK4I
         cMleBhOaoan2iZh3a0aZwuic7Cedsvi9+vfrLbNo3XN2Wp6J1kkJxyJ1Wgqj25K+yaSF
         iUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MNcJZMA4q9Qof1r/YfMqt/g7trBAYJtueHwu9fzJ0WI=;
        b=fqrq5dePRy1QBPzAlW/mGHAQzz1eEjvoX1fZ2oz+adSXsio4KG1Imk2cCj+79p/F09
         Q5bFrMkZB9suxBOR7ERwAeiyqgTjnVCpGEK3DeqBZnCbsroLYfPv6EL8CG09OHCf4CBg
         qluKsSJFHj/3P/2tNJbyNkmdngSRPM7ZdNPDtOmCem+4bl35m5nOrModPfoI4NXs/yDm
         SRWn/2MWDG3a8yjngmSWpC7Er9tEKgEnwfrh2ETHUQb0YDkX5MlTrkH/0IAOCVXPLd52
         UV02URYbkGuY4gnPSOjMd6UVdg3DiEqjZ2N7P9YgofrB0Jhg+VB7rcx6EOf0nIGbGj4z
         vCIA==
X-Gm-Message-State: APjAAAUPKw4G7EIiOQ9rV6wMrLWT8x+U9aePKvxYgTg5jVDn8+3N58e4
        3cM2trHE0CdQ9WKdN33j2Ipgvg==
X-Google-Smtp-Source: APXvYqxjjfrU5qo3ODqkgEdkborlSAFDI2qtFKnUIi8CiMXFsJ1sXPjdIpXVmVAhK7v1FC47cE9/Hw==
X-Received: by 2002:a62:640e:: with SMTP id y14mr57808577pfb.109.1559926794332;
        Fri, 07 Jun 2019 09:59:54 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id k6sm3828350pfi.86.2019.06.07.09.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 09:59:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] arm64: dts: meson-gxm-khadas-vim2: fix gpio-keys-polled node
In-Reply-To: <c8144470-361b-ca26-71c7-d152f976ae19@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-2-narmstrong@baylibre.com> <7hy32ecwlu.fsf@baylibre.com> <c8144470-361b-ca26-71c7-d152f976ae19@baylibre.com>
Date:   Fri, 07 Jun 2019 09:59:53 -0700
Message-ID: <7hblz9covq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 06/06/2019 22:00, Kevin Hilman wrote:
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>>> From: Christian Hewitt <christianshewitt@gmail.com>
>>>
>>> Fix DTC warnings:
>>>
>>> meson-gxm-khadas-vim2.dtb: Warning (avoid_unnecessary_addr_size):
>>>    /gpio-keys-polled: unnecessary #address-cells/#size-cells
>>> 	without "ranges" or child "reg" property
>>>
>>> Fixes: b8b74dda3908 ("ARM64: dts: meson-gxm: Add support for Khadas VIM2")
>>> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> 
>> This patch is missing a S-o-B from the author (Christian?)
>> 
>> The From, Suggested-by and Signed-off-by send mixed messages.  Please
>> clarify if if this is missing a signoff from Christian or if the author
>> is Neil.
>> 
>> Thanks,
>> 
>> Kevin
>> 
>
> The author is Christian Hewitt <christianshewitt@gmail.com>
>
> so s/Suggested-by/Signed-off-by/
>
> Do you need a resend ?

No need, I'll fix up locally.

Thanks for clarifying,

Kevin
