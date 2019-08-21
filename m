Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812B5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0D32339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MGLD5jrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfHUXdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:33:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35579 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:33:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so2233903plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Li3UBe8fI+pi64qmfeKTwbTPteH9HIZjUzvyj3UoeFw=;
        b=MGLD5jrwG4bvu8DWnmzQYJzFS1/EptZ8wSe5Rt8mD73XH/bMx6G8SQefQZ+UmpmiMG
         CTQgRYdud9d65PvEcTExXMizP0qA0bUbNsERbQG05wRcQMmI9kt+KPCv+d8LXuklTlCQ
         8GdNTGObeP6PNG8DMgihfBMa4URCLFOAvPzmXgmoZrYIcWwrYtYUYuwzfrmG7SEf0N+1
         LGr19VM9K0uNGpsCiGs3qBZhAXZbkSJ58M64j4gwnj3BDo1aeybhF+sW4J38W0New54k
         EkAHZqQpYZz/F5wlE1PMOrBjVBPSqbrhBNx7puf/2TZluyPMnPTwslzrP8BanY137KAx
         c/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Li3UBe8fI+pi64qmfeKTwbTPteH9HIZjUzvyj3UoeFw=;
        b=Vl4q8Rpdti5CwyKMwJyZxNG7qzcvU39+93DaNBpm/QLz19pv8QMXrvalx63a5Atdje
         3heQYE4JJmjCHzlOeKJ2oXyXlvmiAZoHSrFXbeOczBzge2hVqxnrFDpJ7SG4SITuLA4X
         nDni8POVoTbh56gDvDJOlQwF9cfojO07Kpaj9ltnPzxPFshQMW3PJVOJ91aDrrCoS7Xb
         R+VsQDNpVjnuIQLPnfVpdUoZAe7X+/GKThGZiq3xeuP6QBwrf6CBtI/ny0rab7l7Y7Bn
         DGZb5bvW6DK3b/65sgMSYOtK2obe4wLJwV+fR4pz72XPd2qwOQKjXc2l5pY/uubyLdOR
         EMTA==
X-Gm-Message-State: APjAAAVUf3aPSI9nX2T/yqCH/gznhlaeUhMqqbMW+Hj8iaOTXMkBKGCO
        m+la1bERkdp0awp5Pd34u8nW6g==
X-Google-Smtp-Source: APXvYqxVI4mbGGV1tJ1qz87U1pU2VgtzBv1P6daTCRDMWqjsD+hGJrnHGR1YWbu9hi+D0j2JGid8uQ==
X-Received: by 2002:a17:902:24b:: with SMTP id 69mr34895534plc.250.1566430380557;
        Wed, 21 Aug 2019 16:33:00 -0700 (PDT)
Received: from [10.17.0.244] ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w11sm25303530pfi.105.2019.08.21.16.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 16:32:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 15/15] riscv: disable the EFI PECOFF header for M-mode
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <MN2PR04MB6061794D39900E038F9FCF218DAA0@MN2PR04MB6061.namprd04.prod.outlook.com>
Date:   Wed, 21 Aug 2019 16:32:58 -0700
Cc:     Atish Patra <Atish.Patra@wdc.com>, "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCBE0CC0-76B2-415B-B987-0110F3CBEE70@sifive.com>
References: <20190813154747.24256-1-hch@lst.de>
 <20190813154747.24256-16-hch@lst.de>
 <3BF39A0F-558D-40E0-880D-27829486F9F0@sifive.com>
 <4f1677e24a5fcdfd2fda714cdd66f4dbe7817284.camel@wdc.com>
 <F4C28F0F-7385-432E-A766-64A3F8B8C381@sifive.com>
 <MN2PR04MB6061794D39900E038F9FCF218DAA0@MN2PR04MB6061.namprd04.prod.outlook.com>
