Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA112C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BDD205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dg20y7Rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfH2Scw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:32:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42558 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfH2Scu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:32:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so2021609pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PP12ZN4mSTKnf0MT7hUsqNIn9m+j13VzNu25K1FEDNA=;
        b=Dg20y7RlR5lw3IrWb9kFXOXh3UDVfvJqh0MeNCYdV/1eNskEXHbrs3axnbFQeu4GZ8
         vFmjGng4fJdYr0EVfjnDJQMJeVh8Wo4mARH6Aeb9PtJVMKWA11VVmX93rx/9dXPGgsvY
         FxthrT/KIwHAPCTHk5xe9/pt6PCokLIvEdi/hS08sdAQp1r3q7AZLSLFBSyNbM+ZMbvl
         jdT+SIaECfhHRfr2vcg+NsuZxc177fxwtSV8aaLMTXD3pfG1Y6o+78RCTUZZhI39TjtW
         d33SNM+MR8spGoN+2NKJdC/pYKU02Tem9FYPj8xh2wOdI8Doud4CFRDFEUMtW9hqdPBS
         szeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PP12ZN4mSTKnf0MT7hUsqNIn9m+j13VzNu25K1FEDNA=;
        b=Dpt+cvt9FEmYr0/4z7gfA0xbruxavmHUxX6oHIS4UPqiAAHTeApTH6B+iStYtVK45h
         ePD09bp7PSM+wkwVXDzzWOJtCWO3iT1Lb+KaihoKJBhyFHC0bSHhurm8WeBgFHhtM1nA
         hTf4XVKcRTddYoOq4HZblWG/xnO3pN7nqFagetUEoffD4RhgDKU7H8aOtf0kAgN/gZ1W
         MSe56OEn1d61alThWybFjoRlradVIh3pqNiHFzwoPy+Xo7HqqbePx/9tgddT5z5NTz+H
         EgPzd5gabQdr7aQ5iqDQvauqrC4hY+7dCBWz0ttESCbGwO2jVS7M1mcRNwHrVc6MKDAL
         EVoA==
X-Gm-Message-State: APjAAAXhxVuX17eS1sZDOx2c2s4wR2km8aeF9DF5uwvyyYcbxjjIJFXZ
        /e8Z5529ek3kg+Er9QI5RJRanw==
X-Google-Smtp-Source: APXvYqybp8pL5qLXcsTDjwIcUXweNsYeikbXrqtzD5ZaFVHnl0f8HgRwGQ8oNuvWwwNDMokHpRBMaw==
X-Received: by 2002:a63:6206:: with SMTP id w6mr9551512pgb.428.1567103569556;
        Thu, 29 Aug 2019 11:32:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g11sm3162127pgu.11.2019.08.29.11.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:32:49 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] arm64: dts: meson-g12: specify suspend OPP
In-Reply-To: <7hy2zeuv9z.fsf@baylibre.com>
References: <20190827100307.21661-1-narmstrong@baylibre.com> <7hy2zeuv9z.fsf@baylibre.com>
Date:   Thu, 29 Aug 2019 11:32:48 -0700
Message-ID: <7ha7brrfe7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> Tag the 1,2GHz OPP as suspend OPP to be set before going in suspend mode,
>> for the G12A, G12B and SM1 SoCs.
>>
>> It has been reported that using various OPPs can lead to error or
>> resume with a different OPP from the ROM, thus use this safe OPP as
>> it is the default OPP used by the BL2 boot firmware.
>>
>> Neil Armstrong (3):
>>   arm64: dts: meson-g12a: specify suspend OPP
>>   arm64: dts: meson-sm1: specify suspend OPP
>>   arm64: dts: meson-g12b: specify suspend OPP
>
> Queued patches 1, 3 for v5.4.
>
> The SM1 patch has a dependency on the SM1 DVFS series, which in turn has
> a dependency on clock changes.  Once I get a stable tag for the SM1
> clock changes, I'll queue up the rest.

FYI... I decided not to queue these for v5.4.

I'm pretty sure we'll need these, but I I think we need to do a bit more
suspend/resume testing to be sure we have the right OPPs. here.

For now, this series is in my `v5.4/testing` branch, which is included
in `integ` so it can get a bit broader testing.

Kevin
