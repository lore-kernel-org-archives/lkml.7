Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13786C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E05207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbfCYLQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2347 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfCYLQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:16:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFB143087BD4;
        Mon, 25 Mar 2019 11:16:51 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-119.pek2.redhat.com [10.72.12.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBD4767644;
        Mon, 25 Mar 2019 11:16:47 +0000 (UTC)
Date:   Mon, 25 Mar 2019 19:16:44 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Boris Petkov <bp@alien8.de>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bp@suse.de" <bp@suse.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190325111644.GB13160@dhcp-128-65.nay.redhat.com>
References: <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 25 Mar 2019 11:16:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/19 at 10:36am, Junichi Nomura wrote:
> On 3/25/19 7:15 PM, Dave Young wrote:
> > On 03/25/19 at 09:54am, Boris Petkov wrote:
> >> On March 25, 2019 9:27:21 AM GMT+01:00, Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
> >>> On 3/25/19 3:59 PM, Dave Young wrote:
> >>>> On 03/25/19 at 06:47am, Junichi Nomura wrote:
> >>>>> On 3/25/19 3:19 PM, Dave Young wrote:
> >>>>>> On 03/25/19 at 02:01pm, Dave Young wrote:
> >>>>>> I think normally people do not see this bug, because kernel will
> >>> set the
> >>>>>> rsdp in boot_params->acpi_rsdp_addr.  Maybe you are testing with
> >>>>>
> >>>>> I think it's only done for file-based kexec interface.
> >>>>
> >>>> Saw Kairui's another reply, yes, kexec-tools need a patch to fill the
> >>>> value as well then.
> >>>>
> >>>> I would vote for a repost of your old patch with some #ifdef
> >>>
> >>> Thanks for comments, Dave, Kairui and Baoquan.
> >>>
> >>> The problem for me is it's a regression in v5.1-rc1, that breaks
> >>> existing setup. If early parsing of RSDP is required only for newly
> >>> supported configuration, I'm fine such configuration requires
> >>> new tools or new options.
> >>>
> >>> This is the 1st version plus #ifdef around the EFI code.
> >>
> >> I'm going to repeat that again until you get it:
> >>
> >> If the kexec kernel should continue to use efi_systab_init() then you
> >> should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.
> > 
> > In that way, early parsing will fail in kexeced kernel, am I missing
> > something?  The early code become complicated but since we have already
> > the early acpi parsing why not to make it consistent in kexeced kernel?
> 
> AFAIU, early parsing is new code in v5.1-rc1 to support kexec on systems
> with hotpluggable memory with KASLR enabled. For systems that requires the
> new feature, it may be ok to say "you need to use another kexec interface"
> and/or "you need new kexec-tools".

Ok, it makes some sense, Kairui mentioned he will work on a kexec-tools
patch then this becomes a must.

Thanks
Dave
