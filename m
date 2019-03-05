Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4912082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qoV6uaaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfCEVBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:01:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35580 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfCEVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:01:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id z19so8711565otm.2;
        Tue, 05 Mar 2019 13:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQxNOt7Dl/cW1ademESBOfmMiyHsuFlzWvnhwBEZDI0=;
        b=qoV6uaaKzb6LbYw679YS1Rp7x806UHwEheF9TeDFisLvCJUWBP4qle3cqi3bFAKVH7
         PvTmeG7qRquzuZzlEAO6Umu5koxp1+OBtj2hgj8a30A4LjHSgX2ykzDELWopddRJCAgX
         yq25YCqIoy9NYKxrNesCUXZgVOOcgMbloppEmoA//Evb2XrizEiKVNcMAI5Nz59SrVpZ
         +MiNqbEkg/g2cd/x0nZkBVysNbnXzM+SiG/PDxnf1tr8cYrkjY2Qzr1xLGua2MiZq7XH
         rABa79XULwKiwDPqkAElJJx8QQs1XCy1/T6f5oopiBSF/5EXfRKzJQ+VtTMEogmT2iAI
         +1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQxNOt7Dl/cW1ademESBOfmMiyHsuFlzWvnhwBEZDI0=;
        b=gMfJgHrURY8Gyma31oBDI195K7d6oQM79QchvY3eH5nsgmCfGFST3l2T3cYuvfhTlV
         HwtgbVBUPPy3qIYCa2HnkZVT3gb2KNZQ8QFjPCh2RBSZuA1hLxvVDaytp16BSiI08unX
         nFrMphAi4l3rXaiXVW2tingieiOeSeYwWYGvfq79THjmdmW7xAxpRbAd+287JK1M0Rw7
         upb3aVV5M6NbEBWVXBp8OVPmJsBb/gZUbRClodHFV6q8KOUJTByoLUzPCFyAxZONExIX
         9LcgSblfRcuZvtskEBMPjDTqQQTQH83D4fu3YZgAS034uMTZ9igxe4Z4OweKZswQsJ9m
         RFFw==
X-Gm-Message-State: APjAAAXo1HCtJyPwXKWW1QgN4UL8PMAk/KZDgOjVnZ66zz9uWlxdMjUr
        ddZEfrCKZujKh3O2sbSy+1tS2e3G9Y47YteP3+h3SPLe
X-Google-Smtp-Source: APXvYqwh0EFjcTO32Iu7jLF7A++H1omTrsdnhrVXfIYwLrbcKiBm3h3lwnvsPYP1URFkDv/E+OOfFzk+0w6nyLlZ7vE=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr2233013oth.308.1551819709301;
 Tue, 05 Mar 2019 13:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20190304111217.882-1-narmstrong@baylibre.com> <20190304111217.882-2-narmstrong@baylibre.com>
In-Reply-To: <20190304111217.882-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 5 Mar 2019 22:01:38 +0100
Message-ID: <CAFBinCA_bGFDOA5sLt26z++=LCtD_3xuaChQWDYJY2D0s2nHZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: document the Meson G12A support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 12:12 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Update the documentation to expicitly support the Meson-G12A SoC.
typo: explicitly

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
apart from that:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
