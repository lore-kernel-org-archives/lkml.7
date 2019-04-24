Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F40C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfDXLhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:37:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40259 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfDXLhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:37:07 -0400
Received: by mail-io1-f67.google.com with SMTP id i21so14945570iol.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCPr+Bpv1PvmLhqWlzdwGPLFCdUpiW+JQjNCuXkw1SU=;
        b=fmfqwBeS4G4PAHj4V8QH2p2KdTxh1GebOV6KdY2S+Zs+RFaA4BDFjVTTsnAsXMOnWl
         JrQlkcrAcGA+LW7up9lDDiNWmvX3BO2jGC+JiZt3aBNXBuO5P+scae9sal1XuXSqgGj1
         pE1dxpVq0D16ZSgKsJhHqAMnj/Bam47K9mAL5viZ8zZ7AXECmEDBxQERF5B8CqtFNuTV
         iKX8I2nSuNXqm7KCx/AFWzKPUYd3PzQ/x8xzATx7B1MqHgBLsoy+xjDMfb4J2DolxwEx
         KMojWJn5PYStZdB9FF7Fr1+ilMhkM6bO1Lv/A7gy+FnsnF2A7zLmDHsIV+PRuHGKf3bk
         BJ2w==
X-Gm-Message-State: APjAAAVU0Zi0XBkSSXfjndqC7EzKw4+JoPj5UnWmnhGtdsbTTMTpIFCs
        G0YhOY4ypx4RVHdP37amod9H6ScvuhDP8pm5853KKQ==
X-Google-Smtp-Source: APXvYqyI5JmtSaeO/3yvXINp+4HX/ANhSgcyY5x5fm/9T34K1VLc2XkJQZ636ETsq3CTfrXzmJ86Q5uZL2lp2hpsads=
X-Received: by 2002:a5e:8b09:: with SMTP id g9mr2043236iok.137.1556105826608;
 Wed, 24 Apr 2019 04:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190422092804.15534-1-kasong@redhat.com> <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
 <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
 <24f1dc7c-1dea-79b0-d364-0dc7d605ce01@ce.jp.nec.com> <20190424054135.GG3584@localhost.localdomain>
 <20190424061831.GA9059@dhcp-128-65.nay.redhat.com> <20190424074553.GH3584@localhost.localdomain>
In-Reply-To: <20190424074553.GH3584@localhost.localdomain>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 24 Apr 2019 07:36:55 -0400
Message-ID: <CACPcB9fuXcc7S2xzw7LrHsnCPjN0tuBt+ivuS5v5KukOWW+YcQ@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
To:     Baoquan He <bhe@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019, 03:46 Baoquan He <bhe@redhat.com> wrote:
>
> On 04/24/19 at 02:18pm, Dave Young wrote:
> > On 04/24/19 at 01:41pm, Baoquan He wrote:
> > > On 04/24/19 at 02:47am, Junichi Nomura wrote:
> > > > On 4/24/19 2:15 AM, Kairui Song wrote:
> > > > > On Mon, Apr 22, 2019 at 11:21 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
> > > > >> Is the mapping of ACPI tables just by luck, too?
> > > > >
> > > > > Good question, they should have same issue with systab, I ignored this one.
> > > > > Then in first kernel when doing kexec it should ensure both ACPI
> > > > > tables and the EFI systab are mapped, that should cover everything and
> > > > > make it work.
> > > >
> > > > Right.
> > > >
> > > > > Is there anything else missing?
> > > > No, as far as I looked around get_rsdp_addr().
> > >
> > > Have made a draft patch to build ident mapping for ACPI tables too, it's
> > > based on Kairui's patch. Dave has tested on his t400s laptop, and
> > > passed. Please check if this adding is OK.
> > >
> > > Kairui, you can add this into your patch to make a new one and resend.
> > > Or I can combine them and send for you today.
>
> >
> > Since I can not reproduce the acpi table accessing fault with Kairui's patch,
> > the test is just sanity testing on same hardware. But the patch looks
> > good.
>
> Yes, usually vendor will put these efi systab, ACPI tables together. See
> the regions you listed on your t420 laptop in another mail:
> da99f000 - dae9efff Reserved (efi systab fall in this region)
> daf9f000 - daffefff ACPI tables
>
> We build 1:1 mapping for kexec kernel down to PMD level. Means for a
> region, it will align starting address down to PMD size, and align end
> address up to PMD size. So the end of efi systab, 0xdae9efff, will cause
> mapping built for the 2MB area, 0xdae00000-0xdaf00000. Clearly ACPI
> tables are covered by that PMD entry. That's why only efi systab
> mapping is built, accessing ACPI tables doesn't cause error.
>
> But we can't assume they will be put together always, so need map ACPI
> tables too.
>
> >
> > With Kairui's fix+ this acpi fix and Junichi's patch everything works.
> > Can anyone send them for example patch 1/2: kexec early mapping for
> > efi/acpi,  patch 2/2: Junichi's previous patch.
>
> Kairui is having a workshop in the US, I can make a patchset to
> include these two patches.
>
> For patch 1/2, I will combine the patch Kairui posted and my draft patch,
> Kairui is the author certainly, since he debugged and found out the root
> cause, and posted v1 when I was on vacation last week.
>
> For patch 2/2, I think the version Boris organized is good.
> http://lkml.kernel.org/r/20190416095209.GG27892@zn.tnic
>

Thanks a lot Bao! I was offline for about 1 day due to timezone and
flight, I have no problem with this and the ACPI mapping part looks
good to me.
