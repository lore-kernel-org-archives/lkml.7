Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6E4C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AE3208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 20:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iCm+4VqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfFHUAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 16:00:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40044 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 16:00:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id x24so4947904otp.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvkpFaao1bpKQ1FWayC3EusodSIMGE6w694SSNfMEPA=;
        b=iCm+4VqZSt6kP2oAqKNK9ttO+n1BscayXijHYPF97LlKXKRTy/SQJZN8g6ptnB37GY
         2qpvcyeM4ipaUGv65IBoJk02Qm02N2zjp1eUXMCq+AN4trMiVdYmCSqfFUNnpqCeLs73
         Hp2SAEt7Mvr8wKtGNmb72g6Av+lQZbvcgd3MLPNKA40YmEdhRMR+1oBXTPPWTEwvlJzj
         tt/CdN305EsiUJ9JuqpVD3D7V7QibejrzDVzpZwMPG3HBT3xKfgfibme2CBG/1ZgwDvL
         bvRP90LTWNSXGucxuU1L5uvWJLtOO0uXdC4As8XsFXZ4rsoY6xw7ij12LQADBI9QEXzN
         hF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvkpFaao1bpKQ1FWayC3EusodSIMGE6w694SSNfMEPA=;
        b=oiYNN6ERf4eaILlA5vNEIRAk+dAbn5Ssis+qeHl4265DDqhfWmsXO3RPMofLxq17Zb
         5w8eTaqfss+qQggH7IMqlGgCNOXaot3NeO6fDuRtyoSmvb3qkd1RN2O83ahSFaE1OBhK
         5+fbNYofWqxfvFqIsmkXS/Evul/myv45mZyVpGDyVqOnQSi+8uFAsGobIJl6d388nF91
         As9amhgjlppzGOnYfdAyYYiAN76RutSLKS50KLqc25fRvppwYtpC8b22uOTNb9wlRWSV
         +WT7AY4fs+/sDcWdgAw/EcjHCb7mLc33JgMK6HOugI2ftWhN/n6SEf8N0OcBgFvTb5Og
         lEbQ==
X-Gm-Message-State: APjAAAWLf54onRBAqUwlnJGCjLggqRCCN7ZXLjQT/XedZFFeN4w5pyWT
        HfkSTYgzfYPK9x1P2Z5UfX+Tg2OJALL91Fyf1E0=
X-Google-Smtp-Source: APXvYqzE1S4at/LKVQiJdPOZ7qR8leNmGzSuvzyjOZztdFT72UxQXxBOmWKetA1I5Vc/iv6tZY4wzFoHoG2nI91n1qA=
X-Received: by 2002:a9d:6d8d:: with SMTP id x13mr23458026otp.6.1560024042878;
 Sat, 08 Jun 2019 13:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
 <20190321214401.GC19508@bombadil.infradead.org> <CAFBinCA6oK5UhDAt9kva5qRisxr2gxMF26AMK8vC4b1DN5RXrw@mail.gmail.com>
 <5cad2529-8776-687e-58d0-4fb9e2ec59b1@amlogic.com> <CAFBinCA=0XSSVmzfTgb4eSiVFr=XRHqLOVFGyK0++XRty6VjnQ@mail.gmail.com>
 <32799846-b8f0-758f-32eb-a9ce435e0b79@amlogic.com> <CAFBinCDHmuNZxuDf3pe2ij6m8aX2fho7L+B9ZMaMOo28tPZ62Q@mail.gmail.com>
 <79b81748-8508-414f-c08a-c99cb4ae4b2a@amlogic.com> <CAFBinCCSkVGp_iWKf=o=7UGuDUWxyLPGdrqGy_P-HPuEJiU1zQ@mail.gmail.com>
 <8cb108ff-7a72-6db4-660d-33880fcee08a@amlogic.com> <CAFBinCD4cRGbC=cFYEGVAHOtBSvrgNbCSfDWe3To0KCE5+ceVw@mail.gmail.com>
 <45ce172c-5c76-bb69-31c8-af91e8ffdd68@amlogic.com>
