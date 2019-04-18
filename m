Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E5EC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E1D214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbfDRBYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:24:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfDRBYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E17D030198A5;
        Thu, 18 Apr 2019 01:24:09 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7697919C65;
        Thu, 18 Apr 2019 01:24:06 +0000 (UTC)
Date:   Thu, 18 Apr 2019 09:24:02 +0800
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
Message-ID: <20190418012402.GB4977@dhcp-128-65.nay.redhat.com>
References: <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <20190416095209.GG27892@zn.tnic>
 <20190416114133.GA7541@dhcp-128-65.nay.redhat.com>
 <20190416132253.GE31772@zn.tnic>
 <20190417013838.GA8411@dhcp-128-65.nay.redhat.com>
 <20190417082250.GA20492@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417082250.GA20492@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 18 Apr 2019 01:24:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/19 at 10:22am, Borislav Petkov wrote:
> On Wed, Apr 17, 2019 at 09:38:38AM +0800, Dave Young wrote:
> > But if you want to apply it now, I think it is fine as well, probably
> > the laptop issue is lenovo firmware specific, we can add rsdp in cmdline
> > or boot params via kexec-tools so it should be good by using new kexec-tools.
> 
> I'm not in a hurry to apply it - if you guys wanna debug this further,
> sure, we can wait and then tag all the fixes for stable so that they can
> get backported.

Thanks!  According to our debugging this indeed need amending.  We tried
maping the efi systab/acpi table area with some hardcode changes, and
test passed.  This means the previous tests people have done probably
just happened work,  maybe early pg table happen to cover the memory
areas in their cases.  We noticed in vm guest and some other machines, the systab
all fall into memory under 2G, but the systab of T420 sits in area
0xda...... which is 2G ~ 4G area.

Kairui is trying to work on some fix so that it can be folded into the
current reviewed patch.

Thanks
Dave
