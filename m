Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CA2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5758E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZgdMARR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfDPS4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:56:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42075 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:56:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so17879223oie.9;
        Tue, 16 Apr 2019 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxYtAVJwFVsOpycxVwKeebGPthDojBTc0/ZdScDrujg=;
        b=GZgdMARRCopgwYIdLe3C+n5X+0fJKGKrYOdzQTxHDw+yB9Fe7qrCAX91ChnSnCtXlp
         pzfSMTXMCQUqgC6AZgLJiuhSPdsrhkHF+jBzc6qGc7L9RVaeMWrcskeAiAvFdUt2OHJy
         m4tCnf8+lrSg4rbB7F1RWOcGxxC7BrXt6BOnQGsEiaYIldUw7Dige1OiHN7sNbq54VyQ
         CnV5OVK8GvySLSSEjTu8Vd2skGsyT6NyZw1TaixuTT1lhoQBsrCq9sRvvGbklUFLoPmm
         7dTe3TZSlHMwg3k2PSh/1B2N32Ap5OGr8esR3amrgMM9gu3KW+pKJK5UJxcwOJK054lB
         Fu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxYtAVJwFVsOpycxVwKeebGPthDojBTc0/ZdScDrujg=;
        b=R4R0eePTU33FdlJI4jD/0PzMsxuOD67CIJN2BQKgpZadoLOUmHFRfpXl6Ags7hZfJ+
         zZD6ByQ3V/dkfMjeromvbEngJysXlv7kSjQfQJ8N3lLWeKGCbnINitzU83o26hIh74iJ
         foSSmcGKyfBxCLyEVGLrMstT7w7XgVJDwcSR41QdNjSbG8gre9Ke1ZbvjjGaKsB/Isgl
         uPYTwYKFgvgkJxY7VMJgEkQpsv8jYyWi7aez1V65D4vLlxzngj1gvT9SfvXpISX/elJM
         MGxc9cLBun42JYD0ySsniEHD3A5oNIQD43vkiGoICr8cFat9/vcBfxML8Cskuw6T5W35
         Qpsw==
X-Gm-Message-State: APjAAAW4zkYPxdygsDQZX5Z1d1ZGuDqgLDU0M4Wg3i31xO5fExKL+3hC
        Pv9G+DRJ+iBo1l4lFE6H4gp5/VX05n4rs/AKqA/bWQ==
X-Google-Smtp-Source: APXvYqxH22wnZmqgEEZAGO7f/TNbzjdsSsv0R3pYZRTu8BIxjADinenIFagqfTa2bhQDTuWqFl3beHfVpUPCyoLoSjw=
X-Received: by 2002:aca:5241:: with SMTP id g62mr24619776oib.103.1555440995340;
 Tue, 16 Apr 2019 11:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com> <c1831703-a476-8870-0a5f-9060bda0f669@metux.net>
In-Reply-To: <c1831703-a476-8870-0a5f-9060bda0f669@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 16 Apr 2019 14:56:24 -0400
Message-ID: <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
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

On Tue, Apr 16, 2019 at 12:49 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
>
> Maybe I'm a bit beaurocratic here, but I really believe that precise
> naming is important, eg. for avoiding potential conflicts w/ different
> fieldbus classes (eg. mvb) that might come in the future.

I named the subsystem 'fieldbus_dev' because it handles fieldbus
devices, not controllers. Granted, it's in the drivers/staging/fieldbus
directory, but that's because people objected to the verbosity of
fieldbus_dev. In the C code, it's all fieldbus_dev.

>
> By the way: any special reason for doing this via device instead of
> socket (like we have w/ can) ?
>

A fieldbus_dev device communicates with its controller through a section
of shared memory (process memory). It just felt more logical to model
this as a device which acts like a file. When you read/write the file,
you read/write the process memory underneath.

Sven
