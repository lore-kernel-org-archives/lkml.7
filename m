Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D514BFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A505F2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="epCRTxPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406476AbfJQPnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:43:43 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40079 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfJQPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:43:43 -0400
Received: by mail-pf1-f180.google.com with SMTP id x127so1900855pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VOvV2/r2ynt55cnuM6fNik0rL8EihZtai79HG+PQGYs=;
        b=epCRTxPcIzW1JK1hav0kYxQFV4/KtoeRzGuJPSEcPwm+07F5s+hclMNoXvQqf4/Xn1
         PHRKmwonpyafnqMNOi9dcJPoPWnD3ya7CTnu9Qry/TzAB4HpaKOrbK0R0qaDDbOiEQuc
         NAMjpGaz/LGOeUnEU04tjxWY9G5Za9Eys1QYmuHKt94WBRAaXPRhFZjOql8+NYkH3ors
         UfFt5ENN2F9lK41nMVEmg+Mu/70pL+aDZgePCLsFDjUW2Ci+iy3EgWg4J7mRQpCA0hge
         OOvt2UsggArcB7npbmFQA0cehGx67F4L0qjr14Beidi0Rt1MqMZm6SjLMBOoC32THmyd
         CsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VOvV2/r2ynt55cnuM6fNik0rL8EihZtai79HG+PQGYs=;
        b=eOpzJr6usjlMtVACMP0rX5D6hhMNpowd22+e/uJAs/xnQp2brIwKhZxqtIwtt/3xuD
         hYelHLfTkirnlRR8Xj+BV3GjarkG+xevWQ2oVdN8WY7hmcshbdEQ1YzoAe1UxW5Cledu
         cyeqgahlPbldUGgvybKfB7Qzvhz+KZf/9xQV7jHnz+TTM57AcY+5H0bP/5BmQdlAUd/F
         ef/jSOl8aBcCcHQM2wJPygyF8b6ZbmtcQnqh/cuFhelFt3NsomvOj9z7t8gsaO/lK+IY
         9azm0p+RlsF9UgceXkZs41iGv9eAVMw7cPrFRrLfiHUXSsn7vc4/JX3PtWHC2d77/asv
         UbJA==
X-Gm-Message-State: APjAAAV25LtQwwgU8TUAF6ouW4q9mP8LsSxivd3yfIXVEGiMkgDFXFPC
        wCFvNRs624eHcHVzT2ZvRdEqeo0WZng=
X-Google-Smtp-Source: APXvYqwBC3rv9yHdPPniodMnf3ve5F6d/VBydNViIQXvnFmqx0IoTgB6MJOo2TPQ1KZma6BcLkaNWA==
X-Received: by 2002:a17:90a:3608:: with SMTP id s8mr5226930pjb.44.1571327022410;
        Thu, 17 Oct 2019 08:43:42 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:d8f2:392e:5b44:157d])
        by smtp.gmail.com with ESMTPSA id f14sm3987624pfq.187.2019.10.17.08.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 08:43:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com
Subject: Re: [PATCH v7 0/7] Add support of New Amlogic temperature sensor for G12 SoCs
In-Reply-To: <9ade0e3e-1bd7-c49b-44b1-2361f1e3a7b1@linaro.org>
References: <20191004090114.30694-1-glaroque@baylibre.com> <7hwod4fxwb.fsf@baylibre.com> <9ade0e3e-1bd7-c49b-44b1-2361f1e3a7b1@linaro.org>
Date:   Thu, 17 Oct 2019 08:43:41 -0700
Message-ID: <7h36frcr82.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 16/10/2019 18:39, Kevin Hilman wrote:
>> Eduardo,
>> 
>> Guillaume La Roque <glaroque@baylibre.com> writes:
>> 
>>> This patchs series add support of New Amlogic temperature sensor and minimal
>>> thermal zone for SEI510 and ODROID-N2 boards.
>> 
>> [...]
>> 
>>> Guillaume La Roque (7):
>>>   dt-bindings: thermal: Add DT bindings documentation for Amlogic
>>>     Thermal
>>>   thermal: amlogic: Add thermal driver to support G12 SoCs
>>>   arm64: dts: amlogic: g12: add temperature sensor
>>>   arm64: dts: meson: g12: Add minimal thermal zone
>>>   arm64: dts: amlogic: g12a: add cooling properties
>>>   arm64: dts: amlogic: g12b: add cooling properties
>>>   MAINTAINERS: add entry for Amlogic Thermal driver
>> 
>> This has now been thorougly reviewed/tested.
>> 
>> I've queued all the "arm64: dts:" patches via my amlogic tree for v5.5.
>> Can you please queue up the driver, bindings and MAINTAINERS patch?
>
> 1, 2, 7 right?

Correct.

Thanks,

Kevin
