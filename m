Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2232FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29342075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXNz84G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfC0U6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:58:31 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40166 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfC0U6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:58:31 -0400
Received: by mail-yw1-f68.google.com with SMTP id p64so13603143ywg.7;
        Wed, 27 Mar 2019 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImgnJ7n7p2BV19ikTurvxso36tI1Walq9NYu4VWXllM=;
        b=nXNz84G9V616IfXaVr+ItjAOflF3CAcvnnpBMx9ZPyHdVVaATmijUyWnVL+2w2Kyy3
         jHE2fs34RPjGlbc1p35IaYMtbmRlvsRo1Ez/L+qbGhlIw7p5GQOa7qWGy/FRd3Is0uQl
         4/u2V4MUlfGhgPWQiG4TZFwXukQiGVSlozW3TBvKd6qM+pkOiTJufjfJYUYaEXaL578C
         619SnpwgChoEUqb1lC8rTtrzwFVfzr/8Z/PwsN0cB+cqgTL77Wl599EgAYP+Wp1mgX1P
         3/XJOhY2YCRl6Eq5hocwjIvS83DyozCRh8QpieEDYmZuo5ikfb0ttNlvc8cLMG5zJsDo
         QCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImgnJ7n7p2BV19ikTurvxso36tI1Walq9NYu4VWXllM=;
        b=g3wLtekhhRQkoeMPo/kk9FhFgyK7YlkhrfIzSBmtS89qzwQI7IZ+SgFeOvDAkNG8OS
         u3wAp5CgpBYOBS0giQ1JNKL0ucShKCtgypHLKT4G2BxQSakSFqv98DpKALzeXZdfFgrT
         azBlp0lati6rpz7qB9BaTIvK2VDczVwsjPXMNe8p0qGVp+vrgUu0JYZ/bQquGU9RrluN
         Kv7llI9BRoRZ0o5j2Puuuk8e8tuogEL9iX/5rqghz2cjv14YXQ0IezBiTCV1O0VyQrbe
         xJFViExP8zgDNeEhEvqF9+0jBKLKvhPd+XBvwrtWXHZG5uZoz8IQcqIKJnqrRMyeTdYX
         QZ/w==
X-Gm-Message-State: APjAAAVONgulzib5fYc46/oxLGNN9Q6Ulzx9g1/3JPHM0xqvy8pLhB4k
        hppJL5WyF/bgdEYKfCa43OLam7eHVJi6LXnYSh8=
X-Google-Smtp-Source: APXvYqxX5YiyXqCCi6rxX4gLgChyb3f7fmbTj9XDrpNZEVl7vhkB/W9x+WlHY2iR79Ax+mmE/V+Fhrgotf5WXMkKKac=
X-Received: by 2002:a25:4e44:: with SMTP id c65mr8834611ybb.386.1553720309739;
 Wed, 27 Mar 2019 13:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAMjKNNM=f5pKgYh+ZAB+hvxeDG5B_5PsYX8YWZMZrmF9qS2DZA@mail.gmail.com>
 <e6ab8c4a-2371-c4a4-a95e-4c72cefa8696@intel.com> <CAMjKNNN+umpQOFALiC9capRyLm_X3eT10Rwt0rW1e4xAO5aaJA@mail.gmail.com>
 <CAMjKNNNL-xW3pwz4Uh47=JJhXq0p-hOPrEEbbdMq+ZnUGa+ryQ@mail.gmail.com>
In-Reply-To: <CAMjKNNNL-xW3pwz4Uh47=JJhXq0p-hOPrEEbbdMq+ZnUGa+ryQ@mail.gmail.com>
From:   jean-luc malet <jeanluc.malet@gmail.com>
Date:   Wed, 27 Mar 2019 21:57:57 +0100
Message-ID: <CAMjKNNM8T0N2Lam96x8YOWTVTztcwsq5U6-tFmtfZxP6W5g=9w@mail.gmail.com>
Subject: Re: linux 4.17, drivers/mmc/host/sdhci-pci-o2micro.c, crash with
 sdcard >128G
To:     adrian.hunter@intel.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, chuanjin.pang@bayhubtech.com
Content-Type: multipart/mixed; boundary="00000000000024999a058519b3f9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000024999a058519b3f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

resentding in plain text


On Wed, Mar 27, 2019 at 9:56 PM jean-luc malet <jeanluc.malet@gmail.com> wr=
ote:
>
> Hi everybody
> thanks to chuanjin pang, it's almost a year that I use my controler with =
sdcards >128G without issue, I upgraded my kernel to 5.0.4 and noticed that=
 the sdcard bug was still present... so I applied the patch again and it di=
