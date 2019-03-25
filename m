Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B968EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B4820848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="p/psuEGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfCYSbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:31:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37373 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYSbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:31:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id v84so7820174oif.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=De4EaLx9v93H4rVCB9OpKmCuXJ71zefVFfl8bToAja8=;
        b=p/psuEGd+bbH84nCMhcR2daLTOwWMpTx48QQFy0ea9FgbMAPI8OV9l3cPelA0UnXTw
         yNdukP3Njy2aa+tv22/A4TKJfJfS3wqJuVs0EI5WasO34XocggcaS/vpz4SV55Xh38/o
         gWbu0WC6cb2vsKL8iXvgpr7O3J7RRcPfNuTHKV3qnsT9I413mAFzSA6GEoRzOwJECinC
         1tsKI5tHfEiruKn1ztiO/tU65nym5IS2Vt9v3NO/GdbJor5opMqtdjM+mM0uj6BWLL9r
         4vJwVIQJx13nSo3vkn8UNI4n5KcEZ+PhXibBCai21qWIn0djEfCrkuCFJLu4vYr8DDEG
         Mw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=De4EaLx9v93H4rVCB9OpKmCuXJ71zefVFfl8bToAja8=;
        b=kb6GWR38DzDkIMqN+0vl+udJ5tgXzSbJzvBzcKAyn+fyV9V/jFrOyvpgzxcLRB2ref
         Bl3HNhznxIK3I0eQ9dJUICT/FpLE9hkATgGVlapymYLF5q6RDF+qJ74EC7uZ9vCbRk0m
         b03KSiZji5CutdRTt/LgQ12LiC5UZ/hXg535d/ker171XstjOOlKP25UfD/8jf9WMEvl
         36ap1cX1xR5KpkIebF4P52AJtAQpfCLHvbQnOcLQCLDQ6tLmC/7P2REF+KFTYeSQA2PC
         bmeBrSaHAWDNnp1DuNZmJOUtzQti6UejyJsUlLQrIEVXa84cT5PaP1ClRdqjQD++C7Xv
         Fweg==
X-Gm-Message-State: APjAAAVmyazOf2B7tSBILocMMGAyyYEfHG5zD7YAzFFiOhWb1V2iJkfw
        9VsAn+3gxC0EJgcvqNk6ih86HJ6rmb5nz9PA6ZcKpA==
X-Google-Smtp-Source: APXvYqweyMJzn4BD11eQrMQCO8LR/J0VVuDuZzmXPjzzKYYY6SYp4FkhWRAhdA0GV/Xtwo99XpOYoKmoe13aHDuvk5o=
X-Received: by 2002:aca:6209:: with SMTP id w9mr13107288oib.47.1553538697302;
 Mon, 25 Mar 2019 11:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
 <20190321214401.GC19508@bombadil.infradead.org> <CAFBinCA6oK5UhDAt9kva5qRisxr2gxMF26AMK8vC4b1DN5RXrw@mail.gmail.com>
 <5cad2529-8776-687e-58d0-4fb9e2ec59b1@amlogic.com>
In-Reply-To: <5cad2529-8776-687e-58d0-4fb9e2ec59b1@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Mar 2019 19:31:26 +0100
Message-ID: <CAFBinCA=0XSSVmzfTgb4eSiVFr=XRHqLOVFGyK0++XRty6VjnQ@mail.gmail.com>
Subject: Re: 32-bit Amlogic (ARM) SoC: kernel BUG in kfree()
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Matthew Wilcox <willy@infradead.org>, mhocko@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="0000000000003310550584ef6a0f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003310550584ef6a0f
Content-Type: text/plain; charset="UTF-8"

Hi Liang,

