Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36703C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB762190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuMszQgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfCUSgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:36:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55365 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbfCUSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:36:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so3435403wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLgrYNwolN+9r7GPWcAGtRbmeuCDTvpFjigbZOG1Z5Y=;
        b=PuMszQgdFL3hNn2ZlFs0RgydRbHnuVvZexrrMTqA0Gy5gm7GujtSI/j3eyBxFaJnFa
         q3q7V7rFeHfK4mYv67F9olRhUuNb8q6EEB+VH19x4D4Y8LSp4oBODF8DMfId45DmK5Wj
         wdLNRLpoiq9tNJt2+W62zvSYJjVCq8Tp+6u+bgyHnREgqlJ7L39/8HQ3cJbjS/vhzdHA
         wTxptMpix7ZSMrmY8iPC/ATq/y9GPruNkYl/KKuJ/rGT359rt1mAFt5Kj/Nf6AMGjkYT
         XAhSCav9FYrvqCEpdNxGAsbpRF6TGfv17h9wA39c1u8rFzmYaMF2BCjczYKzBIVTaNJR
         BU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLgrYNwolN+9r7GPWcAGtRbmeuCDTvpFjigbZOG1Z5Y=;
        b=GHYyeqRSJQXGFZKVxLvClS1zxyQTErlWrEP8GixlUKuoSEcvbIxmTBrKJ/ZytrVJZ7
         wyuhlaNrFanhAQtx4F/cZTIxIwIHX/XLdaLhlcakN3KVOwplmFgEazDh4VyUQFEjRnGI
         KsJY3D9CtLXdZPEaOXon7UOEKmQ62++F/NQkwedqHwkaDn6pqmbEGxsLiLlVq/n7qj5w
         UBEe39LP1j+PLGGnEZnFcBUOKpP2TLrMmhKxcANWYYs2O4OWNgqvl+WBdxSXFXOaS4Jq
         UPlkEpIb2VxGBU6dMhccGpEADt24h8LoPifO2g/etNs2JlJQV4TjoQbS0++WwE0QPdL1
         01iQ==
X-Gm-Message-State: APjAAAXIJmkuPA6NIVa1cMG0ojTXQiQepgVauzWVnmT6+S6NTBJweRti
        71e+VeCrgdTHYSx/CMG0t3fAQd496jEVq96SAcyV1w==
X-Google-Smtp-Source: APXvYqwQFdfeFnVpCc2lhYgsw9fa0xs8nlD0h8M416GsqvRE+fHnqumNhBWGRZipBJjlCc0piDuewJFCpoKa60+DPT4=
X-Received: by 2002:a1c:9691:: with SMTP id y139mr415892wmd.64.1553193398184;
 Thu, 21 Mar 2019 11:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190308205332epcas1p181370b12f611fd746d333a557a1ddb48@epcas1p1.samsung.com>
 <CALAqxLUZKinhCasO4rXBJuip3bOo+JCovWLrHYPBPTopf6d7Vw@mail.gmail.com>
 <fe3b207e-1200-4a76-8c10-28655029f16d@samsung.com> <CALAqxLV2tWWNuo5UWq8UqDsUDbT4CQX5GVXiBRkHRb+322ys_w@mail.gmail.com>
 <CALAqxLW_6rMG3Bh9tR8=_Zw2y4XkMAsBCnZ6WC89tc7-2kKgHw@mail.gmail.com> <2ee85d78-cc76-b43d-5787-72986c0ffb69@gmail.com>
In-Reply-To: <2ee85d78-cc76-b43d-5787-72986c0ffb69@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 21 Mar 2019 11:36:27 -0700
Message-ID: <CALAqxLXZ392tnq82OQOx1_UESNsGD40A+vZV5YmeuqUDgfWy1A@mail.gmail.com>
Subject: Re: REGRESSION: dwc2: gadget: Add scatter-gather mode
To:     Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Gall <tom.gall@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 12:19 AM Andrzej Pietrasiewicz
<andrzejtp2010@gmail.com> wrote:
> Can you please apply this patch:
>
> https://www.spinics.net/lists/linux-usb/msg178195.html
>
> and see if this helps?

