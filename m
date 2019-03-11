Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E78C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B19214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvtdesa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfCKUDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:03:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46765 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfCKUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:03:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id j10so112744oij.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHlnvEsva/WYvGWOyewlYFgLlpgg0v1N7WlkbQXLEyQ=;
        b=Bvtdesa5UnsjnaZmpOryY5m/PTd7tactBpn4K7aA28VOldFjOkEpmzQxpx9TKzwHkG
         hD57kd0f0GMUX72CV5TC8nEfbtZttQr6l5Mt0R1o0DBl6PpEqdMqjZFsFtVyuHoH9WZi
         O0vsHy0+ov1c8DGzHaj4jbPpPSAQ9SSV6Vlom9PBkQccDeh4AD9yluhqIQBccuWjFPfL
         BT6SbTa2zbKDGbmiOAEDuJqysrgtLkq7bfx/rec59Y10slz0Q20KJq4ARkTyJNMoYtM7
         JidELcN9S5sh0DoAZ5ja3Okl7tv/zC2WoTWPaS11mT7G7AONDs9iMAJdJQBEbES90joJ
         7giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHlnvEsva/WYvGWOyewlYFgLlpgg0v1N7WlkbQXLEyQ=;
        b=ip2XhMow9IKdjF70lu1JNQR57e0CIOTXQksqD87pi0RCLmyEczpxDWuXXIMviXTfr+
         N9cWjdLDB9uH/wJPTT0MFo3hL3L4LMi8+cvW5wUeOMlkQfJipoJQ39Mo4WychdRNW0gu
         rs+Rh6SgKTxOMVFXergqoL2PZncN+FhmZ8RfLQxeOLbrR1pP+w35r2bhQRcrWbeLdTFp
         WZe10ZsrCDA0EyUm/rrPesfCVg/2vFDouYYQUvvx4rFFuYQ5tT7ArZ1+0tHvGClkjfgg
         Etz8zeqgn0oC6fIaC594iL9uBKq/4Gy2gZr98qNC8CAp7NhpYTEDqlDhma7yPD9pU6mF
         veHg==
X-Gm-Message-State: APjAAAWJ6suH3KWrAuNCWBJFrEYn9n40a9cfHxfLKBWxnRslNk6Vw3k5
        I5axat8Nv0kOnmqhdPX1BQVw1njFNrFiLCp/4cI=
X-Google-Smtp-Source: APXvYqz0IIEMwh9+yE//5ydGPBr20HUIPSGDzaiNG203U25xdGvbl+ZEltvXlYiGsRJjJZhaeqiqbCS6FgK7V8NRwAY=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr318821oib.169.1552334599592;
 Mon, 11 Mar 2019 13:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
 <20190208121916.GE23483@kroah.com> <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
 <20190208141400.GA22162@kroah.com> <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
 <20190311191339.GA5628@kroah.com>
In-Reply-To: <20190311191339.GA5628@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 11 Mar 2019 16:03:08 -0400
Message-ID: <CAGngYiVHkzOjhDcZ_1MDLDeTu3JEMNVg75-Ui4TEVhNVx9c0NA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:13 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> That sounds like a good plan, I'll take that.  Want to respin the
> patches with the code in drivers/staging/ and I'll be glad to queue them
> up after 5.1-rc1 is out.

Awesome ! You can expect it in the next few days.
I'll also incorporate the last review feedback.
