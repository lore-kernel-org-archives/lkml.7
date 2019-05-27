Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C97C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028B0208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j6D7GGZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfE0SXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:23:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38376 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfE0SXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:23:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id s19so15536311otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5pS9FIkhrcHEm3eZ5Ga4hDJRUcLD0JmetiyRDO9zL0=;
        b=j6D7GGZJ3jnysOk0JfkST3h7j24yQmNC88uoYWa5a1qsie60xuPjBU/Cj/GAUICFlC
         LZo8MfvurqHxMCDwb5EOFeQ8m5KdaAUCNBIK1MTcsBvyV0KQhC1d7Y01//YB5PKn6ib2
         CUVFiE3JYOcipMj41ocGRmFV1vRmlLfEst7sSDT0dxrfJ0ZXRTdhI4GJwIF+G7hBCess
         Z0vxiDtJiNV0/F+GfTtDpRr14rH+iUOcUD5jQN78HNxiwJiwoz4EvfA5kNgaVhqMs9YA
         ReSrGQT88MdeSp7drrfiLU0ShK01qHhkT4Ve8Shfi0JT81JniwQfsUvm9dETgiXVUFWw
         TZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5pS9FIkhrcHEm3eZ5Ga4hDJRUcLD0JmetiyRDO9zL0=;
        b=uMguQ4VvotYYIH2OMa8woHkqPRuhRMcJgfVKGoczVHYFgBqXIvaOpj7ULI+ru06SBD
         StV7lbviglD34AE0KPZyx3GD/0kl9hQKz0AC1SnSAZy9xSR0CxTFW+bLYTS/xFj9V9te
         /DFtA37iF4WrPXNniMHCpQajn39NlEk46pQ20D49F7N2Igsv6F5J8fZiqa7Bz5shBcHN
         iNl8QICSR5V6hzJPc4d+0dOP+5ORQud6pUHWT0MtmhG3MVW0UC24TdzQ03hk3GNQYSrL
         29Z+OHC0g3i3Tg6xnbb5D1J2OVO8d4NSu0HqeLy7mitYCgPhGo2K8NazLF+KU9j6mxRk
         pNXw==
X-Gm-Message-State: APjAAAVdRayYEQoYFzmNvBPoB7sSFV/zhOKibNgl6g1RplgMYMFvoyXt
        pC8fgEzu97QlztU98pQAf/rKAqGj9oQoxsWKwiQ=
X-Google-Smtp-Source: APXvYqwfpF+Rik391VHLo9HSAWgoGl6f3qI+cIt2fwDI2QSuXZfaJTA3JGxi5VY1f+Yun54aGJyKfC4SoUdPayCXxws=
X-Received: by 2002:a9d:7c84:: with SMTP id q4mr2163959otn.98.1558981384606;
 Mon, 27 May 2019 11:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-8-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-8-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:22:53 +0200
Message-ID: <CAFBinCA2uA9TXZzAYhUm9q-qad22fTjiAGxWuuo_L20o+K5qeg@mail.gmail.com>
Subject: Re: [PATCH 07/10] arm64: dts: meson-gxbb-vega-s95: enable CEC
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        christianshewitt@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add CEC nodes to support CEC communication on Vega S95
>
> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
just like on all other boards, so:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
