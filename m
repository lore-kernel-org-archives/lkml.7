Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854A5C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488D72067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Jkzhto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfD1Ocb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 10:32:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40410 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfD1Ocb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 10:32:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id y64so917009oia.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+QLN0lhWS0TTAMCusecl/8H1fccZ10EVVpd07BbNgc=;
        b=P5JkzhtowAoVzgf4mWexhRA/N0+kMAM2EpslYR/Sy9HgyShJdJEFuFkueoKwLz1rwM
         fj1FiZaJqAxwqKUFdOs5onU5l/ICPOrRdoonoVU0ipUXJQ/mHi+86S67QZWqCoM63RrU
         bm+JRV/xaMmSIDTjdp4bEDBcGN1lAmstSPfcwCbkK+UNwxAHK3ZFRHpv+bKmBqUEp5hL
         au6WraHET8uU89ZzNXbmzmZ/U65oQbA6DiBmNTAHQZN85fwNNF1yQvyK9tHcxtYPzX5M
         kL1pdaAuJYJ2LjbfeEedv7ppykTPJ2fhJL0VvyRrfj7NQi4ADGjcvEDqjY0eM4bi16Mw
         3Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+QLN0lhWS0TTAMCusecl/8H1fccZ10EVVpd07BbNgc=;
        b=uEEdP6j4zdeUomFe5Qf1tXrGhveJqzVSRnhqINsZ9OSeVz5mFSsYSRLgnw29WTHYt1
         +zasZ9DnE22A1Z1Fex3AaCcNxeEX/JcvSnxLdfGfJ9pTB8+N9mxY5If7CH6n9AyY1JTX
         VGZec+00Ld3hEMXAGxVXBS0Rcw6MM37/N5frExwXFtMahQEJRVzvPws7Q1YtezfWXKhc
         q0xKir2xgtsASApzPeqZ23hfcqm2WlQd1JRxckfJolD2voePKZiPmiUfE998aKr9IE+t
         k9osiXPMB7ysy47F/7RV8C2NCnxJufyoFjnUdJVXc8R6Mc1QyWNWY6SF2PURAJ8hOTnk
         Pfqw==
X-Gm-Message-State: APjAAAUyKAESfauzomU6avR9MzhVFWtcvch6EgHYddI5N+/HiA0hC4mA
        KQBP1Pa0On6oy6QmWVdbYuG2deTX42AVOjhPzz8=
X-Google-Smtp-Source: APXvYqxuMJagp05qspO9G7+jFNbo87VF4TjqCNNKuU53Fk/6rzjEptsUWgrMdLXYGvP32BVD4U+74A8E+5QNz3yPP0M=
X-Received: by 2002:aca:ecc8:: with SMTP id k191mr12544298oih.103.1556461950564;
 Sun, 28 Apr 2019 07:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <1556418804-10266-1-git-send-email-hofrat@osadl.org> <1556418804-10266-2-git-send-email-hofrat@osadl.org>
In-Reply-To: <1556418804-10266-2-git-send-email-hofrat@osadl.org>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 28 Apr 2019 10:32:19 -0400
Message-ID: <CAGngYiV6ykYFuq458tWaLqDGLOo41aL5JE2OZ7uFTp3T4KOYkw@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybus-s: force endiannes annotation
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the contibution! See inline.

On Sat, Apr 27, 2019 at 10:39 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> While the endiannes is being handled correctly sparse was unhappy with
> the missing annotation as be16_to_cpu() expects a __be16.

Your commit message has room for improvement here. See my remarks
on your other patch:
https://lkml.org/lkml/2019/4/28/95

>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>
> Problem reported by sparse
>
> As far as I understand sparse here the __force is actually the only
> solution possible to inform sparse that the endiannes handling is ok
>
> Patch was compile-tested with. x86_64_defconfig + FIELDBUS_DEV=m,
> HMS_ANYBUSS_BUS=m
>
> Patch is against 5.1-rc6 (localversion-next is next-20190426)
>
>  drivers/staging/fieldbus/anybuss/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
> index 6227daf..278acac 100644
> --- a/drivers/staging/fieldbus/anybuss/host.c
> +++ b/drivers/staging/fieldbus/anybuss/host.c
> @@ -1348,7 +1348,7 @@ anybuss_host_common_probe(struct device *dev,
>         add_device_randomness(&val, 4);
>         regmap_bulk_read(cd->regmap, REG_FIELDBUS_TYPE, &fieldbus_type,
>                          sizeof(fieldbus_type));
> -       fieldbus_type = be16_to_cpu(fieldbus_type);
> +       fieldbus_type = be16_to_cpu((__force __be16)fieldbus_type);

Hmm... that would be cheating :)
what if you create a new local variable of type __be16?
Like so:

__be16 fieldbus_type_be;
<...>
regmap_bulk_read(cd->regmap, REG_FIELDBUS_TYPE, &fieldbus_type_be,
                          sizeof(fieldbus_type_be));
fieldbus_type = be16_to_cpu(fieldbus_type_be);

would that get sparse to shut up?

>         dev_info(dev, "Fieldbus type: %04X", fieldbus_type);
>         regmap_bulk_read(cd->regmap, REG_MODULE_SW_V, val, 2);
>         dev_info(dev, "Module SW version: %02X%02X",
> --
> 2.1.4
>
