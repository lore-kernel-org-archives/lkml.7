Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0DEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D550205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr0qDdPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCKg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:36:26 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46673 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfLCKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:36:25 -0500
Received: by mail-ot1-f47.google.com with SMTP id g18so2410058otj.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q+735gGCXevswzwfpCOFjVKAkug8qCPXCSRULo1Os3Q=;
        b=Pr0qDdPnz4S4yfoq52AnT57mX+qS0QeZyWD2gxwjt7NrHFoBtQzS2CI2ll8Kl0yO9s
         SF30Qb5YdOFOlD229QYAJ87qrdDRb3RSTIdjEFYQpJB6T/KEyFvI9RMiY8/Fdnqiqtya
         4JiA80hxlwCQbWTuyOxf4jvXlx55ODRZXhuJF6oYaDn28MwOPZtOjvNZcV4+D6COhWcO
         LZ8Nj6b9Ob7AUXaq66EbIoEQKv1CSmJEdampHp1TwoRbHi90SgrIomgxjMb5gexZNOBk
         Wj9EPWyCYnpMSYvg0XgzJsIhW1l0EpV16hZFWZb3grsZlPiuKPG5Mudp0dUexkT7v9yV
         edlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q+735gGCXevswzwfpCOFjVKAkug8qCPXCSRULo1Os3Q=;
        b=iVPZGdZmEl1oStJq1iCg6+DamflnVWpxN4FxuPirUUgvvfEagIE5f3yjBHggOsHrLU
         4tLQj3KPCeyam6ro14whdcJjaGENX7WWhxdyeFv9SkiJmaHlP9y2cvWAnYLwPhTz0F3n
         PoshKLSzUCTRtvO9x1tCh2Q/IF3JJIbJPw1781O3dKOuf87Y6tbAOUUijt3UFT1oGqdP
         uvvf2JYiQAoNfII2CHMtsWgh8EXgEkA9HD5Ui9QhPzulJvq0o/jDdO2N+qi/Gy3lb1Uk
         2EzL61AecVUWz207pChHXk2E0YT0aA8+GBHc3atkGEDfD0/Y1Q992MLekQVu/4FSmdGx
         qIOQ==
X-Gm-Message-State: APjAAAWOPJcQpt4mAIYse8+cZlzigAqT4rg+jOeZLi1itkIXDgNjsESQ
        Q4womxCeMWEZhDI7YX8gIFfYpVZCVH7LeUwu10Gt/YT4yeQ=
X-Google-Smtp-Source: APXvYqzfijOqRMtegdoAhWDeSV5H4prhPRTaSzKjuBLhYFIUydZxoXIrqGaHEoIA9kXwVT0n195Hm981fL0uV1x4dGA=
X-Received: by 2002:a9d:192f:: with SMTP id j47mr2765461ota.230.1575369384620;
 Tue, 03 Dec 2019 02:36:24 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <20191203084134.tgzir4mtekpm5xbs@pengutronix.de> <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <614898763.105471.1575364223372.JavaMail.zimbra@nod.at>
In-Reply-To: <614898763.105471.1575364223372.JavaMail.zimbra@nod.at>
From:   naga suresh kumar <nagasureshkumarrelli@gmail.com>
Date:   Tue, 3 Dec 2019 16:06:12 +0530
Message-ID: <CALgLF9KPAk_AsecnTMmbdF5qbgqXe7HNOrNariNVbhSr6FVN2g@mail.gmail.com>
Subject: Re: ubifs mount failure
To:     Richard Weinberger <richard@nod.at>
Cc:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        siva durga paladugu <siva.durga.paladugu@xililnx.com>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Dec 3, 2019 at 2:40 PM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Naga Sureshkumar Relli" <nagasure@xilinx.com>
> > https://elixir.bootlin.com/linux/v5.4/source/fs/ubifs/sb.c#L164
> > we are trying to allocate 4325376 (~4MB)
>
> 4MiB? Is ->min_io_size that large?
if you see https://elixir.bootlin.com/linux/latest/source/fs/ubifs/sb.c#L16=
4
The size is actually ALIGN(tmp, c->min_io_size).
Here tmp is of 4325376 Bytes and min_io_size is 16384 Bytes

Thanks,
Naga Sureshkumar Relli
>
> Thanks,
> //richard
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