d fixed the issue as it did on my previous kernel build
> since the stability seems very good, please consider applying this patch =
for futur kernel release
> thanks and regards
> JLM
>
> On Mon, Jun 11, 2018 at 2:04 PM jean-luc malet <jeanluc.malet@gmail.com> =
wrote:
>>
>> something has changed.... the sdcard wasn't working at all on 4.16.11 ke=
rnel  (crash on reading but sdcard discovery was working)  for any card and=
 not at all on 4.9.? kernel (not even listing the sdcard when inserting) , =
in 4.17 it works with all card below 256G that I have... so there is obviou=
lsy a change somewhere that made this controler works....
>> best regards
>>
>> On Mon, Jun 11, 2018 at 1:11 PM Adrian Hunter <adrian.hunter@intel.com> =
wrote:
>>>
>>> On 09/06/18 11:38, jean-luc malet wrote:
>>> > Hi everybody!
>>> > thanks for adding support to my O2 Micro, Inc. Device 8620 in last ke=
rnel!!!
>>> > I was looking for it since long time!!!!
>>> >
>>> > # lspci -kv
>>> > 02:00.0 SD Host controller: O2 Micro, Inc. Device 8620 (rev 01) (prog=
-if 01)
>>> > Subsystem: Lenovo Device 3800
>>> > Flags: bus master, fast devsel, latency 0, IRQ 17
>>> > Memory at a1001000 (32-bit, non-prefetchable) [size=3D4K]
>>> > Memory at a1000000 (32-bit, non-prefetchable) [size=3D2K]
>>> > Capabilities: [6c] Power Management version 3
>>> > Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
>>> > Capabilities: [80] Express Endpoint, MSI 00
>>> > Capabilities: [100] Virtual Channel
>>> > Capabilities: [200] Advanced Error Reporting
>>> > Capabilities: [230] Latency Tolerance Reporting
>>> > Capabilities: [240] L1 PM Substates
>>> > Kernel driver in use: sdhci-pci
>>> > Kernel modules: sdhci_pci
>>> >
>>> > it works fine with sdcard up to 128G but crash on my samsung 256G evo=
 plus
>>> > card
>>> > (https://www.samsung.com/fr/memory-storage/evo-plus-microsd-card-with=
-sd-adapter/MB-MC256DAEU/)
>>> >
>>> > insert 256G card
>>> > #dmesg
>>> >
>>> >     [94815.892525] mmc0: Tuning timeout, falling back to fixed sampli=
ng clock
>>> >     [94815.892627] mmc0: new ultra high speed SDR104 SDXC card at add=
ress 0001
>>> >     [94815.893398] mmcblk0: mmc0:0001 EE8QT 239 GiB
>>> >     [94815.945330] mmc0: Tuning timeout, falling back to fixed sampli=
ng clock
>>> >
>>> > # dd if=3D/dev/mmcblk0 of=3Dtest bs=3D512 count=3D1
>>> >
>>> >     dd: error reading '/dev/mmcblk0': Input/output error
>>> >     0+0 records in
>>> >     0+0 records out
>>> >     0 bytes copied, 42.829 s, 0.0 kB/s
>>> >
>>> > #dmesg
>>> >
>>> >     [94825.956285] mmc0: Timeout waiting for hardware interrupt.
>>> >     [94825.956289] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
SDHCI REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> >     [94825.956297] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x0=
0000603
>>> >     [94825.956304] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x0=
0000008
>>> >     [94825.956310] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0=
000003b
>>> >     [94825.956316] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x0=
0000017
>>> >     [94825.956322] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x0=
0000000
>>> >     [94825.956327] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0=
0000007
>>> >     [94825.956333] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x0=
0000000
>>> >     [94825.956339] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x0=
2ff008b
>>> >     [94825.956344] mmc0: sdhci: AC12 err:  0x00000004 | Slot int: 0x0=
0000000
>>> >     [94825.956350] mmc0: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x0=
0002077
>>> >     [94825.956356] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x0=
05800c8
>>> >     [94825.956362] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x0=
0000000
>>> >     [94825.956368] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x0=
0001b00
>>> >     [94825.956371] mmc0: sdhci: Host ctl2: 0x0000800b
>>> >     [94825.956378] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf=
ffff208
>>> >     [94825.956380] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> >     [94826.007314] mmc0: Tuning timeout, falling back to fixed sampli=
ng clock
>>> >
>>> > remove card
>>> > insert 128G card (http://www.toshiba-sdcard.com/microsd/microsd_m302.=
html)
>>> > #dmesg
>>> >
>>> >     [95214.753428] mmc0: Tuning timeout, falling back to fixed sampli=
ng clock
>>> >     [95214.753530] mmc0: new ultra high speed SDR104 SDXC card at add=
ress 1234
>>> >     [95214.754399] mmcblk0: mmc0:1234 SA128 116 GiB
>>> >     [95214.756474]  mmcblk0: p1
>>> >
>>> >
>>> >     # dd if=3D/dev/mmcblk0 of=3Dtest bs=3D512 count=3D1
>>> >     1+0 records in
>>> >     1+0 records out
>>> >     512 bytes copied, 0.00209609 s, 244 kB/s
>>> >
>>> >
>>> > remove card
>>> > insert 128G card (samsung 128Gb evo U1 card)
>>> > #dmseg
>>> >
>>> >     [95438.053427] mmc0: Tuning timeout, falling back to fixed sampli=
ng clock
>>> >     [95438.053552] mmc0: new ultra high speed DDR50 SDXC card at addr=
ess 59b4
>>> >     [95438.054139] mmcblk0: mmc0:59b4 00000 120 GiB
>>> >     [95438.056451]  mmcblk0: p1
>>> >
>>> >
>>> > # dd if=3D/dev/mmcblk0 of=3Dtest bs=3D512 count=3D1
>>> >
>>> >     1+0 records in
>>> >     1+0 records out
>>> >     512 bytes copied, 0.0346192 s, 14.8 kB/s
>>> >
>>> >
>>> > since the toshiba a 256G samsung are both U3 this seems not related t=
o this
>>> > since one of the samsung card works, this don't seems to be related t=
o the
>>> > brand....
>>> > so this seems related to the size of the card....
>>> > if you need more information, I'll try to provide the best accurate o=
nes :)
>>>
>>> Tuning fails for all the cards, it is just some of them still work with
>>> fixed sampling.  You need to find someone who knows about the O2 Micro
>>> controllers. but no one has touched the driver since 2015.

