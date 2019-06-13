Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834CFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCA020B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5e9Vl4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfFMTBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:01:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52785 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfFMTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:01:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so11327458wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KguLrFwl0xPCes0CytFyV6BjIEPLyEaRz6Aj70yR7w=;
        b=j5e9Vl4xfjq394daE3nOYQWA0Yekr+zPxdRyPz1NMbmUt/44pK1HGdBPJz+1wrf9DT
         5GHpISbHFPFcJCzoK1FSc0RziFvPWERUsFKxv8wpsFV0YvjMaS/9ZC/ie6YqL6h3uBmg
         tLkotCkYLzdUThhlfYJgI1rwyyWdzjfbhO/I0k64FwtwHFdxKGTJViStVDB8elBiU90H
         iEoSkMzicwD5LQ7yHlON3YDs0f31wcGJp5UCD+Sg23lBMPm4WT3YnyT6V9/SeqKnifnG
         SZ/bZmbv9TrwYiEIOT/R4+VjAE7u7/52hPOp/ppo6h3PPa8Tr1G9rCM7H9R5ikzloyvU
         SGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KguLrFwl0xPCes0CytFyV6BjIEPLyEaRz6Aj70yR7w=;
        b=PYDbw4qDXPZ+RsKSS47hCP/O/P28wXVZ2trXmJcQtR+bH/a5DxbSzcj71KgBdqJX08
         fUgMrh6W+4KM/rUJaDvrBAmRociF1eC4PthRYecpqfDL9pXC0BYULvJMWHi9/8S9y8ko
         HxiW++QRc+YVcK3lIrSehrpryOuGAsVOkyWmNg+AZqS6WCpUQaeVWZLZUXxQhKhhmONz
         Z1LYz28Qn2d4ub+z2V5+wiNCHexzuK4pxjqt69pG0mOL7nwiYV4lQ+0f7goLhZsm1ZCW
         bkk+G2X6D6SUWzFu3GE/hW7Ah7UN9Y1vps0E3fq1eLkYUIg3yNgCcAdC7hJZrKCe0UG4
         V/vA==
X-Gm-Message-State: APjAAAWH/2fL9DUJ9b79Zn3wLel58juUk2kSmp2LLgHkATaEvIxL6i81
        IPFhfAkn6AXcy1yyxUChaZfCm5ETGJZY6Mx5xQwF/g==
X-Google-Smtp-Source: APXvYqxuT1gm3u8/hCDM3wezjyGA7tgkxOInncWJuSpR6tMq+J0eK/KQWnX8tpXhhukbO20sOdbPNpxPlxd5f/YG518=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr4584144wme.173.1560452512591;
 Thu, 13 Jun 2019 12:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <1560377606-40855-1-git-send-email-fei.yang@intel.com>
In-Reply-To: <1560377606-40855-1-git-send-email-fei.yang@intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 13 Jun 2019 12:01:39 -0700
Message-ID: <CALAqxLXeXt1Me_gzUFX8uBAuw_26QEOAX84324kzq7Hih1XDQw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_fs: data_len used before properly set
To:     "Yang, Fei" <fei.yang@intel.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        mgautam@codeaurora.org,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 3:13 PM <fei.yang@intel.com> wrote:
>
> From: Fei Yang <fei.yang@intel.com>
>
> The following line of code in function ffs_epfile_io is trying to set
> flag io_data->use_sg in case buffer required is larger than one page.
>
>     io_data->use_sg = gadget->sg_supported && data_len > PAGE_SIZE;
>
> However at this point of time the variable data_len has not been set
> to the proper buffer size yet. The consequence is that io_data->use_sg
> is always set regardless what buffer size really is, because the condition
> (data_len > PAGE_SIZE) is effectively an unsigned comparison between
> -EINVAL and PAGE_SIZE which would always result in TRUE.
>
> Fixes: 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather buffers")
> Signed-off-by: Fei Yang <fei.yang@intel.com>
> Cc: stable <stable@vger.kernel.org>

