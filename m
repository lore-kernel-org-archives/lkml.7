Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8575721871
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KrKmCgnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfC1SDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:03:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44068 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1SDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:03:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id d24so4683468otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fCTyZRCiCku/USEsGf8y1jvpLGyv9VLGqT64cOE57Q=;
        b=KrKmCgnTtsAf0h+pOPK7PptTOx8H025Pq+M+Aeuhdf0bPy6/jOq5+MGRup9q6f0Q0x
         6r8TgwLnp532B9pY+8HRZqh9GIunc3N2a7HDWtCClZjN6o3O4bgJA5QxRhei5PXEPTXr
         hsQxYP8DYdEVcHKm3RSoGOa8Je11IXxS5QgEggtFfBQnD5CSS6iOCK8Pt8hBfvk7dmCD
         PqWvVvtKwrqgXsvhQA9FlEvGy1FMRySLbwY0myNETsAzbXz2uJCS1/y1sLoqHuxWbOON
         XzuPb2EWrHI83U/iTl5MlBmLyMw1KRUIbnUC+T2tLap6FWoxNaFCNaPnana5HNWD8icS
         OyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fCTyZRCiCku/USEsGf8y1jvpLGyv9VLGqT64cOE57Q=;
        b=oIUolEj1kSZT9xkUiqsKE1KuBw/qlOCDE6LXmC3R53ZpIChO1KPAcHOkNfaO3aMzG+
         mOtcfuCb8/6JdOd6KjvpdLte10DgxrRaqtCmOZ33f7jJTe0QkAB7+IpuXGzZJXyc7FIg
         hAkMlmuaL8RN9z4q/wjcqn5YnahVn0tcqeTfo1A66a7GVd/4UwJ4/Ez7g4T6rvrObQAQ
         58OWlVJTOtFPXmUUcxyZH0RMtjU+cssBl1rCOsQOh7zvxKOUHTh6F1C4VKgbSxagA1NX
         SXz8+wOOIdLNOVo+xs48ZT3SLAIiA5fjJKaDYgwqb431U5k8M5DKfATLlam/dSl3wFwx
         yAAw==
X-Gm-Message-State: APjAAAUKPoH2wNyTlWLpFI7b7wUuT2s52f73N9Cp81Bp/x5Y33cS0+8l
        FF6aUQGxByjKl54jiPem79a9+MTgwKNvswrJ6UM=
X-Google-Smtp-Source: APXvYqy8QRbh5lvdOM3/duJB0f05b7u7CUuXpBLOLyGfteaawvVZabLhkv/ntQdtejwqadv/118F8DKMGve18GJA4C8=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr30907499oth.308.1553796207733;
 Thu, 28 Mar 2019 11:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
 <20190321214401.GC19508@bombadil.infradead.org> <CAFBinCA6oK5UhDAt9kva5qRisxr2gxMF26AMK8vC4b1DN5RXrw@mail.gmail.com>
 <5cad2529-8776-687e-58d0-4fb9e2ec59b1@amlogic.com> <CAFBinCA=0XSSVmzfTgb4eSiVFr=XRHqLOVFGyK0++XRty6VjnQ@mail.gmail.com>
 <32799846-b8f0-758f-32eb-a9ce435e0b79@amlogic.com>
In-Reply-To: <32799846-b8f0-758f-32eb-a9ce435e0b79@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 28 Mar 2019 19:03:16 +0100
Message-ID: <CAFBinCDHmuNZxuDf3pe2ij6m8aX2fho7L+B9ZMaMOo28tPZ62Q@mail.gmail.com>
Subject: Re: 32-bit Amlogic (ARM) SoC: kernel BUG in kfree()
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Matthew Wilcox <willy@infradead.org>, mhocko@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="00000000000004137b05852b5f2b"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000004137b05852b5f2b
Content-Type: text/plain; charset="UTF-8"

Hi Liang,

