Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CAF21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nyl2/uLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCOVmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:42:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46765 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfCOVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:42:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id c18so9624416otl.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLb8kXOdkQ+jp9qWrdVx7EI63MwcD82xghK0py4Ecbk=;
        b=nyl2/uLEiK21uySTCiFyJMU3WVcDzJxEzL+2j91q25szBTepykFemby6nz4feIlzUf
         yzlUatOOcZqgWrKNrSRQWwf/FG6hkc1Bf0X7UhunGrYRHVSME6OYU/nCwOr1KAThBXDt
         17YcSpA76BazKGqPcH2e2hQFDcQHGzXGat0zijsDIi95yAuTbFh7m0M9BdW2zVK/WuXR
         32BI2N1h3olQokpbM5AU78gplw/aHoNdApaKulWEw3/pd2oZHH+YQ6NByj+vjYq221Le
         zMYVIstOjttY0J150r4nnEnc9MhxthrE5YDH+3gVR0qKEb7PFjvM2wX6aUizbIGB1J4Z
         iPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLb8kXOdkQ+jp9qWrdVx7EI63MwcD82xghK0py4Ecbk=;
        b=VoDEA7qqs2wUTbz94hbeCtOFK6Yx/01CrvJbJDKX69Lcv8HQfZvHK1iipfHd8vsLRj
         FOlJacnUrMMFEe9FnJgBdu1Z+U9wKqP7d6kp/tLHLI2SSXBl3bLNnqJrasIcYPimcAth
         a2P5a9E2wtOEdwFMnshMpOyZEBBhjJUkQ3uPrf9j4fqtXGazgGp8LX0tMSwpciJTCwwy
         CEDZlmI5mmgn97BPkINUN4vPGlwpnoUBWFIja9W/pVRMiFDqveP/Rzol7XSXmSv1ACZ9
         y+8QKSY057koYXAPPWaqKWI5AwwZp1MSwnS2tHUSk8ooDM+KGHdAdepwvXrevDQq6vJB
         IC2A==
X-Gm-Message-State: APjAAAXUylMkWYWRtfLK7akP9HN9qhmoiBRMW3jvHfCzamxTgCEoIqxA
        H+8EvZzMZo2K+ooK+vB888BqSyGv1YZ6yEXOlQ8L6CqH
X-Google-Smtp-Source: APXvYqxO3RM3CjJ54zfHnkyxobmzyR/W77uTo0ozd04IS4MdTG9wcVpvdP4ucYlWEwgyGmugkpll+s4cpRvZAC/3S94=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr3611330oth.308.1552686171054;
 Fri, 15 Mar 2019 14:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-4-narmstrong@baylibre.com>
In-Reply-To: <20190311095613.11371-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:42:40 +0100
Message-ID: <CAFBinCAkzcY2A-YusWLMbsmQV0UpBCQJdzOncyUYSyORMkThPA@mail.gmail.com>
Subject: Re: [PATCH 03/11] arm64: dts: meson-g12a-x96-max: add uart_AO pinctrl
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:57 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add pinctrl on the always-enabled debug UART AO.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
