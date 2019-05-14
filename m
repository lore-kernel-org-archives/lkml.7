Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89919C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB0B21473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="V093A41P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfENS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:29:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46818 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfENS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:29:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id 203so12868464oid.13;
        Tue, 14 May 2019 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzHwYmKzjuKvCOCh10t0J9NpuXRpPAJJUwj2kybwkcQ=;
        b=V093A41P+K5tEG4t03XJ3d+7PTyuCoW2oNm1Nh1S21pQjOK3wC6slvaecR/0t2O7gu
         pqYBDniVFRkeX5y41cZui9umzX3h8bAE59uVgNAFZ12zlTQxGDyU2lsUam5c550ol6pN
         kDE6X/4M/ZErMoonr5I/Q5DVmG9ymKHVyzR1dAdImxbcrXz4hvBUXvhXGeV8Td1/szRP
         xPvWEi0B9eHH+gDThvqRrLbzj7agpYLG8pTP2m5fqM3CEXf/zz+cxWa8okMWhOxKuVRc
         a+jDelL2YDDS9m2FZt2kGBP2xbNJm4VD4dEXGy3hvWPHPrl2nTsLJNxPJ8wKO4AoMddY
         KyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzHwYmKzjuKvCOCh10t0J9NpuXRpPAJJUwj2kybwkcQ=;
        b=SgB4df+eQUO9UmjU7Hu8gnpMsrovC4L+XVwqMhxVd+OqUWqW4yxwYvlN7aGODShoBh
         CJKVZq40gyuAYBf+DU68wESblVDWtAjznnzezHkKlM4gZP2F4vjkpzy8Is77XRMlWCLx
         P3qR7m25WrINs/Xy7AiUZrwPtY+PHNfxThCQxwqWA48UHpIJAF3EPLA9iS+Fy9Jv7YrE
         e7VLNlYlNILI9LoAf9ehzrfSr2gSUNJSdLEmQo0sDu47KjNiMLFxgAvti8o/uRaiA1LO
         BHEtxkgdqLHf0z41pyZgXZyt3TSy3h31HK5oNB9dK/G1Lrp+N3VuyZ1rrMvDr6ARsujP
         s3Sg==
X-Gm-Message-State: APjAAAUKw9yo7RlXG0qVlpdbQ24mjhXjtto43BY8aGXUAqegHFU7LLQ1
        CKVr+86j0ev081kSbtfNM8j64ANGC2MZnXZY0uk=
X-Google-Smtp-Source: APXvYqxcWe1Slj1XnihHFg5ydnIfXNbBimRjDB0bETv6zV5QhUSm2aIUfIunQTLyioy582hC+nI5IHzzlfR8e/5WRCk=
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr4134001oih.39.1557858589257;
 Tue, 14 May 2019 11:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190514094537.8765-1-jbrunet@baylibre.com>
In-Reply-To: <20190514094537.8765-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 20:29:38 +0200
Message-ID: <CAFBinCB=p4O53vPpvQBYP_PLxa9oc0_qGBLwYz-jzg+WNoGR7A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: g12a: set uart_ao clocks
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:45 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Now that the AO clock controller is available, make the uarts of the
> always-on domain claim the appropriate peripheral clock.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
