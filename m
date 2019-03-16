Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCAEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55AD21871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sLnEEswN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfCPKzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 06:55:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39059 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCPKzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 06:55:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so3146579otb.6;
        Sat, 16 Mar 2019 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V22RDZ2ZDxWrOyA2Tnt3pM7LQsG8Cmy7bIkEXt1V1mg=;
        b=sLnEEswNIXvGEiL6AW4Qy5gF+xeMdq0O0qvTh1bjK81SthSHVAgDfgxCDnc28De2YK
         YEIlCnilKfIwgpOxAn0WFk91z9ef364OoQW9JP6A4LYFdBIIKnlvo4GNnPEWZTW5gJaW
         NZEd+XRl7xBzjY4Frj32rCNyKnnMTXiYbS2Mdck7O6/+1s3FlqGjkM0vKvJgR6i66Ynj
         0Rvfd08Rxo066pMZUgK3V5lgob1F0smWGmrNXXL8kfu2wMGNKeYNknahTTpDbbewP/G0
         f/5SngGm1DwibnJGYghPEaPEcD+xWskpIBddLKReCe28y1qC/4FoMjjoMv7uWUz46lsS
         RqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V22RDZ2ZDxWrOyA2Tnt3pM7LQsG8Cmy7bIkEXt1V1mg=;
        b=ai/xmeUUesywSxU4gpQaOyIXtmYgFiRXzB/bdLl9PTL+AL29bMHiHfO847HMaIq1+g
         N8eKPvEyTHJjnq1iAj5UCvFp+udWd1haP88E+rhrp9g2wJ8eQDYwWtawukjF3dzwilQs
         /8d+QNyNaUIbKU29MJozZ56Z6DDy9/wWUKqzXDgEGDXuuUHInx1JF7acE1CSGeWXcxKb
         U60cQ2StFZJTZ+5JavFaMeCLB66H+1C9Ivb6etoMOAxQe1q0fd65uIk/0umetewXoUoH
         izferGxvY4EGkq34DQOSF630FyOJa1mhIeHb0CYAr7Hv+mAgWOx/wvqeSVLAlu3PgyVg
         3OIA==
X-Gm-Message-State: APjAAAVJQADrhVgze+QCFnVtHIRf7OsmjVghhoGp8sOyImFkbighjTbV
        zwNc6sUSCGR3ygNYUSAmCwgJm+qhW80mBsgcHWE=
X-Google-Smtp-Source: APXvYqwSPvONR5bzYdISxmy4s8gvjnOBlOM//n1XeuYLzF5xu7tWX6FEcX5PY9AK00cOs+Rd6ZFmTgK59YU7ilOedo0=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr5041524oth.308.1552733711644;
 Sat, 16 Mar 2019 03:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
 <98776767-c4d7-1207-6d42-97105f289bec@amlogic.com> <CAFBinCC7P40sqrDGTuM8M=jVOFTgZLDUK6rGdNpigFoepyCASw@mail.gmail.com>
 <20190307140959.10092d45@xps13> <ccb95e75-e62f-c510-cabd-853481f77fc8@amlogic.com>
In-Reply-To: <ccb95e75-e62f-c510-cabd-853481f77fc8@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Mar 2019 11:55:00 +0100
Message-ID: <CAFBinCBd=dOZjv4KEDY9ODOONDO=WtaBqAMRi_a+gH3_iZEAHQ@mail.gmail.com>
Subject: Re: [RFC PATCH nand-next 0/2] meson-nand: support for older SoCs
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="00000000000050619b058433fd73"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000050619b058433fd73
Content-Type: text/plain; charset="UTF-8"

Hi Liang,

