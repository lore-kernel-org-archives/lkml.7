Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF653C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D692081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRgPqZE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfE1Kq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:46:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54330 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1Kq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:46:58 -0400
Received: by mail-it1-f193.google.com with SMTP id h20so3485609itk.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F3TeIN+4xcJEdyAPxkfOrWv1K9CVlbB4++P0LsFRYE0=;
        b=rRgPqZE/dtEvwpAz9wajK/4aWnoPku5uQ4Uv01lw+jheieupAmztxpIq1/R7sxe0GO
         pLgHf/vxJYkopZgmezoTHs6ZhKSfPX3TDNKW5XG/PNg0JmqlYrSAzc2mqSiFDxJzbaBI
         uNhdISENBC0OIpMGeQI0THDWIMJ1eX24yJfRCYMO067jj6GExVbvUnJKWsGxO+cUiCO+
         3rHVEniWsxNVaOrkw4C9JqKO48OlX1P0XbncTvyI/7JmF1QZXFFfwtdPEtwzfVBP7qB+
         5kzo0X6nl86AXduQzjlqgQgazW1mp9SHx8xWomJlL18/oWnOSwFLgWF5Zc7q4nYyGdld
         AshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F3TeIN+4xcJEdyAPxkfOrWv1K9CVlbB4++P0LsFRYE0=;
        b=EDGiS+dDkqv+XDTHCg7SYemaGCFf2Dqir2cPFtOKeNbtB4soLNaHZB6qzcOQnnPy35
         g+VzYQ92FmMxq3lUedSp3gfWUfpvxzNp4ldkK0Duo6hWdPEEtcXVaLESTBd+yBnx69go
         F1mfqOgxvSb5HZpCUu8IP6GbB4EpQ+bG3fsbfcjK8+IPgAss3bL4eT4pAs/D8h+Pka0s
         jE0REqzWnlMrl+TGmLXKixeGb5lRJ2gyIgPIzz1fOrSvSk7Hqrs2A6N3Y3jHyoDT7GsN
         AIJ7/F44vZ3IWlCenfMhGpWLxHtdouyv3U2Phb0r3MQK8gTsv8bHvK7VGYO/hK1TvrYh
         k1Zw==
X-Gm-Message-State: APjAAAU18e295dxSWEEYRbehs5fTWtzV5ep/ADkCnpI/5SCsb1fu8grN
        e0VyVlaVFdljdHnxBk94HB75Qw6In8TLdGkrgrwpsg==
X-Google-Smtp-Source: APXvYqzS64YNrK2eO1HuvnNjODThawRTxy4oRRn8E9tbFsdmKUL7lOhiKbT5+XxghKkcPcwZ6TRc6I35tY1FjSgJKQU=
X-Received: by 2002:a24:910b:: with SMTP id i11mr2778804ite.76.1559040417731;
 Tue, 28 May 2019 03:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190524041814.7497-1-atish.patra@wdc.com> <CAKv+Gu9U56b50TrfriBfRFed_1aoXg2Y624tu7v5m2y+6DVq5w@mail.gmail.com>
 <20190527221619.fkxtzk4jpeyfoptf@excalibur.cnev.de> <3178D175-18AD-47D0-8D51-CB2900DFA572@sifive.com>
 <MN2PR04MB60610CF4829D5251A112CF9C8D1E0@MN2PR04MB6061.namprd04.prod.outlook.com>
 <20190528082248.awjwbz44lp6ak3m3@excalibur.cnev.de> <MN2PR04MB6061590CE56092CB79D96AA48D1E0@MN2PR04MB6061.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB6061590CE56092CB79D96AA48D1E0@MN2PR04MB6061.namprd04.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 28 May 2019 12:46:45 +0200
Message-ID: <CAKv+Gu_7bQaBf8+94VKHT3bYGWbTnHoTWy20pa1Bj9e1o3cAOA@mail.gmail.com>
Subject: Re: [v4 PATCH] RISC-V: Add an Image header that boot loader can parse.
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Karsten Merker <merker@debian.org>,
        Troy Benjegerdes <troy.benjegerdes@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Zong Li <zong@andestech.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 at 12:34, Anup Patel <Anup.Patel@wdc.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Karsten Merker <merker@debian.org>
