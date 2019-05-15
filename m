Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFD9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DFF20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1qr5UW1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfEOSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:33:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfEOSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:33:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so205865pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KTn4Z+mP+RK9qfYjM/8C+gF7DHUoeVhnhade+GuKjk4=;
        b=1qr5UW1hGKCD1t9Lva/WBysBSCPPi07jakQMbn5YKqeIpXFI1j60Sqn0793aukY46q
         CmQAicqUN2t3dlERSLLqZnF3xzjDMU3ojhnsIXn0feXMYgbxasdk8E2h9K+Xtsjx3Kfs
         PCeZmfQTaJA7sH1py4q+nuMh5ZytiTYn54FamSdbLq1Elg+rNRdGVrFpaG6KI8HrqW2S
         yyEwTA4pSWJbiaTFJwRZtRPCAZia3yJHaabp+Q353LeX/l/tN807VLhvt+pB1+2utqfM
         1ECCPRDY+VwvfzTY8VDQExnN8849lbIAEzZjNKP0AZY3X4Zxahe7+M92uJAOozk8ecL8
         jNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KTn4Z+mP+RK9qfYjM/8C+gF7DHUoeVhnhade+GuKjk4=;
        b=aVEkNiZgM14qwrOdj/5fRjgIGQTukW5NcINFetO6MWqxdG935mXU/7IwHVQ9FmYszM
         71FmgLUedb75Zb91csxQ7wFVI1wg9vu+ZmyAqg/EyqdZtAgK40+VFAuXyFw0srzNcYcf
         LppSAmRVljY77GOfhnlf3BbRl+hVr9Cq632wu9zR7ujl/UGQsJDTuMVP9cf6rJHTLHDC
         K2WAPfEtwOHzgjgIHNGaEC8JwJjL+MQXFpe+vtP+K56WdGmsRo1UL06XVPlJHiHRRtNa
         YWxL0J2SECJNK+nkUnwwDgKtZ3Ur9rUsQ6LA3rz2RmakBSTBfwXRJ/BIe1spGTZlELJI
         OJVw==
X-Gm-Message-State: APjAAAWSEmfqsTDNVooeHHz2478zxiau8JOzQoUZj17p/Er0C6t0ZTxA
        02/Pk2f+f4GJpdu/72biK8AcrA==
X-Google-Smtp-Source: APXvYqy/xNuRdj0vQvs/4sL1fODiYHQj+T+AwczqxGkZPytjid2N4wSlezxn8X+oTdH3vdNaXnYwow==
X-Received: by 2002:a65:480c:: with SMTP id h12mr44587808pgs.266.1557945199335;
        Wed, 15 May 2019 11:33:19 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:20fc:89b:acbc:4e17])
        by smtp.googlemail.com with ESMTPSA id q128sm3528980pfb.164.2019.05.15.11.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:33:18 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/5] ASoC: meson: add hdmitx glue support
In-Reply-To: <20190515131858.32130-1-jbrunet@baylibre.com>
References: <20190515131858.32130-1-jbrunet@baylibre.com>
Date:   Wed, 15 May 2019 11:33:17 -0700
Message-ID: <7h7eard0uq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On the Amlogic SoC, there is a glue between the SoC audio outputs and the
> input of the embedded Synopsys HDMI controller.
>
> On the g12a, this glue is mostly a couple of muxes to select the i2s and
> spdif inputs of the hdmi controller. Each of these inputs may have
> different hw_params and fmt which makes our life a little bit more
> interesting, especially when switching between to active inputs.
>
> This glue is modeled as codec driver and uses codec-to-codec links to
> connect to the Synopsys controller. This allows to use the regular
> hdmi-codec driver (used by dw-hdmi i2s).
>
> To avoid glitches while switching input, the trick is to temporarily
> force a disconnection of the mux output, which shutdowns the output dai
> link. This also ensure that the stream parameters and fmt are updated
> when the output is connected back.

Tested-by: Kevin Hilman <khilman@baylibre.com>
