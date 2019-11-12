Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E87C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFC62067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l52eleMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKLTfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:35:24 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35549 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLTfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:35:23 -0500
Received: by mail-io1-f66.google.com with SMTP id x21so1806414ior.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 11:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=m93e2QXWf88AbXgWK2sEQ2l6gtvzuuGFmNQYaUWfXNg=;
        b=l52eleMCbJB3sqImSHB8+0rROJ34XYVb9aJgBXvlp6QavrLjYHPmW5TCty9yBkePtN
         EDB0Dr1uH1LOFEhzd0Z4Aqh9qCU/FlL/oLfxBKT5oYfmiVRp8/XJWwlRkoTKndGbsrBY
         EpKayEbLj5l8PH9WKNZA/fqty+eg1E3a6W9aiqotpZcrNA9RCGYML2QL9K2v+qoy7H3X
         KGaZXebb/I8WpzwthYbpol7tqzklks6HuKEott00HXMkKxSkfnQIJEkO+9rOl7hCtHYX
         1f07gXdeoxSzuv5JPivm5CklpoOAkXoVq9sDFyhJVhOLvBJ6Ns+Ge+i8OkDpQIY/7Veb
         tYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=m93e2QXWf88AbXgWK2sEQ2l6gtvzuuGFmNQYaUWfXNg=;
        b=Td3JSGajXSyraSCrmn7PvXKOCVyoWoGCWVb7oMP899ohygD/Y6Nnei2eGkXskaqpKu
         CpSVcuamGIzO2kXrjTA33stltJy0I16wqguRRbdrys9s//c+3RJExJXaz2IYg5yhFxdO
         ztyxh21pKYpBrKQ27DV3OuJdLdPcXJLaZGlsI17QScCNiUIF1mD/DQ3+REmBJqEdCGnU
         Lw3ZCRfSKPkmir5edzhx5Fru//iHTRPnxX3+GGBNJOsDpn/gH24naJ0GbInkaIj4mQRd
         E6Q/SCzYKCNcDrNWiFCuPZae7QvKi2rVkx9AHAPv2EyOc+sI3f9BTCowhZpIQN9CfT3s
         IJig==
X-Gm-Message-State: APjAAAX2D/VXUaDtPuS2ZX+wpSpEbQb6j+XJ2wqsfG5Wo9og0EevM0jY
        fYcu7BsNjZl2Cov4zJWOWlXTHaQoDiw=
X-Google-Smtp-Source: APXvYqzpmUsR0xh7kS0qo4ZEyUZIBFnS7WPJ+sDXJX2PPlPUcSH60/M0y1Ik8F4kBklzWWHcXDzpcA==
X-Received: by 2002:a5e:8202:: with SMTP id l2mr10041486iom.207.1573587322864;
        Tue, 12 Nov 2019 11:35:22 -0800 (PST)
Received: from localhost ([75.104.69.238])
        by smtp.gmail.com with ESMTPSA id t6sm1235747ilq.53.2019.11.12.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:35:22 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:35:14 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] RISC-V: Add multiple compression image format.
In-Reply-To: <20191106000652.8370-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1911121135020.32590@viisi.sifive.com>
References: <20191106000652.8370-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Atish Patra wrote:

> Currently, there is only support for .gz compression type
> for generating kernel Image.
> 
> Add support for other compression methods(lzma, lz4, lzo, bzip2)
> that helps in generating a even smaller kernel image. Image.gz
> will still be the default compressed image.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Thanks, queued for v5.5-rc1.


- Paul
