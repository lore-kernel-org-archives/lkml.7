Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A8C34365
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D47724755
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZtrdO5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfLMNSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:18:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbfLMNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576243124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0nky12orMup3uHVTjxW11YMibSHUYyr0g45zDHseWEs=;
        b=QZtrdO5vp0yHeh9G+mIViBEJuRRuI4tNY6ItKJdVb5RqkufftXOP9XtLLiGRhMIXdCxR28
        tONhYy41kah8fg+wqX88S9I+QLFfNNW7BqHL8iT09hyR7rVjMqL+q+xR/xhFCVe3E/Aw+6
        VIqTfgto6fsSfxzIyUJD/3pj5gX8OBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-7zpZSS7FMwGkE85d4ICd7g-1; Fri, 13 Dec 2019 08:18:38 -0500
X-MC-Unique: 7zpZSS7FMwGkE85d4ICd7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E2964A80;
        Fri, 13 Dec 2019 13:18:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1267960BA8;
        Fri, 13 Dec 2019 13:18:26 +0000 (UTC)
Date:   Fri, 13 Dec 2019 21:18:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>, "hare@suse.com" <hare@suse.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
Message-ID: <20191213131822.GA19876@ming.t460p>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <0ad37515-c22d-6857-65a2-cc28256a8afa@huawei.com>
 <20191212223805.GA24463@ming.t460p>
 <d4b89ecf-7ced-d5d6-fc02-6d4257580465@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b89ecf-7ced-d5d6-fc02-6d4257580465@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Dec 13, 2019 at 11:12:49AM +0000, John Garry wrote:
> Hi Ming,
> 
> > > I am running some NVMe perf tests with Marc's patch.
> > 
> > We need to confirm that if Marc's patch works as expected, could you
> > collect log via the attached script?
> 
> As immediately below, I see this on vanilla mainline, so let's see what the
> issue is without that patch.

IMO, the interrupt load needs to be distributed as what X86 IRQ matrix
does. If the ARM64 server doesn't do that, the 1st step should align to
that.

Also do you pass 'use_threaded_interrupts=1' in your test?

