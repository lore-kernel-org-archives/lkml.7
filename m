Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A17DC3A5A8
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7018621874
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 14:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbaOe7gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfHaOkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 10:40:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35144 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfHaOkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 10:40:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so10332220wmg.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwEmp1kDTQ3Jn1SW8xtl3haIlhSExOyTeIkvr/BLe40=;
        b=dbaOe7gsw7vbI31moeXg5xlZY/Vw1BO2RNU6iZ0gQO8pGKzqcsvP97xwcNIAKDwUbk
         H+HUJDWDVwfK50rCnKvggoKRtANaHiNby2worNOZUwl7Zz8dLdxsAXCGDzPV3p23YCDK
         z/QgV9W/1ompNHZQ06OxWT33mmEvqOuScPpLrS4oUTzaBTDU/u5GBE+WvW8sucRviNwL
         qYJfQADZPN1WQLJn3yEQClJXCH8K/HU7Ow0zbxpBTOR6qiNC2JdXPR7aP8DHo76OkjAa
         Xu9Iz9xqakTzNmtw9PTlYZCEX70gc+RTCGJinLcVUd0zsFBdenqJnP9+v3/qYJklQ4ZU
         OGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwEmp1kDTQ3Jn1SW8xtl3haIlhSExOyTeIkvr/BLe40=;
        b=V2PsDKthoOq5He3YT/37bvU5MfpypGQsHhBTyIxsie0RrF9fpg/8+H+PGHWUByrxUn
         caYFYnLHNn0MBRs3S5TfDPUSL1X0KUY9RCvvjHd7NExbFuQU5yth+mqk7Vj4TlxVcT0X
         WNZiBaxguNHKNHsuow5M464Rz63DH6qDtSK1bU6wugoORmHgTkl8TRjZySY843ycmRQa
         6WdHf2n55PYw6Lb8+kdH0y5v7u9nFnPnqMDZh7ySbxhMRYUmJQ5wIQ4M6x4nWBxwwL3p
         AAlm8ertO/ubUiVv0rT5CzvtvPSKdnBS75VH4fg/hfAja1VEXdvDlJWkzTG9uQlhtsaR
         iu5w==
X-Gm-Message-State: APjAAAWo8Jp/ka2YoBAHT8MlCFNzndZP848bE8IREOou+cLPeBlirVL8
        7CIU9AILVRdMBU+0EuHgruYaDsfLX6SU5Li145fe
X-Google-Smtp-Source: APXvYqyvP45u0HybFwcrSz8Ft0vPypO8L9qyYG7MxIeARKwjeEza/zNK7M/CtAUXFRDZFbLiplDynymFyQSMGZ/pT98=
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr25303766wmk.149.1567262412501;
 Sat, 31 Aug 2019 07:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190830132311.7190ccc3@canb.auug.org.au> <CAErSpo618ewbJQHS3E3KWhTLe6T47u=Xjx9E-gYKMzjn=MmujA@mail.gmail.com>
 <9ae74244-f1e1-de7f-6d03-b2cca012f6fc@nvidia.com> <20190831084917.GA27466@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190831084917.GA27466@e121166-lin.cambridge.arm.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat, 31 Aug 2019 09:40:00 -0500
Message-ID: <CAErSpo6bf_qzkA5p_EbmdLGyRBr980R4yXS5_9b5RNsVr=sXWw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pci tree
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Krzysztof Wilczynski <kw@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 3:49 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Sat, Aug 31, 2019 at 09:51:05AM +0530, Vidya Sagar wrote:
> > On 8/30/2019 6:00 PM, Bjorn Helgaas wrote:
> > > [+cc Krzysztof]
> > >
> > > On Thu, Aug 29, 2019 at 10:23 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> > > > failed like this:
> > > >
> > > > drivers/pci/controller/dwc/pcie-tegra194.c:24:10: fatal error: linux/pci-aspm.h: No such file or directory
> > > >     24 | #include <linux/pci-aspm.h>
> > > >        |          ^~~~~~~~~~~~~~~~~~
> > > >
> > > > Caused by commit
> > > >
> > > >    81564976b1a9 ("PCI: tegra: Add Tegra194 PCIe support")
> > > >
> > > > I have reverted that commit for todat.
> > >
> > > Thanks, Stephen.
> > >
> > > I *could* fix this by removing that include in the merge, since the
> > > contents of linux/pci-aspm.h were moved into linux/pci.h by
> > > https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=7ce2e76a0420
> > >
> > > But as far as I can tell, pcie-tegra194.c doesn't actually require
> > > anything from linux/pci-aspm.h, so I'd rather amend the tegra194
> > > commit https://git.kernel.org/cgit/linux/kernel/git/lpieralisi/pci.git/commit/?id=81564976b1a9
> > > so it doesn't include pci-aspm.h in the first place.
> > Thanks Bjorn for the reply.
> > Yes. This header file is not required for now and can be removed.
> > Is there any action required from my side for this?
>
> I updated my pci/tegra branch so that Bjorn can pull it.

I pulled it and updated my "next" branch, thanks!
