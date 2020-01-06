Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C426C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279392072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pkW2Bc8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAFVSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:18:30 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44822 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgAFVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:18:29 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so7310923iln.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNSwpAU9T9Ditm5lbQpzyHWb6Vjzt8MFLktggpxIJ0w=;
        b=pkW2Bc8uL7WFlR5binpUJ2o+mA+wJOL4zBIg31tpcCRmDn7+Ovh2mNB9fKUivhrzZy
         6msTWNsj+DMQZGlaWH2MJJY3Erq+TvGCgTqZvKuVsKUWxIfOarjMDPtDI5cFe4WNx2sH
         WHMxrKKqr8ie8VYK86DW3E2A2hAdX6UtnYqy0JGrOmYgHL91qPbHnNyr9zjrfMFjHYRE
         fSm/awWyRsOS6KrhnjuXYP/x/SeElZsPWNScdnTc/jFjjhIieugXz12i0rQmPYoHbQAY
         Eh8DqEvdBTcV7DjAn5XEsX7OIoa0do/2fm3I5jDXvOeVdildyrMztVDISn0M2cc1SNCH
         SZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNSwpAU9T9Ditm5lbQpzyHWb6Vjzt8MFLktggpxIJ0w=;
        b=p/yjX6cmZXF2564dufno59gyjUvbLYSvzjciY2Tho2mn9F4SKRRa/8sVB2PiZfsVGP
         ESVX59T9sm8+4Qc6mJI3Wx5uQ2LGafykDu14KGWssE3OA6vD+BhEE3p61+3+fshSubAf
         wbo+XfMKGFde2zFgKWKvGU5smk2EKsD4Gw1tqqMrDQjO7GpqJYxOlg6EiWeJCKFtExE0
         6ORC79sfJjuSBVbZYJCyneVGMPkG1ZO5RmruGNZ2yVeB8te7hDBoY4t7GZuKFfBHznVw
         +bW4eUYplIeZRFcCAHuncNQdOKGmnoVq9Wf/R3fZC889SCvUnMBOgtm7M8aZWyVzqNUu
         w7NA==
X-Gm-Message-State: APjAAAX/MHyE6m0RgjSEQ4s5s1jC0Nan8uKKQexe0+QphAJqWUgkphrH
        537eUNomBvgt4aPQcV9MdK+zDs7Omkmonqk9vxp41A==
X-Google-Smtp-Source: APXvYqy8MsJCk5GJ8K445xwMzgYaN3g6i94F2/UxUyENUV9JW1kEJ5YELMSltxVBc8qNWXIY9gK8wWOvwuyUoQaO+cc=
X-Received: by 2002:a92:5d03:: with SMTP id r3mr82418941ilb.278.1578345508762;
 Mon, 06 Jan 2020 13:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20191216110947.6fb2423a@xps13> <20191218095715.25585-1-gomonovych@gmail.com>
In-Reply-To: <20191218095715.25585-1-gomonovych@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 6 Jan 2020 13:18:17 -0800
Message-ID: <CAOesGMjp8=uOwTnGwuMwTJMKVh915udgkhSb0joKMTcwWBEy-Q@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: cadence: Fix cast to pointer from integer of
 different size warning
To:     Vasyl Gomonovych <gomonovych@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Piotr Sroka <piotrs@cadence.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel, this warning is still there both in mainline and linux-next.

Can you please apply it and get it sent in so we can keep the tree
building cleaning and spot warnings without the noise? Thanks!

On Wed, Dec 18, 2019 at 1:57 AM Vasyl Gomonovych <gomonovych@gmail.com> wrote:
>
> Use dma_addr_t type to pass memory address and control data in
> DMA descriptor fields memory_pointer and ctrl_data_ptr
> To fix warning: cast to pointer from integer of different size
>
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
