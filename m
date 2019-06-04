Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20450C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCC8212F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QFezxepB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfFDOlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:41:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfFDOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:41:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id d17so329042wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JYu/Sf6DYA1LvVsAE9hAP2/zUxBfGo6g6Cc3589jfpA=;
        b=QFezxepBvrgiXhmKm1McpNMYyYT4mjgtLdF0nIx340LiL8knK4tBoXTMiANhRLdvUz
         WT1jjJjAx7LRstuYIGqb5S2luxmEgQuy8ZCzLwt4Nv5SPg9u09Z6R4GTFbIjngteY7DQ
         bZfU38bR0MYhdpoYlf8QngSBFdr5U4n2PClMG0cNR/0FiS7WZNUKJBA6oobE2kj39HJ2
         X+7KY+xPSi36O9Jc4LSb+sJGTx3q25GGVKVevxhS8ZanmDbnT5mPMWZMB7ood8v6nsGs
         SQqWV22m1Y89u8IMFn4hhhBfibFC4h8/rZWieu1EHOO0eXT2T2GtD/blPXf2PYWYE4h9
         mfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JYu/Sf6DYA1LvVsAE9hAP2/zUxBfGo6g6Cc3589jfpA=;
        b=KPfOi570pmF0PIR13ebP3KGYQA5mDASwUNCslz6Upur8z5p8pzQ7cZk4MbnEhss5t5
         /icUIY4JRR6RikOk7O03B1dal4yXs3KhlOyYsmc/d//zZTjju4v/KobhLYRckLAje3vh
         R908OFHAUcE/szSE4kUsg3fSusTNnyDDb+4oPyiA7kXvOtsxWefiq8gh+RZWO56qhSHI
         GwZmyhgKrIKv5hUGTxHGbUyH4uiO0g55le/5Ea7Ww1sLit2nHN4FjSnjc8VNSKsd3j4k
         +Qv2d4oKGTgRTV2tQH4ldjfOj8y2apaM3YqFtsvFYJ1XW2YsXUWH6jDzgKI7zzos37ir
         j2aQ==
X-Gm-Message-State: APjAAAUtNz4jM27lFI8TAh6j9pFOh8LwsK2VxmVNYNUuuQutWTVuhLJT
        iExPZBu2Uuuvkhpexq9O7Bt44Q==
X-Google-Smtp-Source: APXvYqyc1QeM0/4vvWBgZDrhojj2xAQnDeiCexy1d/QXuq48dTOxl1LvD7DQ5J2L9IH0Govxwc79Lw==
X-Received: by 2002:a1c:188:: with SMTP id 130mr18108451wmb.18.1559659279143;
        Tue, 04 Jun 2019 07:41:19 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q14sm15217623wrw.60.2019.06.04.07.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:41:18 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 5/5] riscv: dts: add initial board data for the SiFive HiFive Unleashed
In-Reply-To: <20190602080500.31700-6-paul.walmsley@sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <20190602080500.31700-6-paul.walmsley@sifive.com>
Date:   Tue, 04 Jun 2019 16:41:17 +0200
Message-ID: <86pnnth0qa.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 02 Jun 2019 at 01:05, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> Add initial board data for the SiFive HiFive Unleashed A00.
>
> Currently the data populated in this DT file describes the board
> DRAM configuration and the external clock sources that supply the
> PRCI.
>
> This third version incorporates changes based on more comments from
> Rob Herring <robh+dt@kernel.org>.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Loys Ollivier <lollivier@baylibre.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