--00000000000024999a058519b3f9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-clean-bayhub-quirks2-flag-for-tuning-UHS-timeout-iss.patch"
Content-Disposition: attachment; 
	filename="0001-clean-bayhub-quirks2-flag-for-tuning-UHS-timeout-iss.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtroxcsv0>
X-Attachment-Id: f_jtroxcsv0

RnJvbSA2M2MzZTI3YmU2MTlkYjFiMTMyNDFjYzNhZmY0NmZmZGNjODExZWUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiY2h1YW5qaW4ucGFuZyIgPGNodWFuamluLnBhbmdAYmF5aHVi
dGVjaC5jb20+CkRhdGU6IFNhdCwgMTUgU2VwIDIwMTggMDA6Mjc6MjcgKzA4MDAKU3ViamVjdDog
W1BBVENIXSBjbGVhbiBiYXlodWIgcXVpcmtzMiBmbGFnIGZvciB0dW5pbmcgVUhTIHRpbWVvdXQg
aXNzdWUKCi0tLQogbW1jL2hvc3Qvc2RoY2ktcGNpLWNvcmUuYyB8IDEgLQogMSBmaWxlIGNoYW5n
ZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9tbWMvaG9zdC9zZGhjaS1wY2ktY29yZS5j
IGIvbW1jL2hvc3Qvc2RoY2ktcGNpLWNvcmUuYwppbmRleCA3N2RkMzUyLi42NTczZjQ0IDEwMDY0
NAotLS0gYS9tbWMvaG9zdC9zZGhjaS1wY2ktY29yZS5jCisrKyBiL21tYy9ob3N0L3NkaGNpLXBj
aS1jb3JlLmMKQEAgLTExNzYsNyArMTE3Niw2IEBAIHN0YXRpYyBpbnQgam1pY3Jvbl9yZXN1bWUo
c3RydWN0IHNkaGNpX3BjaV9jaGlwICpjaGlwKQogc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhjaV9w
Y2lfZml4ZXMgc2RoY2lfbzIgPSB7CiAJLnByb2JlID0gc2RoY2lfcGNpX28yX3Byb2JlLAogCS5x
dWlya3MgPSBTREhDSV9RVUlSS19OT19FTkRBVFRSX0lOX05PUERFU0MsCi0JLnF1aXJrczIgPSBT
REhDSV9RVUlSSzJfQ0xFQVJfVFJBTlNGRVJNT0RFX1JFR19CRUZPUkVfQ01ELAogCS5wcm9iZV9z
bG90ID0gc2RoY2lfcGNpX28yX3Byb2JlX3Nsb3QsCiAjaWZkZWYgQ09ORklHX1BNX1NMRUVQCiAJ
LnJlc3VtZSA9IHNkaGNpX3BjaV9vMl9yZXN1bWUsCi0tIAoyLjcuNAoK
--00000000000024999a058519b3f9--