On Tue, Mar 12, 2019 at 10:05 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hi Martin and Miquel,
>
> On 2019/3/7 21:09, Miquel Raynal wrote:
> > Hello,
> >
> > Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote on Tue,
> > 5 Mar 2019 23:12:51 +0100:
> >
> >> Hi Liang,
> >>
> >> On Mon, Mar 4, 2019 at 5:55 AM Liang Yang <liang.yang@amlogic.com> wrote:
> >>>
> >>> Hello Martin,
> >>>
> >>> On 2019/3/2 2:29, Martin Blumenstingl wrote:
> >>>> Hi Liang,
> >>>>
> >>>> I am trying to add support for older SoCs to the meson-nand driver.
> >>>> Back when the driver was in development I used an early revision (of
> >>>> your driver) and did some modifications to make it work on older SoCs.
> >>>>
> >>>> Now that the driver is upstream I wanted to give it another try and
> >>>> make a real patch out of it. Unfortunately it's not working anymore.
> >>>>
> >>>> As far as I know the NFC IP block revision on GXL is similar (or even
> >>>> the same?) as on all older SoCs. As far as I can tell only the clock
> >>>> setup is different on the older SoCs (which have a dedicated NAND
> >>>> clock):
> >>>> - we don't need the "amlogic,mmc-syscon" property on the older SoCs
> >>>>     because we don't need to setup any muxing (common clock framework
> >>>>     will do everything for us)
> >>>> - "rx" and "tx" clocks don't exist
> >>>> - I could not find any other differences between Meson8, Meson8b,
> >>>>     Meson8m2, GXBB and GXL
> >>>>
> >>> That is right. the serials NFC is almost the same except:
> >>> 1) The clock control and source that M8-serials are not share with EMMC.
> >>> 2) The base register address
> >>> 3) DMA encryption option which we don't care on NFC driver.
> >> great, thank you for confirming this!
> >>
> >>>> In this series I'm sending two patches which add support for the older
> >>>> SoCs.
> >>>>
> >>>> Unfortunately these patches are currently not working for me (hence the
> >>>> "RFC" prefix). I get a (strange) crash which is triggered by the
> >>>> kzalloc() in meson_nfc_read_buf() - see below for more details.
> >>>>
> >>>> Can you please help me on this one? I'd like to know whether:
> >>>> - the meson-nand driver works for you on GXL or AXG on linux-next?
> >>>>     (I was running these patches on top of next-20190301 on my M8S
> >>>>     board which uses a 32-bit Meson8m2 SoC. I don't have any board using
> >>>>     a GXL SoC which also has NAND)
> >>> Yes, it works on AXG platform using a MXIC slc nand flash(MX30LF4G); but
> >>> i an not sure it runs the same flow with yours. because i see the print
> >>> "Counld not find a valid ONFI parameter page, ...." in yours. i will try
> >>> to reproduce it on AXG(i don't have a M8 platform now).
> >> I'm looking forward to hear about the test results on your AXG boards
> >> for reference: my board has a SK Hynix H27UCG8T2B (ID bytes: 0xad 0xde
> >> 0x94 0xeb 0x74 0x44, 20nm MLC)
> >> I have another board (where I haven't tested the NFC driver yet) with
> >> a SK Hynix H27UCG8T2E (ID bytes: 0xad 0xde 0x14 0xa7 0x42 0x4a, 1Ynm
> >> MLC). if it helps with your analysis I can test on that board as well
> >
> > Liang, you just have to fake the output of the ONFI page detection and
> > you will probably run into this error which will then be easy to
> > reproduce.
> >
> i don't reproduce it by using a SK Hynix nand flash H27UCG8T2E on gxl
> platform. it runs well.
> [......]
> [    0.977127] loop: module loaded
> [    0.998625] Could not find a valid ONFI parameter page, trying
> bit-wise majority to recover it
> [    1.001619] ONFI parameter recovery failed, aborting
> [    1.006684] Could not find valid JEDEC parameter page; aborting
> [    1.012391] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xde
> [    1.018660] nand: Hynix NAND 8GiB 3,3V 8-bit
> [    1.022885] nand: 8192 MiB, MLC, erase size: 4096 KiB, page size:
> 16384, OOB size: 1664
> [    1.047033] Bad block table not found for chip 0
> [    1.054950] Bad block table not found for chip 0
> [    1.054970] Scanning device for bad blocks
> [    1.522664] random: fast init done
> [    4.893731] Bad eraseblock 1985 at 0x0001f07fc000
> [    5.020637] Bad block table written to 0x0001ffc00000, version 0x01
> [    5.028258] Bad block table written to 0x0001ff800000, version 0x01
> [    5.029905] 5 fixed-partitions partitions found on MTD device
> d0074800.nfc
> [    5.035714] Creating 5 MTD partitions on "d0074800.nfc":
> [......]
>
> Martin, Now i am not sure whether NFC driver leads to kernel panic when
> calling kmem_cache_alloc_trace.
thank you for confirming that it works for you on GXL

I'm not sure that this is a NFC driver problem.
after enabling CONFIG_SLAB_FREELIST_HARDENED in my kernel config the
crash moves. it's now crashing in slub.c's kfree() at
BUG_ON(!PageCompound(page));

maybe this is related to some difference in 32-bit ARM and arm64
or it could even be some memory management issue
I'm not sure yet so I'll try to dig deeper


Regards
Martin

--00000000000050619b058433fd73
Content-Type: text/plain; charset="US-ASCII"; name="meson-nfc-32bit-crash.txt"
Content-Disposition: attachment; filename="meson-nfc-32bit-crash.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jtbdhyye0>
X-Attachment-Id: f_jtbdhyye0

WyAgICAyLjA4MDQ2MV0gQ291bGQgbm90IGZpbmQgYSB2YWxpZCBPTkZJIHBhcmFtZXRlciBwYWdl
LCB0cnlpbmcgYml0LXdpc2UgbWFqb3JpdHkgdG8gcmVjb3ZlciBpdApbICAgIDIuMDg0MTQwXSBP
TkZJIHBhcmFtZXRlciByZWNvdmVyeSBmYWlsZWQsIGFib3J0aW5nClsgICAgMi4wODkxNTRdIC0t
LS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQpbICAgIDIuMDkzNjMxXSBrZXJuZWwg
QlVHIGF0IG1tL3NsdWIuYzozOTUwIQpbICAgIDIuMDk3NjE5XSBJbnRlcm5hbCBlcnJvcjogT29w
cyAtIEJVRzogMCBbIzFdIFBSRUVNUFQgU01QIEFSTQpbICAgIDIuMTAzNDI3XSBNb2R1bGVzIGxp
bmtlZCBpbjoKWyAgICAyLjEwNjQ2NF0gQ1BVOiAxIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90
IHRhaW50ZWQgNS4wLjAtMTE5NDQtZzQ0NzlmYTQ3MjhlOS1kaXJ0eSAjNDE5NgpbICAgIDIuMTE0
NzgxXSBIYXJkd2FyZSBuYW1lOiBBbWxvZ2ljIE1lc29uIHBsYXRmb3JtClsgICAgMi4xMTk0NzBd
IFBDIGlzIGF0IGtmcmVlKzB4Mjk4LzB4MmM0ClsgICAgMi4xMjMxOTVdIExSIGlzIGF0IG1lc29u
X25mY19leGVjX29wKzB4MzRjLzB4M2U4ClsgICAgMi4xMjc5NThdIHBjIDogWzxjMDQ4ZTliND5d
ICAgIGxyIDogWzxjMDhjMjEwOD5dICAgIHBzcjogNDAwMDAwMTMKWyAgICAyLjEzNDE5OV0gc3Ag
OiBjMDJhZmM2MCAgaXAgOiBlYWZkOTAwMCAgZnAgOiBlOWUzNmU0MApbICAgIDIuMTM5NDAwXSBy
MTA6IDAwMDAwMDAyICByOSA6IGU5ZDZjMDQ4ICByOCA6IGVlMzY0MzRiClsgICAgMi4xNDQ2MDFd
IHI3IDogZWI1OWZjODAgIHI2IDogZWUzNjQzNGIgIHI1IDogYzA4YzIxMDggIHI0IDogYzAyYWZk
MTgKWyAgICAyLjE1MTEwMl0gcjMgOiBlYjU5ZmM4NCAgcjIgOiBjMTIwODljMCAgcjEgOiBlZTM2
NDM0MCAgcjAgOiBlZTM2NDM0YgpbICAgIDIuMTU3NjA1XSBGbGFnczogblpjdiAgSVJRcyBvbiAg
RklRcyBvbiAgTW9kZSBTVkNfMzIgIElTQSBBUk0gIFNlZ21lbnQgbm9uZQpbICAgIDIuMTY0NzEy
XSBDb250cm9sOiAxMGM1Mzg3ZCAgVGFibGU6IDAwMjA0MDRhICBEQUM6IDAwMDAwMDUxClsgICAg
Mi4xNzA0MzNdIFByb2Nlc3Mgc3dhcHBlci8wIChwaWQ6IDEsIHN0YWNrIGxpbWl0ID0gMHgocHRy
dmFsKSkKWyAgICAyLjE3NjQxM10gU3RhY2s6ICgweGMwMmFmYzYwIHRvIDB4YzAyYjAwMDApClsg
ICAgMi4xODA3NTJdIGZjNjA6IGVlMzY0MzRiIGMwOGMwYzc0IDAwMDAwMDAwIGMwMmFmZDE4IDAw
MDAwMDI4IGU5ZTkyNjgwIGMwMmFmY2YwIGVlMzY0MzRiClsgICAgMi4xODg4OTldIGZjODA6IGU5
ZDZjMDQ4IGMwOGMyMTA4IDAwMDAwMDA4IDAwMDAwMDAyIDEwNjI0ZGQzIGMwMmFmY2U0IDEwNjI0
ZGQzIDAwMDAwMDA1ClsgICAgMi4xOTcwNDddIGZjYTA6IGU5ZTM2ZTQwIGMwZjY3MzEwIDAwMjIw
MDA1IGMwZjE1MmU4IDAwMDAwMDA1IGU5ZDZjMDQ4IDAwMDAwMDA1IGMwMmFmZDU3ClsgICAgMi4y
MDUxOTVdIGZjYzA6IGMxMTA4Yzg4IGU5ZTM2ZTQwIGMwMmFmY2YwIGU5ZDZjNDI4IGU5ZDZjM2Iw
IGMwOGFkYjE4IDAwMDAwMDAwIDQwMDAwMDAwClsgICAgMi4yMTMzNDNdIGZjZTA6IGMwMmFmY2U4
IDAwMDAwMDAwIGMwMmFmY2YwIDAwMDAwMDAzIDAwMDAwMDAwIDAwMDAwMDkwIDAwMDAwMDAwIDAw
MDAwMDAwClsgICAgMi4yMjE0OTFdIGZkMDA6IDAwMDAwMDAwIDAwMDAwMDAxIDAwMDAwMDAxIGMw
MmFmY2RmIDAwMDAwMDAwIDAwMDAwMTkwIDAwMDAwMDAyIDAwMDAwMDA1ClsgICAgMi4yMjk2Mzld
IGZkMjA6IGMwMmFmZDU3IDAwMDAwMDAxIDAwMDAwMDAwIDViMWRhOGU5IDAwMDAwMDAwIGMxMTA4
Yzg4IGMxMTgxMmYwIGU5ZDZjM2MwClsgICAgMi4yMzc3ODddIGZkNDA6IDAwMDAwMDAxIDAwMDAw
MGRlIDAwMDAwMDAwIGMwOGI4OWQ0IGMwZjE0NzA0IDAwZDZjM2MwIDAwMDAwMDAwIDViMWRhOGU5
ClsgICAgMi4yNDU5MzZdIGZkNjA6IDAwMDAwMDE1IGU5ZDZjMDQ4IGMxMTA4Yzg4IGMwOGI4ZDMw
IGU5ZDZjMDQ4IGMwOGI0MTc0IDAwMDAwMDAwIDYwMDAwMDEzClsgICAgMi4yNTQwODRdIGZkODA6
IGMwZWY3NjA0IDAwMDAwMGFkIGMwZGEyN2FjIDAwMDAwMDAwIGU5ZTM2ZThjIGMwY2Y4OTUwIGMx
MjFiNTBjIDViMWRhOGU5ClsgICAgMi4yNjIyMzJdIGZkYTA6IGU5ZTM2ZTQwIGU5ZTM2ZTQwIGU5
ZDZjMDQwIGMwZWY3NjA0IGU5ODdmODEwIGVhZmQ2YTAwIGU5ZDZjMDQ4IGMxMTA4Yzg4ClsgICAg
Mi4yNzAzODBdIGZkYzA6IGU5ZTM2ZThjIGMwOGMxNTMwIDAwMDAwMDAwIGU5ODc0ZTgwIGU5ZTM2
ZTQwIGMwNTE3ZmQwIDAwMDAwMDAwIGVhZmQ2Nzc0ClsgICAgMi4yNzg1MjhdIGZkZTA6IGU5ZTM2
ZjM0IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAxIDViMWRhOGU5IDAwMDAwMDAw
IGU5ODdmODEwClsgICAgMi4yODY2NzZdIGZlMDA6IDAwMDAwMDAwIGMxMTgxN2M4IDAwMDAwMDAw
IDAwMDAwMDAwIGMxMTgxN2M4IDAwMDAwMDAwIGMxMDcxODU0IGMwODI4YjI4ClsgICAgMi4yOTQ4
MjRdIGZlMjA6IGMxMjE2Yzc4IGU5ODdmODEwIGMxMjE2YzdjIDAwMDAwMDAwIDAwMDAwMDAwIGMw
ODI2YmIwIGU5ODdmODEwIGMxMTgxN2M4ClsgICAgMi4zMDI5NzNdIGZlNDA6IGMxMTgxN2M4IGMw
ODI3MGIwIDAwMDAwMDAwIGMxMDcxODM0IGMxMDAwNGE4IGMwODI2ZGZjIGMxMDAwNGE4IGMwYWJm
MGFjClsgICAgMi4zMTExMjFdIGZlNjA6IGMwZGEzZjE0IGU5ODdmODEwIDAwMDAwMDAwIGMxMTgx
N2M4IGMwODI3MGIwIDAwMDAwMDAwIGMxMDcxODM0IGMxMDAwNGE4ClsgICAgMi4zMTkyNjldIGZl
ODA6IGMxMDcxODU0IGMwODI3MGE4IDAwMDAwMDAwIGMxMTgxN2M4IGU5ODdmODEwIGMwODI3MTA4
IGU5OGJhZmI0IGMxMTA4Yzg4ClsgICAgMi4zMjc0MTddIGZlYTA6IGMxMTgxN2M4IGMwODI0Zjc4
IGMxMTc2MzAwIGMwMjljOTU4IGU5OGJhZmI0IDViMWRhOGU5IGMwMjljOTZjIGMxMTgxN2M4Clsg
ICAgMi4zMzU1NjVdIGZlYzA6IGU5ZTM5ZTgwIGMxMTc2MzAwIDAwMDAwMDAwIGMwODI1ZmU4IGMw
ZjE1NWI0IGMxMTA4Yzg4IGZmZmZlMDAwIGMxMTgxN2M4ClsgICAgMi4zNDM3MTNdIGZlZTA6IGMx
MTA4Yzg4IGZmZmZlMDAwIGMxMDNiODU0IGMwODI3YzM0IGMxMWMzZTQwIGMxMTA4Yzg4IGZmZmZl
MDAwIGMwMzAyZjU0ClsgICAgMi4zNTE4NjFdIGZmMDA6IGViZmZmZGMwIGMwMzQ3MjE4IGMwZmI2
ZDgwIGMwZjM2ODAwIDAwMDAwMDAwIDAwMDAwMDA2IDAwMDAwMDA2IGMwZWE2MzMwClsgICAgMi4z
NjAwMTBdIGZmMjA6IDAwMDAwMDAwIGMxMTA4Yzg4IGMwZWIzZGM0IGMwZWE2M2E0IGMxMWRhNTAw
IGViZmZmZGFlIGViZmZmZGIzIDViMWRhOGU5ClsgICAgMi4zNjgxNThdIGZmNDA6IGMxMDcxODM4
IGMxMWMzZTQwIGMxMDkxNGE0IDViMWRhOGU5IGMxMWMzZTQwIGMxMDkxN2YwIDAwMDAwMDA3IGMx
MWRhNTAwClsgICAgMi4zNzYzMDZdIGZmNjA6IGMxMWRhNTAwIGMxMDAxMTgwIDAwMDAwMDA2IDAw
MDAwMDA2IDAwMDAwMDAwIGMxMDAwNGE4IDAwMDAwMTNkIDAwMDAwMDAwClsgICAgMi4zODQ0NTRd
IGZmODA6IGMwMmMwNTA0IDAwMDAwMDAwIGMwY2YxMmU4IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwClsgICAgMi4zOTI2MDJdIGZmYTA6IDAwMDAwMDAwIGMwY2Yx
MmYwIDAwMDAwMDAwIGMwMzAxMGU4IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
ClsgICAgMi40MDA3NTBdIGZmYzA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwClsgICAgMi40MDg4OThdIGZmZTA6
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDEzIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwClsgICAgMi40MTcwNTJdIFs8YzA0OGU5YjQ+XSAoa2ZyZWUpIGZyb20g
WzxjMDhjMjEwOD5dIChtZXNvbl9uZmNfZXhlY19vcCsweDM0Yy8weDNlOCkKWyAgICAyLjQyNDU5
Ml0gWzxjMDhjMjEwOD5dIChtZXNvbl9uZmNfZXhlY19vcCkgZnJvbSBbPGMwOGFkYjE4Pl0gKG5h
bmRfcmVhZGlkX29wKzB4MTI4LzB4MWM0KQpbICAgIDIuNDMyOTE0XSBbPGMwOGFkYjE4Pl0gKG5h
bmRfcmVhZGlkX29wKSBmcm9tIFs8YzA4Yjg5ZDQ+XSAoaHluaXhfbmFuZF9oYXNfdmFsaWRfamVk
ZWNpZCsweDM0LzB4NzgpClsgICAgMi40NDIwMTNdIFs8YzA4Yjg5ZDQ+XSAoaHluaXhfbmFuZF9o
YXNfdmFsaWRfamVkZWNpZCkgZnJvbSBbPGMwOGI4ZDMwPl0gKGh5bml4X25hbmRfZGVjb2RlX2lk
KzB4NjQvMHgzZmMpClsgICAgMi40NTE3MjFdIFs8YzA4YjhkMzA+XSAoaHluaXhfbmFuZF9kZWNv
ZGVfaWQpIGZyb20gWzxjMDhiNDE3ND5dIChuYW5kX3NjYW5fd2l0aF9pZHMrMHhhMDQvMHgxNzFj
KQpbICAgIDIuNDYwNzM1XSBbPGMwOGI0MTc0Pl0gKG5hbmRfc2Nhbl93aXRoX2lkcykgZnJvbSBb
PGMwOGMxNTMwPl0gKG1lc29uX25mY19wcm9iZSsweDQ2MC8weDY5MCkKWyAgICAyLjQ2OTIzMl0g
WzxjMDhjMTUzMD5dIChtZXNvbl9uZmNfcHJvYmUpIGZyb20gWzxjMDgyOGIyOD5dIChwbGF0Zm9y
bV9kcnZfcHJvYmUrMHg0OC8weDk4KQpbICAgIDIuNDc3NTUzXSBbPGMwODI4YjI4Pl0gKHBsYXRm
b3JtX2Rydl9wcm9iZSkgZnJvbSBbPGMwODI2YmIwPl0gKHJlYWxseV9wcm9iZSsweDFlMC8weDJj
YykKWyAgICAyLjQ4NTc4Nl0gWzxjMDgyNmJiMD5dIChyZWFsbHlfcHJvYmUpIGZyb20gWzxjMDgy
NmRmYz5dIChkcml2ZXJfcHJvYmVfZGV2aWNlKzB4NjAvMHgxNmMpClsgICAgMi40OTQwMjFdIFs8
YzA4MjZkZmM+XSAoZHJpdmVyX3Byb2JlX2RldmljZSkgZnJvbSBbPGMwODI3MGE4Pl0gKGRldmlj
ZV9kcml2ZXJfYXR0YWNoKzB4NTgvMHg2MCkKWyAgICAyLjUwMjg2Ml0gWzxjMDgyNzBhOD5dIChk
ZXZpY2VfZHJpdmVyX2F0dGFjaCkgZnJvbSBbPGMwODI3MTA4Pl0gKF9fZHJpdmVyX2F0dGFjaCsw
eDU4LzB4Y2MpClsgICAgMi41MTEzNTddIFs8YzA4MjcxMDg+XSAoX19kcml2ZXJfYXR0YWNoKSBm
cm9tIFs8YzA4MjRmNzg+XSAoYnVzX2Zvcl9lYWNoX2RldisweDc0LzB4YjQpClsgICAgMi41MTk1
MDVdIFs8YzA4MjRmNzg+XSAoYnVzX2Zvcl9lYWNoX2RldikgZnJvbSBbPGMwODI1ZmU4Pl0gKGJ1
c19hZGRfZHJpdmVyKzB4MWI4LzB4MWQ4KQpbICAgIDIuNTI3NzQwXSBbPGMwODI1ZmU4Pl0gKGJ1
c19hZGRfZHJpdmVyKSBmcm9tIFs8YzA4MjdjMzQ+XSAoZHJpdmVyX3JlZ2lzdGVyKzB4NzQvMHgx
MDgpClsgICAgMi41MzU4MDRdIFs8YzA4MjdjMzQ+XSAoZHJpdmVyX3JlZ2lzdGVyKSBmcm9tIFs8
YzAzMDJmNTQ+XSAoZG9fb25lX2luaXRjYWxsKzB4NTQvMHgyODQpClsgICAgMi41NDM5NTZdIFs8
YzAzMDJmNTQ+XSAoZG9fb25lX2luaXRjYWxsKSBmcm9tIFs8YzEwMDExODA+XSAoa2VybmVsX2lu
aXRfZnJlZWFibGUrMHgyZDQvMHgzNmMpClsgICAgMi41NTI2MjFdIFs8YzEwMDExODA+XSAoa2Vy
bmVsX2luaXRfZnJlZWFibGUpIGZyb20gWzxjMGNmMTJmMD5dIChrZXJuZWxfaW5pdCsweDgvMHgx
MTApClsgICAgMi41NjA3NjhdIFs8YzBjZjEyZjA+XSAoa2VybmVsX2luaXQpIGZyb20gWzxjMDMw
MTBlOD5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgyYykKWyAgICAyLjU2ODMwNF0gRXhjZXB0aW9u
IHN0YWNrKDB4YzAyYWZmYjAgdG8gMHhjMDJhZmZmOCkKWyAgICAyLjU3MzMzM10gZmZhMDogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAKWyAgICAyLjU4MTQ4M10gZmZjMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAKWyAgICAyLjU4
OTYzMF0gZmZlMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMTMg
MDAwMDAwMDAKWyAgICAyLjU5NjIyMF0gQ29kZTogMWEwMDAwMDMgZTU5NzMwMDQgZTMxMzAwMDEg
MWEwMDAwMDAgKGU3ZjAwMWYyKSAgClsgICAgMi42MDIyOTVdIC0tLVsgZW5kIHRyYWNlIDBiZGY1
ZDRiZmQ0YjNmYjEgXS0tLQo=
--00000000000050619b058433fd73--
