Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D43C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E72120854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S2IlJaR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfCSQQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:16:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42486 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:16:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so11284826pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AVUDGAKMXL02had+OfqDpgrMI7oxWdy7jajLhNkrmyE=;
        b=S2IlJaR1xm8sukVefIyGyCJ1F5AE9+cotz3qtiXFXWrsLH+KitmIjXSdkZoh5Rdhzq
         Ckog4x47NulvYgX7aCLITngufAINlgwtcHFdkg3brS+iEuwYCU9Fh09+N0iZ6hrzEata
         QsrtXvd9BQJmVq7TTrYluKxCFWQ/MtO9yq+PBBRitBlOVIl2MT/XOXW4JWm088KsPc0d
         e3KiWhmxt0AYeiSngftqkFvzpPqud5k2lx/dJeZN6jXEqbLMaYEGacDpKGTbHpBeL4PQ
         4pWKRZuiOrjAtlqYggy8gn34ePLQIXv3Bx3fRih/t/nQcUn3cCK10b34OxdI8+1dbFj3
         Vt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AVUDGAKMXL02had+OfqDpgrMI7oxWdy7jajLhNkrmyE=;
        b=PDQ4ud1fDMZKiXlo28tIQHQU3R07ZaUABNXVsVsaa6gbPj60dY86VKwIS4iKkpEkN9
         rM5xwSlrxAPBhPA7F+FY7oR5JpYKQn/z7uZVilTAIf1GTJ2w9CLh1m+lpySog2EhQzp9
         N55H3VnYM7dfn5yJH5X0C+kOeg5bs+g1wg9DVUTQ7UuFr1cZUa5N5ZAP7mqfZlQPYqLC
         v0llu2cco8DfEA9Y/sobC3ZE4XwFzW6CBDKvJWMdeXP68UwDV4wWaHBFpQEw0aUM5qw2
         +fASZKeEdBE1pD8EKqAfKtR+x4OO2wKqG9293mW4dBZ0mpAKYqjI0OQb5N7TQqIzsxxt
         ppeA==
X-Gm-Message-State: APjAAAXRp8hWP6vn0GeuZp/+1E6rqnhcTrh3nbaCojpYhWZDFQdDEQTQ
        nipT9pEspbKkfdGp7RyHgSzNJQ==
X-Google-Smtp-Source: APXvYqwj6y8yzmHlW8DfzTGUVXLjBxzZQpe+ovEtdOmKaOCF/pwWJ4ULKIWhqbt0hTzt/Eotj3fscw==
X-Received: by 2002:a63:ed0a:: with SMTP id d10mr2580885pgi.452.1553012211556;
        Tue, 19 Mar 2019 09:16:51 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id x5sm16510833pgp.68.2019.03.19.09.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:16:50 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        bbrezillon@kernel.org, miquel.raynal@bootlin.com
Cc:     liang.yang@amlogic.com, richard@nod.at, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 1/2] mtd: rawnand: meson: add missing ENOMEM check in meson_nfc_read_buf()
In-Reply-To: <20190318204722.9901-2-martin.blumenstingl@googlemail.com>
References: <20190318204722.9901-1-martin.blumenstingl@googlemail.com> <20190318204722.9901-2-martin.blumenstingl@googlemail.com>
Date:   Tue, 19 Mar 2019 09:16:50 -0700
Message-ID: <7hy35ag7pp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> kzalloc() can return NULL if memory could not be allocated. Check the
> return value of the kzalloc() call in meson_nfc_read_buf() to make it
> consistent with other memory allocations within the meson_nand driver.
>
> Fixes: 8fae856c53500a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Liang Yang <liang.yang@amlogic.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
