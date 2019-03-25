Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E8220854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfCYMXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731091AbfCYMXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:23:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38DA031449EA;
        Mon, 25 Mar 2019 12:23:11 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-119.pek2.redhat.com [10.72.12.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D22FA1001DC8;
        Mon, 25 Mar 2019 12:23:06 +0000 (UTC)
Date:   Mon, 25 Mar 2019 20:23:02 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
References: <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325120149.GI12016@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 25 Mar 2019 12:23:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/19 at 01:01pm, Borislav Petkov wrote:
> On Mon, Mar 25, 2019 at 10:36:33AM +0000, Junichi Nomura wrote:
> > AFAIU, early parsing is new code in v5.1-rc1 to support kexec on systems
> > with hotpluggable memory with KASLR enabled. For systems that requires the
> > new feature, it may be ok to say "you need to use another kexec interface"
> > and/or "you need new kexec-tools".
> 
> No, this exactly should *not* happen. kexec is already full of duct tape
> - don't need any more of that.
> 
> So I suggested that efi_get_rsdp_addr() should exit early on in the
> kexeced kernel but making this all play nice with the kexec-ed kernel,
> as Dave suggests, is better.
> 
> Now, my next question is: why does the RDSP address need to come from
> kexec(1) (by way of efi_setup_data) and why can't the kexec'ed kernel
> figure it out itself by parsing the EFI tables in a similar way to
> efi_get_rsdp_addr ?

efi_enter_virtual_mode() can only run once because of efi firmware/spec
limitation,  and after entered virtual mode, efi firmware just updated
the original efi sys table, for example the original
systab64->fw_vendor, systab64->tables, and even smbios (only found on
some HPE machine) are changed from physcial address to virtual address.

In the current efi_get_rsdp_addr, it assumes the efi config tables
address is not touched (as physical addresses), it will break then.

Kexec saved the original physical addresses, and pass them to kexeced
kernel via x86 setup_data, so  both the early parsing or efi init code
need to get those physical values from setup_data.

Thanks
Dave
