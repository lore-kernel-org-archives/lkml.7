Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95EFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9454D21473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Mazte5J0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfENS3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:29:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35920 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfENS3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:29:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so12920767oia.3;
        Tue, 14 May 2019 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeXlOJL3K8v7KWG3tXskIvOY8eKPAZMh5I01Otu6OTo=;
        b=Mazte5J0xZY5ZnJfnGirkWTAZb5+4/H/0co+UgIgZU/D1vfggLqWv01UNPYuKhIq9F
         OfHXSuq8vva/s+Ar+KXiMBzrIhJnPtcEjmPop9A/n+keRtck9Vg2GvLn0xjSOptk5XN+
         9hr/1bl14aFkba1o5tFjeXVysOyPE9ynh8b4tlq19M1B+FANVS/b8w0l8fkYqjLq07iq
         2E1OKm4kUFZOnKZ27oYHQm7RW3qwrN0lxooI6r3DlMKaVV+AORj0+CLat+OkfYhaUpfE
         Shpipt4CmDiY27XLMIxF5VVNmhifPPuzasJoSlfG0soyk5Vu7Y834e9KDKepFbYeSHlH
         xR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeXlOJL3K8v7KWG3tXskIvOY8eKPAZMh5I01Otu6OTo=;
        b=tXMrrtXScov6QZ58hKb40U9EbHba0WSm0hIAvX1H7wKnsb6I+JwRPf7yb56VT8lQsM
         u0yw9FxrrKNJ6yZTOGno39+yoqIbTT4pEo3DFVNyEQIzvaoF9bRAoSM7inWjsVfjSkn3
         oqx3yZhBIufuEkDK0LBZuiwuolUCPrdAqbm+KBpjFOy/xlEE/oANGOx4MjGYWYd+2Ght
         VrprPd9zMoxpyKSYl6YBjb+aHv4AD0PtTIue9NKLIe2iFpv5D2qkv5z9VufurPF1pu0U
         6HZBBwlbrp3SYN8TYc7Uap0daYezF+M+mndfA/1mVij0Oe48yuxxIc4Knr97gqw+y9wd
         olFQ==
X-Gm-Message-State: APjAAAXpLt4ibHuuh0etalKzMqoyEMMgIsEcngGJxZXTQDeY+FPhkNWb
        dYM5c4JdywcrEjId96ikHYkS9+3gu7Kuw6rerZo=
X-Google-Smtp-Source: APXvYqzl/vS4QgHDQEBICZ17isICjtzP1YI2jmHtSQ5pyW6Bkeg/9KCzddZ5Rl5YpUXAKAtnHUPcDScg+Nti+VynZWw=
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr4077569oif.140.1557858556579;
 Tue, 14 May 2019 11:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190514091611.15278-1-jbrunet@baylibre.com> <20190514091611.15278-2-jbrunet@baylibre.com>
In-Reply-To: <20190514091611.15278-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 20:29:05 +0200
Message-ID: <CAFBinCCrJ+qXgKkDrePWGriYyttwjHV+8jgT=Hk55Mr0VNhw7A@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: meson: g12a: add mmc nodes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:16 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add port B (sdcard) and port C (eMMC) pinctrl and controllers nodes to
> the g12a DT.
I assume port A is missing due to the controller bug (missing DDR
access) for which Neil has sent a fix. this shouldn't stop us from
adding SD card and eMMC support though

first I was surprised to see that the MMC controllers are not part of any bus.
however, the public S922X datasheet mentions the MMC controllers
directly in the memory map (on page 83), so Jerome is doing the right
thing here as far as I can tell

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
