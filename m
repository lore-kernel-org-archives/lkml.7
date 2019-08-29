Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3736C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA9D21874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SNx8bxK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfH2SMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:12:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46588 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfH2SMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:12:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so2580897pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=A7u147Wje9ZAoxZSgxkGO16cCmIS7cio1ghCQtK3PnA=;
        b=SNx8bxK8xYtZf3R7Yb6iVttjoaWALJFDJgJjneuJzwyKfowwLpbo5ms7zt9efOvBCy
         miktAVtmawMZD4lK/vKTOCq9oWHw+IEfyM326Pv0UsQO1Hha7gZS6+dII3Idtc/EVdui
         M9jFVFVUpx37kIz4OKg6Tb+629yPn9oyoaJdb30ZrIWEWHbQZoIw9/eYllSzStvW0Vvm
         RKafHCsNAmWtNSyGBrwcS1/aImhOlwl1LWF5Llp6/JhdMMI7x+UjMzk5fXi6DXQ8mVrf
         XpxJw1BB1gA9Hl1MY6VyWlijaUserMvM2vQVjuElJwkGufBSanZYzmw7yj3dTM1fLcXj
         Ai8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=A7u147Wje9ZAoxZSgxkGO16cCmIS7cio1ghCQtK3PnA=;
        b=W44HX/vVEOwRfNg2iUXKBNwhgqoCodhnKlDHHfc+fjSGGWAYQ9aTtQrVVtRQKvh9ek
         6bAgy/3v9etFdXy+YbIr7VwQGnQuDeHvYQSAduTsWknx1dbxLNXVX4dcQrxJn4Ht8zs6
         bP05uM2Kp4ZSJ8i3/rDTbqAEqqNPDk5RQvoODBq4NypvRU4u30v/azwGnIiD+cGlZM/Z
         QI2YV5D6hzbAzLQ8u4hmnErLwZkEikLYuMnXKLwmqLaNcVx0PU5LSrLyXdnOFZTiK8z5
         19qLx3Oe5csG4PJJ0P2GOWnCLXt8fw73aEitRBdHY1TJBMNpzenshcm5TphVcfC0mran
         bDVw==
X-Gm-Message-State: APjAAAV3stv+AxwO3+WTM0+62Mv8RxYiZWg3MCNfSaoU/ZSZIr3ILAdi
        LsnwEwp5Q4umxIHNJ+isH6Es6YmKtC4=
X-Google-Smtp-Source: APXvYqw15bSJm6EPYsc5pmdAEw1JAIB1W9K5w1rWrHlK7Wx3GTV7qbdBrmB0HKBLDd8e52fp2WCxzg==
X-Received: by 2002:a62:6801:: with SMTP id d1mr12909483pfc.117.1567102366420;
        Thu, 29 Aug 2019 11:12:46 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 185sm4284988pff.54.2019.08.29.11.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:12:45 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-sm1-sei610: add stdout-path property back
In-Reply-To: <20190829132728.20042-1-narmstrong@baylibre.com>
References: <20190829132728.20042-1-narmstrong@baylibre.com>
Date:   Thu, 29 Aug 2019 11:12:45 -0700
Message-ID: <7hv9ufrgbm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The commit d4609acce187 ("arm64: dts: meson-sm1-sei610: enable DVFS")
> incorrectly removed the chosen node and the stdout-path property.
>
> Add these back.
>
> Fixes: d4609acce187 ("arm64: dts: meson-sm1-sei610: enable DVFS")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.4,

I'll probably squash with the original.

Thanks,

Kevin