> 
> >  >
> > You never provide the test details(how many drives, how many disks
> > attached to each drive) as I asked, so I can't comment on the reason,
> > also no reason shows that the patch is a good fix.
> 
> So I have only 2x ES3000 V3s. This looks like the same one:
> https://actfornet.com/HUAWEI_SERVER_DOCS/PCIeSSD/Huawei%20ES3000%20V3%20NVMe%20PCIe%20SSD%20Data%20Sheet.pdf
> 
> > 
> > My theory is simple, so far, the CPU is still much quicker than
> > current storage in case that IO aren't from multiple disks which are
> > connected to same drive.
> 
> Hopefully this is all the info you need:
> 
> Last login: Fri Dec 13 10:41:55 GMT 2019 on ttyAMA0
> Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 5.5.0-rc1-00001-g3779c27ad995-dirty
> aarch64)
> 
>  * Documentation:  https://help.ubuntu.com
>  * Management:     https://landscape.canonical.com
>  * Support:        https://ubuntu.com/advantage
> 
> Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check
> your Internet connection or proxy settings
> 
> john@ubuntu:~$ lstopo
> Machine (14GB total)
>   Package L#0
>     NUMANode L#0 (P#0 14GB)
>       L3 L#0 (32MB)
>         L2 L#0 (512KB) + L1d L#0 (64KB) + L1i L#0 (64KB) + Core L#0 + PU L#0
> (P#0)
>         L2 L#1 (512KB) + L1d L#1 (64KB) + L1i L#1 (64KB) + Core L#1 + PU L#1
> (P#1)
>         L2 L#2 (512KB) + L1d L#2 (64KB) + L1i L#2 (64KB) + Core L#2 + PU L#2
> (P#2)
>         L2 L#3 (512KB) + L1d L#3 (64KB) + L1i L#3 (64KB) + Core L#3 + PU L#3
> (P#3)
>         L2 L#4 (512KB) + L1d L#4 (64KB) + L1i L#4 (64KB) + Core L#4 + PU L#4
> (P#4)
>         L2 L#5 (512KB) + L1d L#5 (64KB) + L1i L#5 (64KB) + Core L#5 + PU L#5
> (P#5)
>         L2 L#6 (512KB) + L1d L#6 (64KB) + L1i L#6 (64KB) + Core L#6 + PU L#6
> (P#6)
>         L2 L#7 (512KB) + L1d L#7 (64KB) + L1i L#7 (64KB) + Core L#7 + PU L#7
> (P#7)
>         L2 L#8 (512KB) + L1d L#8 (64KB) + L1i L#8 (64KB) + Core L#8 + PU L#8
> (P#8)
>         L2 L#9 (512KB) + L1d L#9 (64KB) + L1i L#9 (64KB) + Core L#9 + PU L#9
> (P#9)
>         L2 L#10 (512KB) + L1d L#10 (64KB) + L1i L#10 (64KB) + Core L#10 + PU
> L#10 (P#10)
>         L2 L#11 (512KB) + L1d L#11 (64KB) + L1i L#11 (64KB) + Core L#11 + PU
> L#11 (P#11)
>         L2 L#12 (512KB) + L1d L#12 (64KB) + L1i L#12 (64KB) + Core L#12 + PU
> L#12 (P#12)
>         L2 L#13 (512KB) + L1d L#13 (64KB) + L1i L#13 (64KB) + Core L#13 + PU
> L#13 (P#13)
>         L2 L#14 (512KB) + L1d L#14 (64KB) + L1i L#14 (64KB) + Core L#14 + PU
> L#14 (P#14)
>         L2 L#15 (512KB) + L1d L#15 (64KB) + L1i L#15 (64KB) + Core L#15 + PU
> L#15 (P#15)
>         L2 L#16 (512KB) + L1d L#16 (64KB) + L1i L#16 (64KB) + Core L#16 + PU
> L#16 (P#16)
>         L2 L#17 (512KB) + L1d L#17 (64KB) + L1i L#17 (64KB) + Core L#17 + PU
> L#17 (P#17)
>         L2 L#18 (512KB) + L1d L#18 (64KB) + L1i L#18 (64KB) + Core L#18 + PU
> L#18 (P#18)
>         L2 L#19 (512KB) + L1d L#19 (64KB) + L1i L#19 (64KB) + Core L#19 + PU
> L#19 (P#19)
>         L2 L#20 (512KB) + L1d L#20 (64KB) + L1i L#20 (64KB) + Core L#20 + PU
> L#20 (P#20)
>         L2 L#21 (512KB) + L1d L#21 (64KB) + L1i L#21 (64KB) + Core L#21 + PU
> L#21 (P#21)
>         L1i L#23 (64KB) + Core L#23 + PU L#23 (P#23)
>       HostBridge L#0
>         PCIBridge
>           2 x { PCI 8086:10fb }
>         PCIBridge
>           PCI 19e5:0123
>         PCIBridge
>           PCI 19e5:1711
>       HostBridge L#4
>         PCIBridge
>           PCI 19e5:a250
>         PCI 19e5:a230
>         PCI 19e5:a235
>       HostBridge L#6
>         PCIBridge
>           PCI 19e5:a222
>             Net L#0 "eno1"
>           PCI 19e5:a222
>             Net L#1 "eno2"
>           PCI 19e5:a222
>             Net L#2 "eno3"
>           PCI 19e5:a221
>             Net L#3 "eno4"
>     NUMANode L#1 (P#1) + L3 L#1 (32MB)
>       L2 L#24 (512KB) + L1d L#24 (64KB) + L1i L#24 (64KB) + Core L#24 + PU
> L#24 (P#24)
>       L2 L#25 (512KB) + L1d L#25 (64KB) + L1i L#25 (64KB) + Core L#25 + PU
> L#25 (P#25)
>       L2 L#26 (512KB) + L1d L#26 (64KB) + L1i L#26 (64KB) + Core L#26 + PU
> L#26 (P#26)
>       L2 L#27 (512KB) + L1d L#27 (64KB) + L1i L#27 (64KB) + Core L#27 + PU
> L#27 (P#27)
>       L2 L#28 (512KB) + L1d L#28 (64KB) + L1i L#28 (64KB) + Core L#28 + PU
> L#28 (P#28)
>       L2 L#29 (512KB) + L1d L#29 (64KB) + L1i L#29 (64KB) + Core L#29 + PU
> L#29 (P#29)
>       L2 L#30 (512KB) + L1d L#30 (64KB) + L1i L#30 (64KB) + Core L#30 + PU
> L#30 (P#30)
>       L2 L#31 (512KB) + L1d L#31 (64KB) + L1i L#31 (64KB) + Core L#31 + PU
> L#31 (P#31)
>       L2 L#32 (512KB) + L1d L#32 (64KB) + L1i L#32 (64KB) + Core L#32 + PU
> L#32 (P#32)
>       L2 L#33 (512KB) + L1d L#33 (64KB) + L1i L#33 (64KB) + Core L#33 + PU
> L#33 (P#33)
>       L2 L#34 (512KB) + L1d L#34 (64KB) + L1i L#34 (64KB) + Core L#34 + PU
> L#34 (P#34)
>       L2 L#35 (512KB) + L1d L#35 (64KB) + L1i L#35 (64KB) + Core L#35 + PU
> L#35 (P#35)
>       L2 L#36 (512KB) + L1d L#36 (64KB) + L1i L#36 (64KB) + Core L#36 + PU
> L#36 (P#36)
>       L2 L#37 (512KB) + L1d L#37 (64KB) + L1i L#37 (64KB) + Core L#37 + PU
> L#37 (P#37)
>       L2 L#38 (512KB) + L1d L#38 (64KB) + L1i L#38 (64KB) + Core L#38 + PU
> L#38 (P#38)
>       L2 L#39 (512KB) + L1d L#39 (64KB) + L1i L#39 (64KB) + Core L#39 + PU
> L#39 (P#39)
>       L2 L#40 (512KB) + L1d L#40 (64KB) + L1i L#40 (64KB) + Core L#40 + PU
> L#40 (P#40)
>       L2 L#41 (512KB) + L1d L#41 (64KB) + L1i L#41 (64KB) + Core L#41 + PU
> L#41 (P#41)
>       L2 L#42 (512KB) + L1d L#42 (64KB) + L1i L#42 (64KB) + Core L#42 + PU
> L#42 (P#42)
>       L2 L#43 (512KB) + L1d L#43 (64KB) + L1i L#43 (64KB) + Core L#43 + PU
> L#43 (P#43)
>       L2 L#44 (512KB) + L1d L#44 (64KB) + L1i L#44 (64KB) + Core L#44 + PU
> L#44 (P#44)
>       L2 L#45 (512KB) + L1d L#45 (64KB) + L1i L#45 (64KB) + Core L#45 + PU
> L#45 (P#45)
>       L2 L#46 (512KB) + L1d L#46 (64KB) + L1i L#46 (64KB) + Core L#46 + PU
> L#46 (P#46)
>       L2 L#47 (512KB) + L1d L#47 (64KB) + L1i L#47 (64KB) + Core L#47 + PU
> L#47 (P#47)
>   Package L#1
>     NUMANode L#2 (P#2)
>       L3 L#2 (32MB)
>         L2 L#48 (512KB) + L1d L#48 (64KB) + L1i L#48 (64KB) + Core L#48 + PU
> L#48 (P#48)
>         L2 L#49 (512KB) + L1d L#49 (64KB) + L1i L#49 (64KB) + Core L#49 + PU
> L#49 (P#49)
>         L2 L#50 (512KB) + L1d L#50 (64KB) + L1i L#50 (64KB) + Core L#50 + PU
> L#50 (P#50)
>         L2 L#51 (512KB) + L1d L#51 (64KB) + L1i L#51 (64KB) + Core L#51 + PU
> L#51 (P#51)
>         L2 L#52 (512KB) + L1d L#52 (64KB) + L1i L#52 (64KB) + Core L#52 + PU
> L#52 (P#52)
>         L2 L#53 (512KB) + L1d L#53 (64KB) + L1i L#53 (64KB) + Core L#53 + PU
> L#53 (P#53)
>         L2 L#54 (512KB) + L1d L#54 (64KB) + L1i L#54 (64KB) + Core L#54 + PU
> L#54 (P#54)
>         L2 L#55 (512KB) + L1d L#55 (64KB) + L1i L#55 (64KB) + Core L#55 + PU
> L#55 (P#55)
>         L2 L#56 (512KB) + L1d L#56 (64KB) + L1i L#56 (64KB) + Core L#56 + PU
> L#56 (P#56)
>         L2 L#57 (512KB) + L1d L#57 (64KB) + L1i L#57 (64KB) + Core L#57 + PU
> L#57 (P#57)
>         L2 L#58 (512KB) + L1d L#58 (64KB) + L1i L#58 (64KB) + Core L#58 + PU
> L#58 (P#58)
>         L2 L#59 (512KB) + L1d L#59 (64KB) + L1i L#59 (64KB) + Core L#59 + PU
> L#59 (P#59)
>         L2 L#60 (512KB) + L1d L#60 (64KB) + L1i L#60 (64KB) + Core L#60 + PU
> L#60 (P#60)
>         L2 L#61 (512KB) + L1d L#61 (64KB) + L1i L#61 (64KB) + Core L#61 + PU
> L#61 (P#61)
>         L2 L#62 (512KB) + L1d L#62 (64KB) + L1i L#62 (64KB) + Core L#62 + PU
> L#62 (P#62)
>         L2 L#63 (512KB) + L1d L#63 (64KB) + L1i L#63 (64KB) + Core L#63 + PU
> L#63 (P#63)
>         L2 L#64 (512KB) + L1d L#64 (64KB) + L1i L#64 (64KB) + Core L#64 + PU
> L#64 (P#64)
>         L2 L#65 (512KB) + L1d L#65 (64KB) + L1i L#65 (64KB) + Core L#65 + PU
> L#65 (P#65)
>         L2 L#66 (512KB) + L1d L#66 (64KB) + L1i L#66 (64KB) + Core L#66 + PU
> L#66 (P#66)
>         L2 L#67 (512KB) + L1d L#67 (64KB) + L1i L#67 (64KB) + Core L#67 + PU
> L#67 (P#67)
>         L2 L#68 (512KB) + L1d L#68 (64KB) + L1i L#68 (64KB) + Core L#68 + PU
> L#68 (P#68)
>         L2 L#69 (512KB) + L1d L#69 (64KB) + L1i L#69 (64KB) + Core L#69 + PU
> L#69 (P#69)
>         L2 L#70 (512KB) + L1d L#70 (64KB) + L1i L#70 (64KB) + Core L#70 + PU
> L#70 (P#70)
>         L2 L#71 (512KB) + L1d L#71 (64KB) + L1i L#71 (64KB) + Core L#71 + PU
> L#71 (P#71)
>       HostBridge L#8
>         PCIBridge
>           PCI 19e5:0123
>       HostBridge L#10
>         PCIBridge
>           PCI 19e5:a250
>       HostBridge L#12
>         PCIBridge
>           PCI 19e5:a226
>             Net L#4 "eno5"
>     NUMANode L#3 (P#3) + L3 L#3 (32MB)
>       L2 L#72 (512KB) + L1d L#72 (64KB) + L1i L#72 (64KB) + Core L#72 + PU
> L#72 (P#72)
>       L2 L#73 (512KB) + L1d L#73 (64KB) + L1i L#73 (64KB) + Core L#73 + PU
> L#73 (P#73)
>       L2 L#74 (512KB) + L1d L#74 (64KB) + L1i L#74 (64KB) + Core L#74 + PU
> L#74 (P#74)
>       L2 L#75 (512KB) + L1d L#75 (64KB) + L1i L#75 (64KB) + Core L#75 + PU
> L#75 (P#75)
>       L2 L#76 (512KB) + L1d L#76 (64KB) + L1i L#76 (64KB) + Core L#76 + PU
> L#76 (P#76)
>       L2 L#77 (512KB) + L1d L#77 (64KB) + L1i L#77 (64KB) + Core L#77 + PU
> L#77 (P#77)
>       L2 L#78 (512KB) + L1d L#78 (64KB) + L1i L#78 (64KB) + Core L#78 + PU
> L#78 (P#78)
>       L2 L#79 (512KB) + L1d L#79 (64KB) + L1i L#79 (64KB) + Core L#79 + PU
> L#79 (P#79)
>       L2 L#80 (512KB) + L1d L#80 (64KB) + L1i L#80 (64KB) + Core L#80 + PU
> L#80 (P#80)
>       L2 L#81 (512KB) + L1d L#81 (64KB) + L1i L#81 (64KB) + Core L#81 + PU
> L#81 (P#81)
>       L2 L#82 (512KB) + L1d L#82 (64KB) + L1i L#82 (64KB) + Core L#82 + PU
> L#82 (P#82)
>       L2 L#83 (512KB) + L1d L#83 (64KB) + L1i L#83 (64KB) + Core L#83 + PU
> L#83 (P#83)
>       L2 L#84 (512KB) + L1d L#84 (64KB) + L1i L#84 (64KB) + Core L#84 + PU
> L#84 (P#84)
>       L2 L#85 (512KB) + L1d L#85 (64KB) + L1i L#85 (64KB) + Core L#85 + PU
> L#85 (P#85)
>       L2 L#86 (512KB) + L1d L#86 (64KB) + L1i L#86 (64KB) + Core L#86 + PU
> L#86 (P#86)
>       L2 L#87 (512KB) + L1d L#87 (64KB) + L1i L#87 (64KB) + Core L#87 + PU
> L#87 (P#87)
>       L2 L#88 (512KB) + L1d L#88 (64KB) + L1i L#88 (64KB) + Core L#88 + PU
> L#88 (P#88)
>       L2 L#89 (512KB) + L1d L#89 (64KB) + L1i L#89 (64KB) + Core L#89 + PU
> L#89 (P#89)
>       L2 L#90 (512KB) + L1d L#90 (64KB) + L1i L#90 (64KB) + Core L#90 + PU
> L#90 (P#90)
>       L2 L#91 (512KB) + L1d L#91 (64KB) + L1i L#91 (64KB) + Core L#91 + PU
> L#91 (P#91)
>       L2 L#92 (512KB) + L1d L#92 (64KB) + L1i L#92 (64KB) + Core L#92 + PU
> L#92 (P#92)
>       L2 L#93 (512KB) + L1d L#93 (64KB) + L1i L#93 (64KB) + Core L#93 + PU
> L#93 (P#93)
>       L2 L#94 (512KB) + L1d L#94 (64KB) + L1i L#94 (64KB) + Core L#94 + PU
> L#94 (P#94)
>       L2 L#95 (512KB) + L1d L#95 (64KB) + L1i L#95 (64KB) + Core L#95 + PU
> L#95 (P#95)
> john@ubuntu:~$ lscpu
> Architecture:        aarch64
> Byte Order:          Little Endian
> CPU(s):              96
> On-line CPU(s) list: 0-95
> Thread(s) per core:  1
> Core(s) per socket:  48
> Socket(s):           2
> NUMA node(s):        4
> Vendor ID:           0x48
> Model:               0
> Stepping:            0x0
> BogoMIPS:            200.00
> L1d cache:           64K
> L1i cache:           64K
> L2 cache:            512K
> L3 cache:            32768K
> NUMA node0 CPU(s):   0-23
> NUMA node1 CPU(s):   24-47
> NUMA node2 CPU(s):   48-71
> NUMA node3 CPU(s):   72-95
> Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> cpuid asimdrdm dcpop
> john@ubuntu:~$ dmesg | grep "Linux v"
> [    0.000000] Linux version 5.5.0-rc1-00001-g3779c27ad995-dirty
> (john@john-ThinkCentre-M93p) (gcc version 7.3.1 20180425
> [linaro-7.3-2018.05-rc1 revision 38aec9a676236eaa42ca03ccb3a6c1dd0182c29f]
> (Linaro GCC 7.3-2018.05-rc1)) #1436 SMP PREEMPT Fri Dec 13 10:51:46 GMT 2019
> john@ubuntu:~$
> john@ubuntu:~$ lspci
> 00:00.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 00:04.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 00:08.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 00:0c.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 00:10.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 00:12.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+
> Network Connection (rev 01)
> 01:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+
> Network Connection (rev 01)
> 04:00.0 Non-Volatile memory controller: Huawei Technologies Co., Ltd. ES3000
> V3 NVMe PCIe SSD (rev 45)
> 05:00.0 VGA compatible controller: Huawei Technologies Co., Ltd. Hi1710
> [iBMC Intelligent Management system chip w/VGA support] (rev 01)
> 74:00.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCI-PCI Bridge
> (rev 20)
> 74:02.0 Serial Attached SCSI controller: Huawei Technologies Co., Ltd.
> HiSilicon SAS 3.0 HBA (rev 20)
> 74:03.0 SATA controller: Huawei Technologies Co., Ltd. HiSilicon AHCI HBA
> (rev 20)
> 75:00.0 Processing accelerators: Huawei Technologies Co., Ltd. HiSilicon ZIP
> Engine (rev 20)
> 78:00.0 Network and computing encryption device: Huawei Technologies Co.,
> Ltd. HiSilicon HPRE Engine (rev 20)
> 7a:00.0 USB controller: Huawei Technologies Co., Ltd. HiSilicon USB 2.0
> 2-port Host Controller (rev 20)
> 7a:01.0 USB controller: Huawei Technologies Co., Ltd. HiSilicon USB 2.0
> 2-port Host Controller (rev 20)
> 7a:02.0 USB controller: Huawei Technologies Co., Ltd. HiSilicon USB 3.0 Host
> Controller (rev 20)
> 7c:00.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCI-PCI Bridge
> (rev 20)
> 7d:00.0 Ethernet controller: Huawei Technologies Co., Ltd. HNS GE/10GE/25GE
> RDMA Network Controller (rev 20)
> 7d:00.1 Ethernet controller: Huawei Technologies Co., Ltd. HNS GE/10GE/25GE
> RDMA Network Controller (rev 20)
> 7d:00.2 Ethernet controller: Huawei Technologies Co., Ltd. HNS GE/10GE/25GE
> RDMA Network Controller (rev 20)
> 7d:00.3 Ethernet controller: Huawei Technologies Co., Ltd. HNS GE/10GE/25GE
> Network Controller (rev 20)
> 80:00.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 80:08.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 80:0c.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 80:10.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCIe Root Port
> with Gen4 (rev 45)
> 81:00.0 Non-Volatile memory controller: Huawei Technologies Co., Ltd. ES3000
> V3 NVMe PCIe SSD (rev 45)
> b4:00.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCI-PCI Bridge
> (rev 20)
> b5:00.0 Processing accelerators: Huawei Technologies Co., Ltd. HiSilicon ZIP
> Engine (rev 20)
> b8:00.0 Network and computing encryption device: Huawei Technologies Co.,
> Ltd. HiSilicon HPRE Engine (rev 20)
> ba:00.0 USB controller: Huawei Technologies Co., Ltd. HiSilicon USB 2.0
> 2-port Host Controller (rev 20)
> ba:01.0 USB controller: Huawei Technologies Co., Ltd. HiSilicon USB 2.0
> 2-port Host Controller (rev 20)
> ba:02.0 USB controller: Huawei Technologies Co., Ltd. HiSilicon USB 3.0 Host
> Controller (rev 20)
> bc:00.0 PCI bridge: Huawei Technologies Co., Ltd. HiSilicon PCI-PCI Bridge
> (rev 20)
> bd:00.0 Ethernet controller: Huawei Technologies Co., Ltd. HNS
> GE/10GE/25GE/50GE/100GE RDMA Network Controller (rev 20)
> john@ubuntu:~$ sudo /bin/bash create_fio_task_cpu_liuyifan_nvme.sh 4k read
> 20 1
> Creat 4k_read_depth20_fiotest file sucessfully
> job1: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B,
> ioengine=libaio, iodepth=20
> ...
> job1: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B,
> ioengine=libaio, iodepth=20
> ...
> fio-3.1
> Starting 40 processes
> [  175.642410] rcu: INFO: rcu_preempt self-detected stall on CPU IOPS][eta
> 00m:18s]
> [  175.648150] rcu: 0-....: (1 GPs behind) idle=3ae/1/0x4000000000000004
> softirq=1589/1589 fqs=2322
> Jobs: 40 (f=40): [R(40)][100.0%][r=4270MiB/s,w=0KiB/s][r=1093k,w=0 IOPS][eta
> 00m:00s]
> job1: (groupid=0, jobs=40): err= 0: pid=1227: Fri Dec 13 10:57:49 2019
>    read: IOPS=952k, BW=3719MiB/s (3900MB/s)(145GiB/40003msec)
>     slat (usec): min=2, max=20126k, avg=10.66, stdev=9637.70
>     clat (usec): min=13, max=20156k, avg=517.95, stdev=31017.58
>      lat (usec): min=21, max=20156k, avg=528.77, stdev=32487.76
>     clat percentiles (usec):
>      |  1.00th=[  103],  5.00th=[  113], 10.00th=[  147], 20.00th=[  200],
>      | 30.00th=[  260], 40.00th=[  318], 50.00th=[  375], 60.00th=[  429],
>      | 70.00th=[  486], 80.00th=[  578], 90.00th=[  799], 95.00th=[  996],
>      | 99.00th=[ 1958], 99.50th=[ 2114], 99.90th=[ 2311], 99.95th=[ 2474],
>      | 99.99th=[ 7767]
>    bw (  KiB/s): min=  112, max=745026, per=4.60%, avg=175285.03,
> stdev=117592.37, samples=1740
>    iops        : min=   28, max=186256, avg=43821.06, stdev=29398.12,
> samples=1740
>   lat (usec)   : 20=0.01%, 50=0.01%, 100=0.14%, 250=28.38%, 500=43.76%
>   lat (usec)   : 750=16.17%, 1000=6.65%
>   lat (msec)   : 2=4.02%, 4=0.86%, 10=0.01%, 20=0.01%, 50=0.01%
>   lat (msec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 2000=0.01%
>   lat (msec)   : >=2000=0.01%
>   cpu          : usr=3.67%, sys=15.82%, ctx=20799355, majf=0, minf=4275
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%,
> >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
> >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%,
> >=64=0.0%
>      issued rwt: total=38086812,0,0, short=0,0,0, dropped=0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=20
> 
> Run status group 0 (all jobs):
>    READ: bw=3719MiB/s (3900MB/s), 3719MiB/s-3719MiB/s (3900MB/s-3900MB/s),
> io=145GiB (156GB), run=40003-40003msec
> 
> Disk stats (read0/0, ticks=5002739/0, in_queue=540, util=99.83%
> john@ubuntu:~$ dmesg | tail -n 100
> [   20.380611] Key type dns_resolver registered
> [   20.385000] registered taskstats version 1
> [   20.389092] Loading compiled-in X.509 certificates
> [   20.394494] pcieport 0000:00:00.0: Adding to iommu group 9
> [   20.401556] pcieport 0000:00:04.0: Adding to iommu group 10
> [   20.408695] pcieport 0000:00:08.0: Adding to iommu group 11
> [   20.415767] pcieport 0000:00:0c.0: Adding to iommu group 12
> [   20.422842] pcieport 0000:00:10.0: Adding to iommu group 13
> [   20.429932] pcieport 0000:00:12.0: Adding to iommu group 14
> [   20.437077] pcieport 0000:7c:00.0: Adding to iommu group 15
> [   20.443397] pcieport 0000:74:00.0: Adding to iommu group 16
> [   20.449790] pcieport 0000:80:00.0: Adding to iommu group 17
> [   20.453983] usb 1-2: new high-speed USB device number 3 using ehci-pci
> [   20.457553] pcieport 0000:80:08.0: Adding to iommu group 18
> [   20.469455] pcieport 0000:80:0c.0: Adding to iommu group 19
> [   20.477037] pcieport 0000:80:10.0: Adding to iommu group 20
> [   20.484712] pcieport 0000:bc:00.0: Adding to iommu group 21
> [   20.491155] pcieport 0000:b4:00.0: Adding to iommu group 22
> [   20.517723] rtc-efi rtc-efi: setting system clock to 2019-12-13T10:54:56
> UTC (1576234496)
> [   20.525913] ALSA device list:
> [   20.528878]   No soundcards found.
> [   20.618601] hub 1-2:1.0: USB hub found
> [   20.622440] hub 1-2:1.0: 4 ports detected
> [   20.744970] EXT4-fs (sdd1): recovery complete
> [   20.759425] EXT4-fs (sdd1): mounted filesystem with ordered data mode.
> Opts: (null)
> [   20.767090] VFS: Mounted root (ext4 filesystem) on device 8:49.
> [   20.788837] devtmpfs: mounted
> [   20.793124] Freeing unused kernel memory: 5184K
> [   20.797817] Run /sbin/init as init process
> [   20.913986] usb 1-2.1: new full-speed USB device number 4 using ehci-pci
> [   21.379891] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT
> +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT
> +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2
> default-hierarchy=hybrid)
> [   21.401921] systemd[1]: Detected architecture arm64.
> [   21.459107] systemd[1]: Set hostname to <ubuntu>.
> [   21.474734] systemd[1]: Couldn't move remaining userspace processes,
> ignoring: Input/output error
> [   21.947303] systemd[1]: File
> /lib/systemd/system/systemd-journald.service:36 configures an IP firewall
> (IPAddressDeny=any), but the local system does not support BPF/cgroup based
> firewalling.
> [   21.964340] systemd[1]: Proceeding WITHOUT firewalling in effect! (This
> warning is only shown for the first loaded unit using IP firewalling.)
> [   22.268240] random: systemd: uninitialized urandom read (16 bytes read)
> [   22.274946] systemd[1]: Started Forward Password Requests to Wall
> Directory Watch.
> [   22.298022] random: systemd: uninitialized urandom read (16 bytes read)
> [   22.304894] systemd[1]: Created slice User and Session Slice.
> [   22.322032] random: systemd: uninitialized urandom read (16 bytes read)
> [   22.328850] systemd[1]: Created slice System Slice.
> [   22.346109] systemd[1]: Listening on Syslog Socket.
> [   22.552644] random: crng init done
> [   22.558740] random: 7 urandom warning(s) missed due to ratelimiting
> [   23.370478] EXT4-fs (sdd1): re-mounted. Opts: errors=remount-ro
> [   23.547390] systemd-journald[806]: Received request to flush runtime
> journal from PID 1
> [   23.633956] systemd-journald[806]: File
> /var/log/journal/f0ef8dc5ede84b5eb7431c01908d3558/system.journal corrupted
> or uncleanly shut down, renaming and replacing.
> [   23.814035] Adding 2097148k swap on /swapfile.  Priority:-2 extents:6
> across:2260988k
> [   25.012707] hns3 0000:7d:00.2 eno3: renamed from eth2
> [   25.054228] hns3 0000:7d:00.3 eno4: renamed from eth3
> [   25.086971] hns3 0000:7d:00.1 eno2: renamed from eth1
> [   25.118154] hns3 0000:7d:00.0 eno1: renamed from eth0
> [   25.154467] hns3 0000:bd:00.0 eno5: renamed from eth4
> [   26.130742] input: Keyboard/Mouse KVM 1.1.0 as /devices/pci0000:7a/0000:7a:01.0/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input1
> [   26.190189] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10
> Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input0
> [   26.191049] input: Keyboard/Mouse KVM 1.1.0 as /devices/pci0000:7a/0000:7a:01.0/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input2
> [   26.191090] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 Mouse
> [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input1
> [  175.642410] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  175.648150] rcu: 0-....: (1 GPs behind) idle=3ae/1/0x4000000000000004
> softirq=1589/1589 fqs=2322
> [  175.657102] (t=5253 jiffies g=2893 q=3123)
> [  175.657105] Task dump for CPU 0:
> [  175.657108] fio             R  running task        0  1254   1224
> 0x00000002
> [  175.657112] Call trace:
> [  175.657122]  dump_backtrace+0x0/0x1a0
> [  175.657126]  show_stack+0x14/0x20
> [  175.657130]  sched_show_task+0x164/0x1a0
> [  175.657133]  dump_cpu_task+0x40/0x2e8
> [  175.657137]  rcu_dump_cpu_stacks+0xa0/0xe0
> [  175.657139]  rcu_sched_clock_irq+0x6d8/0xaa8
> [  175.657143]  update_process_times+0x2c/0x50
> [  175.657147]  tick_sched_handle.isra.14+0x30/0x50
> [  175.657149]  tick_sched_timer+0x48/0x98
> [  175.657152]  __hrtimer_run_queues+0x120/0x1b8
> [  175.657154]  hrtimer_interrupt+0xd4/0x250
> [  175.657159]  arch_timer_handler_phys+0x28/0x40
> [  175.657162]  handle_percpu_devid_irq+0x80/0x140
> [  175.657165]  generic_handle_irq+0x24/0x38
> [  175.657167]  __handle_domain_irq+0x5c/0xb0
> [  175.657170]  gic_handle_irq+0x5c/0x148
> [  175.657172]  el1_irq+0xb8/0x180
> [  175.657175]  efi_header_end+0x94/0x234
> [  175.657178]  irq_exit+0xd0/0xd8
> [  175.657180]  __handle_domain_irq+0x60/0xb0
> [  175.657182]  gic_handle_irq+0x5c/0x148
> [  175.657184]  el1_irq+0xb8/0x180
> [  175.657194]  nvme_open+0x80/0xc8
> [  175.657199]  __blkdev_get+0x3f8/0x4f0
> [  175.657201]  blkdev_get+0x110/0x180
> [  175.657204]  blkdev_open+0x8c/0xa0
> [  175.657207]  do_dentry_open+0x1c4/0x3d8
> [  175.657210]  vfs_open+0x28/0x30
> [  175.657212]  path_openat+0x2a8/0x12a0
> [  175.657214]  do_filp_open+0x78/0xf8
> [  175.657217]  do_sys_open+0x19c/0x258
> [  175.657219]  __arm64_sys_openat+0x20/0x28
> [  175.657222]  el0_svc_common.constprop.2+0x64/0x160
> [  175.657225]  el0_svc_handler+0x20/0x80
> [  175.657227]  el0_sync_handler+0xe4/0x188
> [  175.657229]  el0_sync+0x140/0x180
> 
> john@ubuntu:~$ ./dump-io-irq-affinity
> kernel version:
> Linux ubuntu 5.5.0-rc1-00001-g3779c27ad995-dirty #1436 SMP PREEMPT Fri Dec
> 13 10:51:46 GMT 2019 aarch64 aarch64 aarch64 GNU/Linux
> PCI name is 04:00.0: nvme0n1
> irq 56, cpu list 75, effective list 75
> irq 60, cpu list 24-28, effective list 24
> irq 61, cpu list 29-33, effective list 29
> irq 62, cpu list 34-38, effective list 34
> irq 63, cpu list 39-43, effective list 39
> irq 64, cpu list 44-47, effective list 44
> irq 65, cpu list 48-51, effective list 48
> irq 66, cpu list 52-55, effective list 52
> irq 67, cpu list 56-59, effective list 56
> irq 68, cpu list 60-63, effective list 60
> irq 69, cpu list 64-67, effective list 64
> irq 70, cpu list 68-71, effective list 68
> irq 71, cpu list 72-75, effective list 72
> irq 72, cpu list 76-79, effective list 76
> irq 73, cpu list 80-83, effective list 80
> irq 74, cpu list 84-87, effective list 84
> irq 75, cpu list 88-91, effective list 88
> irq 76, cpu list 92-95, effective list 92
> irq 77, cpu list 0-3, effective list 0
> irq 78, cpu list 4-7, effective list 4
> irq 79, cpu list 8-11, effective list 8
> irq 80, cpu list 12-15, effective list 12
> irq 81, cpu list 16-19, effective list 16
> irq 82, cpu list 20-23, effective list 20
> PCI name is 81:00.0: nvme1n1
> irq 100, cpu list 0-3, effective list 0
> irq 101, cpu list 4-7, effective list 4
> irq 102, cpu list 8-11, effective list 8
> irq 103, cpu list 12-15, effective list 12
> irq 104, cpu list 16-19, effective list 16
> irq 105, cpu list 20-23, effective list 20
> irq 57, cpu list 63, effective list 63
> irq 83, cpu list 24-28, effective list 24
> irq 84, cpu list 29-33, effective list 29
> irq 85, cpu list 34-38, effective list 34
> irq 86, cpu list 39-43, effective list 39
> irq 87, cpu list 44-47, effective list 44
> irq 88, cpu list 48-51, effective list 48
> irq 89, cpu list 52-55, effective list 52
> irq 90, cpu list 56-59, effective list 56
> irq 91, cpu list 60-63, effective list 60
> irq 92, cpu list 64-67, effective list 64
> irq 93, cpu list 68-71, effective list 68
> irq 94, cpu list 72-75, effective list 72
> irq 95, cpu list 76-79, effective list 76
> irq 96, cpu list 80-83, effective list 80
> irq 97, cpu list 84-87, effective list 84
> irq 98, cpu list 88-91, effective list 88
> irq 99, cpu list 92-95, effective list 92
 
The above log shows there are two nvme drives, each drive has 24 hw
queues.

Also the system has 96 cores, and 96 > 24 * 2, so if everything is fine,
each hw queue can be assigned one unique effective CPU for handling
the queue's interrupt.

Because arm64's gic driver doesn't distribute irq's effective cpu affinity,
each hw queue is assigned same CPU to handle its interrupt.

As you saw, the detected RCU stall is on CPU0, which is for handling
both irq 77 and irq 100.

Please apply Marc's patch and observe if unique effective CPU is
assigned to each hw queue's irq.

If unique effective CPU is assigned to each hw queue's irq, and the RCU
stall can still be triggered, let's investigate further, given one single
ARM64 CPU core should be quick enough to handle IO completion from single
NVNe drive.


Thanks,
Ming

