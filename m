Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4361C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96059214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PDjG2y4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbfDRToR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:44:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36841 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389965AbfDRToQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:44:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id o74so2690283ota.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bx5KZfdXjm8ofYlrpIW9ivlLzCel7RPnKzTt4neA1m4=;
        b=PDjG2y4A+ODJSC0q5bF1f9z9TQsnJEK6Z/nQLQt6t6m+YV8A+/CJ5zo+I9dRy7vnTK
         AqE2sG9BqaK/BTOKWz/xe3nFKoForFr8PjoeE2FbzLdBSRfk2/e4N5dKybQfA6JnEPB/
         AZe0PZX3LzhwWkAR/sfZO16S6VWzJeyVNVYPNU4a+g2byBvhyoJsul3efRIdpnoSOJAL
         8hYOGDhaGN/PRqpNUr+Hh0m2SYSu3TnUKRHCnDKXHcBzTllEoufAV5/stkq0bx8SkrSH
         0PK3Lsxdp2SV/M1qIjVTsGYi/pxWmMcn3dpIJ9NTotVkZKiNIACd1DbS66zS1ie3Agk+
         x6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx5KZfdXjm8ofYlrpIW9ivlLzCel7RPnKzTt4neA1m4=;
        b=G8xRr8HkqWTJyUfu/UmkVYSqMcf/Z9j/MvmUDR2LPziDbp7QadbI9YxivLtISmRVaL
         8n3ZRdqpVxnhcCq5DkfsTkWc8iGfPKb3fL1EeDs+cVwhnt5zPeOuMABD50o37uj08pl8
         tG37ZTtGQ6FPQGMcBbZM23pS4H8bDrra2WY7y9isqhSPJe5+VAdpQ6kKA/IKDqqvsZHW
         5vHH/UGnQPoIKCx1bUR6XIG3VmKTPqfZNOiHpkmvAk7404BGX2nM9tWPwZHROFWslAep
         HU+fYWHftXSU+1qn8LSz/DeP8HT8N4llc4uHI2dyvjGTM+a8cy25l4+nS9ej3OtczXea
         KyZQ==
X-Gm-Message-State: APjAAAXj4zhr+q5kSu46jo0RllLWEaFXNW2W3zvZmUqaHSrKuxVM7HZy
        tTeuop0yVdGAjBybslwPaMGOCAsjLpZFFUqBRCE=
X-Google-Smtp-Source: APXvYqyijd+OHnD93J6murDFe1J7q1CB4zrpQTFpLXHp4Y+tOsizvLu6b1hoZweO/hrVZVErO+7FYTomNtc/0Yz5UU4=
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr56649724otl.86.1555616655912;
 Thu, 18 Apr 2019 12:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
 <20190411220056.19109-5-martin.blumenstingl@googlemail.com> <bd1900db-7ca1-a6e5-39f9-db54e0b570dd@amlogic.com>
In-Reply-To: <bd1900db-7ca1-a6e5-39f9-db54e0b570dd@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 Apr 2019 21:44:05 +0200
Message-ID: <CAFBinCB9Z_H4wX3_g2hVL-XnS6Oq-KtPHa4Z1ws79FGp5jCapQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mtd: rawnand: meson: only initialize the RB
 completion once
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        richard@nod.at, miquel.raynal@bootlin.com,
        linux-arm-kernel@lists.infradead.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org, jianxin.pan@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Mon, Apr 15, 2019 at 8:04 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
>
> On 2019/4/12 6:00, Martin Blumenstingl wrote:
> > Documentation/scheduler/completion.txt states:
> >    Calling init_completion() on the same completion object twice is
> >    most likely a bug as it re-initializes the queue to an empty queue and
> >    enqueued tasks could get "lost" - use reinit_completion() in that case,
> >    but be aware of other races.
> >
> > Initialize nfc->completion in meson_nfc_probe using init_completion and
> > change the call in meson_nfc_queue_rb to reinit_completion so the logic
> > matches what the documentation suggests.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >   drivers/mtd/nand/raw/meson_nand.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> > index 57cc4bd3f665..ea57ddcec41e 100644
> > --- a/drivers/mtd/nand/raw/meson_nand.c
> > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > @@ -400,7 +400,7 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> >       cfg |= NFC_RB_IRQ_EN;
> >       writel(cfg, nfc->reg_base + NFC_REG_CFG);
> >
> > -     init_completion(&nfc->completion);
> > +     reinit_completion(&nfc->completion);
> Tested-by:Liang Yang <liang.yang@amlogic.com>
> Acked-by: Liang Yang <liang.yang@amlogic.com>
thank you for reviewing and testing my patches!

[...]
> Tested-by:Liang Yang <liang.yang@amlogic.com>
> Acked-by: Liang Yang <liang.yang@amlogic.com>
please consider the following note for future code-reviews:
most maintainers take the patch from patchwork and apply it to their git tree.
however, patchwork is not smart enough to detect when the same
Tested-by/Acked-by is sent multiple times.
this results in the same Tested-by/Acked-by being listed multiple
times in the final commit: [0]

what I do instead is to reply with one set of Tested-by/Acked-by
(below the author's Signed-off-by) which is then valid for the whole
patch.
There's no problem to have Tested-by and Acked-by at the same time,
the issue only shows up if you send Acked-by (or any other tag) for
the same patch multiple times.


Have a great day!
Regards,
Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=nand/next&id=39e01956e2f70ff9f0e97db1a69c9847aa1d5d8b