> > Sent: Tuesday, May 28, 2019 1:53 PM
> > To: Anup Patel <Anup.Patel@wdc.com>
> > Cc: Troy Benjegerdes <troy.benjegerdes@sifive.com>; Karsten Merker
> > <merker@debian.org>; Albert Ou <aou@eecs.berkeley.edu>; Jonathan
> > Corbet <corbet@lwn.net>; Ard Biesheuvel <ard.biesheuvel@linaro.org>;
> > linux-kernel@vger.kernel.org List <linux-kernel@vger.kernel.org>; Zong =
Li
> > <zong@andestech.com>; Atish Patra <Atish.Patra@wdc.com>; Palmer
> > Dabbelt <palmer@sifive.com>; paul.walmsley@sifive.com; Nick Kossifidis
> > <mick@ics.forth.gr>; linux-riscv@lists.infradead.org;
> > marek.vasut@gmail.com
> > Subject: Re: [v4 PATCH] RISC-V: Add an Image header that boot loader ca=
n
> > parse.
> >
> > On Tue, May 28, 2019 at 03:54:02AM +0000, Anup Patel wrote:
> > > > From: Troy Benjegerdes <troy.benjegerdes@sifive.com>
> > > > > On May 27, 2019, at 5:16 PM, Karsten Merker <merker@debian.org>
> > > > wrote:
> > > > >
> > > > > On Mon, May 27, 2019 at 04:34:57PM +0200, Ard Biesheuvel wrote:
> > > > >> On Fri, 24 May 2019 at 06:18, Atish Patra <atish.patra@wdc.com>
> > wrote:
> > > > >>> Currently, the last stage boot loaders such as U-Boot can accep=
t
> > > > >>> only uImage which is an unnecessary additional step in
> > > > >>> automating boot process.
> > > > >>>
> > > > >>> Add an image header that boot loader understands and boot Linux
> > > > >>> from flat Image directly.
> > > > >>>
> > > > >>> This header is based on ARM64 boot image header and provides an
> > > > >>> opportunity to combine both ARM64 & RISC-V image headers in
> > future.
> > > > >>>
> > > > >>> Also make sure that PE/COFF header can co-exist in the same
> > > > >>> image so that EFI stub can be supported for RISC-V in future.
> > > > >>> EFI specification needs PE/COFF image header in the beginning o=
f
> > > > >>> the kernel image in order to load it as an EFI application. In
> > > > >>> order to support EFI stub, code0 should be replaced with "MZ"
> > > > >>> magic string and res4(at offset 0x3c) should point to the rest
> > > > >>> of the PE/COFF header (which will be added during EFI support).
> > > > > [...]
> > > > >>> Documentation/riscv/boot-image-header.txt | 50
> > > > ++++++++++++++++++
> > > > >>> arch/riscv/include/asm/image.h            | 64
> > +++++++++++++++++++++++
> > > > >>> arch/riscv/kernel/head.S                  | 32 ++++++++++++
> > > > >>> 3 files changed, 146 insertions(+) create mode 100644
> > > > >>> Documentation/riscv/boot-image-header.txt
> > > > >>> create mode 100644 arch/riscv/include/asm/image.h
> > > > >>>
> > > > >>> diff --git a/Documentation/riscv/boot-image-header.txt
> > > > >>> b/Documentation/riscv/boot-image-header.txt
> > > > >>> new file mode 100644
> > > > >>> index 000000000000..68abc2353cec
> > > > >>> --- /dev/null
> > > > >>> +++ b/Documentation/riscv/boot-image-header.txt
> > > > >>> @@ -0,0 +1,50 @@
> > > > >>> +                               Boot image header in RISC-V
> > > > >>> + Linux
> > > > >>> +
> > > > >>> + =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >>> +
> > > > >>> +Author: Atish Patra <atish.patra@wdc.com> Date  : 20 May 2019
> > > > >>> +
> > > > >>> +This document only describes the boot image header details for
> > > > >>> +RISC-V
> > > > Linux.
> > > > >>> +The complete booting guide will be available at
> > > > Documentation/riscv/booting.txt.
> > > > >>> +
> > > > >>> +The following 64-byte header is present in decompressed Linux
> > > > >>> +kernel
> > > > image.
> > > > >>> +
> > > > >>> +       u32 code0;                /* Executable code */
> > > > >>> +       u32 code1;                /* Executable code */
> > > > >>
> > > > >> Apologies for not mentioning this in my previous reply, but give=
n
> > > > >> that you already know that you will need to put the magic string
> > > > >> MZ at offset 0x0, it makes more sense to not put any code there
> > > > >> at all, but educate the bootloader that the first executable
> > > > >> instruction is at offset 0x20, and put the spare fields right
> > > > >> after it in case you ever need more than 2 slots. (On arm64, we
> > > > >> were lucky to be able to find an opcode that happened to contain
> > > > >> the MZ bit pattern and act almost like a NOP, but it seems silly
> > > > >> to rely on that for RISC-V as
> > > > >> well)
> > > > >>
> > > > >> So something like
> > > > >>
> > > > >> u16 pe_res1;  /* MZ for EFI bootable images, don't care otherwis=
e */
> > > > >> u8 magic[6];    /* "RISCV\0"
> > > > >>
> > > > >> u64 text_offset;          /* Image load offset, little endian */
> > > > >> u64 image_size;           /* Effective Image size, little endian=
 */