On Wed, Mar 27, 2019 at 9:52 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hi Martin,
>
> Thanks a lot.
> On 2019/3/26 2:31, Martin Blumenstingl wrote:
> > Hi Liang,
> >
> > On Mon, Mar 25, 2019 at 11:03 AM Liang Yang <liang.yang@amlogic.com> wrote:
> >>
> >> Hi Martin,
> >>
> >> On 2019/3/23 5:07, Martin Blumenstingl wrote:
> >>> Hi Matthew,
> >>>
> >>> On Thu, Mar 21, 2019 at 10:44 PM Matthew Wilcox <willy@infradead.org> wrote:
> >>>>
> >>>> On Thu, Mar 21, 2019 at 09:17:34PM +0100, Martin Blumenstingl wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I am experiencing the following crash:
> >>>>>     ------------[ cut here ]------------
> >>>>>     kernel BUG at mm/slub.c:3950!
> >>>>
> >>>>           if (unlikely(!PageSlab(page))) {
> >>>>                   BUG_ON(!PageCompound(page));
> >>>>
> >>>> You called kfree() on the address of a page which wasn't allocated by slab.
> >>>>
> >>>>> I have traced this crash to the kfree() in meson_nfc_read_buf().
> >>>>> my observation is as follows:
> >>>>> - meson_nfc_read_buf() is called 7 times without any crash, the
> >>>>> kzalloc() call returns 0xe9e6c600 (virtual address) / 0x29e6c600
> >>>>> (physical address)
> >>>>> - the eight time meson_nfc_read_buf() is called kzalloc() call returns
> >>>>> 0xee39a38b (virtual address) / 0x2e39a38b (physical address) and the
> >>>>> final kfree() crashes
> >>>>> - changing the size in the kzalloc() call from PER_INFO_BYTE (= 8) to
> >>>>> PAGE_SIZE works around that crash
> >>>>
> >>>> I suspect you're doing something which corrupts memory.  Overrunning
> >>>> the end of your allocation or something similar.  Have you tried KASAN
> >>>> or even the various slab debugging (eg redzones)?
> >>> KASAN is not available on 32-bit ARM. there was some progress last
> >>> year [0] but it didn't make it into mainline. I tried to make the
> >>> patches apply again and got it to compile (and my kernel is still
> >>> booting) but I have no idea if it's still working. for anyone
> >>> interested, my patches are here: [1] (I consider this a HACK because I
> >>> don't know anything about the code which is being touched in the
> >>> patches, I only made it compile)
> >>>
> >>> SLAB debugging (redzones) were a great hint, thank you very much for
> >>> that Matthew! I enabled:
> >>>     CONFIG_SLUB_DEBUG=y
> >>>     CONFIG_SLUB_DEBUG_ON=y
> >>> and with that I now get "BUG kmalloc-64 (Not tainted): Redzone
> >>> overwritten" (a larger kernel log extract is attached).
> >>>
> >>> I'm starting to wonder if the NAND controller (hardware) writes more
> >>> than 8 bytes.
> >>> some context: the "info" buffer allocated in meson_nfc_read_buf is
> >>> then passed to the NAND controller IP (after using dma_map_single).
> >>>
> >>> Liang, how does the NAND controller know that it only has to send
> >>> PER_INFO_BYTE (= 8) bytes when called from meson_nfc_read_buf? all
> >>> other callers of meson_nfc_dma_buffer_setup (which passes the info
> >>> buffer to the hardware) are using (nand->ecc.steps * PER_INFO_BYTE)
> >>> bytes?
> >>>
> >> NFC_CMD_N2M and CMDRWGEN are different commands. CMDRWGEN needs to set
> >> the ecc page size (1KB or 512B) and Pages(2, 4, 8, ...), so
> >> PER_INFO_BYTE(= 8) bytes for each ecc page.
> >> I have never used NFC_CMD_N2M to transfer data before, because it is
> >> very low efficient. And I do a experiment with the attachment and find
> >> on overwritten on my meson axg platform.
> >>
> >> Martin, I would appreciate it very much if you would try the attachment
> >> on your meson m8b platform.
> > thank you for your debug patch! on my board 2 * PER_INFO_BYTE is not enough.
> > I took the idea from your patch and adapted it so I could print a
> > buffer with 256 bytes (which seems to be "big enough" for my board).
> it only needs PER_INFO_BYTE (= 8) bytes, because NFC_CMD_N2M don't set
> *Pages*, that is not like CMDRWGEN which needs Pages*PER_INFO_BYTE (= 8)
>   bytes when setting *Pages* parameter. I have been thinking that
> NFC_CMD_N2M  only occupis PER_INFO_BYTE (= 8) bytes. And i have tried to
> not set the info address, the machine would crash.
thank you for the explanation. the command is built using:
  cmd = NFC_CMD_N2M | (len & GENMASK(5, 0));

> > see the attached, modified patch
> >
> > in the output I see that sometimes the first 32 bytes are not touched
> > by the controller, but everything beyond 32 bytes is modified in the
> > info buffer.
> >
> it really makes sense that the controller sometimes fills the space
> beyond the first 8 bytes. However i expect the controller should only
> take the first 8 bytes when using NFC_CMD_N2M.
in my tests (see the attached log output) it seems that the info
buffer size has the following constraints:
- use the "len" which is passed to meson_nfc_read_buf
- if "len" is smaller than PER_INFO_BYTE then use PER_INFO_BYTE (= 8)

> > I also tried to increase the buffer size to 512, but that didn't make
> > a difference (I never saw any info buffer modification beyond 256
> > bytes).
> >
> > also I just noticed that I didn't give you much details on my NAND chip yet.
> > from Amlogic vendor u-boot on Meson8m2 (all my Meson8b boards have
> > eMMC flash, but I believe the NAND controller on Meson8 to GXBB is
> > identical):
> >    m8m2_n200_v1#amlnf chipinfo
> >    flash  info
> >    name:B revision 20nm NAND 8GiB H27UCG8T2B, id:ad de 94 eb 74 44  0  0
> >    pagesize:0x4000, blocksize:0x400000, oobsize:0x500, chipsize:0x2000,
> >      option:0x8, T_REA:16, T_RHOH:15
> >    hw controller info
> >    chip_num:1, onfi_mode:0, page_shift:14, block_shift:22, option:0xc2
> >    ecc_unit:1024, ecc_bytes:70, ecc_steps:16, ecc_max:40
> >    bch_mode:5, user_mode:2, oobavail:32, oobtail:64384
> >
> I don't think it is caused by a different NAND type, but i have followed
> the some test on my GXL platform. we can see the result from the
> attachment. By the way, i don't find any information about this on meson
> NFC datasheet, so i will ask our VLSI.
> Martin, May you reproduce it with the new patch on meson8b platform ? I
> need a more clear and easier compared log like gxl.txt. Thanks.
your gxl.txt is great, finally I can also compare my own results with
something that works for you!
in my results (see attachment) the "DATA_IN  [256 B, force 8-bit]"
instructions result in a different info buffer output.
does this make any sense to you?


Regards
Martin

--00000000000004137b05852b5f2b
Content-Type: text/plain; charset="US-ASCII"; 
	name="nand-debug-output-operations-and-info-buffer.txt"
Content-Disposition: attachment; 
	filename="nand-debug-output-operations-and-info-buffer.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jtsxts9n0>
X-Attachment-Id: f_jtsxts9n0

WyAgICAyLjcyNjkyMV0gRXhlY3V0aW5nIG9wZXJhdGlvbiBbMiBpbnN0cnVjdGlvbnNdOgpbICAg
IDIuNzI2OTI0XSAgIC0+Q01EICAgICAgWzB4ZmZdClsgICAgMi43MjY5NTBdICAgLT5XQUlUUkRZ
ICBbbWF4IDI1MCBtc10KWyAgICAyLjcyOTEzMV0gRXhlY3V0aW5nIG9wZXJhdGlvbiBbMyBpbnN0
cnVjdGlvbnNdOgpbICAgIDIuNzMyNzQ4XSAgIC0+Q01EICAgICAgWzB4OTBdClsgICAgMi43Mzc0
ODBdICAgLT5BRERSICAgICBbMSBjeWNdClsgICAgMi43NDA1NTBdICAgLT5EQVRBX0lOICBbMiBC
LCBmb3JjZSA4LWJpdF0KWyAgICAyLjc0Nzk2M10gMHgwIDB4MCAweDUgMHg4MCAweDAgMHgyOCAw
eDQ1IDB4MjkgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIu
NzU1OTc4XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuNzY0NDMxXSAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIApbICAgIDIuNzcyODA1XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAg
IDIuNzgxMjExXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuNzg5NjE3XSAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIApbICAgIDIuNzk4MDI3XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApb
ICAgIDIuODA2NDQwXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuODE0ODM2XSAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuODIzMjUyXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IApbICAgIDIuODMxNjU4XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuODQwMDY3XSAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuODQ4NDc1XSAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIApbICAgIDIuODU2ODg0XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuODY1Mjg1
XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuODczNjk5XSAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIApbICAgIDIuODgyMTIyXSBFeGVjdXRpbmcgb3BlcmF0aW9uIFszIGluc3RydWN0aW9u
c106ClsgICAgMi44ODIxMjRdICAgLT5DTUQgICAgICBbMHg5MF0KWyAgICAyLjg4Njc5MV0gICAt
PkFERFIgICAgIFsxIGN5Y10KWyAgICAyLjg4OTkwNF0gICAtPkRBVEFfSU4gIFs4IEIsIGZvcmNl
IDgtYml0XQpbICAgIDIuODk3MzE2XSAweDAgMHgwIDB4MWIgMHg4MCAweDAgMHgyOCAweDQ1IDB4
MjkgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuOTA1NDE5
XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuOTEzODM3XSAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIApbICAgIDIuOTIyMjQ0XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuOTMw
NjUwXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuOTM5MDU5XSAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIApbICAgIDIuOTQ3NDY3XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIu
OTU1ODY4XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuOTY0MjgzXSAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIApbICAgIDIuOTcyNzA2XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAg
IDIuOTgxMTAxXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDIuOTg5NTA3XSAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIApbICAgIDIuOTk3OTE2XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApb
ICAgIDMuMDA2MzE3XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMDE0NzMxXSAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMDIzMTQxXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IApbICAgIDMuMDMxNTY1XSBFeGVjdXRpbmcgb3BlcmF0aW9uIFszIGluc3RydWN0aW9uc106Clsg
ICAgMy4wMzE1NjddICAgLT5DTUQgICAgICBbMHg5MF0KWyAgICAzLjAzNjIyM10gICAtPkFERFIg
ICAgIFsxIGN5Y10KWyAgICAzLjAzOTM1M10gICAtPkRBVEFfSU4gIFs0IEIsIGZvcmNlIDgtYml0
XQpbICAgIDMuMDQ2Nzg0XSAweDAgMHgwIDB4MTEgMHg4MCAweDAgMHgzZCAweDVlIDB4MjkgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMDU0ODU5XSAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMDYzMjgwXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IApbICAgIDMuMDcxNjg3XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMDgwMDkyXSAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMDg4NDk5XSAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIApbICAgIDMuMDk2OTA3XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMTA1MzA4
XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMTEzNzIyXSAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIApbICAgIDMuMTIyMTMyXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMTMw
NTM5XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMTM4OTQ4XSAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIApbICAgIDMuMTQ3MzU2XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMu
MTU1NzU3XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMTY0MTcyXSAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIApbICAgIDMuMTcyNTc5XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAg
IDMuMTgxMDQ4XSBFeGVjdXRpbmcgb3BlcmF0aW9uIFszIGluc3RydWN0aW9uc106ClsgICAgMy4x
ODEwNTBdICAgLT5DTUQgICAgICBbMHhlY10KWyAgICAzLjE4NTY2M10gICAtPkFERFIgICAgIFsx
IGN5Y10KWyAgICAzLjE4ODc5M10gICAtPldBSVRSRFkgIFttYXggMjAwMDAwIG1zXQpbICAgIDMu
MTkyMDEzXSBFeGVjdXRpbmcgb3BlcmF0aW9uIFsxIGluc3RydWN0aW9uc106ClsgICAgMy4xOTU4
OTNdICAgLT5EQVRBX0lOICBbMjU2IEIsIGZvcmNlIDgtYml0XQpbICAgIDMuMjA0OTIzXSAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMjEzMzIyXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IApbICAgIDMuMjIxNzMwXSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMjMwMTM3XSAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMjM4NTQ2XSAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIApbICAgIDMuMjQ2OTU0XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4
NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMjU1MzU1
XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMjYzNzcxXSAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIApbICAgIDMuMjcyMTc3XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMjgw
NTg3XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4
NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMjg4OTk0XSAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIApbICAgIDMuMjk3NDAzXSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMu
MzA1ODA0XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMzE0MjE4XSAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4
NmIgMHg2YiAweDZiIApbICAgIDMuMzIyNjI4XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAg
IDMuMzMxMDM5XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweGE1IApbICAgIDMuMzM5NDY5XSBFeGVjdXRp
bmcgb3BlcmF0aW9uIFsxIGluc3RydWN0aW9uc106ClsgICAgMy4zMzk0NzFdICAgLT5EQVRBX0lO
ICBbMjU2IEIsIGZvcmNlIDgtYml0XQpbICAgIDMuMzQ4NDc1XSAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIApbICAgIDMuMzU2ODY4XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuMzY1MjY4
XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMzczNjgzXSAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIApbICAgIDMuMzgyMDkyXSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMzkw
NTE0XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4
NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuMzk4OTExXSAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIApbICAgIDMuNDA3MzE3XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMu
NDE1NzE4XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNDI0MTMzXSAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4
NmIgMHg2YiAweDZiIApbICAgIDMuNDMyNTQwXSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAg
IDMuNDQwOTQ5XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNDQ5MzU2XSAweDZiIDB4
NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIApbICAgIDMuNDU3NzY2XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApb
ICAgIDMuNDY2MTY3XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNDc0NTgxXSAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweGE1IApbICAgIDMuNDgzMDE0XSBFeGVjdXRpbmcgb3BlcmF0aW9uIFsx
IGluc3RydWN0aW9uc106ClsgICAgMy40ODMwMTZdICAgLT5EQVRBX0lOICBbMjU2IEIsIGZvcmNl
IDgtYml0XQpbICAgIDMuNDkyMDEzXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuNTAw
NDE1XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuNTA4ODIxXSAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIApbICAgIDMuNTE3MjMwXSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMu
NTI1NjMxXSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNTM0MDQ1XSAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4
NmIgMHg2YiAweDZiIApbICAgIDMuNTQyNDU0XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAg
IDMuNTUwODYxXSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNTU5MjcxXSAweDZiIDB4
NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIApbICAgIDMuNTY3Njc4XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApb
ICAgIDMuNTc2MDgwXSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNTg0NDk1XSAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNTkyOTA2XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4
NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZi
IApbICAgIDMuNjAxMzI2XSAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIg
MHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNjA5NzIwXSAw
eDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2
YiAweDZiIDB4NmIgMHg2YiAweDZiIApbICAgIDMuNjE4MTI5XSAweDZiIDB4NmIgMHg2YiAweDZi
IDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAweDZiIDB4NmIgMHg2YiAw
eGE1IApbICAgIDMuNjI2NTYwXSBDb3VsZCBub3QgZmluZCBhIHZhbGlkIE9ORkkgcGFyYW1ldGVy
IHBhZ2UsIHRyeWluZyBiaXQtd2lzZSBtYWpvcml0eSB0byByZWNvdmVyIGl0ClsgICAgMy42MzUx
NTVdIE9ORkkgcGFyYW1ldGVyIHJlY292ZXJ5IGZhaWxlZCwgYWJvcnRpbmcKWyAgICAzLjY0MDA3
M10gRXhlY3V0aW5nIG9wZXJhdGlvbiBbMyBpbnN0cnVjdGlvbnNdOgpbICAgIDMuNjQwMDc1XSAg
IC0+Q01EICAgICAgWzB4OTBdClsgICAgMy42NDQ3MzNdICAgLT5BRERSICAgICBbMSBjeWNdClsg
ICAgMy42NDc4NjNdICAgLT5EQVRBX0lOICBbNSBCLCBmb3JjZSA4LWJpdF0KWyAgICAzLjY1NTI2
OV0gMHgwIDB4MCAweDEwIDB4ODAgMHgwIDB4M2QgMHg1ZSAweDI5IDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjY2MzM4MV0gMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAKWyAgICAzLjY3MTc4NF0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjY4MDE5
M10gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjY4ODYwMV0gMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAKWyAgICAzLjY5NzAwOV0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjcw
NTQxMF0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjcxMzgyNF0gMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAKWyAgICAzLjcyMjIzNF0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAz
LjczMDY0MF0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjczOTA1MF0gMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAKWyAgICAzLjc0NzQ1OF0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAg
ICAzLjc1NTg1OV0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjc2NDI3NF0gMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjc3MjY4MV0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAK
WyAgICAzLjc4MTA5MV0gMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAKWyAgICAzLjc4OTUzN10gRXhl
Y3V0aW5nIG9wZXJhdGlvbiBbMyBpbnN0cnVjdGlvbnNdOgpbICAgIDMuNzg5NTM5XSAgIC0+Q01E
ICAgICAgWzB4OTBdClsgICAgMy43OTQxNzRdICAgLT5BRERSICAgICBbMSBjeWNdClsgICAgMy43
OTczMDRdICAgLT5EQVRBX0lOICBbNSBCLCBmb3JjZSA4LWJpdF0KWyAgICAzLjgwNDcwN10gMHgw
IDB4MCAweDEwIDB4ODAgMHhjMCAweDIyIDB4NWUgMHgyOSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy44MTI5MjFdIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
ClsgICAgMy44MjEzMTRdIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy44Mjk3MTldIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy44MzgxMjhdIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgClsgICAgMy44NDY1NDBdIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy44NTQ5Mzdd
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy44NjMzNTNdIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgClsgICAgMy44NzE3NTldIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy44ODAx
NjldIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy44ODg1NzddIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgClsgICAgMy44OTY5ODVdIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy45
MDUzODZdIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy45MTM4MDBdIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgClsgICAgMy45MjIyMTBdIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAg
My45MzA2MTZdIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgClsgICAgMy45MzkwNTNdIG5hbmQ6IGRl
dmljZSBmb3VuZCwgTWFudWZhY3R1cmVyIElEOiAweGFkLCBDaGlwIElEOiAweGRlClsgICAgMy45
NDUzNDhdIG5hbmQ6IEh5bml4IE5BTkQgOEdpQiAzLDNWIDgtYml0ClsgICAgMy45NDk2MDRdIG5h
bmQ6IDgxOTIgTWlCLCBNTEMsIGVyYXNlIHNpemU6IDQwOTYgS2lCLCBwYWdlIHNpemU6IDE2Mzg0
LCBPT0Igc2l6ZTogMTI4MApbICAgIDMuOTU3NjExXSBFeGVjdXRpbmcgb3BlcmF0aW9uIFszIGlu
c3RydWN0aW9uc106ClsgICAgMy45NTc2MTNdICAgLT5DTUQgICAgICBbMHg5MF0KWyAgICAzLjk2
MjI1MV0gICAtPkFERFIgICAgIFsxIGN5Y10KWyAgICAzLjk2NTM3Ml0gICAtPkRBVEFfSU4gIFs1
IEIsIGZvcmNlIDgtYml0XQpbICAgIDMuOTcyNzg3XSAweDAgMHgwIDB4MTAgMHg4MCAweDAgMHgy
NCAweDVlIDB4MjkgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAg
IDMuOTgwODk5XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDMuOTg5MzAyXSAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIApbICAgIDMuOTk3NzExXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApb
ICAgIDQuMDA2MTExXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDQuMDE0NTM5XSAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDQuMDIyOTUwXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IApbICAgIDQuMDMxMzQzXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDQuMDM5NzUyXSAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDQuMDQ4MTU5XSAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAw
eGZkIApbICAgIDQuMDU2NTY3XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDQuMDY0OTY4
XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDQuMDczMzgyXSAweGZkIDB4ZmQgMHhmZCAw
eGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhm
ZCAweGZkIApbICAgIDQuMDgxNzkyXSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZk
IDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDQuMDkw
MTk5XSAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4
ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIApbICAgIDQuMDk4NjA4XSAweGZkIDB4ZmQgMHhm
ZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQgMHhmZCAweGZkIDB4ZmQg
MHhmZCAweGZkIAo=
--00000000000004137b05852b5f2b--
