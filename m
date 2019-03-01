Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D92FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED13520830
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0HpGexN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfCADEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:04:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34955 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCADEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:04:32 -0500
Received: by mail-it1-f195.google.com with SMTP id 188so19240018itb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 19:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DM+d/4EP4JRgwKFIQ8vTGi+KTuta0nTyCKeSsyUW+IQ=;
        b=R0HpGexNCXxU8+buIYrCqvxn9P1eVd/e6fX87s3tas6Nd8yMl5BdqFjXUW22CaKr72
         iS/PwDw32Cq/26zCWDKnDmHafZzuL6UtI+lN/sBa1wwk93xPhvacEOC4R3lRO86ppxJT
         sO7kFqp4RjiHMZxSgv37VPjfFaYxbyneyZjaDpr1zgPW7ztVS3MwAzRxrOEBZvG3J/CH
         GLFF/XBsJ8MDXHE3ytrX/u39fpsiimm+sqUqi2R5yNUBJUkpJEdNeeqt8F7J8a69Pdsy
         +VDzbePnbipkG1fwmPzhXkO9i6pSMbYG5Ws5bHdqCS8PbenqtMJPHXBonU92pVM4jrHR
         jL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DM+d/4EP4JRgwKFIQ8vTGi+KTuta0nTyCKeSsyUW+IQ=;
        b=HGUkkM6cHb7X/2Y7F9uVtsx/wtkN67zialWlzdMW8E+7QAAQtFSF7u0V62Ut5Y0nx8
         +ucrUkg52Hpx+/FghhWlP4Qm6W1VPn7AxCxSnfo0A7oGjxeS7JDHeHH2w1jWetYEFEZU
         E5+7Od/PXjA9NvMXxR5qfAuA/oXt2k0A64KSlaFg4bAgWAlCtTIwDOw+e7cETQiiHtnl
         xLYHRvDanbQqfBTUkUAexDn6mR47UZhMcgbfbXEhmDVnK9oQ6VuznktIsqRDVyNFNT0L
         4KibETNfiAaydU4ngIp2/V9whdcwoA0JsZAPtIYTTUUyyjcsmMbVVSQaMd+gif946CfX
         8pvg==
X-Gm-Message-State: APjAAAVe+uTbw2kF2kYnjTF10qeLtrqq+ulOv2ysEz3Dj2V1RPfIUmMC
        k7hlxyjHHhqpvx1kjYKZ/6mhh0JDOKtPQ04c6A==
X-Google-Smtp-Source: APXvYqxno2Gy/0WCVkCrPyDKeGjZggAjQXWYrJ1fBvBQzcQOlfA+bvq3pBSBUmC5W/39qKJFhwWRkKj0do5PVhCbm4A=
X-Received: by 2002:a02:8c28:: with SMTP id l37mr1469411jak.17.1551409470930;
 Thu, 28 Feb 2019 19:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20190215102458.GD10433@zn.tnic> <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic> <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic> <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de> <20190222130026.GA30766@zn.tnic>
 <20190225110043.GA5884@suse.de> <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
 <20190225113003.GE26145@zn.tnic>
In-Reply-To: <20190225113003.GE26145@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 1 Mar 2019 11:04:19 +0800
Message-ID: <CAFgQCTvP-YDUEcHTgupr+ar+qeoj5rw1y8k+6kzrzHPzTqBkaw@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

Do you think the following patch is good at present?
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 81f9d23..9213073 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -460,7 +460,7 @@ static void __init
memblock_x86_reserve_range_setup_data(void)
 # define CRASH_ADDR_LOW_MAX    (512 << 20)
 # define CRASH_ADDR_HIGH_MAX   (512 << 20)
 #else
-# define CRASH_ADDR_LOW_MAX    (896UL << 20)
+# define CRASH_ADDR_LOW_MAX    (1 << 32)
 # define CRASH_ADDR_HIGH_MAX   MAXMEM
 #endif

For documentation, I will send another patch to improve the description.

Thanks,
Pingfan

On Mon, Feb 25, 2019 at 7:30 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 25, 2019 at 07:12:16PM +0800, Dave Young wrote:
> > If we move to high as default, it will allocate 160M high + 256M low. It
>
> We won't move to high by default - we will *fall* back to high if the
> default allocation fails.
>
> > To make the process less fragile maybe we can remove the 896M limitation
> > and only try <4G then go to high.
>
> Sure, the more robust for the user, the better.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
