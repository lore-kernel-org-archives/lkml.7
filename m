Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A0C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC1920637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Os0qYB1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLIWYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:24:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37226 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfLIWYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:24:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so6491754pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=x3D7n4O3kX8B7KT//FIge0j+XydruvOFEBnBKMDQn84=;
        b=Os0qYB1gNkMhu5bccBa/iWtRXy7cUmbltuRSoHOA25++iLBHnsK4LQqIGSW/4VmaUC
         rFx94GXTakBK9ErXWX79g1pQR3cUrClNexIUuGxabmhdbuyaLvBPj3lveAg8nlbfyxrb
         NDe0LNsNQUiOD/ROkrf69V1RTxWrq/tqRMR4Gw/2VFO9TPgIGD8rWvy/QgD2u+VkmNk+
         RrInxkfVAJKiuPt/3JknHM2YxMUH16ZEBeW0JzY1pC9ps/Y2av9qGc5qYan8b3kIHdvI
         uFyeenmN6uxhFlomDtFrM0WjE2/gAidWiYxA0PJ/NvejI6fB6VyRmXxjgRLneQobSsU1
         3bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x3D7n4O3kX8B7KT//FIge0j+XydruvOFEBnBKMDQn84=;
        b=QttBJZkVt5pcsHyoTVMY7bdkxqf/KZRYkqWNSmbKbTpThnPdkYa8cXdGsm/lL1aZPA
         jjiYdP4rZQHWNbCciBSF3ZrT+IEUEV1yu8FCt413aQl06L869hmkfQMbAk8RrarQK9gM
         ursAqQuUcR8nwdswmr82sogp+VfuXpn/F/Wp70axjrrU3H9ey4AClMlhe9a6etjUI3Y5
         r4W4zLOlXhaiuQ+UmzlrDJnoCTlaEhPfQrNQTHBIOPzn8gTMiENy0GZVO1c9NGsinrkb
         YbyyovQKX7IUMkH66mu/IYj5kTG9xaZToqLBXgoctwut/0vjKSr4B1zivg9OpVNLW46u
         mIWQ==
X-Gm-Message-State: APjAAAWVBIRGpnc8/Tl0LzD2Tk99i3vENSDsW0OuoFQI6rmt2+ArCSN8
        lY4xRGronuP++wxR30Cl447Z63fIedvTBw==
X-Google-Smtp-Source: APXvYqwmpgZFnfs15zotdT2qkfcibGHFV7p0FuUe95hjRjGSKRP1wFd1Bqfcrf67Nov5zS8f7qjaDw==
X-Received: by 2002:a17:90a:d783:: with SMTP id z3mr1473865pju.3.1575930294097;
        Mon, 09 Dec 2019 14:24:54 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 16sm452756pfh.182.2019.12.09.14.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 14:24:53 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH RESEND v1 0/2] amlogic: meson-ee-pwrc: two small fixes
In-Reply-To: <20191130145821.1490349-1-martin.blumenstingl@googlemail.com>
References: <20191130145821.1490349-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 09 Dec 2019 14:24:52 -0800
Message-ID: <7h8snlrvbf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> While working on power domain support for the 32-bit SoCs I had some
> crashes when trying to actually use the power domains. Turns out I had
> a bug in my patches which add support for the older SoCs to
> meson-ee-pwrc. However, I didn't notice these because the driver probed
> just fine.
>
> This is my attempt to spot "problems" (bugs in my code) earlier.
>
> RESEND: sorry for the noise, I forgot to add the linux-amlogic mailing
> list. This is important so patchwork can pick up these patches.

Queued as fixes for v5.5,

Thanks,

Kevin