Thanks so much for the suggestion!

So I added that, but unfortunately I'm still seeing things crash on boot with:

[   13.655003] init: starting service 'bootanim'...
[   13.699548] functionfs read size 512 > requested size 24, splitting
request into multiple reads.
[   13.699631] ------------[ cut here ]------------
[   13.713062] kernel BUG at mm/slub.c:3950!
[   13.717096] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   13.722600] Modules linked in:
[   13.725685] CPU: 5 PID: 2123 Comm: adbd Not tainted
5.1.0-rc1-00032-g6cf2064-dirty #1015
[   13.733795] Hardware name: HiKey Development Board (DT)
[   13.739031] pstate: 40400005 (nZcv daif +PAN -UAO)
[   13.743834] pc : kfree+0x210/0x258
[   13.747246] lr : ffs_epfile_io.isra.12+0xfc/0x6a0
[   13.751950] sp : ffffff801199bb50
[   13.755278] x29: ffffff801199bb50 x28: ffffffc074e5c600
[   13.760596] x27: ffffffc06f200e38 x26: 00000000000001e8
[   13.765912] x25: ffffff801199bc98 x24: ffffffc06f0cfa00
[   13.771230] x23: ffffffc07497f000 x22: ffffff801146d000
[   13.776547] x21: ffffff80108a6294 x20: ffffff8012063000
[   13.781865] x19: ffffffbf004818c0 x18: 0000000000000000
[   13.787202] x17: 0000000000000000 x16: ffffffc074e5c600
[   13.792540] x15: 0000000000000000 x14: 0000000000000000
[   13.797877] x13: 0000000000000000 x12: 0000000000000000
[   13.803213] x11: 0000000000000000 x10: 0000000000000000
[   13.808547] x9 : 0000000000000000 x8 : 0000000000000000
[   13.813865] x7 : 0000000000000000 x6 : 000000761e605113
[   13.819182] x5 : 000000761e605113 x4 : 0000000000000000
[   13.824516] x3 : ffffffc06f200e00 x2 : 0000000000000000
[   13.829853] x1 : ffffffbf004818c8 x0 : ffffffbf004818c8
[   13.835199] Process adbd (pid: 2123, stack limit = 0x00000000c418bad6)
[   13.841744] Call trace:
[   13.844208]  kfree+0x210/0x258
[   13.847288]  ffs_epfile_io.isra.12+0xfc/0x6a0
[   13.851673]  ffs_epfile_read_iter+0xb4/0x188
[   13.855973]  new_sync_read+0xe4/0x158
[   13.859643]  __vfs_read+0x2c/0x40
[   13.862977]  vfs_read+0x8c/0x148
[   13.866230]  ksys_read+0x5c/0xc8
[   13.869486]  __arm64_sys_read+0x14/0x20
[   13.873352]  el0_svc_common+0xac/0x108
[   13.877132]  el0_svc_handler+0x2c/0x80
[   13.880910]  el0_svc+0x8/0xc
[   13.883810] Code: f9400260 378000a0 f9400660 37000060 (d4210000)
[   13.889928] ---[ end trace 967312c15ae7c93d ]---


But I like the direction your thinking with that patch.

I realize on some other dwc3 based hardware I was seeing different
issues with larger transfers that cropped up with 772a7a724f69 ("usb:
gadget: f_fs: Allow scatter-gather buffers"), and my hack workaround
there has been to comment out the assignment of
dwc->gadget.sg_supported to true. A similar hack w/ dwc2 seems to
avoid the issue too, so maybe the dwc2 sg_support patch is tripping
over the same thing in the ffs driver?

thanks
-john
