Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C7EC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95E321955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bhk1S958"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGVFyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:54:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39511 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfGVFyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:54:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id w190so27722405qkc.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 22:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALpZrOrvgH+r7X2cMMcT3uazbVSi6LZd2S6e6b7HWF4=;
        b=bhk1S958rGZBS6IEGXloGFPbjRFD/ifwQs5J8bpIbKoLNxWYouoDqsXARyuDAJOP3a
         FhvZFvxqJS7NSPoGT6HKX21gwXhgd7uLzYfk0+liNpXD5P8+Nv1tpo/pWOSp6lQRdMia
         NufcCHw9qga7kxTfV/sKcSmAj/BuRmPi+ewjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALpZrOrvgH+r7X2cMMcT3uazbVSi6LZd2S6e6b7HWF4=;
        b=Jts/kycyBX5f+bCx44sgS+EFq6wBjPE+UXZ0Y3nXVV9+9j6jH2M+1eIvT0Ik1z+Fbr
         9cZkCa0k84CLwchNM78/4FIs5Xqyf0uZOo1Fsxe59Rw/wMXKRJWXi7btzVr+6l17tVY1
         bTESYvVXf+n+40Fe2z8KaNk/m5XMY8g7HRMW3nvMPoq0Q3xugFnngYD8OjRT/vz5K6++
         tOgAQCHsc4cEfLimQW3by3+6oQ/AL+Wlr97fgf6mch8tN3wdITSCQr23h1tN66CFmLNK
         n/e7BQz84qL9Zm7rzQGBTRinb0SqdQAzzI1JTjlizdZkmIsFTCIKOJbOaCdksgh3zxFs
         6XAg==
X-Gm-Message-State: APjAAAWZfIfz6WrLTUytLNTrn8RRnD366PJtDuHoi2zbRKSbbZZTWApi
        IUzfwo4gOoy6EzZyRrW5IhY+ufr5Fu5onOELXTdadg==
X-Google-Smtp-Source: APXvYqyJS23zphBFVEahm9k+YlYFppVjg+Ahm5ctjBpTcgFAVUGpCf3TDqrV67yInPXuq6NdYTudh86LjK8xE8uirFw=
X-Received: by 2002:ae9:f017:: with SMTP id l23mr45458670qkg.457.1563774841009;
 Sun, 21 Jul 2019 22:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190703050827.173284-1-drinkcat@chromium.org>
 <815a8414-bfbe-c693-3208-1580779815ec@gmail.com> <CAL_JsqLETdazfnz5EU0Qw4TVVBhWmzk12Z5zYMo5Hm2ACPXh1w@mail.gmail.com>
 <421844aa-cf68-d4d2-f02d-aefaf8954fdf@gmail.com>
In-Reply-To: <421844aa-cf68-d4d2-f02d-aefaf8954fdf@gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 22 Jul 2019 13:53:49 +0800
Message-ID: <CANMq1KB_VZ2DsHeWJK5HLx6pa9Mad6UXhvnfL0u_1ik-_NnXfw@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Make sure no-map does not remove already reserved regions
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ian Campbell <ian.campbell@citrix.com>,
        Grant Likely <grant.likely@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 7:17 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 7/16/19 4:12 PM, Rob Herring wrote:
> > On Tue, Jul 16, 2019 at 4:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> On 7/2/19 10:08 PM, Nicolas Boichat wrote:
> >>> If the device tree is incorrectly configured, and attempts to
> >>> define a "no-map" reserved memory that overlaps with the kernel
> >>> data/code, the kernel would crash quickly after boot, with no
> >>> obvious clue about the nature of the issue.
> >>>
> >>> For example, this would happen if we have the kernel mapped at
> >>> these addresses (from /proc/iomem):
> >>> 40000000-41ffffff : System RAM
> >>>   40080000-40dfffff : Kernel code
> >>>   40e00000-411fffff : reserved
> >>>   41200000-413e0fff : Kernel data
> >>>
> >>> And we declare a no-map shared-dma-pool region at a fixed address
> >>> within that range:
> >>> mem_reserved: mem_region {
> >>>       compatible = "shared-dma-pool";
> >>>       reg = <0 0x40000000 0 0x01A00000>;
> >>>       no-map;
> >>> };
> >>>
> >>> To fix this, when removing memory regions at early boot (which is
> >>> what "no-map" regions do), we need to make sure that the memory
> >>> is not already reserved. If we do, __reserved_mem_reserve_reg
> >>> will throw an error:
> >>> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory
> >>>    for node 'mem_region': base 0x0000000040000000, size 26 MiB
> >>> and the code that will try to use the region should also fail,
> >>> later on.
> >>>
> >>> We do not do anything for non-"no-map" regions, as memblock
> >>> explicitly allows reserved regions to overlap, and the commit
> >>> that this fixes removed the check for that precise reason.
> >>>
> >>> Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/ regions in the case of partial overlap")
> >>> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >>> ---
> >>>  drivers/of/fdt.c | 10 +++++++++-
> >>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> >>> index cd17dc62a71980a..a1ded43fc332d0c 100644
> >>> --- a/drivers/of/fdt.c
> >>> +++ b/drivers/of/fdt.c
> >>> @@ -1138,8 +1138,16 @@ int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
> >>>  int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
> >>>                                       phys_addr_t size, bool nomap)
> >>>  {
> >>> -     if (nomap)
> >>> +     if (nomap) {
> >>> +             /*
> >>> +              * If the memory is already reserved (by another region), we
> >>> +              * should not allow it to be removed altogether.
> >>> +              */
> >>> +             if (memblock_is_region_reserved(base, size))
> >>> +                     return -EBUSY;
> >>> +
> >>>               return memblock_remove(base, size);
> >>
> >> While you are it, the nomap argument (introduced with
> >> e8d9d1f5485b52ec3c4d7af839e6914438f6c285) predates the introduction of
> >> memblock_is_nomap() (bf3d3cc580f9960883ebf9ea05868f336d9491c2), so
> >> should just remove memblock_remove() and use memblock_mark_nomap()
> >> instead here.
> >
> > Perhaps like this patch[1]? Though the reasoning is different and the
> > commit message here is more thorough, so can I get a combined patch.
>
> From a quick reading it does look like memblock_isolate_range(), as
> called by memblock_setclr_flag() should be able to detect this region
> was already reserved, though I have not tried it.

I quickly tested it, and just using memblock_mark_nomap does not seem
be be enough (the call does not fail, and the nomap memory is still
allocated).

> > However, I don't under how handling a misconfigured DT and aligned
> > with EFI are the same patch. What's considered valid for EFI is not
> > for DT regions?
>
> That I don't know how to answer.
> --
> Florian