In-Reply-To: <45ce172c-5c76-bb69-31c8-af91e8ffdd68@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 8 Jun 2019 22:00:31 +0200
Message-ID: <CAFBinCDWaDoRbbG+5B=27MNRTcekbooEdgAZv5kyS+Xu6M7Bzg@mail.gmail.com>
Subject: Re: 32-bit Amlogic (ARM) SoC: kernel BUG in kfree()
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Matthew Wilcox <willy@infradead.org>, mhocko@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Thu, Apr 11, 2019 at 5:00 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hi Martin,
> On 2019/4/11 1:54, Martin Blumenstingl wrote:
> > Hi Liang,
> >
> > On Wed, Apr 10, 2019 at 1:08 PM Liang Yang <liang.yang@amlogic.com> wrote:
> >>
> >> Hi Martin,
> >>
> >> On 2019/4/5 12:30, Martin Blumenstingl wrote:
> >>> Hi Liang,
> >>>
> >>> On Fri, Mar 29, 2019 at 8:44 AM Liang Yang <liang.yang@amlogic.com> wrote:
> >>>>
> >>>> Hi Martin,
> >>>>
> >>>> On 2019/3/29 2:03, Martin Blumenstingl wrote:
> >>>>> Hi Liang,
> >>>> [......]
> >>>>>> I don't think it is caused by a different NAND type, but i have followed
> >>>>>> the some test on my GXL platform. we can see the result from the
> >>>>>> attachment. By the way, i don't find any information about this on meson
> >>>>>> NFC datasheet, so i will ask our VLSI.
> >>>>>> Martin, May you reproduce it with the new patch on meson8b platform ? I
> >>>>>> need a more clear and easier compared log like gxl.txt. Thanks.
> >>>>> your gxl.txt is great, finally I can also compare my own results with
> >>>>> something that works for you!
> >>>>> in my results (see attachment) the "DATA_IN  [256 B, force 8-bit]"
> >>>>> instructions result in a different info buffer output.
> >>>>> does this make any sense to you?
> >>>>>
> >>>> I have asked our VLSI designer for explanation or simulation result by
> >>>> an e-mail. Thanks.
> >>> do you have any update on this?
> >> Sorry. I haven't got reply from VLSI designer yet. We tried to improve
> >> priority yesterday, but i still can't estimate the time. There is no
> >> document or change list showing the difference between m8/b and gxl/axg
> >> serial chips. Now it seems that we can't use command NFC_CMD_N2M on nand
> >> initialization for m8/b chips and use *read byte from NFC fifo register*
> >> instead.
> > thank you for the status update!
> >
> > I am trying to understand your suggestion not to use NFC_CMD_N2M:
> > the documentation (public S922X datasheet from Hardkernel: [0]) states
> > that P_NAND_BUF (NFC_REG_BUF in the meson_nand driver) can hold up to
> > four bytes of data. is this the "read byte from NFC FIFO register" you
> > mentioned?
> >
> You are right.take the early meson NFC driver V2 on previous mail as a
> reference.
>
> > Before I spend time changing the code to use the FIFO register I would
> > like to wait for an answer from your VLSI designer.
> > Setting the "correct" info buffer length for NFC_CMD_N2M on the 32-bit
> > SoCs seems like an easier solution compared to switching to the FIFO
> > register. Keeping NFC_CMD_N2M on the 32-bit SoCs also allows us to
> > have only one code-path for 32 and 64 bit SoCs, meaning we don't have
> > to maintain two separate code-paths for basically the same
> > functionality (assuming that NFC_CMD_N2M is not completely broken on
> > the 32-bit SoCs, we just don't know how to use it yet).
> >
> All right. I am also waiting for the answer.
do you have any update on this?


Martin
