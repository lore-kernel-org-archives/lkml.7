Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E666C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7644E20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfDQE5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfDQE5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C19030ADBCF;
        Wed, 17 Apr 2019 04:57:50 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21C6C5D707;
        Wed, 17 Apr 2019 04:57:46 +0000 (UTC)
Date:   Wed, 17 Apr 2019 12:57:42 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Message-ID: <20190417045447.GB8411@dhcp-128-65.nay.redhat.com>
References: <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <20190416095209.GG27892@zn.tnic>
 <20190416114133.GA7541@dhcp-128-65.nay.redhat.com>
 <20190416132253.GE31772@zn.tnic>
 <20190417013838.GA8411@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417013838.GA8411@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 17 Apr 2019 04:57:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/19 at 09:38am, Dave Young wrote:
> On 04/16/19 at 03:22pm, Borislav Petkov wrote:
> > On Tue, Apr 16, 2019 at 07:41:33PM +0800, Dave Young wrote:
> > > On 04/16/19 at 11:52am, Borislav Petkov wrote:
> > > > I'll queue the below in the next days if there are no more complaints:
> > > 
> > > As for the kexec breakage, even with the V3 patch, kexec still hangs on
> > > a Lenovo T420 laptop.  Kairui also reproduced the problem. So can we
> > > wait a few days see if we can make some progress to find the cause?
> > 
> > How is applying this patch going to change anything?
> > 
> > I was told that the breakage is there even without it...
> 
> Without this patch, the bug happens in the efi_get_rsdp.. function, this
> patch tries to fix that by adding kexec_get.. but the new introduced
> kexec_* function does not work on some laptops, so it is not a 100% good
> fix, I hoped we can get it working for all known issues.  But if we can
> not do it eg. within one week we can go with this version and leave the
> laptop issue as a known issue.
> 

Latest debugging status:

Kexec boot works with commenting out some code like below, so the guid
cmp (memcmp) caused a system reset), still need to find out why:

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index d9f9abd63c68..13e7a23ae94c 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -95,10 +95,12 @@ __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
 			table = tbl->table;
 		}
 
+/*
 		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
 			rsdp_addr = table;
 		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
 			return table;
+*/
 	}
 
 	return rsdp_addr;
@@ -291,9 +293,10 @@ acpi_physical_address get_rsdp_addr(void)
 	if (!pa)
 		pa = kexec_get_rsdp_addr();
 
+/*
 	if (!pa)
 		pa = efi_get_rsdp_addr();
-
+*/
 	if (!pa)
 		pa = bios_get_rsdp_addr();
 

Thanks
Dave
