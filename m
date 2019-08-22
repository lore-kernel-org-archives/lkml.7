Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79375205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L02p7MTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404933AbfHVW03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:26:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404932AbfHVW00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:26:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so4500100pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=t4hXv9cggrlxKrmBWOfxBfWb9+XY7JPaFG3ZSJTCrY4=;
        b=L02p7MTZgJSiLnO5xtArax8M52FA4xo/lKe0Dc38mB2q1uJl2C1xNZJTSRufArXftm
         bGVtFcHDRfmEdMNyxpxyX6sAxuPAlRtvhcR1wrcvkdVNhP2hmuL3Yg3WkfzV3UuCiHpE
         qBdCZPjxT4jKeeLRp7vIfFYVvzouMA2SEyWES5czqFEzZMXBHywEztChIjLDMAB1V7fI
         bcI4zWblknUhZlnFdTAJX8+r5O8kJ4jBv9JF1ifzhV0z0Fq/JtXD7kkOCa1cwuEM3v9H
         8oCGPEeJT/iLPQ6HMXGrFK+w7sj0kORhV3asiA4zet/AHDWuTeVyQKMG7SGGinBLH/ii
         sMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t4hXv9cggrlxKrmBWOfxBfWb9+XY7JPaFG3ZSJTCrY4=;
        b=L/KVVcXd/s3EGkFm/CAJ/yjqnPdx9XjhP9EJL85YqZLMbSUenEq6UCR0j9NZr0a103
         0Gf7X5Xr0sKU8g45r/jCvo8TEN2nLwQp6xPyK7NI+qMSISgFKE3p4ZCNxj+gLxCqaYh1
         WwntZEzU/LPL1dLyAXmkzN7E7L3/EOIstRO4Y/Cvw9A2mPtWGPMXtVTXCbNFVnmwKhiy
         gYrGOOSlx7c+Qx26jXC32W5gOZhl1o1fY30JOBDFplaWgYZIRRU3O+1ymap/0lBSiRCn
         F7r+cHgEzONg3rSl/yET5s/ZxUWn3LtJq5pJqiq/yaq3MEMIgWsBt++qJ7wFuHv4NXLZ
         YEHw==
X-Gm-Message-State: APjAAAVngwWBN4CCNAmAtGPsp9QQ5H6hP0nZOyj/mLF5LZV3DXdvGIWl
        8PDwSlzIJRe9r1GkgojpxuOqXA==
X-Google-Smtp-Source: APXvYqz7feSiqp0VVtPbpzkC0q2Llqu7JNkCqqYZ963rXLnIewSU4VusDt5Oga9DB5bP6eTW3VjLdg==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr1209603pgv.437.1566512785980;
        Thu, 22 Aug 2019 15:26:25 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:89d4:68d1:fc04:721])
        by smtp.gmail.com with ESMTPSA id v145sm412995pfc.31.2019.08.22.15.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 15:26:25 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 00/14] arm64: dts: meson: fixes following YAML bindings schemas conversion
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
Date:   Thu, 22 Aug 2019 15:26:24 -0700
Message-ID: <7h36hs3khb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This is the first set of DT fixes following the first YAML bindings conversion
> at [1], [2] and [3].
>
> After this set of fixes, the remaining errors are :
> meson-axg-s400.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
> meson-g12a-sei510.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
> meson-g12b-odroid-n2.dt.yaml: usb-hub: gpios:0:0: 20 is not valid under any of the given schemas
> meson-g12b-odroid-n2.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
> meson-g12a-x96-max.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
>
> These are only cosmetic changes, and should not break drivers implementation
> following the bindings.

Any chance you can rebase this on top of my v5.4/dt64 branch?

Thanks,

Kevin
