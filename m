Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2B6C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8B02075D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZwYkZdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfI1AWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 20:22:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36874 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfI1AW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 20:22:29 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so21254676iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 17:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MGfAg+ftfrg7JakNjVZA5/HVf0Fx2tTzvDQ/fEzJUiE=;
        b=sZwYkZdya8wP93M8NVSDorKR80/Rgcv6oJy0wfNsXonjkxrLhLEYQnoHm6Na+qnbFJ
         ZIKLqDq8BzMXR3ybkJAxsmHMVNapmaWwigRr7raPJhe7UQdauvMMoj+5biEC1Qe2Sem0
         KnbcFPWp1OvlcLI0Q85McEu7Gr++d4pQAUwiVEqVQ9h32GsHNuChU22oH2cC2tWhSVjD
         BlG4SnOgUQOPc3y9REizfH7ViBkV8MpTxsfZDor4P5BlxacBYRc/9Xg/YUvIG20VtSnB
         1UwKx6kDC1GyYdFMjDAoXXqFRqh8K2i2vA2WZssAAIhUSVF40yqUyD7Zc8Z263oy/JbE
         jTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MGfAg+ftfrg7JakNjVZA5/HVf0Fx2tTzvDQ/fEzJUiE=;
        b=QOFPh+RR8vxw475SYLIYOcSGDJrEJihSDSqJQns0qIJ2JwF5ajQB0HDiI7roUG2EUM
         cvu+9x+KSQatgsTduzcX2nalEqp7ySJMop8RnvB7s9FPP8qWJoUdxrIxpphsTffzZCsZ
         BSsHDdFaSj7feTt1jsxxXOaK6VWkj5ybzB3/o28qrQ5U3J5kFmFfC9bZoiB1tzHwayAS
         8djkOUMRJUu9/yeaFiHr7JVoUrtTQo/I9KW2pURwPWgkUIeTGfodLVrU88PctSwBL4Jy
         zqZOOkG4Pycb8s+A1LHjiZH6ha7HzkVHRDxECBaDUb+gFBsoTzxQyV/jlvGf12AAZfA/
         21ig==
X-Gm-Message-State: APjAAAVKQFmHeRkVTz7cKokCMDqEyJSbDvCtVCCnAR4NrHR6+MaS1MOl
        us5Ob/TU88L0WNTpcNEJW+WGTMs+7O2AGfnvaYU=
X-Google-Smtp-Source: APXvYqxP60FRmGlkKIxFjl5C1vDUzY4xzsu9tBtjuiYKRb4kRcbnxECGsZVnsVivdsrEmwn01MJ3yOmAfZxE2igkdAY=
X-Received: by 2002:a5e:9917:: with SMTP id t23mr11216075ioj.141.1569630148976;
 Fri, 27 Sep 2019 17:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QWFisTLhw4afMZDdhAkLcb32MAWdvXKJ=YZwKroxhFt0g@mail.gmail.com>
In-Reply-To: <CAD-N9QWFisTLhw4afMZDdhAkLcb32MAWdvXKJ=YZwKroxhFt0g@mail.gmail.com>
From:   =?UTF-8?B?6rmA64+Z7ZiE?= <austinkernel.kim@gmail.com>
Date:   Sat, 28 Sep 2019 09:22:29 +0900
Message-ID: <CAOoBcBXWU9Tr6Fd27p9ZzBKmv5bS63dVipR1Qiqbm+_pKr+8zA@mail.gmail.com>
Subject: Re: Summary of Crash/Panic Behaviors in Linux Kernel
To:     =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=EB=85=84 9=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 5:01, =
=E6=85=95=E5=86=AC=E4=BA=AE <mudongliangabcd@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
>
> Dear all,
>
> Is there any summary of crash/panic behaviors in the Linux Kernel? For
> example, GPF (general protection fault), Kernel BUG (BUG_ON).

There are a number of blogs and material which describe the behavior
the kernel panic.

Talking about Android Linux Device, the behavior of kernel panic is as
followings:

USER DEBUG Version(Engineering version)

* On kernel panic, the device suddenly stops execution and keep on
displaying kernel log through the screen.
Below is one of the examples.
[   34.187856 01-05 13:30:49.424] Unable to handle kernel NULL pointer
dereference at virtual address 00000000
[   34.197812 01-05 13:30:49.434] pgd =3D e6f9c000
[   34.202275 01-05 13:30:49.438] [00000000] *pgd=3D00000000
[   34.207610 01-05 13:30:49.444] Internal error: Oops: 5 [#1] PREEMPT SMP =
ARM
[   34.214663 01-05 13:30:49.451] Modules linked in: bcmdhd(O)
[   34.220400 01-05 13:30:49.457] CPU: 0    Tainted: G        W  O
(3.4.65-gbc0bf75 #1)
[   34.228317 01-05 13:30:49.464] PC is at ext4_free_inode+0x288/0x574
[   34.234664 01-05 13:30:49.471] LR is at ext4_free_inode+0x260/0x574

Kernel engineers are able to notice what is the cause of the kernel
panic from kernel log.

USER Version(Production version)

 * When kernel panic occurs, the device suddenly stops execution and
starts rebooting again.

In addition, we can describe BUG_ON()  and exception as followings:

BUG_ON()

  * If the subsystem realizes that it is running under critical condition,
    BUG_ON() is called to cause kernel panic.

    Please be aware that BUG_ON or BUG is executed only with CONFIG_BUG ena=
bled.
    Normally, many Linux devices are running with CONFIG_BUG enabled
*by default*.

Exception(Data abort, Prefeth abort: ARM processor)

  * If MMU cannot handle the virtual address  translation, exception occurs=
.
    The program counter is jumped into predefined exception vector.
    Usually panic() is called and then system is crashed.

Hope above would be helpful.

Thanks,
Austin Kim

>
> --
> My best regards to you.
>
>      No System Is Safe!
>      Dongliang Mu
