Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28264C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F302B217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQYjAcZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEISZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:25:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43072 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEISZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:25:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so4336618wro.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8AxXyua6skxc3/3kJBuCD7WeH5GL35ISvW5fGGS1Eo=;
        b=hQYjAcZ5MDNPj6PBJB0Dlxy5j1K6Is+95GIDcnqeKNHP3o5YhX/VdojpxEE+Y8PIn9
         /fDqo/k1ReiQClt2rA6ccdDUYxCsVG5oAVrjjlu6UDUp0NgJdXlLBtInln8PnklrzfJV
         DLBNO3BMDsOIOvsVEp5acBBy+sPABhK1y8hIi+9SFc1WnnI4jGuCynFeEUq09y2GbZkT
         k9gYjETJovJMIg+ZmPP2KKnznNs9QABQ9BODXKGEIN/RKwa/pm6KQaODoACb0hHV9uCC
         iD+570gPRIgSdGmIfM80s57JZgIk28wGy9tEBilYPQkkjxA1C0bLtfFmSOagtNiUZCUk
         rieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8AxXyua6skxc3/3kJBuCD7WeH5GL35ISvW5fGGS1Eo=;
        b=kMKNR/zNGYJgWTCqDT+WfzpD5kibWQqNAqcfWqXaUwi7j4Ei7rpgP1r+RG5NyvgC+C
         nW8RBaPmyzpQit7ipG6/ILz2XmykIQrYdZPm5DufcxuAQ/EnqjWrZPKxjwzYpP1xHObZ
         NaneQpPD9IM1G9OKd8km+Jg6sxQxWo1d+rQl4Y4XLNlREHWMkXbDW4jOTQaJQXxEqyjt
         Kr3pAmIGUto9Zv3wfQ9yNs189IfHFZA3iezKM4q98Hbf2pz18uSJTDG0UZuZzdhv3gXc
         Fb7YyNclSFwzV7ksDqG+nT+f03EAXiAOycRRdEYKSbUGV5ufW2jrXGPiBLLCK1yYoeX1
         SiPA==
X-Gm-Message-State: APjAAAWnaHBf+rTgdGnrGKnM/rb2buQQBAp4oKxF39nuBBCksEu/407h
        G4mJppaPECyPK6r1rrj79fYEr4ywJbwcauOApdy3ow==
X-Google-Smtp-Source: APXvYqwrj4aBN6HdRlizpUxg1PGEChem2gmiZwG/9gSosEfNDYAwOUv4ht7lxL+8e98302C4W9vgXaGVYprhjoWVbcc=
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr4344469wrt.253.1557426325552;
 Thu, 09 May 2019 11:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com>
In-Reply-To: <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 9 May 2019 11:25:14 -0700
Message-ID: <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Felipe Balbi <balbi@kernel.org>, "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 7:02 AM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Hi John,
> W dniu 08.05.2019 o 04:18, John Stultz pisze:
> > Since commit 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather
> > buffers"), I've been seeing trouble with adb transfers in Android on
> > HiKey960, HiKey and now Dragonboard 845c.
> >
> > Sometimes things crash, but often the transfers just stop w/o any
> > obvious error messages.
> >
> > Initially I thought it was an issue with the HiKey960 dwc3 usb patches
> > being upstreamed, and was using the following hack workaround:
> >    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-5.1&id=dcdadaaec9db7a7b78ea9b838dd1453359a2f388
> >
> > Then dwc2 added sg support, and I ended up having to revert it to get
> > by on HiKey:
> >    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-5.1&id=6e91b4c7bd1e94bdd835263403c53e85a677b848
> >
> > (See thread here: https://lkml.org/lkml/2019/3/8/765)
>
> So the thread says there are problems at boot, but here you mention about
> adb transfers, which must obviously be happening after the board has booted.
> Do you experience problems at boot or not?
>
> If a crash happens, what is in the log?

So, yes.  Sorry, I am maybe muddling two issues (though they both seem
to be tied to f_fs sg).  On dwc2, with the current code, we often (but
not always) crash as soon as adb starts up in the boot process. Thus
I'm running with a revert of "usb: dwc2: gadget: Add scatter-gather
mode" to get by.

As for example crashes, there is a crash in the thread linked above
(https://lkml.org/lkml/2019/3/8/765) and also the one I sent yesterday
when testing with your zlp patch. Let me know if you're looking for
something more specific.

One thing I didn't do, but I should is run w/ the zlp + your
memset/kzalloc patch. See if that helps get dwc2 further along at
least.  I'll test that shortly here and get back to you.

thanks
-john
