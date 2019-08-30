Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7E5C3A5A7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398221897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGALJXQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfH3Ma5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:30:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53438 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfH3Ma5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:30:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so7117075wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lK3SdEfdHzl9jiQrhuM9R9qwguoBC0l1FGo+Jyx6ye4=;
        b=mGALJXQYufxSI9/NMXya55UCstbt+vyLc/JREg/ztiRBsbrhkFs+2GBIwHI+npCKmx
         9nopyIVxmxq7feMOYn4uj7VpUvPipLTxMmuGfCgZXtlk2DdRiNLLdltVivFn6INeK+Ru
         EWFP1NT5G4L9YOzyONXBummjWiPklvYAsFAGV93+0zjwiLGpQzC8uTIqvIeetVDT4bs0
         iwmgG+uPaZUH4oI5NmSaiS42tL1QmZ0ahpUC4uJIPdg5P8NxWeTDMTElbqMfLRXAcpZ4
         hTlslfMebOGZYUa3kLbXbACr65UU4EtwpZ/0gWZQHWR384uJ5hoOGOJx9JtpegrcqjMn
         TRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lK3SdEfdHzl9jiQrhuM9R9qwguoBC0l1FGo+Jyx6ye4=;
        b=B6I+CkhqZJublEymIkGbnOgX5e7xfn0XFFP6l3Q8Mv7WzrrDUn/lu1hNSuwZI1/RKi
         jjVJPRAcEbnhekyPUfYtLN0r/OdwVmc1G+te8HLF5ipEVHBuAyUKufgTbQyXPpDm8ted
         qY1lLKzJOh0nDutavm9Qu6Ta9uDKZeCzmDLNM+kL7yUD11bNZCEKhB3TYyOztGys/8yi
         7R0khEC1WCg4UqkzrD/xrWP6IO0GL4bnCfn/ZsMIkzL5cFSa+fxF8vqBUJu7RX2TOE1Q
         H8baCkqlScv0j0wsNnWn3Kv6Q8MtymaSZE9j5MImoWYbjFiDYlrJG2Z45qjPQUSih3a+
         gV2g==
X-Gm-Message-State: APjAAAVarznYASiNp08jwAJp9ggKFzHLLvnKU7q7D2Lm3C2/ESEuMQRp
        RtbfUCdqp/H+BpCUI7ep8GxEFRSB6AfGqx0nZhDp
X-Google-Smtp-Source: APXvYqxiSI/F1NevyNssi3lKq65ebc/V93G1PJODpIbGRxXGCx11RsYl1WKBYAF6TnctmYCzjRhkwGQ0+ZS3SlpMW7E=
X-Received: by 2002:a1c:658a:: with SMTP id z132mr18335687wmb.98.1567168254754;
 Fri, 30 Aug 2019 05:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190830132311.7190ccc3@canb.auug.org.au>
In-Reply-To: <20190830132311.7190ccc3@canb.auug.org.au>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 30 Aug 2019 07:30:42 -0500
Message-ID: <CAErSpo618ewbJQHS3E3KWhTLe6T47u=Xjx9E-gYKMzjn=MmujA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pci tree
To:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Krzysztof Wilczynski <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Krzysztof]

On Thu, Aug 29, 2019 at 10:23 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> drivers/pci/controller/dwc/pcie-tegra194.c:24:10: fatal error: linux/pci-aspm.h: No such file or directory
>    24 | #include <linux/pci-aspm.h>
>       |          ^~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   81564976b1a9 ("PCI: tegra: Add Tegra194 PCIe support")
>
> I have reverted that commit for todat.

Thanks, Stephen.

I *could* fix this by removing that include in the merge, since the
contents of linux/pci-aspm.h were moved into linux/pci.h by
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=7ce2e76a0420

But as far as I can tell, pcie-tegra194.c doesn't actually require
anything from linux/pci-aspm.h, so I'd rather amend the tegra194
commit https://git.kernel.org/cgit/linux/kernel/git/lpieralisi/pci.git/commit/?id=81564976b1a9
so it doesn't include pci-aspm.h in the first place.

Bjorn
