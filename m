Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A01AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366EE21479
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Md1/iNe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfE0SIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:08:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42186 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:08:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id i2so15479214otr.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Z8u+Mb6Dq9130guFLmfDlxiV/OSJhxaQytulTManxM=;
        b=Md1/iNe3wpFg7pJRiiTPYACJft0AqPYLSVHS86cINONlNtBMoS6cwZSCdTtBdoIdm3
         565psYs4LGlFtaqtO4X10qXVS+90VoiFiw49WiVbulPp1zyKccOaMC//TjCYszO7YshT
         J8RmIhICklmIIASLuxIvS0m4qoT7WuLRhr7q0jKK/FIO3vRGmiMMNGz9iizEuPlmN7eg
         LnJ7T3YvtS/R7phhUfIOWg1TgkLpecleLlJYMiPQYj63M/cdb1DX7ukZJG1PGDTaZe90
         bXncpZ0Cq3feoQ6jOB7cghvn2/6dEhWqb8hCCMLRNm92CdyXdEew7H5rcIO9HxJBX9Vp
         qyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Z8u+Mb6Dq9130guFLmfDlxiV/OSJhxaQytulTManxM=;
        b=egkKacekDX8nmoibztilxwJRVM5qgZOdr+59sy2pQUqofz2wSM55bdUNg+PPkcPFaC
         waxPwIVeBKW24tDZsoHSr1oh/TQ5n+VyrmQJyFJ+vJI043Xt8jYD+eeLJHmqwHW0i05y
         WY4RPVQ7HZoJyMm2Y6syow7PH9mhjgefRonOwQEbsDxz8s59N49jawoS3x/Ejj41gQAx
         8o7HcU4l+6p7YSsJAiYAAQqn8hVZW7MosnenRhlw6QHyeJDDHQMQ2Npt7hagdYCZUaBq
         H4K2aN7EOVdtc9SMi4DR5DyEJuf2OU/sfVoOCHLAn8+vFgG2mvYjBU987xeL1KPLHcwV
         L4ow==
X-Gm-Message-State: APjAAAWR6A/Gy6JGiP9YX1snYluKTgat31/bEDU84xq0KyeUGLSXej3w
        yy6UYf1grj1wilw67wQHq3gmKEnf0igcvizM7Gk=
X-Google-Smtp-Source: APXvYqw1KCJR0ykK+JZRq5RQEXEcYYqCwA42UGA6D3HXVktBN7+YLknn2jRyumOKZM/ijc37rS9VkNSx4uS8BgfiZng=
X-Received: by 2002:a9d:744d:: with SMTP id p13mr50955091otk.96.1558980483396;
 Mon, 27 May 2019 11:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-11-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-11-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:07:52 +0200
Message-ID: <CAFBinCD-rkB9_LDHAUL3oSD2iSmKHYctUY3_ZYdFNgfh3X4_NA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: mach-meson: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:41 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