On Mon, Mar 25, 2019 at 11:03 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hi Martin,
>
> On 2019/3/23 5:07, Martin Blumenstingl wrote:
> > Hi Matthew,
> >
> > On Thu, Mar 21, 2019 at 10:44 PM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Thu, Mar 21, 2019 at 09:17:34PM +0100, Martin Blumenstingl wrote:
> >>> Hello,
> >>>
> >>> I am experiencing the following crash:
> >>>    ------------[ cut here ]------------
> >>>    kernel BUG at mm/slub.c:3950!
> >>
> >>          if (unlikely(!PageSlab(page))) {
> >>                  BUG_ON(!PageCompound(page));
> >>
> >> You called kfree() on the address of a page which wasn't allocated by slab.
> >>
> >>> I have traced this crash to the kfree() in meson_nfc_read_buf().
> >>> my observation is as follows:
> >>> - meson_nfc_read_buf() is called 7 times without any crash, the
> >>> kzalloc() call returns 0xe9e6c600 (virtual address) / 0x29e6c600
> >>> (physical address)
> >>> - the eight time meson_nfc_read_buf() is called kzalloc() call returns
> >>> 0xee39a38b (virtual address) / 0x2e39a38b (physical address) and the
> >>> final kfree() crashes
> >>> - changing the size in the kzalloc() call from PER_INFO_BYTE (= 8) to
> >>> PAGE_SIZE works around that crash
> >>
> >> I suspect you're doing something which corrupts memory.  Overrunning
> >> the end of your allocation or something similar.  Have you tried KASAN
> >> or even the various slab debugging (eg redzones)?
> > KASAN is not available on 32-bit ARM. there was some progress last
> > year [0] but it didn't make it into mainline. I tried to make the
> > patches apply again and got it to compile (and my kernel is still
> > booting) but I have no idea if it's still working. for anyone
> > interested, my patches are here: [1] (I consider this a HACK because I
> > don't know anything about the code which is being touched in the
> > patches, I only made it compile)
> >
> > SLAB debugging (redzones) were a great hint, thank you very much for
> > that Matthew! I enabled:
> >    CONFIG_SLUB_DEBUG=y
> >    CONFIG_SLUB_DEBUG_ON=y
> > and with that I now get "BUG kmalloc-64 (Not tainted): Redzone
> > overwritten" (a larger kernel log extract is attached).
> >
> > I'm starting to wonder if the NAND controller (hardware) writes more
> > than 8 bytes.
> > some context: the "info" buffer allocated in meson_nfc_read_buf is
> > then passed to the NAND controller IP (after using dma_map_single).
> >
> > Liang, how does the NAND controller know that it only has to send
> > PER_INFO_BYTE (= 8) bytes when called from meson_nfc_read_buf? all
> > other callers of meson_nfc_dma_buffer_setup (which passes the info
> > buffer to the hardware) are using (nand->ecc.steps * PER_INFO_BYTE)
> > bytes?
> >
> NFC_CMD_N2M and CMDRWGEN are different commands. CMDRWGEN needs to set
> the ecc page size (1KB or 512B) and Pages(2, 4, 8, ...), so
> PER_INFO_BYTE(= 8) bytes for each ecc page.
> I have never used NFC_CMD_N2M to transfer data before, because it is
> very low efficient. And I do a experiment with the attachment and find
> on overwritten on my meson axg platform.
>
> Martin, I would appreciate it very much if you would try the attachment
> on your meson m8b platform.
thank you for your debug patch! on my board 2 * PER_INFO_BYTE is not enough.
I took the idea from your patch and adapted it so I could print a
buffer with 256 bytes (which seems to be "big enough" for my board).
see the attached, modified patch

in the output I see that sometimes the first 32 bytes are not touched
by the controller, but everything beyond 32 bytes is modified in the
info buffer.

I also tried to increase the buffer size to 512, but that didn't make
a difference (I never saw any info buffer modification beyond 256
bytes).

also I just noticed that I didn't give you much details on my NAND chip yet.
from Amlogic vendor u-boot on Meson8m2 (all my Meson8b boards have
eMMC flash, but I believe the NAND controller on Meson8 to GXBB is
identical):
  m8m2_n200_v1#amlnf chipinfo
  flash  info
  name:B revision 20nm NAND 8GiB H27UCG8T2B, id:ad de 94 eb 74 44  0  0
  pagesize:0x4000, blocksize:0x400000, oobsize:0x500, chipsize:0x2000,
    option:0x8, T_REA:16, T_RHOH:15
  hw controller info
  chip_num:1, onfi_mode:0, page_shift:14, block_shift:22, option:0xc2
  ecc_unit:1024, ecc_bytes:70, ecc_steps:16, ecc_max:40
  bch_mode:5, user_mode:2, oobavail:32, oobtail:64384


Regards

Martin

--0000000000003310550584ef6a0f
Content-Type: text/plain; charset="US-ASCII"; name="debug-256-buffer-output.txt"
Content-Disposition: attachment; filename="debug-256-buffer-output.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jtoomclb1>
X-Attachment-Id: f_jtoomclb1

Li4uClsgICAgMi43MTY4ODVdIDAwMDAwMDAwOiAwMDAwIDgwMDUgMjgwMCAyOTQ1IGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkClsgICAg
Mi43MjA0NjRdIDAwMDAwMDIwOiBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkClsgICAgMi43Mjk2ODld
IDAwMDAwMDQwOiBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkClsgICAgMi43Mzg4NDddIDAwMDAwMDYw
OiBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkClsgICAgMi43NDgwNjVdIDAwMDAwMDgwOiBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkClsgICAgMi43NTcyMjhdIDAwMDAwMGEwOiBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkClsgICAgMi43NjY0MDRdIDAwMDAwMGMwOiBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkClsg
ICAgMi43NzU2MDJdIDAwMDAwMGUwOiBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkClsgICAgMi43ODQ3
ODBdIApbICAgIDIuNzg2MzA2XSAwMDAwMDAwMDogMDAwMCA4MDFiIDI4MDAgMjk0NSBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAg
IDIuNzk1NDU1XSAwMDAwMDAyMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDIuODA0NjM4
XSAwMDAwMDA0MDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDIuODEzODI4XSAwMDAwMDA2
MDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDIuODIzMDE0XSAwMDAwMDA4MDogZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZApbICAgIDIuODMyMjAzXSAwMDAwMDBhMDogZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZApbICAgIDIuODQxMzkwXSAwMDAwMDBjMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApb
ICAgIDIuODUwNTgwXSAwMDAwMDBlMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDIuODU5
NzU5XSAKWyAgICAyLjg2MTMwM10gMDAwMDAwMDA6IDAwMDAgODAxMSAzZDAwIDI5NWUgZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAg
ICAyLjg3MDQzNV0gMDAwMDAwMjA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAyLjg3OTYx
OF0gMDAwMDAwNDA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAyLjg4ODgxMl0gMDAwMDAw
NjA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAyLjg5Nzk5Nl0gMDAwMDAwODA6IGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAyLjkwNzE4NF0gMDAwMDAwYTA6IGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQKWyAgICAyLjkxNjM2NF0gMDAwMDAwYzA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQK
WyAgICAyLjkyNTU1OV0gMDAwMDAwZTA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAyLjkz
NDc0MV0gClsgICAgMi45MzYzNjddIDAwMDAwMDAwOiBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkClsg
ICAgMi45NDU0MTNdIDAwMDAwMDIwOiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZi
IDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiClsgICAgMi45NTQ2
MDBdIDAwMDAwMDQwOiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2
YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiClsgICAgMi45NjM4MDNdIDAwMDAw
MDYwOiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZi
NmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiClsgICAgMi45NzI5NzhdIDAwMDAwMDgwOiA2YjZi
IDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2
YjZiIDZiNmIgNmI2YiA2YjZiClsgICAgMi45ODIxNjNdIDAwMDAwMGEwOiA2YjZiIDZiNmIgNmI2
YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIg
NmI2YiA2YjZiClsgICAgMi45OTEzNTJdIDAwMDAwMGMwOiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZi
NmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZi
ClsgICAgMy4wMDA1MzldIDAwMDAwMGUwOiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2
YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiBhNTZiClsgICAgMy4w
MDk3MjJdIApbICAgIDMuMDExMjMzXSAwMDAwMDAwMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApb
ICAgIDMuMDIwMzkwXSAwMDAwMDAyMDogNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2
YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YgpbICAgIDMuMDI5
NTgwXSAwMDAwMDA0MDogNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZi
NmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YgpbICAgIDMuMDM4NzY2XSAwMDAw
MDA2MDogNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2
YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YgpbICAgIDMuMDQ3OTcxXSAwMDAwMDA4MDogNmI2
YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIg
NmI2YiA2YjZiIDZiNmIgNmI2YgpbICAgIDMuMDU3MTQ1XSAwMDAwMDBhMDogNmI2YiA2YjZiIDZi
NmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZi
IDZiNmIgNmI2YgpbICAgIDMuMDY2MzI1XSAwMDAwMDBjMDogNmI2YiA2YjZiIDZiNmIgNmI2YiA2
YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2
YgpbICAgIDMuMDc1NTIxXSAwMDAwMDBlMDogNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIg
NmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgYTU2YgpbICAgIDMu
MDg0NzAwXSAKWyAgICAzLjA4NjIxM10gMDAwMDAwMDA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQK
WyAgICAzLjA5NTM3M10gMDAwMDAwMjA6IDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZi
NmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIKWyAgICAzLjEw
NDU1OF0gMDAwMDAwNDA6IDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2
YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIKWyAgICAzLjExMzc0OF0gMDAw
MDAwNjA6IDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIg
NmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIKWyAgICAzLjEyMjkzNF0gMDAwMDAwODA6IDZi
NmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZi
IDZiNmIgNmI2YiA2YjZiIDZiNmIKWyAgICAzLjEzMjEyNF0gMDAwMDAwYTA6IDZiNmIgNmI2YiA2
YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2
YiA2YjZiIDZiNmIKWyAgICAzLjE0MTMxMV0gMDAwMDAwYzA6IDZiNmIgNmI2YiA2YjZiIDZiNmIg
NmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZi
NmIKWyAgICAzLjE1MDUwNV0gMDAwMDAwZTA6IDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZi
IDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIDZiNmIgNmI2YiA2YjZiIGE1NmIKWyAgICAz
LjE1OTY4MV0gClsgICAgMy4xNjExNzFdIENvdWxkIG5vdCBmaW5kIGEgdmFsaWQgT05GSSBwYXJh
bWV0ZXIgcGFnZSwgdHJ5aW5nIGJpdC13aXNlIG1ham9yaXR5IHRvIHJlY292ZXIgaXQKWyAgICAz
LjE2OTc4Nl0gT05GSSBwYXJhbWV0ZXIgcmVjb3ZlcnkgZmFpbGVkLCBhYm9ydGluZwpbICAgIDMu
MTc0NzQwXSAwMDAwMDAwMDogMDAwMCA4MDEwIDNkMDAgMjk1ZSBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMTgzODc3XSAw
MDAwMDAyMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMTkzMDY0XSAwMDAwMDA0MDog
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMjAyMjQ5XSAwMDAwMDA2MDogZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQgZmRmZApbICAgIDMuMjExNDM5XSAwMDAwMDA4MDogZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZApbICAgIDMuMjIwNjI2XSAwMDAwMDBhMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAg
IDMuMjI5ODE1XSAwMDAwMDBjMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMjM5MDAy
XSAwMDAwMDBlMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMjQ4MTg0XSAKWyAgICAz
LjI0OTc0M10gMDAwMDAwMDA6IDAwMDAgODAxMCAyMmMwIDI5NWUgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAzLjI1ODg1N10g
MDAwMDAwMjA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAzLjI2ODA0NF0gMDAwMDAwNDA6
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAzLjI3NzIzMV0gMDAwMDAwNjA6IGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQKWyAgICAzLjI4NjQxMV0gMDAwMDAwODA6IGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQKWyAgICAzLjI5NTYwN10gMDAwMDAwYTA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAg
ICAzLjMwNDc5NF0gMDAwMDAwYzA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAzLjMxMzk4
NF0gMDAwMDAwZTA6IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQKWyAgICAzLjMyMzE2M10gClsgICAg
My4zMjQ2NTddIG5hbmQ6IGRldmljZSBmb3VuZCwgTWFudWZhY3R1cmVyIElEOiAweGFkLCBDaGlw
IElEOiAweGRlClsgICAgMy4zMzA5NjhdIG5hbmQ6IEh5bml4IE5BTkQgOEdpQiAzLDNWIDgtYml0
ClsgICAgMy4zMzUyMTBdIG5hbmQ6IDgxOTIgTWlCLCBNTEMsIGVyYXNlIHNpemU6IDQwOTYgS2lC
LCBwYWdlIHNpemU6IDE2Mzg0LCBPT0Igc2l6ZTogMTI4MApbICAgIDMuMzQzMjc0XSAwMDAwMDAw
MDogMDAwMCA4MDEwIDI0MDAgMjk1ZSBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMzUyMzkwXSAwMDAwMDAyMDogZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMzYxNTcyXSAwMDAwMDA0MDogZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZApbICAgIDMuMzcwNzYyXSAwMDAwMDA2MDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZk
IGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApb
ICAgIDMuMzc5OTYzXSAwMDAwMDA4MDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMzg5
MTQwXSAwMDAwMDBhMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZk
ZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuMzk4MzI2XSAwMDAw
MDBjMDogZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBm
ZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuNDA3NTE5XSAwMDAwMDBlMDogZmRm
ZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQgZmRmZCBmZGZkIGZkZmQg
ZmRmZCBmZGZkIGZkZmQgZmRmZApbICAgIDMuNDE2Njk1XSAKLi4uCg==
--0000000000003310550584ef6a0f
Content-Type: application/x-patch; name="nand_debug_martin.patch"
Content-Disposition: attachment; filename="nand_debug_martin.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtoomcks0>
X-Attachment-Id: f_jtoomcks0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L21lc29uX25hbmQuYyBiL2RyaXZlcnMv
bXRkL25hbmQvcmF3L21lc29uX25hbmQuYwppbmRleCBjYjBiMDNlMzZhMzUuLjZkNzkyNzE1MDA4
MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFuZC5jCisrKyBiL2Ry
aXZlcnMvbXRkL25hbmQvcmF3L21lc29uX25hbmQuYwpAQCAtNTI3LDEyICs1MjcsMTQgQEAgc3Rh
dGljIGludCBtZXNvbl9uZmNfcmVhZF9idWYoc3RydWN0IG5hbmRfY2hpcCAqbmFuZCwgdTggKmJ1
ZiwgaW50IGxlbikKIAl1MzIgY21kOwogCXU4ICppbmZvOwogCi0JaW5mbyA9IGt6YWxsb2MoUEVS
X0lORk9fQllURSwgR0ZQX0tFUk5FTCk7CisJaW5mbyA9IGt6YWxsb2MoMjU2LCBHRlBfS0VSTkVM
KTsKIAlpZiAoIWluZm8pCiAJCXJldHVybiAtRU5PTUVNOwogCi0JcmV0ID0gbWVzb25fbmZjX2Rt
YV9idWZmZXJfc2V0dXAobmFuZCwgYnVmLCBsZW4sIGluZm8sCi0JCQkJCSBQRVJfSU5GT19CWVRF
LCBETUFfRlJPTV9ERVZJQ0UpOworCW1lbXNldChpbmZvLCAweEZELCAyNTYpOworCisJcmV0ID0g
bWVzb25fbmZjX2RtYV9idWZmZXJfc2V0dXAobmFuZCwgYnVmLCBsZW4sIGluZm8sIFBFUl9JTkZP
X0JZVEUsCisJCQkJCSBETUFfRlJPTV9ERVZJQ0UpOwogCWlmIChyZXQpCiAJCWdvdG8gb3V0Owog
CkBAIC01NDQsNiArNTQ2LDkgQEAgc3RhdGljIGludCBtZXNvbl9uZmNfcmVhZF9idWYoc3RydWN0
IG5hbmRfY2hpcCAqbmFuZCwgdTggKmJ1ZiwgaW50IGxlbikKIAltZXNvbl9uZmNfZG1hX2J1ZmZl
cl9yZWxlYXNlKG5hbmQsIGxlbiwgUEVSX0lORk9fQllURSwgRE1BX0ZST01fREVWSUNFKTsKIAog
b3V0OgorCXByaW50X2hleF9kdW1wKEtFUk5fRVJSLCAiIiwgRFVNUF9QUkVGSVhfT0ZGU0VULCAz
MiwgMiwgaW5mbywgMjU2LCBmYWxzZSk7CisJcHJpbnRrKCJcbiIpOworCiAJa2ZyZWUoaW5mbyk7
CiAKIAlyZXR1cm4gcmV0Owo=
--0000000000003310550584ef6a0f--
