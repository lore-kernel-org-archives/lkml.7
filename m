Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8E1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161F72084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfDCI0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCI0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA2B4308427C;
        Wed,  3 Apr 2019 08:26:41 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 757925C234;
        Wed,  3 Apr 2019 08:26:38 +0000 (UTC)
Date:   Wed, 3 Apr 2019 16:26:34 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "bhe@redhat.com" <bhe@redhat.com>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190403082634.GA14852@dhcp-128-65.nay.redhat.com>
References: <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403063911.GA2579@dhcp-128-65.nay.redhat.com>
 <20190403073023.GF1555@localhost.localdomain>
 <20190403075015.GQ7627@MiWiFi-R3L-srv>
 <20190403082313.GA14838@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403082313.GA14838@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 03 Apr 2019 08:26:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/19 at 04:23pm, Dave Young wrote:
> On 04/03/19 at 03:50pm, Baoquan He wrote:
> > On 04/03/19 at 03:30pm, Chao Fan wrote:
> > > On Wed, Apr 03, 2019 at 02:39:11PM +0800, Dave Young wrote:
> > > >> Actually I got some different kexec test results.
> > > >> 
> > > >> Yesterday, with my installed kernel (based on git head several weeks
> > > >> ago), kexec kernel panics.
> > > >> 
> > > >> Then I tried latest mainline with git pull, everything works, (with or
> > > >> without the patch, and can not reproduce the bug this patch is fixing)
> > > >> 
> > > >> Today, test again, kexec reboot hangs (with or without your patch), but
> > > >> kdump works always (with or without the patch)
> > > >> 
> > > >> It is weird to me. Probably I need find out why I can not reproduce the
> > > >> bug this patch is addressing first.
> > > >> 
> > > >> earlyprintk seems not working for me anymore, it is not easy to debug on
> > > >> laptop now.
> > > >> 
> > > >> But the patch itself is clear, I think it should be good.  There might be
> > > >> other things broken.
> > > >
> > > >Disable your immovable mem code then everything works for me.  There
> > > >might be something wrong in the code.  Also "nokaslr" does not help, it
> > > >should be another problem 
> > > 
> > > If "nokaslr" doesn't help, so I think
> > > >+      /*num_immovable_mem = count_immovable_mem_regions();*/
> > > also doesn't help. I think the problem is from get_rsdp_addr().
> > 
> > Yes, seems get_rsdp_addr() has issue in this case. I am wondering if we
> > can adjust the postion of get_rsdp_addr() calling. If nokaslr is
> > specified, no need to get rsdp?
> 
> I assumed the early code is only be useful for kaslr, if this is true
> then no need to get rsdp in case nokaslr.
> 
> But I vaguely remember Boris want the boot_params rsdp pointer be a
> general thing, I did not followed up these patch discussions, need to see how Boris thinks about this.
> 
Personally I would like to have a cmdline to bypass the early acpi code
because early code is hard to debug, if we have something weird happens
we can try to gate out these code, and then get some idea..
