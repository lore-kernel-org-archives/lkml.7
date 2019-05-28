Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685FDC04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4149620B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfE1IXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:23:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1IXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:23:21 -0400
Received: from excalibur.cnev.de ([194.8.209.98]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MORN0-1hFWOR0OnW-00PwjF; Tue, 28 May 2019 10:22:53 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hVXNh-0000hc-5J; Tue, 28 May 2019 10:22:49 +0200
Date:   Tue, 28 May 2019 10:22:49 +0200
From:   Karsten Merker <merker@debian.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Troy Benjegerdes <troy.benjegerdes@sifive.com>,
        Karsten Merker <merker@debian.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Zong Li <zong@andestech.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: Re: [v4 PATCH] RISC-V: Add an Image header that boot loader can
 parse.
Message-ID: <20190528082248.awjwbz44lp6ak3m3@excalibur.cnev.de>
References: <20190524041814.7497-1-atish.patra@wdc.com>
 <CAKv+Gu9U56b50TrfriBfRFed_1aoXg2Y624tu7v5m2y+6DVq5w@mail.gmail.com>
 <20190527221619.fkxtzk4jpeyfoptf@excalibur.cnev.de>
 <3178D175-18AD-47D0-8D51-CB2900DFA572@sifive.com>
 <MN2PR04MB60610CF4829D5251A112CF9C8D1E0@MN2PR04MB6061.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR04MB60610CF4829D5251A112CF9C8D1E0@MN2PR04MB6061.namprd04.prod.outlook.com>
X-No-Archive: yes
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:+QRl04MRj8MHfX3dOiZkiAUGWmcdVK4/mq8zXNzBszUWJYIH9rb
 /PJmqbgHeGJ5EaWibyGBk2QjxFCJ878m7kkv/l7w52qa+rCTj2YWlFmwBx/6ksY0PqcCCv0
 krl+NQLFuhFsLeJjZx6cL2ORrPW1ghyh8TMslGcZTnNNbigmrwHWFGTiNqtQiwRtcwE/rk6
 Oqf0QhmZJJn1/Zohl/Fag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RX9GybnE7/Y=:M8Sjg1yzXEFumDZ/7N8QQy
 VniwJ7hvJbs3+tuCkSwJOL1T6n43IlFeZfcSAWwwIVY7oaUObQ8xZI96na2YuU4Bczo1TqSXY
 XbMY+4usg4T4kE0JzN7VVodOnNLmy786FI6tdYikTCmSr969xuljrizoKCnczCfTYtyBEqK8H
 Y2VO4fCxArLGZJk6gnM1cNUIZPDL/js0X79pq7LMXxoQLQfo9o2fkZOhTMsiMcMZp8R4Lajij
 cVoVEcWUGyPY4ywTKcH7FRl9gziv1peuOBcYpWrQIWDazbdaell+aG1ot0S7+AQTagLINmhH2
 Zkvfhp2Tzrf+9o5RQpOCk3Umg45RlK5j1U0P0A/gKyk4mx8Qjsqebl0X7pMHDUlnrNwx9xjC3
 h7KgjG/okF2iImYjDaRICbFTNcC8MMeBb2HSHUPgbzp1F128m4fh3pROTHU5/Ta+ELZ97b0G+
 ueLZG3k/i9XjGRqQOBCcy5fUHLt174fp8/SQK3UNYEjHuBHAIE75aRKHj5Pcdd8zPPLBsBeqn
 8wOhhGPxbqBKBHkqN9CnQQxU6lenMCD9b6IeRqQG8KBMMCthhBDSjKh12MQe6sG6S/Hwwa5AZ
 dOuAvaWf9uneFt2F9CXXn1I2nEXEybe3ZrGrYwJzrpXEeSAXGyBAuxexkB9XgPYsOltcHg3a/
 KweixexBVh2BS2LLWKk89TN6sI7rKRacmiyYvaKxRRBv48F8tCNwYTyIWsh1bkb5WncXlPhjW
 iVJFC1SmFTHju0i48CfFNUm61tMtn3gsgHksOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:54:02AM +0000, Anup Patel wrote:
> > From: Troy Benjegerdes <troy.benjegerdes@sifive.com>
> > > On May 27, 2019, at 5:16 PM, Karsten Merker <merker@debian.org>
> > wrote:
> > >
> > > On Mon, May 27, 2019 at 04:34:57PM +0200, Ard Biesheuvel wrote:
> > >> On Fri, 24 May 2019 at 06:18, Atish Patra <atish.patra@wdc.com> wrote:
> > >>> Currently, the last stage boot loaders such as U-Boot can accept
> > >>> only uImage which is an unnecessary additional step in automating
> > >>> boot process.
> > >>>
> > >>> Add an image header that boot loader understands and boot Linux from
> > >>> flat Image directly.
> > >>>
> > >>> This header is based on ARM64 boot image header and provides an
> > >>> opportunity to combine both ARM64 & RISC-V image headers in future.
> > >>>
> > >>> Also make sure that PE/COFF header can co-exist in the same image so
> > >>> that EFI stub can be supported for RISC-V in future. EFI
> > >>> specification needs PE/COFF image header in the beginning of the
> > >>> kernel image in order to load it as an EFI application. In order to
> > >>> support EFI stub, code0 should be replaced with "MZ" magic string
> > >>> and res4(at offset 0x3c) should point to the rest of the PE/COFF
> > >>> header (which will be added during EFI support).
> > > [...]
> > >>> Documentation/riscv/boot-image-header.txt | 50
> > ++++++++++++++++++
> > >>> arch/riscv/include/asm/image.h            | 64 +++++++++++++++++++++++
> > >>> arch/riscv/kernel/head.S                  | 32 ++++++++++++
> > >>> 3 files changed, 146 insertions(+)
> > >>> create mode 100644 Documentation/riscv/boot-image-header.txt
> > >>> create mode 100644 arch/riscv/include/asm/image.h
> > >>>
> > >>> diff --git a/Documentation/riscv/boot-image-header.txt
> > >>> b/Documentation/riscv/boot-image-header.txt
> > >>> new file mode 100644
> > >>> index 000000000000..68abc2353cec
> > >>> --- /dev/null
> > >>> +++ b/Documentation/riscv/boot-image-header.txt
> > >>> @@ -0,0 +1,50 @@
> > >>> +                               Boot image header in RISC-V Linux
> > >>> +
> > >>> + =============================================
> > >>> +
> > >>> +Author: Atish Patra <atish.patra@wdc.com> Date  : 20 May 2019
> > >>> +
> > >>> +This document only describes the boot image header details for RISC-V
> > Linux.
> > >>> +The complete booting guide will be available at
> > Documentation/riscv/booting.txt.
> > >>> +
> > >>> +The following 64-byte header is present in decompressed Linux kernel
> > image.
> > >>> +
> > >>> +       u32 code0;                /* Executable code */
> > >>> +       u32 code1;                /* Executable code */
> > >>
> > >> Apologies for not mentioning this in my previous reply, but given
> > >> that you already know that you will need to put the magic string MZ
> > >> at offset 0x0, it makes more sense to not put any code there at all,
> > >> but educate the bootloader that the first executable instruction is
> > >> at offset 0x20, and put the spare fields right after it in case you
> > >> ever need more than 2 slots. (On arm64, we were lucky to be able to
> > >> find an opcode that happened to contain the MZ bit pattern and act
> > >> almost like a NOP, but it seems silly to rely on that for RISC-V as
> > >> well)
> > >>
> > >> So something like
> > >>
> > >> u16 pe_res1;  /* MZ for EFI bootable images, don't care otherwise */
> > >> u8 magic[6];    /* "RISCV\0"
> > >>
> > >> u64 text_offset;          /* Image load offset, little endian */
> > >> u64 image_size;           /* Effective Image size, little endian */
> > >> u64 flags;                /* kernel flags, little endian */
> > >>
> > >> u32 code0;                /* Executable code */
> > >> u32 code1;                /* Executable code */
> > >>
> > >> u64 reserved[2];     /* reserved for future use */
> > >>
> > >> u32 version;              /* Version of this header */
> > >> u32 pe_res2;                 /* Reserved for PE COFF offset */
> > >
> > > Hello,
> > >
> > > wouldn't that immediately break existing systems (including qemu when
> > > loading kernels with the "-kernel" option) that rely on the fact that
> > > the kernel entry point is always at the kernel load address?  The
> > > ARM64 header and Atish's original RISC-V proposal based on the ARM64
> > > header keep the property that jumping to the kernel load address
> > > always works, regardless of what the particular header looks like and
> > > which potential future extensions it includes, but the proposed change
> > > above wouldn't do that.
> > >
> > > Although I agree that having to integrate the "MZ" string as an
> > > instruction isn't particularly nice, I don't think that this is a
> > > sufficient justification for breaking compatibility with prior kernel
> > > releases and/or existing boot firmware.  On RISC-V, the "MZ" string is
> > > a compressed load immediate to x20/s4, i.e. an instruction that should
> > > be "harmless" as far as the kernel boot flow is concerned as the
> > > x20/s4 register AFAIK doesn't contain any information that the kernel
> > > would use.
> > >
> > > Regards,
> > > Karsten
> > >
> > 
> > Yes, that would break existing systems. Besides, the qemu -kernel option
> > uses the vmlinux elf file, and I think a better solution is make ‘loadelf’ work,
> > and include a second method for EFI.
> > 
> > (unfortunately, I had to drop some lists as I’m having trouble sending to
> > them via gmail, so the CC list on my response has been limited)
> 
> Nopes, it works perfectly fine on QEMU RISC-V.
> 
> Just like ARM64, we are lucky for RISC-V as well. The "MZ" string is a
> harmless load instruction in RISC-V so we don't need any changes in QEMU.

Hello,

just to avoid misunderstandings: Atish, does your "Nopes, it
works perfectly fine on QEMU RISC-V" refer to your original
header proposal or to Ard's modified header proposal?  For your
proposal I agree that it works without problems in all cases that
have worked before introduction of the header, i.e. adding your
proposed header is completely transparent, but as described above
I have doubts that the same is true for the (different) header
format that Ard has proposed above.

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
