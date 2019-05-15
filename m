Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EC3C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E512084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PetMlvwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEOAX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:23:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEOAX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:23:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so370905pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wdHUSojhWcuxM8z/4jOLd1SbHmFBMx7gtwGTAimM+xw=;
        b=PetMlvwplvZt9XhqbP1EVC/t4NW4tFZGnpR6f4xmO3APjwNOBr7IRwhHO2zXUzogKc
         DsrzEtiMeD2BO9dlHELmxuxdz1TMetbRaKuAY1gv/3DHtJvAhVQPUSHNr9yRn/DPdXxU
         C9Ld1A72ps2umwULHtHnM8mvYuC1ehSUCxVbZz0sMTTHvDwc/g1J+uAoE6NJbTTFcte+
         FywVeYiBt0N4dpLoME85x0Ii1PI2ayjNBf4u0slU1u9m4RfrYwFr3uUgGWvtw5xvKhnm
         6dQzntHqJYBbFROvCBtrtixkubohPxPkGXaD0zZPJYjNw0I4+BeB325/IxQfhEWaZ/9W
         RwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wdHUSojhWcuxM8z/4jOLd1SbHmFBMx7gtwGTAimM+xw=;
        b=uEGeARwIlxdN1sZwX/vSmcdtoMy2d1G6n7ZxsgVjkqq7FKInc3AV72XKkqjzAja4mw
         g2qxh0ySwVUSHHb82dn6gZknlDXKshBLwBEP1T/BmrPvqRJQBzPpmuiuEj6FssHbkN4y
         zCmSEN7KtCycwnX9NzLURbKRLMU62P5L4un1bSUcB2OdEgBBsLWC6nlabOdWLJbZlmON
         //+kS5BrQ3w5SfTKrQnXQj8RtlcGA32CeLWO7Rhdm9xAm/FXeXzgVg295mwnL7u0fd4A
         kpEK5nBlUKzT50AqegTMbVjiaN49NdyeCCAUIwbGM0vsSGo9WZfzY3hLRJp8l+x7AKVj
         tEeQ==
X-Gm-Message-State: APjAAAWcAdqEa2YMCzwxF1eaCiAKkaKlaX9rR6L59kpmM6GLGSs3rzNn
        QgvP3KGzRbfiqZnk4hLhRhuYe0ExwV+rew==
X-Google-Smtp-Source: APXvYqy2MGn1Ku2hW9/ADj9wkfT6F3sGWHPjub0aWtj/eqxycREWUwqdPl+DGtvldVl/FuD7c7c4+g==
X-Received: by 2002:a63:4820:: with SMTP id v32mr40593010pga.89.1557879835950;
        Tue, 14 May 2019 17:23:55 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id n35sm275804pgl.44.2019.05.14.17.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:23:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: meson: g12a: add mmc B and C
In-Reply-To: <20190514091611.15278-1-jbrunet@baylibre.com>
References: <20190514091611.15278-1-jbrunet@baylibre.com>
Date:   Tue, 14 May 2019 17:23:54 -0700
Message-ID: <7hd0kkd0px.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds the MMC controller B and C to the g12a SoC as well
> as the u200 and sei510 boards.
>
> MMC controller A has been left out on purpose. This controller is
> special on this SoC family and will be added later on.
>
> Notice the use of the pinconf DT property 'drive-strength-microamp'.
> Support for this property is not yet merged in meson pinctrl driver but
> the DT part as been acked by the DT maintainer [0] so it should be safe
> to use.
>
> [0]: https://lkml.kernel.org/r/20190513152451.GA25690@bogus

Queued for v5.3 with tags from Neil and Martin,

Kevin
