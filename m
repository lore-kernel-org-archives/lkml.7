Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661B9C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 03:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDD7208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 03:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfENDdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 23:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63705 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfENDdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 23:33:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BDBB308793E;
        Tue, 14 May 2019 03:33:44 +0000 (UTC)
Received: from localhost (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A3BC19C69;
        Tue, 14 May 2019 03:33:40 +0000 (UTC)
Date:   Tue, 14 May 2019 11:33:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Young <dyoung@redhat.com>, dirk.vandermerwe@netronome.com,
        j-nomura@ce.jp.nec.com
Cc:     Borislav Petkov <bp@alien8.de>, kasong@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190514033338.GA6612@MiWiFi-R3L-srv>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 14 May 2019 03:33:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/19 at 11:22am, Dave Young wrote:
> On 05/13/19 at 04:06pm, Baoquan He wrote:
> > Hi Dave,
> > 
> > On 05/13/19 at 09:50am, Borislav Petkov wrote:
> > > On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> > > > This is a critical bug which breaks memory hotplug,
> > > 
> > > Please concentrate and stop the blabla:
> > > 
> > > 36f0c423552d ("x86/boot: Disable RSDP parsing temporarily")
> > > 
> > > already explains what the deal is. This code was *purposefully* disabled
> > > because we ran out of time and it broke a couple of machines. Don't make
> > 
> > I remember your machine is the one on whihc the issue is reported. Could
> > you also test it and confirm if these all things found ealier are
> > cleared out?
> > 
> 
> I did some tests on the laptop,  thing is:
> 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
>    on latest Linus master branch, everything works fine.
> 
> 2. build and test the tip/next-merge-window branch, kernel hangs early
> without output, (both 1st boot and kexec boot)

Thanks, Dave.

Yeah, I also tested on a HP machine, problem reprodued on the current
master branch when revert commit 52b922c3d49c.

Then apply these two patches, problem solved.

Tried boris's next-merge-window branch too, kexec works very well.

Dirk, Junichi, feel free to add your test result if you have time.

> 
> Another thing is we can move the get rsdp after console_init, but that
> can be done later as separate patch.

Yes, agree.