Hey Fei! Thanks so much for sending this out! I was excited that this
might resolve the ffs stalls I've been seeing on dwc3/dwc2 hardware,
but when I gave it a shot, it doesn't seem to help. In fact, rather
then a stall, I end up seeing the following panic:

[  383.415362] Unable to handle kernel read from unreadable memory at
virtual address 0000000000000018
[  383.431935] Mem abort info:
[  383.431937]   ESR = 0x96000005
[  383.431940]   Exception class = DABT (current EL), IL = 32 bits
[  383.431941]   SET = 0, FnV = 0
[  383.431942]   EA = 0, S1PTW = 0
[  383.431943] Data abort info:
[  383.431945]   ISV = 0, ISS = 0x00000005
[  383.431946]   CM = 0, WnR = 0
[  383.431951] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000aae1f000
[  383.431953] [0000000000000018] pgd=000000009f064003,
pud=000000009f064003, pmd=0000000000000000
[  383.482560] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[  383.488128] Modules linked in:
[  383.491181] CPU: 0 PID: 399 Comm: irq/69-dwc3 Tainted: G S
      5.2.0-rc4-00092-gf5f12f5d3fdd #296
[  383.501002] Hardware name: HiKey960 (DT)
[  383.504918] pstate: 20400085 (nzCv daIf +PAN -UAO)
[  383.509714] pc : dma_direct_unmap_sg+0x38/0x80
[  383.514151] lr : dma_direct_unmap_sg+0x5c/0x80
[  383.518586] sp : ffffff8011fcbc40
[  383.521893] x29: ffffff8011fcbc40 x28: ffffffc0bad9c180
[  383.527199] x27: ffffffc0bae05300 x26: 0000000000000002
[  383.532504] x25: ffffffc0b9a9fd00 x24: 0000000000000000
[  383.537809] x23: 0000000000000001 x22: ffffffc0bad9fc10
[  383.543114] x21: 0000000000000002 x20: 0000000000000001
[  383.548420] x19: 0000000000000000 x18: 0000000000000000
[  383.553726] x17: 0000000000000000 x16: 0000000000000000
[  383.559032] x15: 0000000000000000 x14: ffffff8010eb6ad0
[  383.564338] x13: 0000000000000000 x12: 0000000000000000
[  383.569643] x11: 0000000000000000 x10: 00000000000009d0
[  383.574949] x9 : ffffff8011fcbd20 x8 : ffffffc0b63c3a30
[  383.580254] x7 : ffffffc0bc515c00 x6 : 0000000000000007
[  383.585560] x5 : 0000000000000001 x4 : 0000000000000004
[  383.590865] x3 : 0000000000000001 x2 : 0000000000000001
[  383.596169] x1 : 000000000006bf42 x0 : 0000000000000000
[  383.601477] Call trace:
[  383.603916]  dma_direct_unmap_sg+0x38/0x80
[  383.608013]  usb_gadget_unmap_request_by_dev+0xb0/0xc8
[  383.613148]  dwc3_gadget_del_and_unmap_request.isra.13+0x78/0x150
[  383.619235]  dwc3_gadget_giveback+0x30/0x68
[  383.623412]  dwc3_thread_interrupt+0x694/0x14e0
[  383.627938]  irq_thread_fn+0x28/0x78
[  383.631506]  irq_thread+0x124/0x1c0
[  383.634991]  kthread+0x128/0x130
[  383.638214]  ret_from_fork+0x10/0x1c
[  383.641786] Code: 2a0303f7 aa0403f8 52800014 d503201f (b9401a62)
[  383.647874] ---[ end trace f48053c2040c5658 ]---

From the looks of it though, I suspect your fix is a good one, and
maybe its just helping expose some related underlying issues in the
dwc3 driver?

thanks
-john