> > > > >> u64 flags;                /* kernel flags, little endian */
> > > > >>
> > > > >> u32 code0;                /* Executable code */
> > > > >> u32 code1;                /* Executable code */
> > > > >>
> > > > >> u64 reserved[2];     /* reserved for future use */
> > > > >>
> > > > >> u32 version;              /* Version of this header */
> > > > >> u32 pe_res2;                 /* Reserved for PE COFF offset */
> > > > >
> > > > > Hello,
> > > > >
> > > > > wouldn't that immediately break existing systems (including qemu
> > > > > when loading kernels with the "-kernel" option) that rely on the
> > > > > fact that the kernel entry point is always at the kernel load
> > > > > address?  The
> > > > > ARM64 header and Atish's original RISC-V proposal based on the
> > > > > ARM64 header keep the property that jumping to the kernel load
> > > > > address always works, regardless of what the particular header
> > > > > looks like and which potential future extensions it includes, but
> > > > > the proposed change above wouldn't do that.
> > > > >
> > > > > Although I agree that having to integrate the "MZ" string as an
> > > > > instruction isn't particularly nice, I don't think that this is a
> > > > > sufficient justification for breaking compatibility with prior
> > > > > kernel releases and/or existing boot firmware.  On RISC-V, the
> > > > > "MZ" string is a compressed load immediate to x20/s4, i.e. an
> > > > > instruction that should be "harmless" as far as the kernel boot
> > > > > flow is concerned as the
> > > > > x20/s4 register AFAIK doesn't contain any information that the
> > > > > kernel would use.
> > > > >
> > > > > Regards,
> > > > > Karsten
> > > > >
> > > >
> > > > Yes, that would break existing systems. Besides, the qemu -kernel
> > > > option uses the vmlinux elf file, and I think a better solution is
> > > > make =E2=80=98loadelf=E2=80=99 work, and include a second method fo=
r EFI.
> > > >
> > > > (unfortunately, I had to drop some lists as I=E2=80=99m having trou=
ble
> > > > sending to them via gmail, so the CC list on my response has been
> > > > limited)
> > >
> > > Nopes, it works perfectly fine on QEMU RISC-V.
> > >
> > > Just like ARM64, we are lucky for RISC-V as well. The "MZ" string is =
a
> > > harmless load instruction in RISC-V so we don't need any changes in Q=
EMU.
> >
> > Hello,
> >
> > just to avoid misunderstandings: Atish, does your "Nopes, it works perf=
ectly
> > fine on QEMU RISC-V" refer to your original header proposal or to Ard's
> > modified header proposal?  For your proposal I agree that it works with=
out
>
> Sorry for the confusion. I meant here that adding "MZ" at start in Atish'=
s
> proposed header works fine on QEMU.
>
> > problems in all cases that have worked before introduction of the heade=
r,
> > i.e. adding your proposed header is completely transparent, but as desc=
ribed
> > above I have doubts that the same is true for the (different) header fo=
rmat
> > that Ard has proposed above.
>
> Yes, Ard's proposed header will break booting on current QEMU and
> existing HW. I think Ard's proposed header was to address the case if
> "MZ" was not a valid and harmless instruction in RISC-V. Other than
> that Ard's proposal is similar to Atish's proposal but organized differen=
tly.
>
> For Atish's proposed header, we are certainly relying on the fact that
> "MZ" represents a valid and harmless instruction (just like ARM64) but
> this approach is allowing us to boot Linux RISC-V kernel without breaking
> existing booting methods.
>

Fair enough. If you guys can live with it, then so can I :-)
