Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7088CFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4472720865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="0QMe2Dam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfKHW3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:29:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40336 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHW3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:29:43 -0500
Received: by mail-io1-f66.google.com with SMTP id p6so8036458iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tG3CMleYdOoOJlDJUqZcQjcg5RUyLpG6Jn1aCKR4UeI=;
        b=0QMe2DamNA24EOuI+UywMP9UlxhPIEd9A3ejSSwX5dRvxIuLh1eyekTxCIaEXQw45R
         54KJMXm13tA1bXnQ5gJkP3Bc2AXpK5GqrZmTonZGLH7QjaBf30/ySbas7znjaZC8cE1G
         dvINXztNO0uL0txG0mi6Bc5/ap9kcdnlTiqhlqswN/TjS2cBK4KeW5Nwx13lqVQuEvxX
         oGKBNxbZ5TalYTw1lCFi09i1ffQkcnGX5b5VkolnEU5VWoGxPkE3Trg9U5Fmdt/c9FIa
         zNy9okvAx34ttHfQFN4jU4TQ/XK6X0+WuB4rn384C8czKSZAdSDyG4KOBvp6caVBgMS9
         LBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tG3CMleYdOoOJlDJUqZcQjcg5RUyLpG6Jn1aCKR4UeI=;
        b=jIR7BxqK4zfBnK4124bRvAwU+GTkv8w+AyK/6I2x5uimCiuOxcLCxqGswPN7ZtPmlF
         Kg1AoK7N+UH8nW8sHpYMDGmpMbVQPNBl1IxvQ4d2QvEFkPrK1/3b7uvABy9xq1ueyZIu
         euWftaqbcfEZgNufaw3CqEE5Xg/NH5uh5gVk0tpT+B8NKgAaupwRgcgTHV+gNtBGDyB6
         sc2GOtWhqoC/BhEJzN1COxrD0StaCY24jsdhTcTzYZ02LFlq6WTcoj/waapYbKn8k1KD
         8pj1sb96f8SllAi9bS8UJBUTGzyURCxUaeEyZqKvhCX7FEZYPKpv7+7wK/VNtekoFDD6
         4mew==
X-Gm-Message-State: APjAAAWnPVg5kUTuUPViqsVhLxndgW71WCYWtaE2HBXL/xe9Fz7DTHzj
        6+WwGs+FYjjBrOIdb3Kywl+2iPJ5kkWNQdDvr5rwRm9Vy4dnxw==
X-Google-Smtp-Source: APXvYqxR2Iojnfzgt1D2EKNQghVo4JbH2TyZSSa7HkkqJ9Q6NanRF7wM7yANUTTIbJh1g1uWd98XskwAsn4twL28rCk=
X-Received: by 2002:a6b:6509:: with SMTP id z9mr12039319iob.123.1573252182905;
 Fri, 08 Nov 2019 14:29:42 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMjVUCd9bN=pggS-ECjMR42b0SqXKewsp+NYFSVqRgSWrg@mail.gmail.com>
 <20191107211801.GA107543@google.com> <20191108110736.GA10708@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191108110736.GA10708@e121166-lin.cambridge.arm.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 8 Nov 2019 14:29:31 -0800
Message-ID: <CAOesGMhxs0A-YTXpS9Lqk_sn2=Q5jaCM2+mjEuvtwSX9Y49eMw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 3:07 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Nov 07, 2019 at 03:18:01PM -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 07, 2019 at 10:27:20AM -0800, Olof Johansson wrote:
> > > On Wed, Nov 6, 2019 at 2:46 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > Today's linux-next merge of the pci tree got a conflict in:
> > > >
> > > >   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > >
> > > > between commit:
> > > >
> > > >   68e36a429ef5 ("arm64: dts: ls1028a: Move thermal-zone out of SoC")
> > > >
> > > > from the arm-soc tree and commit:
> > > >
> > > >   8d49ebe713ab ("arm64: dts: ls1028a: Add PCIe controller DT nodes")
> > >
> > > Bjorn, we ask that driver subsystem maintainers don't pick up DT
> > > changes since it causes conflicts like these.
> > >
> > > Is it easy for you to drop this patch, or are we stuck with it?
> > > Ideally it should never have been sent to you in the first place. :(
> >
> > Lorenzo, is it feasible for you to drop it from your pci/layerscape
> > branch and repush it?  If so, I can redo the merge into my "next"
> > branch.
>
> Done. Should we ignore all dts updates from now onwards ?

Thanks!

Indeed, dts updates should only go in through the platform maintainers
(i.e. through soc tree), unless there are strong reasons to bring them
in through driver trees.

If there's a need for a dt-include to be shared between driver and
dts, getting them on a stable branch that's merged through both trees
is usually the best way. Reach out when that happens and we can
coordinate.


Regards,

-Olof
