Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D8C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8342085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKf+Bx2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfIKWSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:18:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45159 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfIKWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:18:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so11127575ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYPZjqVFeTKtC5fFBJy5p2xhCEzihUmpj3JugWAlHQc=;
        b=DKf+Bx2Mm7PKVq3sa6xruXc32c1xCVB9cgUxbSD/cezevVPHYtu67U93s3lL2jdvPM
         LoN8IUOa4JhmpsA+Uu+ZQPZ2qQgX4+TBrHpnMxN4t3Bs8o62m9uhwQMVdgHEpDpzywv0
         1tGCczjkYO4NhTJnWLP51NBeir3eAwCRcjQZUqvUmngkM8y0PtvoT4xNccwI33N2ZKQA
         HEVmu3ldRwqhBdGjPeykuBArqowntCgD7SqMWOYwyG2y6YtzXMdDAl41zcaCFHSzIjRL
         VSglC0PrgQ2xUsP2iL8MoEIjkSxyy47HvnKExeh0GZ0R2LyX+9iZYqXm7PHFEYt5sC2q
         MlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYPZjqVFeTKtC5fFBJy5p2xhCEzihUmpj3JugWAlHQc=;
        b=bOS+yaHEZ8KErXCy1JqMN9pm/CozWYNBg0CUTdqLvaEIFA19NTC6iDYoGl2xDyDGcT
         C5Zc1TcoLbpXl5ex/7k/A0M96WnsYpPc/JINuOXtIH+qmmF46iS3V13t0dY4GmcIl7ei
         0ZQbZVB838RZmxjl/F9pYZKuYJ2aer2s/Ci7R+erj/q61c1OGYQPQOm4CTeKYu9ztVKf
         LKO06LZjQPBdsdgdtiabOUxya4n/N8qqH2Q53jSKWKSFp9bISiKMRoqPbyGGa1OnxKKj
         gL5W/7E98wWpf75/MQpCnhczcvSX5xZnJim13Y4PO40M0wPl5/X2GqbidGwTpOiqgVSw
         RrvA==
X-Gm-Message-State: APjAAAUm9JsEUls/SxXB5IBYwPV9QfRRkH623OVkeq0mHnpO4tesrUfo
        EvzhvQENpCfLi9MTWDIwd4IJzlrTEuV+dZG61GuaWPA=
X-Google-Smtp-Source: APXvYqy41t37T+leAmtkmNzYYvqmCCXlVPxMlzOZ/lNcbnh/UNjp/OXUUlj1Kl89C6uklAVHDh9iZl/ODTY4arlQqbc=
X-Received: by 2002:a2e:9cd7:: with SMTP id g23mr24585040ljj.25.1568240321866;
 Wed, 11 Sep 2019 15:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgjJEHmTT3N42BXkeb+2mDbteE1YwW25cgUpMk7A_sOWzg@mail.gmail.com>
 <6a47a06d-f8f1-1865-1919-5ede359d0b10@kernel.dk>
In-Reply-To: <6a47a06d-f8f1-1865-1919-5ede359d0b10@kernel.dk>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Thu, 12 Sep 2019 00:18:15 +0200
Message-ID: <CAEJqkgguW183DsU+JUPcV193HtDXzVsyUa4JEgVKrhumYTzpAg@mail.gmail.com>
Subject: Re: [PATCH v2] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 11. Sept. 2019 um 23:33 Uhr schrieb Jens Axboe <axboe@kernel.dk>:
>
> On 9/11/19 3:21 PM, Gabriel C wrote:
> >   Booting with default_ps_max_latency_us >6000 makes the device fail.
> >   Also SUBNQN is NULL and gives a warning on each boot/resume.
> >    $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
> >      subnqn    : (null)
> >
> >   I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
> >   To be sure is not a Laptop issue only, I tested the device on
> >   my server board too with the same results.
> >   ( with 2x,4x link on the board and 4x on a PCI-E card ).
> >
> >   Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
> >   Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
> For some reason your commit message is indented. Additionally, your
> patch is whitespace damaged. So this won't apply anywhere.

Gmail hates me it seems. Sry but I don't have an proper setup on that
box right now.
My Laptop died and I try to fix the usual issue for new Laptops on
this one right now.
I uploaded the git patch, if you accept it like this. If not I will
re-send as soon I fix
this laptop and have git* and other things proper set up.

http://crazy.dev.frugalware.org/0001-Added-QUIRKs-for-ADATA-XPG-SX8200-Pro-512GB.patch

Best Regards,

Gabriel C
