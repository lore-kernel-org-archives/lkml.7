Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC172C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB37620856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OlUQn9n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfHEKcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:32:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33613 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfHEKcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:32:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so14683396edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2t8NpBMFz+vZWj7uMv0mNnSRA2UuSvBBLYkX3l+9iFg=;
        b=OlUQn9n1XfLu7teP0KKGlghRXxE6YfdgOYBt+po0ODAQAZtrX33RsFC7JrwnExa8cL
         MSNWxapbzgtY/jV/tmPXt03VuurAMp7FYIh6dN5w7vOK4bqXapuRztsQMw4XbnFxCq5j
         qi6USnwHuwJmQK4LdK0w4JDAEpdOA4Bo7Sw3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2t8NpBMFz+vZWj7uMv0mNnSRA2UuSvBBLYkX3l+9iFg=;
        b=aUqXB3I1pT16EjL3xeZQDIGYuBua8YnezugTj0NGiAcBP4m1TDYyxJDTs6qzOWcwW1
         EWy5Tv5bliGtwiLTr8y4MzJr3wZXW+YdV9M3d9ZapZk1rkO3F47UXheIoUX/4hkXy/x4
         QVGoRb6ClD7N8QuwWMWlczBMxnRNIz0l785KmG8hyvinm7M7QEP7OtictPjBJ9vxSIF0
         hKfR4obbhXLgHxxAO/QdOYLFlpHxMJR6ptn4V2HwsYSWCaqZ4BMFChRvIYIr4PcoD+Uy
         UTR36NE23zWj/7pRHcTiEJCFnlIZCswiw/x6yvzsa0Ib2uHYbFAQBbIX62pvyPAbYsQb
         1gwA==
X-Gm-Message-State: APjAAAXc+WjoKUHvYImO7mx4o3aF31HXZmQZyWf2vVkmZ/gurOkcC3QZ
        qtraPCbI81I3rawLbuUr5qYAd2PR45a0Otez1dfdkg==
X-Google-Smtp-Source: APXvYqzAn+oC3iie4UJoTUwTGxe/UPUNm7dP1YnY1Jv/HqewkbGk9qXU4qTnKQnQjKvN1dc2A2il3n7AnKDHmWIRPmg=
X-Received: by 2002:a17:906:644c:: with SMTP id l12mr112559234ejn.142.1565001123236;
 Mon, 05 Aug 2019 03:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190709072547.217957-1-pihsun@chromium.org> <20190709072547.217957-3-pihsun@chromium.org>
 <CAPBb6MUsKYsG2qYFsj8DhtAWipRw887nk_gi68Gt+DcuHzApgw@mail.gmail.com>
In-Reply-To: <CAPBb6MUsKYsG2qYFsj8DhtAWipRw887nk_gi68Gt+DcuHzApgw@mail.gmail.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 5 Aug 2019 18:31:26 +0800
Message-ID: <CANdKZ0cb8OZVjOb9j7ivCCs3afXgshFWgrYkkZJOrGkHNWcEPg@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] remoteproc/mediatek: add SCP support for mt8183
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
        "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review. I'll address most of the comments in the next version.

On Mon, Jul 22, 2019 at 5:37 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> Hi Pi-Hsun,
>
> On Tue, Jul 9, 2019 at 4:27 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
> > +static void *scp_da_to_va(struct rproc *rproc, u64 da, int len)
> > +{
> > +       struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
> > +       int offset;
> > +
> > +       if (da < scp->sram_size) {
> > +               offset = da;
> > +               if (offset >= 0 && ((offset + len) < scp->sram_size))
> > +                       return (__force void *)(scp->sram_base + offset);
> > +       } else if (da >= scp->sram_size &&
> > +                  da < (scp->sram_size + MAX_CODE_SIZE)) {
> > +               offset = da;
>
> This line looks suspicious. Shouldn't it be
>
>     offset = da - scp->sram_size?
>

Actually the whole "else if (...)" is not used. Would remove this in
next version.

> > +
> > +/*
> > + * Copy src to dst, where dst is in SCP SRAM region.
> > + * Since AP access of SCP SRAM don't support byte write, this always write a
> > + * full word at a time, and may cause some extra bytes to be written at the
> > + * beginning & ending of dst.
> > + */
> > +void scp_memcpy_aligned(void *dst, const void *src, unsigned int len)
> > +{
> > +       void *ptr;
> > +       u32 val;
> > +       unsigned int i = 0;
> > +
> > +       if (!IS_ALIGNED((unsigned long)dst, 4)) {
> > +               ptr = (void *)ALIGN_DOWN((unsigned long)dst, 4);
> > +               i = 4 - (dst - ptr);
> > +               val = readl_relaxed(ptr);
> > +               memcpy((u8 *)&val + (4 - i), src, i);
> > +               writel_relaxed(val, ptr);
> > +       }
> > +
> > +       while (i + 4 <= len) {
> > +               val = *((u32 *)(src + i));
> > +               writel_relaxed(val, dst + i);
>
> If dst is not aligned to 4, this is going to write to an address that
> is not a multiple of 4, even though it writes a long. Is this ok?
> Typically limitations in write size come with alignment limitations.
>

If dst is not aligned to 4, the first if (!IS_ALIGNED(...)) block
should make that the (dst + i) is a multiple of 4, so the write here
is aligned.

> > +               i += 4;
> > +       }
> > +       if (i < len) {
> > +               val = readl_relaxed(dst + i);
> > +               memcpy(&val, src + i, len - i);
> > +               writel_relaxed(val, dst + i);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(scp_memcpy_aligned);
>
> IIUC this function's symbol does not need to be exported since it is
> only used in the current kernel module.
>

I've tried to remove this EXPORT line, but then there would be error
while compiling:
ERROR: "scp_memcpy_aligned" [drivers/remoteproc/mtk_scp.ko] undefined!
I think it's because the mtk_scp.c and mtk_scp_ipi.c both use the
scp_memcpy_aligned, but is compiled as separate .o files. So the
EXPORT_SYMBOL is needed.
