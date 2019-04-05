Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1846AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D801321850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rcG/Bw3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDEEbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:31:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35766 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEEbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:31:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id m10so4487438otp.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 21:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7lBtA8vKkwjwj7PTowhExzIEuTQG9ZRxuYeTf2eq3c=;
        b=rcG/Bw3Vg4FKUUKeWMIhWWl+Dot5HReKA20TPVY5QGg0EZEWRVdHuNhLlde7bDr2LC
         4BLBBvJSbBRGJmPDGv/B6B0rJypBhrdF5rRlIxvZXGI6AyaQV/QvN2X9FZAL4uqIxvFF
         miIIBZxbDgDNVzJ/lGJ/EBoek9bgSj4A1HSOtmQfmLnXEmanh30ShC/bY2ZcyriSLwpm
         HJ17qsUzqkpKAVjuE32VzvhlvR+54/yQxLNHib6tk3DOBIMIqtcnyY2m1gL/JdQOi1/R
         QxeG6Bf9FzsGG4r4TRGLWd5iqlCDZx90ws5uYaxpFB3/w+torG7AzrLAig+aSkflXOjg
         WPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7lBtA8vKkwjwj7PTowhExzIEuTQG9ZRxuYeTf2eq3c=;
        b=irUitlZmGCzZhVa7VfqI13JB0Mg6kQJ90aWGSzGcTZVLGaqRCsxbWLytsplwir556L
         rIdWTQMbJ0dGm014Wr5jSXfWiKSVKIGqE0Yapi0oO7qWgOwdojcMR0Tluxwf1IHI6VLS
         ZTUKydh7x9QzQPMtX9KNxp502Ws8EEd3uXehApjX87hj1BRP4IyhLhMEIwkNpJBg96w9
         RwsEXC7sCJ+JLeJlGxa8VpeVOY8bt/04UnIj4nL6yYWotXOGpYt3KZu1jBSHN2kk+eFH
         Ko7f77e9OVBrsbb+Xd1dQ1itH5JAES8J88hIWCHbIgMVAy/O37SxT7lIZWVHVF0aTHIc
         Jf6g==
X-Gm-Message-State: APjAAAUDDuywraftyF7dRDIwrmZ81o4yjFEQVvTHRIWgvjqlDOUJ+f1J
        TH/7h+LkDSF6Um46HqOnjF2elc156TTN2yIK6ff3Eg==
X-Google-Smtp-Source: APXvYqwxFoWU7xp487Ebvt3wzo5VYHnSYc2CvTe5RZAI/ctb22VitfNeaCIFtIGcIC9xMiHlKjZ8oQ+fxNcB9ZMAh5k=
X-Received: by 2002:a9d:7856:: with SMTP id c22mr6972611otm.261.1554438662631;
 Thu, 04 Apr 2019 21:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
 <20190321214401.GC19508@bombadil.infradead.org> <CAFBinCA6oK5UhDAt9kva5qRisxr2gxMF26AMK8vC4b1DN5RXrw@mail.gmail.com>
 <5cad2529-8776-687e-58d0-4fb9e2ec59b1@amlogic.com> <CAFBinCA=0XSSVmzfTgb4eSiVFr=XRHqLOVFGyK0++XRty6VjnQ@mail.gmail.com>
 <32799846-b8f0-758f-32eb-a9ce435e0b79@amlogic.com> <CAFBinCDHmuNZxuDf3pe2ij6m8aX2fho7L+B9ZMaMOo28tPZ62Q@mail.gmail.com>
 <79b81748-8508-414f-c08a-c99cb4ae4b2a@amlogic.com>
In-Reply-To: <79b81748-8508-414f-c08a-c99cb4ae4b2a@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 5 Apr 2019 06:30:51 +0200
Message-ID: <CAFBinCCSkVGp_iWKf=o=7UGuDUWxyLPGdrqGy_P-HPuEJiU1zQ@mail.gmail.com>
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

On Fri, Mar 29, 2019 at 8:44 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hi Martin,
>
> On 2019/3/29 2:03, Martin Blumenstingl wrote:
> > Hi Liang,
> [......]
> >> I don't think it is caused by a different NAND type, but i have followed
> >> the some test on my GXL platform. we can see the result from the
> >> attachment. By the way, i don't find any information about this on meson
> >> NFC datasheet, so i will ask our VLSI.
> >> Martin, May you reproduce it with the new patch on meson8b platform ? I
> >> need a more clear and easier compared log like gxl.txt. Thanks.
> > your gxl.txt is great, finally I can also compare my own results with
> > something that works for you!
> > in my results (see attachment) the "DATA_IN  [256 B, force 8-bit]"
> > instructions result in a different info buffer output.
> > does this make any sense to you?
> >
> I have asked our VLSI designer for explanation or simulation result by
> an e-mail. Thanks.
do you have any update on this?


Martin
