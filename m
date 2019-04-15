Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D299520854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0FS+TkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfDOSb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:31:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44960 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfDOSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:31:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so15303928otl.11;
        Mon, 15 Apr 2019 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVLj8tFQS/ywsn/qSFpfdC+Yrm0GXk+bPV9Sg4B6QHQ=;
        b=K0FS+TkXPNMN+3ALGJaEe5RntkIHoN3Aff4IfPZjKTFpMTq88CMIwwCBhqrcDE02cD
         CKMK6D3gG0zpwj52dCjV3SqoPxFFGq3WYhZMl6otyjHpaQ3aWY6ELN/in+MK+/baSW/a
         i8Crt48EQn50rhJ7XOyNmg3fyk5P0QczoF7USRX/1/TCUkJ1opaHxKYgCtDIjL0oMXyJ
         JkupFuH5qJWZHL5XZ9GAxrALpX/9jOmWeU+4sx2Owzu9K5DyxlBthPUwJlCBlbm691Gh
         8LaEaPnVqrLDRfNYGqMJdRsEhNSqo61Yz9Fe06Xy/1GfxZ8HPu2NiIEAdlefVaKGRhSS
         cdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVLj8tFQS/ywsn/qSFpfdC+Yrm0GXk+bPV9Sg4B6QHQ=;
        b=XgFlABJvqqhrA//6D+SpjhdZwabBj8SqzPvlCC/7t5UnsKbDIbZ/9WF+u5kTa4GSmB
         q4yv54y5QcqZNm9mELf8xeWs/50WUOGLwyFemTvMhV5tvCbKGjrjsJVmdGHuF2VdRzOq
         +u/bR/HNbPALjh9EAfOq5JdL6rEQqmX7HG53trQ7Rn6Cdaho6LEEyr+xu4jIEstBmPOQ
         GsE1CccrfgMKTWTQEysZbZ73S23A0EFvX/9VTMPrSNTBQhoIdGy+3nRGX0VC5lCatByz
         SSIS3v3R61EcD1hrx0Gjqry0gf3HIWXAVaEJaa3AHdn+yIgXwRtl2MnpiHC3GBNusFxK
         UBqg==
X-Gm-Message-State: APjAAAX+UyfPyZYHTY4NraJvhReVcgruAbjhiTwKL2cT9NmzEUDxi4wk
        ngq7alByTKgW409RZ629pWUwF2utz2HKi82LFLk=
X-Google-Smtp-Source: APXvYqytP3RLvk3Qr4DfWeuC01A6q/elvfqzd3rKimjq3LjCWwFyDkN3n9Hb5BPR+WOYJig83PB4TC2iN4t2dccA3Gc=
X-Received: by 2002:a05:6830:153:: with SMTP id j19mr43431876otp.248.1555353116552;
 Mon, 15 Apr 2019 11:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
In-Reply-To: <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 15 Apr 2019 14:31:45 -0400
Message-ID: <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet card
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

Thanks for your input, appreciate it !

On Mon, Apr 15, 2019 at 1:41 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> AFAIK, "fieldbus" is a bit broader term than just the typical IEC61158-
> style remote memory stuff. At least that's the terminology my clients
> tend to use (eg. they also call some homebbrewn rs485-based protocols
> "fieldbus").
>
> Maybe it would be better calling it "IEC-61158" instead of "fieldbus" ?
>

Yes, we are certainly open to that, if it is more correct and/or better
accepted by users.

>
> By the way: can this device be opened/used by several processes
> simultaniously ?
>

Yes. You can open as many handles to the device as you like,
they will all share the fieldbus memory. When the remote
fieldbus memory changes, that event will be broadcast to
all open handles, via poll/select.

Of course if your application is monitoring the fieldbus memory
in more than one thread/process, you may need to guard
against race conditions. There is no guarantee which
thread/process will react to the change first.

Sven
