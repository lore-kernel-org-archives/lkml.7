Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D6220825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfDOHqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:46:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfDOHq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:46:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02521308222E;
        Mon, 15 Apr 2019 07:46:29 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6399B5D9CA;
        Mon, 15 Apr 2019 07:46:25 +0000 (UTC)
Date:   Mon, 15 Apr 2019 15:46:20 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190415074620.GA15224@dhcp-128-65.nay.redhat.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
 <20190411084235.GJ3805@localhost.localdomain>
 <1bb7bccb-0270-d073-fa2f-43e1a1c73fbe@ce.jp.nec.com>
 <20190412002345.GA6356@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412002345.GA6356@MiWiFi-R3L-srv>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 15 Apr 2019 07:46:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/19 at 08:23am, Baoquan He wrote:
> On 04/11/19 at 09:14am, Junichi Nomura wrote:
> > On 4/11/19 5:42 PM, Baoquan He wrote:
> > > On 04/11/19 at 08:16am, Junichi Nomura wrote:
> > >> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
> > >> setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
> > >> will hit the problem of accessing invalid table pointer again.
> > > 
> > > Seems you are trying to address Dave Young's comment in 
> > > http://lkml.kernel.org/r/20190404073233.GC5708@dhcp-128-65.nay.redhat.com
> > 
> > Right. His "In case kexec_get_rsdp_addr failed.." comment.
> > 
> > > We may need discuss and make clear if those are doable. E.g the first
> > > comment, if not hang by below line of code, returning 0 for what? Can
> > > kexec still be saved, or just reset to firmware?
> > > 
> > > 	error("EFI system table not found in kexec boot_params.")
> > 
> > If we return 0 and also don't hang in the rest of get_rsdp_addr(),
> > it just work as the same way as v5.0 and earlier kernel do.
> > 
> > Failure cases in kexec_get_rsdp_addr() are followings:
> > 1. efi_setup_data is invalid
> > 2. loader signature is invalid
> > 3. EFI systab is not found in boot_params
> > 4. RSDP is not found by parsing tables pointed to by efi_setup_data
> > 
> > I think all of them are critical for EFI boot, so one option could be
> > we never return failure in kexec_get_rsdp_addr() and just hang.
> > But hanging in this very early stage of boot may make the problem
> > harder to investigate once happens. Even earlyprintk is not working yet.
> > So the other option is returning 0 to defer the crash for later stage.
> 
> OK, I got the point, thanks. So it is deferred to the late stage, KASLR
> may not avoid those memory region which is marked as hotpluggable in
> SRAT. Kernel can boot up, but doesn't function well on hotplug stuff.
> In this case, people don't know why it happened. We are still blind.
> 
> Seems early console in efi is the problem, but not kexec or hotplug. I
> am fine to hang, or make it continue booting for now.
> 
> Hi Dave, 
> 
> Is it possible to fix the efi early console issue? I mean the
> feasibility, I believe it won't be easy. Ask this because not only this
> issue encountered, any other issue could be triggered during boot
> decompressing stage. If efi has this problem, we can't debug them
> either.

For normal boot, it maybe doable to use some boot services eg. some
graphic protocols efi firmware provided.

But for kexec, it is different because it become virtual mode, boot
services are not available, and kernel takes over the mode setting etc.
the early framebuffer maybe usable, maybe not, it is not reliable.

Thanks
Dave