To:     Anup Patel <Anup.Patel@wdc.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 21, 2019, at 4:02 PM, Anup Patel <Anup.Patel@wdc.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
>> owner@vger.kernel.org> On Behalf Of Troy Benjegerdes
>> Sent: Wednesday, August 21, 2019 11:25 PM
>> To: Atish Patra <Atish.Patra@wdc.com>
>> Cc: hch@lst.de; paul.walmsley@sifive.com; =
linux-riscv@lists.infradead.org;
>> Damien Le Moal <Damien.LeMoal@wdc.com>; linux-
>> kernel@vger.kernel.org; palmer@sifive.com
>> Subject: Re: [PATCH 15/15] riscv: disable the EFI PECOFF header for =
M-mode
>>=20
>>=20
>>=20
>>> On Aug 21, 2019, at 10:31 AM, Atish Patra <Atish.Patra@wdc.com> =
wrote:
>>>=20
>>> On Tue, 2019-08-20 at 21:14 -0700, Troy Benjegerdes wrote:
>>>>> On Aug 13, 2019, at 8:47 AM, Christoph Hellwig <hch@lst.de> wrote:
>>>>>=20
>>>>> No point in bloating the kernel image with a bootloader header if =
we
>>>>> run bare metal.
>>>>=20
>>>> I would say the same for S-mode. EFI booting should be an option, =
not
>>>> a requirement.
>>>=20
>>> EFI booting is never a requirement on any board. When EFI stub will =
be
>>> added for kernel, it will be enabled with CONFIG_EFI_STUB only.
>>>=20
>>> The current additional header is only 64 bytes and also required for
>>> booti in U-boot. So it shouldn't disabled for S-mode.
>>>=20
>>> Disabling it for M-Mode Linux is okay because of memory constraint =
and
>>> M-Mode linux won't use U-boot anyways.
>>>=20
>>>> I have M-mode U-boot working with bootelf to start BBL, and at some
>>>> point, I=E2=80=99m hoping we can have a M-mode linux kernel be the =
SBI
>>>> provider for S-mode kernels,
>>>=20
>>> Why do you want bloat a M-Mode software with Linux just for SBI
>>> implementation?
>>>=20
>>> Using Linux as a last stage boot loader i.e. LinuxBoot may make =
sense
>>> though.
>>>=20
>>=20
>> Boot time, and ease of development, and simplified system management.
>>=20
>> Having M-mode linux as a supervisor/boot kernel can get us to =
responding to
>> HTTPS/SSH/etc requests within seconds of power-on, while the =
=E2=80=98boot=E2=80=99
>> kernel can be loading guest S-mode kernels from things like NVME =
flash
>> drives that are going to be a lot more code and development to =
support in U-
>> boot or any other non-linux dedicated boot loader.
>=20
> I don't see why these things cannot be achieved in existing =
open-source
> bootloaders. In fact, U-boot already has "Falcon" mode for fast =
booting.
>=20
>>=20
>> There=E2=80=99s also a very strong security argument, as Linux is =
going to get the
>> largest and broadest security review, and will likely get software =
updates a
>> lot faster than dedicated boot firmwares will.
>=20
> For security, we have to get SW certified with various something like =
ISO2626
> standard. This is very common practice in Automotive industry. To =
achieve such
> a certification for any SW, the size of code base is very very =
important.
>=20
> Due to this reason, even today Linux (and other big open-source =
project)
> are very difficult to be security certified.

There=E2=80=99s security certified, and then there=E2=80=99s what I =
personally consider secure.

The second category is code that I know is widely audited by lots of =
people,
and gets quickly updated when there is a problem. I like U-boot, and I =
think
its a great solution for industry, it=E2=80=99s just not the only =
solution that could be=20
used.

>=20
>>=20
>> Another reason would be sharing the same kernel binary (elf file) for =
both
>> M-mode, and S-mode, and using the device tree passed to each to =
specify
>> which mode it should be running it. There are probably a bunch of =
gotchas
>> with this idea, and even so I suspect someone will decide to go ahead =
and
>> just do it eventually because it could make testing, validation, and =
security
>> updates a lot easier from an operational/deployment point of view.
>>=20
>> Linuxbios convinced me that if you want to do a really large cluster, =
you can
>> build, manage, and run such a thing with fewer people and engineering =
cost
>> than if you have all these extra layers of boot firmware that require =
some
>> company to have firmware engineers and lots of extra system testing =
on the
>> firmware.
>=20
> I don't by this last argument. These days it's just very few folks =
doing firmware,
> bootloader, and Linux porting for any new SOC (any architecture). Most =
of
> the things are already there in various open-source project so same =
person
> can easily contribute to various projects.
>=20
> Regards,
> Anup

What I see though is we=E2=80=99re duplicating code and work between =
bootloaders
and kernel, for example the SPI-NOR code, and if it was all linux, it =
would be
one driver model to learn/remember/track, and one place to fix things.

U-boot is great because you can boot other !linux things (like FreeBSD),
however if I was purpose building a linux cluster, I would want to be =
running
linux as early as possible so I can use linux scripting in =
bash/go/python and
talk to the queue/workload manager over a native high performance =
network
instead of the extremely limited =E2=80=98hush=E2=80=99 shell and having =
to discover which
user image to boot with something old and slow like dhcp/tftp/etc.=
