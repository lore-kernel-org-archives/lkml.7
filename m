Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A86C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657B82054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQDQpPxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEFNR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:17:28 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44520 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEFNR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:17:27 -0400
Received: by mail-wr1-f54.google.com with SMTP id c5so17197191wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Oh8yGa7KaAND9FbnIE72MJkl17NYp9pioZYW/WS5+WI=;
        b=yQDQpPxkJSKvfbzaktGEBf0ycIst2QjKEXx3+YFbiYH4OWMpyIx3IOJ+howJR5SsrR
         N9mjZfTyUAXKsfsMQzcqFX8wORz2DNYVtsTc1U24KlVAB/ogk20bGzkaaEsh8d8RDlLM
         IYYTyH6w9F8UOfYguLEXyqxWHi/dsixm4Sz1angRWNPiVApPgADeu7iUH0wjoyG6L2my
         FR5e+O5dd2H0OvEYCMyUPDYDyy88O3TPZDWa2l/Qr+8n3VCVxxvBwcdbzIpHtw5r+0iy
         hCCQbt3Nq36zq++eF8q1dQIjomUAnVu/ucGvx0ByMFDP64HaNYdLiuno+L/CUMu/pbHa
         dA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Oh8yGa7KaAND9FbnIE72MJkl17NYp9pioZYW/WS5+WI=;
        b=HUA+uJecYqcL4eQ5CtyJxaqnkohKsSUU6X8LR01YBxkT40YLX9t8zoTW+VPBA2W/pN
         sJur868wJcljfbG/8Yn02GIqAE9iEw9KyWALhsTPcTxQ4Zk/z81VgN4kZ08RNCH7DF4R
         gigwHZDlbc4IiBOgjMvu6rr85e4T8Wd5+20PrXeA4oiU5O4eJdf7T8wHoE6+c94Rz5UN
         oLDgAhTCLHRuPJHwU36ugLtGu4h6lYVuGz7yB0RCyjkFjlAZ9VDnbYzUq9Sy6tsaQXP/
         tRb9hjazztUIRFWGL1cQxMw9n9fTtS/VHGaa6Z4vDCN2m86YWZdtdNAZ5nqziElIyCqA
         K5nw==
X-Gm-Message-State: APjAAAX+ISjcyjWQczz918wOJj0Jly0EX5fixa1NMqAViAQtCLWM3tzT
        rHKKKXZL/si+NJdFFicJ9vC/bw==
X-Google-Smtp-Source: APXvYqwplCggB0mb0G5YFvWUgsL21gQN/BZYesjAoZaq+VDrHAYzlHs83Lch/plxeayppFbm1f1njg==
X-Received: by 2002:adf:8068:: with SMTP id 95mr17411560wrk.174.1557148645735;
        Mon, 06 May 2019 06:17:25 -0700 (PDT)
Received: from [192.168.0.41] (64.93.129.77.rev.sfr.net. [77.129.93.64])
        by smtp.googlemail.com with ESMTPSA id v18sm9050787wro.11.2019.05.06.06.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 06:17:24 -0700 (PDT)
To:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Missing patches for thermal for 5.2
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Message-ID: <b3fbf910-d073-1dd9-649c-eea370ae71f7@linaro.org>
Date:   Mon, 6 May 2019 15:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Eduardo, Zhang,

AFAICS, the following patches are missing for 5.2:


[PATCH -next] mlxsw: Remove obsolete dependency on THERMAL=m

[PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl setting error

[PATCH v3 2/3] dt-bindings: rockchip-thermal: Support the PX30 SoC
compatible

[PATCH v3 3/3] thermal: rockchip: Support the PX30 SoC in thermal driver

[PATCH] thermal: cpu_cooling: Actually trace CPU load in
thermal_power_cpu_get_power

[PATCH] thermal/drivers/cpu_cooling: Remove pointless test in power2state()

[PATCH - resend] thermal/drivers/cpu_cooling: Fixup the header and copyright

[PATCH - resend 2/3] thermal/drivers/cpu_cooling: Add Software Package
Data Exchange (SPDX)

[PATCH - resend 3/3] thermal/drivers/cpu_cooling: Remove pointless field



This one is pending:

[PATCH] thermal/drivers/of: Add a get_temp_id callback function

The series [PATCH v3 00/13] QorIQ TMU multi-sensor and HWMON support
depends on it.

Hope that helps.

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

