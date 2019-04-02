Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E43C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6752B20663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpAB4QO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfDBEli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:41:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34660 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDBElh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:41:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so7933016lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vl6J89XgagQKYNNgKiOqHql7e5NVWi0yfcj7xtLNWs=;
        b=NpAB4QO807HdXtc+bvVUAOK8FzUDVPZEaIIpJaJ7MDjiYLUgjMvuDLt/OGJrigPBDi
         k2oZbknM6afivb5J1FneMXmDvhq6M+ayegW4lE2afbzsLAUcb+afOz9WP/w/UwaZYYDy
         6Ua4MEm3NdiBP9NEn0HdGQbPN2hFIPlmsGRWU62xsQjLs5xMlBMOYsjhUEX3RmNPE1mm
         MpHLokupzMOWIRcyGFvh1wblNduVHu77FkqCzwKwsSxKf+4afwbZec9EtfnOQaHsU5nd
         6YiL5jEfHrI6H0rTxkPQpNrn7+2BJd8BXFxgGWPExwFat5asR+sOFWS64PGGkyDYJ5My
         dQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vl6J89XgagQKYNNgKiOqHql7e5NVWi0yfcj7xtLNWs=;
        b=ser+Z3rdDH2IcKEYrdMW+TkFVXSlD+RddLj6SAfqa3+KyeI5iHqE8fPuITT1EqLKv6
         svHA7wrm1CKFIXtVjvm5uxAHNaDgedZCeqPo1WV5zr6XtMv8s1qs10F/JhU+1lvx+Wly
         YUafeNDVESNfUfiPL3iPOb7R1fV7xBv5E/TQtq7SUgqp+x1ygjrVORHnMhwsynSazWcw
         GhP5boSpuZPsjXMCIUAsni4M8NGlRBe6i08SxDbno0wLcCqZmxVR7l4O0o2WAp0Lrzfh
         Rn/LsttS8d53yNQSxf5XueyZdrKxvJcEyS7ZOnOKpTXQ3Ssb9lallKUrzIz4QUybjhMf
         8MAg==
X-Gm-Message-State: APjAAAUeRUE+nMD0YBuhCNnVEXs/LoAYjP0ewadiNOwhKN0yY5uvcfV7
        1OfsFmB5+ptWb0/YqfUdbDJ/WkeutWY02hW5alDNrkiR
X-Google-Smtp-Source: APXvYqzbq4vE8F7XgSbNVGyq6DFTavl2mgrcV1IutxQgK3EmFG3COuvItQtXGH6h33FrTt512ZSA4qIEuECCioxm3qI=
X-Received: by 2002:ac2:491a:: with SMTP id n26mr19756620lfi.122.1554180095751;
 Mon, 01 Apr 2019 21:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <1551746131-10232-1-git-send-email-info@metux.net>
In-Reply-To: <1551746131-10232-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 11:41:23 +0700
Message-ID: <CACRpkdZ7iop_Y9g4qWiotfwjREEJ_vqABU-ucSMzOU5Oyg52Bw@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: Kconfig: pedantic formatting cleanups
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 7:35 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Align the Kconfig formatting with the vast majority of the Kconfig
> files, to make it a bit easier / more pleasant to read ;-)
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
