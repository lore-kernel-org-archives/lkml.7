Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11FAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758B8218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDKIml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:42:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfDKIml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:42:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 342D23007452;
        Thu, 11 Apr 2019 08:42:41 +0000 (UTC)
Received: from localhost (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2231D5D961;
        Thu, 11 Apr 2019 08:42:37 +0000 (UTC)
Date:   Thu, 11 Apr 2019 16:42:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190411084235.GJ3805@localhost.localdomain>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
 <20190411080927.GA30080@zn.tnic>
 <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 11 Apr 2019 08:42:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 at 08:16am, Junichi Nomura wrote:
> On 4/11/19 5:09 PM, Borislav Petkov wrote:
> > On Wed, Apr 10, 2019 at 11:34:51PM +0000, Junichi Nomura wrote:
> >> But efi_get_rsdp_addr() needs to check whether the kernel was
> >> kexec booted to avoid accessing invalid EFI table address.
> >> efi_get_kexec_setup_data_addr() is the only method I know
> >> to check if it was kexec-booted.
> > 
> > Your v3 had the right approach - you first check if you can get the
> > address as a kexec-ed kernel. If you do, you use that one and continue
> > the normal path.
> > 
> > If you don't, you fall back to efi_get_rsdp_addr() and get it directly
> > from EFI.
> > 
> > And then carve out the functionality you need to call multiple times in
> > helper functions like __efi_get_rsdp_addr().
> > 
> > Why doesn't that work anymore?
> 
> kexec_get_rsdp_addr() might fail on kexec-booted kernel, e.g. if the
> setup_data was invalid. In such a case, falling back to efi_get_rsdp_addr()
> will hit the problem of accessing invalid table pointer again.

Seems you are trying to address Dave Young's comment in 
http://lkml.kernel.org/r/20190404073233.GC5708@dhcp-128-65.nay.redhat.com

We may need discuss and make clear if those are doable. E.g the first
comment, if not hang by below line of code, returning 0 for what? Can
kexec still be saved, or just reset to firmware?

	error("EFI system table not found in kexec boot_params.")

It may need be clarified firstly, then go further to rearrange patch.
That can ease the work, I guess.

Personal opinion.

Thanks
Baoquan
