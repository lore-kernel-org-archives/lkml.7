Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E020C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F58222CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MibkJfl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfHURyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:54:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38295 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHURyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:54:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id o70so1915307pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GFAV8pilcC1llj60Idd3qdxSrJ9XJ4F1Bsi8o/Z7L3Y=;
        b=MibkJfl7NKH/Ky1f2m047yCyVn5HDj4h6BknsBFQMSfENX5y0PQ1W2NTQ79Rop+fDk
         gnrHmhmIEMZizhSk2NF/hIQ/HpvS/o5x2Nbx/X1esXKSnNTeFbO+j+uJtqljh4W5syWV
         zYCuAvwFSC1KrO2UM9p5N40NAGb1ptPkpwdf5lhOhSbkXDgnaxDdfrz3VGEb6cS+CUgM
         gX40QJmY1GD41LsOkBft2oDXHTnDcW8yl4srOLdUWZytc4t1Se/aA0FieLoQ25xCJ+1S
         afVz7Gsmink0LcorkG1DT2UEyiSP7dzs6QYHk0RM36cmpaXaCUd5adGSbzNoby5UChKH
         jcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GFAV8pilcC1llj60Idd3qdxSrJ9XJ4F1Bsi8o/Z7L3Y=;
        b=baRhlr49DuBTvPx3KrZfj9NEYRWRaHVQKeEPTEcoYACO57sz6B14JggCzD38DzPEFb
         s82twVltXSsMtcCL+mhmRBMB8PoMfzP+mAniLX6V7y1q9rC2DCLOGPgBtfVKkkXAFN0X
         FHGXsBXPFBt+rP1CEhDr0Ax2xScJIoyLxU60BspHBrWlpCjJowpQ8tMsBmDL8QjUzSle
         HyxWqbN+bJTZqn4PuITG+vmdTTADSLCAz3PFgeEOL5QjPxeJoyYenvxxR2VCMv0T2RxT
         2AAKGU8CEorNQwlXi4QTMR22cUlwrVC9hkNif2ZhTGx7Eg+YK5gKbPa8uBtn32/YU7tt
         Lb7g==
X-Gm-Message-State: APjAAAWhTjbglQuUpgwoYWmDe0XF9AksKqZR6s82tmS8/oYhyYK92Xy1
        rNuzHtnXjgs3dlh6mSyHQGMZKDi/C7I=
X-Google-Smtp-Source: APXvYqzvv2yyxmIZr/MR3cUYyWoZfEcDhy3LLFAqmSRfCTCiHwpo72LGfKqsh5kqmA7eStyCHOlaoQ==
X-Received: by 2002:aa7:9d07:: with SMTP id k7mr36355208pfp.94.1566410086221;
        Wed, 21 Aug 2019 10:54:46 -0700 (PDT)
Received: from [10.17.0.244] ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e26sm26762008pfd.14.2019.08.21.10.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 10:54:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 15/15] riscv: disable the EFI PECOFF header for M-mode
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <4f1677e24a5fcdfd2fda714cdd66f4dbe7817284.camel@wdc.com>
Date:   Wed, 21 Aug 2019 10:54:44 -0700
Cc:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4C28F0F-7385-432E-A766-64A3F8B8C381@sifive.com>
References: <20190813154747.24256-1-hch@lst.de>
 <20190813154747.24256-16-hch@lst.de>
 <3BF39A0F-558D-40E0-880D-27829486F9F0@sifive.com>
 <4f1677e24a5fcdfd2fda714cdd66f4dbe7817284.camel@wdc.com>
To:     Atish Patra <Atish.Patra@wdc.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 21, 2019, at 10:31 AM, Atish Patra <Atish.Patra@wdc.com> wrote:
>=20
> On Tue, 2019-08-20 at 21:14 -0700, Troy Benjegerdes wrote:
>>> On Aug 13, 2019, at 8:47 AM, Christoph Hellwig <hch@lst.de> wrote:
>>>=20
>>> No point in bloating the kernel image with a bootloader header if
>>> we run bare metal.
>>=20
>> I would say the same for S-mode. EFI booting should be an option, not
>> a requirement.=20
>=20
> EFI booting is never a requirement on any board. When EFI stub will be
> added for kernel, it will be enabled with CONFIG_EFI_STUB only.=20
>=20
> The current additional header is only 64 bytes and also required for
> booti in U-boot. So it shouldn't disabled for S-mode.
>=20
> Disabling it for M-Mode Linux is okay because of memory constraint and
> M-Mode linux won't use U-boot anyways.
>=20
>> I have M-mode U-boot working with bootelf to start BBL,
>> and at some point, I=E2=80=99m hoping we can have a M-mode linux =
kernel be
>> the SBI provider for S-mode kernels,=20
>=20
> Why do you want bloat a M-Mode software with Linux just for SBI
> implementation?
>=20
> Using Linux as a last stage boot loader i.e. LinuxBoot may make sense
> though.
>=20

Boot time, and ease of development, and simplified system management.

Having M-mode linux as a supervisor/boot kernel can get us to responding
to HTTPS/SSH/etc requests within seconds of power-on, while the =
=E2=80=98boot=E2=80=99
kernel can be loading guest S-mode kernels from things like NVME flash
drives that are going to be a lot more code and development to support =
in
U-boot or any other non-linux dedicated boot loader.

There=E2=80=99s also a very strong security argument, as Linux is going =
to get the
largest and broadest security review, and will likely get software =
updates
a lot faster than dedicated boot firmwares will.

Another reason would be sharing the same kernel binary (elf file) for =
both
M-mode, and S-mode, and using the device tree passed to each to specify
which mode it should be running it. There are probably a bunch of =
gotchas
with this idea, and even so I suspect someone will decide to go ahead =
and
just do it eventually because it could make testing, validation, and =
security
updates a lot easier from an operational/deployment point of view.

Linuxbios convinced me that if you want to do a really large cluster,
you can build, manage, and run such a thing with fewer people and
engineering cost than if you have all these extra layers of boot =
firmware
that require some company to have firmware engineers and lots of extra
system testing on the firmware.=
