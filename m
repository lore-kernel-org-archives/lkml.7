Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F54A2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JJYISij6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfEWQNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:13:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33425 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfEWQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:13:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so3397722pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Kla6xn5Rtm/ynxCsZh/uXOzs/7PtvcUWbm78TW3QhsA=;
        b=JJYISij6OTQsMewWsc7E1+XwxCJ7YJu4Ozycyefko7cDmUqjkzF/kf6xWuFAnOuEtt
         LvswkfXUWuKGPntdlRHylbPV9y1JW5Hu0fqMzZNcnf2Oz4HfZuuweY6RZ6BnA6pS2LRQ
         Mwn12h3qCDX3PIoCuk5sWBE41AaqOiijn8jXAI7gvSJQ6cIFqLV693BJheHieGlWjvHo
         s3hqw5gZ49nccTodxDAp/AT15UCMFafqatcT58SdQDyCpqZVObvuW3h7YS1WPGYtyllc
         wsalnXQnQyPywJaKwG15xvgfqoHoD40PWsPDm8KYmKGKQ+bGe1973LFOFsYo2CyB0q/M
         H5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Kla6xn5Rtm/ynxCsZh/uXOzs/7PtvcUWbm78TW3QhsA=;
        b=X1AeYaSoFHvHlPz16qKBj6TT42dadkg2dxknfQ5brLqoKzwWOHvdUNe3gX9IZmrJsJ
         fw5I9Nq9vhzCgOvPuY9+NV6tQiy+ZVpkumuk0Fu+Q7cqDuXFiwL/VoIBhJ1TMDH1MNiF
         PKJfUKz52b1oNHeD7cgOR+/MbJuLsRXMG1vCfZQDxhH7dwZDKCO5s9sH/uAfpFvQ6Jdr
         Irv400V0D23BVAUuJ3p1W6I93gddWTIbRo9Z6aEI4EpVFjEkX7T3sPcrIZUlZHx47+vv
         cxOhxeBMNKg7y9NL89KsZmK8pcLInzwSAmvDsss7qmGZdzs3V5Gn+UWy3jgVtTK5oKzU
         hxYA==
X-Gm-Message-State: APjAAAVLWsJ2AYA5eSB5Hi5OuZcZeUbRMYBjOBYhWwH7J6r/bn/6mejN
        gpsjerNo5r9mBACyh4aXyKlI3Q==
X-Google-Smtp-Source: APXvYqzBDUKiUXW17Cp+BBLLt2WrMZacAsmzczuBQyg6+dOwQ2cQhPPIpTsGvSMwoBSJZaVBpKP9qQ==
X-Received: by 2002:a63:950d:: with SMTP id p13mr99087861pgd.269.1558628009001;
        Thu, 23 May 2019 09:13:29 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id v39sm1383544pjb.3.2019.05.23.09.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 09:13:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: dts: meson: g12a: add drive-strength hdmi ddc pins
In-Reply-To: <CAFBinCA+G6f8pq8zPwzq6rkNmyS6U=7fL5HWnObvWDWCB893iQ@mail.gmail.com>
References: <20190520134817.25435-1-narmstrong@baylibre.com> <20190520134817.25435-2-narmstrong@baylibre.com> <CAFBinCA+G6f8pq8zPwzq6rkNmyS6U=7fL5HWnObvWDWCB893iQ@mail.gmail.com>
Date:   Thu, 23 May 2019 09:13:27 -0700
Message-ID: <7hk1eh409k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Mon, May 20, 2019 at 3:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> With the default boot settings, the DDC drive strength is too weak,
>> set the driver-strengh to 4mA to avoid errors on the DDC line.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Amlogic's vendor kernel (from buildroot-openlinux-A113-201901) does the same so:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.3,

Kevin
