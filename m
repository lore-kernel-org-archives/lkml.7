Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C012173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGc5ZZV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfEUPx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:53:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35766 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:53:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id a132so13216133oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uiy2m9z99ipbVeeWFB4EOcFq0uh6YoqdjiXnnlz32AE=;
        b=dGc5ZZV9m0gIO9qApqTZsdg/BMohXW3nXpoRoTFn41fsv8zZ+0GfLrCTMUyd90zhcy
         lpANNPkydRSz/k48z+g/y8wHvFOp8rVV84sk3R3NrK6vkgpoEK51w+pxYnUkZYfZfXXV
         LZ1q36BZf9Q4zpGVMNzZE54z1iYMc7COZwGs1Ve4IvzJTAN+9IZjKFg3+SRH3D/SBavL
         ROGtiVdI5VTA7Xp1zWBkp7buRnHrzBR+VBjRuX2eoOhTP2NPeLyxeOLkVcY5N31b71KG
         KtW3soYtqm32k3xLY2S2EP6E3gCILfwUhAAonXdqwaxKCclfBrjovtaQpkCq5XLLq7AZ
         0rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uiy2m9z99ipbVeeWFB4EOcFq0uh6YoqdjiXnnlz32AE=;
        b=RvqM2Zn9a4odnR9ksyv4iBwN8ngYASdBfIDnITa0+4+1hOZ2jzPx/rqnPrS0aKFvJL
         Yr/vgzftCnkfVQR5KYz19RSvMlRY2KifLV4lN+ivmLYIkFJ2yie3QmWnJ+mW8brNdFW9
         mraksjHQztxrp9TgwWhaSebC4m6VC2FMMkszu8/P5Zerx1su0zRWycHWhNKY+GPs/gGO
         Gse+aC/HdDn1paMYXqLMdEZrcnBv0ivv2JgxiO4dAfw4L/LZHUqcUTo4I6B0VrzsQGRO
         iOv0NnZG3UX2qSwKhkqwbYqySG/Wz0jd1SpnBg52/vSbTIGKzI6n+guWMyTLuviLlFRQ
         fhdQ==
X-Gm-Message-State: APjAAAUQvePX2IDNBpH8+PolG9DRtZkLdKU3lyknDmwRN9I9TGkBKbJG
        BYgoqvkTVL4YDcHtqoDBSY1mdp3IcQZuv4kYIqvIj0Sp
X-Google-Smtp-Source: APXvYqzzcqppAL/kopI3FM+VWAkNyBbUx3pEfH8WRHrx7NOG5uRvquGWrBk9Tt1uboZQhqYDmmGR3RE0ch5xE3wAcxc=
X-Received: by 2002:aca:580b:: with SMTP id m11mr1401504oib.169.1558454006316;
 Tue, 21 May 2019 08:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190521145116.24378-1-TheSven73@gmail.com> <20190521151059.GM31203@kadam>
 <CAGngYiXLN-oT_b9d1kRyBrrFMALhKO-KnuwXB0MjVq0NFc01Xw@mail.gmail.com> <20190521154241.GB15818@kroah.com>
In-Reply-To: <20190521154241.GB15818@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 21 May 2019 11:53:15 -0400
Message-ID: <CAGngYiU_iK5=swD_DA5PcOeYFT0zTrdQ+30Db0YrahuEukEP_A@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: force address space conversion
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 11:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Ick, if you are using __force, almost always something is wrong.
>

What if I create a separate structure for the regmap context ?

struct anybus_regmap_context {
        void __iomem *base;
};

Then just store the base pointer inside the struct, and pass the struct
as the regmap context:

ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
ctx->base = base;
devm_regmap_init(..., ctx);

static int write_reg_bus(void *context, unsigned int reg,
                  unsigned int val)
{
        struct anybus_regmap_context *ctx = context;
        <now access ctx->base>
}

Penalty is an additional dynamic pointer-size
allocation. Pro: it'll be formally correct ?
